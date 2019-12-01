Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F403BC43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7C215E5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575210527;
	bh=23kRnY9l6hVzpnOefG+pIrRM6Q4rbbUBC993dsfYmbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1t/YW9LLbafQfYtR54AE4fFqk63mnrzND2xe1R6U1LrapYnsIab3PcmwwFVGdNUiU
	 RzAxKjIRTFy7DdclL3A3trpLE63rOVWCJkJzqX/tK+GDcda6PxNaKMApFHB4MyyYVU
	 ujFRBhPU8ifpappxXfTagDw+HCDrJ0pLFZD7Hmmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfLAO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 09:28:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 09:28:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id m6so29548776ljc.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+vQUnn8WZrN5mb0l4AFAbcnrvnGqD368BEzSK9vrjc=;
        b=baMDvJB6x8ri1qgpZoRR0QipjSxPz0EEG55lu0LWWNDGxqXr35SvhtHnTdr0mqJtTZ
         3XZYFpoAzcmAwtQ7IU63gh+QOVuRVOxxwtk+Bpp7Vxliv+9zRWXvpPLzbOFBknSXNohb
         RpAk8a5uQkYnRxanRCUziu0yMVd0+EBWtyUL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+vQUnn8WZrN5mb0l4AFAbcnrvnGqD368BEzSK9vrjc=;
        b=XU0DGXT2ZU2T0C1cMj2pyrdOnUdmB5DYBrQloomT504ZZexEZqPlkWrrTMYwpUjrZ1
         xNG5CqV9YGRU+3ELFeTD80fcVvhVJmYfhVfhEvTlP7pdGOYiP3HsbQXnaOEWTaqgBMzD
         MU4tjsrjkgpF1XgYsBg3Zz6Lc9pMePaktJgH32ObcvF5tyyfm11YrTRrL4KDRUn5VIhy
         h78vSSSeGHjb0Vy6KCR0OFyDnq/puUZeK1MAdmstJi1x663wGkeEIEkfxBITbCWtc19b
         TQDg4FSPJdM0EEcOZK0Yz4N6E8DENR1Lht5lGbBng1HQLCgiZLSI6sYnBUcdjp90UXCJ
         4FHw==
X-Gm-Message-State: APjAAAXqp42F9j/L6Lnw7Yi5k0jFYsNM97oK8GWJ+ERl32Nr0hPS7kM8
        GbbqQEy2OPH1pp7J7eeOzKtOJ78pcxc=
X-Google-Smtp-Source: APXvYqwh+1EMVjesVwp4vp9zgbhSsWwcPt5nH7W998FlqrwDNdzIEEkJaOLiud275s31P9yi0qa3JQ==
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr2839624lju.120.1575210504415;
        Sun, 01 Dec 2019 06:28:24 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c22sm13413897ljk.43.2019.12.01.06.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2019 06:28:23 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id h23so485690ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 06:28:23 -0800 (PST)
X-Received: by 2002:a2e:63dd:: with SMTP id s90mr1932908lje.48.1575210502841;
 Sun, 01 Dec 2019 06:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20191130180301.5c39d8a4@lwn.net> <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
 <20191130184512.23c6faaa@lwn.net> <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Dec 2019 06:28:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com>
Message-ID: <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray asterisks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 10:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> OK, so it appears that the tool is working as documented.

Well, yes and no.

I think it's a mistake that --no-keep-cr (which is the default) only
acts on the outer envelope.

Now, *originally* the outer envelope was all that existed so it makes
sense in a historical context of "CR removal happens when splitting
emails in an mbox". And that's the behavior we have.

But then git learnt to do MIME decoding and extracting things from
base64 etc, and the CR removal wasn't updated to that change.

I guess "documented" is arguable in the sense that the git
documentation does talk about "git-mailsplit" as an implementation
detail, but still..

             Linus
