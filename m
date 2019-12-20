Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61191C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21C2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865305;
	bh=+XL7ZInXX1HHmOCI5izumvXTe4GPIdZh/XmifK4Czh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q0mlb1Wg+GnGOs1N0TGwEbsFxDsX0Cb1wtVO5c/45CwCegQF9xBigm8pXKsG0kbk0
	 HBsdKEw3q1YjPJS9RKFT8p6kNL/gAX72nTl6S3rQ6W5r4gs99nS+Q91fqQ6S9aE2R8
	 1M3v1SDFj319UU+gsiJf7f6V58TnikOWujcKv5JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLTSIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:08:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35181 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:08:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so7732379lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXVFal7Vfx9p/0v6Lfo4AszqTDh48OL14YxtwAoozRw=;
        b=S8tRDL7EKj2cfmNGSzq9/Y7J88woUCjBT1gnU/MsJm+oNAd2FtQMXWc8JR9T4yMk6Z
         W/xJKyur9rwEu0sOZYuzVaJXfvy7UqJxeCkSdc9eWrH/bJ+gd7vrM+qCYygBZmCZWcfC
         QiCG2fO9+1AooB6euumc03SFYpbbHQeUB6w1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXVFal7Vfx9p/0v6Lfo4AszqTDh48OL14YxtwAoozRw=;
        b=aHB+D+5AvZKyiyE00iI/AuNQG/0LYNzr+bwvSIn/3+uNE3H/HLDqLULWnABBMnk7+k
         zXLUByqBjPW3/x2U8BO2Ak/ModawpSyPDKwXPBkLcy+zuzFBl9e38PDmoF3HO+8UWUza
         8Cnx6U0faLCFvqpjo9tnkSGPyCyEjV2XtU4xnFscexaQynGculoJokagUIEOhnZpJZt/
         kRDHjTt5+BYvVQte/VJ5GeVX+tBKQ5ins2YGrpbdli2lorFD/yYlOI6KI1O/jkPZBk/X
         ouzeEenZBJStub+nNRLBWCyjOY/XcXAdP/AxaR9eqm2RL/mYFMKzvZmDCufIg99fYj1u
         yyvg==
X-Gm-Message-State: APjAAAW14xCMa3gU8GpicCDJose0zx648m5hQCirqgdeglgo7fh92KB+
        UMcfkqgKNMAGllw9Nkl5+2/0IEiP8rQ=
X-Google-Smtp-Source: APXvYqyzxVTvpngDk9afBR3yvHnT4ilV3q1VDLvAuUQd62net1rXyQnw8ekzeOzjr4niNwP71UHQ/g==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr9893826lfm.189.1576865300770;
        Fri, 20 Dec 2019 10:08:20 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i197sm4429198lfi.56.2019.12.20.10.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:08:19 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id j1so3533226lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:08:19 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr10813815ljn.48.1576865299304;
 Fri, 20 Dec 2019 10:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20191220070747.GA2190169@kroah.com>
In-Reply-To: <20191220070747.GA2190169@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Dec 2019 10:08:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
Message-ID: <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> The last tty core fix should resolve a long-standing bug with a race
> at port creation time that some people would see, and Sudip finally
> tracked down.

Hmm, looks good. But it makes me wonder if we should now try to remove
the second call to tty_port_link_device()?

Now we have a number of helpers that do that tty_port_link_device()
call for the driver (eg tty_port_register_device_attr_serdev(),
tty_port_register_device_attr(), and the just added
uart_add_one_port()).

But we also have drivers doing it by hand, and presumably we now have
drivers that do it through multiple paths? I guess it's harmless, but
it feels a bit odd. No?

            Linus
