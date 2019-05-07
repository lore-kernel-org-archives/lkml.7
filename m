Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469A1206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557256724;
	bh=67tnEF9PjYK24nykxEO2iZX5wFuosHz9Vizdyl+/cPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mkgd7oftdfn+R2Mac+jtVVJxKDoIpP7fmJpJ0KEBR/vaY59iRxUFowkvEEdISnveZ
	 KV/tTCaNbzKEBZIYI+4IsHxoBxDz07a8z2lRp2UNkSOgmLFL1QpGwhYlanm9y/tRcV
	 qkksk0liSY7JAHTNns+veS64Jlc+hb64+T0bX5+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfEGTSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:18:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41378 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfEGTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:18:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so15334106lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtF42CqL123SSRl10dCYLKTcv2hhlfrc0BUh3e4ZyQA=;
        b=MDNkFF5/XrluyqCwIMfLlVttmyMxCjmI2wG7YwAycEXZCEOWsEc2x6MssI+Rlbi/iu
         yQsVKdRqLbBtdsbUldIBJx0z/BfyC9QXVCs0johj7JFgnda+gRiZW//uOT35LvQueJfP
         e5w65jeDG6ogGawBTKsmIemyIVj87dZWPIMVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtF42CqL123SSRl10dCYLKTcv2hhlfrc0BUh3e4ZyQA=;
        b=rbGSGeK1GHprd1kQ8X/LBLS0ntNqDnmtzLEuBd7qe3W/19HxrzWSRr5uPD/A9kef9k
         f9NuCouAvvDT6xWH48gyhhfEGgcNmDhwvmlLZo/LrebUVTpdRkj4xzU+h+oL0Gf85WDH
         +WqXkS2VHkEcGuO1XIHWBcmlI6veumT9eOabSv2biXVbTNZfy9S8bDGLmxoaqOB1QY2h
         E+o9y7UOpEtY1VbtBv6L9gnLuXmyBH1+sK7kIyMdSx6e9mzu5O56NpErzPtlRuJAsB7O
         XtYd6nIJ1MXkbepA+rUcgHuUNEYJxbUon9YKe1+o+dZdF1BZoEJn1onN7jnUvDW0pMBi
         1dpw==
X-Gm-Message-State: APjAAAU71XYxO9xNKv0wKCVA6tiwaMhxYnXN2QAgyQuRFNa4/KXHoGIi
        xHwr2NotN1Fjh8u9A34H920KrjSs8uM=
X-Google-Smtp-Source: APXvYqygigNN+qGC8QLLdpZ4FE/dv77DwgnXlm+D0yJLHUu3IAmgbl5P4fUFHehwCmUVC/rsDIENgA==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr18882082ljk.73.1557256700856;
        Tue, 07 May 2019 12:18:20 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g8sm3661958lfg.4.2019.05.07.12.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:18:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u21so6219725lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 12:18:19 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr3212578ljg.94.1557256699430;
 Tue, 07 May 2019 12:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557162679.git.kirr@nexedi.com> <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
 <20190507190939.GA12729@deco.navytux.spb.ru>
In-Reply-To: <20190507190939.GA12729@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 12:18:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
Message-ID: <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 12:09 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> I've pushed corresponding gpg-signed tag (stream_open-5.2) to my tree. I
> did not go the gpg way initially because we do not have a gpg-trust
> relation established and so I thought that signing was useless.

Ok, since I hadn't pushed out my pull yet, I just re-did it with your
signature, so that the key is visible in the git tree.

                   Linus
