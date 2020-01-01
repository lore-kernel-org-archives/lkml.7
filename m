Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA1C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4630B20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577919694;
	bh=+i35ERBwW360ij3oAhsL59qGMF/FQpEEC1YFqKhKm9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ADd9+O5zwtDrztBnkwAdwh9L3Jyb2Y4iZMjMFIfbKlU8G82jBkrSG+V8KWbXZSXM0
	 XaI6tcLs/o4FZyNF2XRNzHBlmPTg2FgFxrQLoW2W6HaX5ODogW+YboOZxnTRqriXT3
	 PYfPe6DGoiakUt9xdWYyIHq4iwDDGGRQxzlviDT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgAAXBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 18:01:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44852 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgAAXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 18:01:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so28813938lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JasYi67QqqR/bQFvtusaBY+N2VpDxfNqKz3KIu6InR0=;
        b=B74IeM9Cw1Tjn+MVVpL2o37ZTVmNIVOjuTqHwS04fn7jzJys06+of5G7mnpZgZlqfW
         Sq/wfVjwdSOrq+AIV23ux5f6ckYbqhkngQJ/zMDcjdoWMXBYdQBWQHhht12vZBQ1jZJF
         vqBFHfhel5F4vNYexMVXQVBNi7FkRSDs4mENU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JasYi67QqqR/bQFvtusaBY+N2VpDxfNqKz3KIu6InR0=;
        b=cjM2zbUJMUQR2FoSp106CROQ45PGZLoKf95fo3LE7hnpc9fzxe1Fzjcl7OHzdibLu4
         RboxsmaQLory6yF6YPF6sYAHRHffOJiWqYEOx5ve4Z838cOSucKc55/k6DCeaE9LJ4MU
         8AW79XKHSK/h5aqOUYr49dQvDJY1RtiWMRiDxEgfoAWlPshdHBjRRsNYt98n6xmNfhxa
         0YeYJG3Z8TK68vGwQYdfZBt3wjqNhhOTv98EoGVa2FUSm0bhCMq17rxki2cfTDxDhFDa
         Iv2ouapCjMTzNSr4gwoV/WMLVbXEtG55bX3TK/dAf8GkYSWssqtFkjNilO88wc5B6c8Q
         E4fw==
X-Gm-Message-State: APjAAAUa+vcfYOUsP+Z3M9nz9WrkLB++3ihn+T0NriBg4J4dQtQX5On8
        nQ7XD82+/aMFxMjF2IvTQWHrsuAgcc4=
X-Google-Smtp-Source: APXvYqxPQIDqEESRuE6lqwHmUivVnZ/H7jRTX0qwh728lL9EEEMGac9PS9htbjS4Rdo0JdD/Ef9zkA==
X-Received: by 2002:a19:c382:: with SMTP id t124mr44665674lff.124.1577919689446;
        Wed, 01 Jan 2020 15:01:29 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m13sm22284051lfo.40.2020.01.01.15.01.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 15:01:28 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m30so28843259lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 15:01:28 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr44060584lfk.52.1577919688226;
 Wed, 01 Jan 2020 15:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com> <20200101225049.GB438328@rani.riverdale.lan>
In-Reply-To: <20200101225049.GB438328@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jan 2020 15:01:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHg8z5WQBoypjyi0VPp3E44oO_Szuvk9f6v1mGMqsSZg@mail.gmail.com>
Message-ID: <CAHk-=wgHg8z5WQBoypjyi0VPp3E44oO_Szuvk9f6v1mGMqsSZg@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        youling 257 <youling257@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 1, 2020 at 2:50 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Shouldn't that only affect init though? The getty's it spawns should be
> in their own sessions.

They *should* be in their own sessions, and clearly this problem
doesn't seem to really affect much anybody else.

But I think youling has some limited and/or odd init userspace, and I
think it gets confused.

So my theory is that because of the file descriptor leak, that "forget
the old controlling tty" doesn't happen, and then subsequent tty opens
don't do the right thing.

Maybe.

But it's the only real semantic change I can see in that whole patch.

                 Linus
