Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE32DC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3C92081C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558824480;
	bh=l7O3TjOqYyNXNH0OShAD1lcMEvmuRIcslnZ/UkUrAig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BaexdrXl8FgOjLUDpwzUAaK+6f/+/Srb6NGPefZUzUwLXTNLaUQmT4VHakisnM/OE
	 j7JE0stOGUJ9dETGY6j7YLAiC5SUlk2DmffmXhOJMTxb5Kc6d08dXICbBT+3jGr11p
	 U/aeYNUWKQbS7mr+ITL9zsu4/oDPu5ce/+07/n5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfEYWr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 18:47:59 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40840 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfEYWr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 18:47:59 -0400
Received: by mail-lf1-f49.google.com with SMTP id h13so9543859lfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQ7BwFJoSpj9c00vKeRnVyly5w7f9yCUj7tcA/rh3jI=;
        b=WY+YVPF3/zOv5Kcsslhaz8aZ/Mlbtf3JUVIVnPtxzoRf74+sFlW30W+zMWNRTLPrYQ
         jDT1E/1XkErHjhCr9Jtg7z0hMKjtIbC4WMUl2smmZDMPrJOxEWDexDbR56wjtjp3FDLu
         floHc2SPI26tjURl5ZUQdV18alzjA16vh3emw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ7BwFJoSpj9c00vKeRnVyly5w7f9yCUj7tcA/rh3jI=;
        b=bIJD9/nPGytR4lTlBB5m989Cgn1/gOuvzyGrJSFvUDxrt6GN7J4rWILAlL8TTr8H0r
         klLht0neztHAHYNBeKvDeZuQM0OoG99jH03OXNL4yDSc136EyGLnCPEbpFB9/RIQ9vXi
         LgfILvGJL/f7qW166g+WekPteL3o+ecvdkswiikb3zEr8cgingzKOKPTNtdNFziTpToj
         CXhXeGCU2B/JNarKbmLobTN2HUgbzZEzAZRH2JFNTIXtcKWDWhgRYzTahQIj5uuZLTQY
         PFi/OFtDwIbPAFQ4NfEoRENMKhobHdNrp0heixyrGop3kVPktMW1Vz4mnKaEiD+uXwqa
         IQog==
X-Gm-Message-State: APjAAAUFXI2bgGks15nWFKdfm8MXAW18zX3Mlr+ZL9iZFmYRnjL/v+PJ
        A4MB/aB7AdzQJwV3lrMIdxeo5drbc9E=
X-Google-Smtp-Source: APXvYqzxKFvEfX4ePYcI4woslz2LhRp13WrV54rxx6QhAjygaSrhxbf/0OO+hYNJHEUzpTf/WInn0g==
X-Received: by 2002:a19:ae01:: with SMTP id f1mr16106088lfc.29.1558824476580;
        Sat, 25 May 2019 15:47:56 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r11sm1291194ljd.91.2019.05.25.15.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 15:47:55 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id f1so9528777lfl.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 15:47:54 -0700 (PDT)
X-Received: by 2002:a19:7418:: with SMTP id v24mr10729858lfe.79.1558824474432;
 Sat, 25 May 2019 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190524231106.5812936b@gandalf.local.home> <CAHk-=wgseDTYAw-O7=21j4vQmufm=eZCMqeq9Z+PtCst9WkmnA@mail.gmail.com>
 <20190525183951.1dbe9a89@gandalf.local.home>
In-Reply-To: <20190525183951.1dbe9a89@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 15:47:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw21yNAwND=h6so=fVHeks91X+xRMBsxNAy=-=gGSO4g@mail.gmail.com>
Message-ID: <CAHk-=whw21yNAwND=h6so=fVHeks91X+xRMBsxNAy=-=gGSO4g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Small fixes to histogram code and header cleanup
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 3:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> You mean this one:

Yes.

> I have it in my queue for the next merge window, but I can cherry pick
> it and send it to you directly now.

Oh, "next merge window" is *way* too late.

This is a serious problem that causes tens of lines of warnings, and
may be hiding other warnings as a result simply because developers
stop looking at them.

Warnings are bad.

            Linus
