Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042820659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmV0D1Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbfJ1O1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:27:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34625 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJ1O1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:27:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so6812563otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRPcGUyjyYP3X+dNbFskpOrzjRKBib41L5MZ+6/IumQ=;
        b=dmV0D1FpdEoza5dLoPFkgv/FDQhs15CmGwpEPlAT0j2u3NQ2wpQzX8doVJJvQLp8JI
         Sfyln9GCLLrHiTDMC9FFAPtoCYXUkkrn8fg3vnkP0F4aygf3f7NO3lu8Np3KBwwjX0yZ
         pJc7k0q8BWbyZAOWshLqcmfonZjCgHkNKErJnqANJ2AVg7gmRmWRvkqxo90KRjbJ8Dai
         qvQZARVLSIAcnLYvMtXDOSAMNGQv/X31yNvWqRGx52VSt53OGmAo6QV2VHFtVEuRZNp6
         ulx6antxyR/+qm+LVSywVNCb06FB76QI/zVpjXVy5PTJwIo8185g2OOeqJm95/BKsGD6
         2F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRPcGUyjyYP3X+dNbFskpOrzjRKBib41L5MZ+6/IumQ=;
        b=U/4EVeBSCt8SCWuWfYTwDWeOw+rjQzeg5ztB/rMmnHdZZU8V0Ln1yyKYgLm69EFUOq
         A8iWqxRoyE6t1vDOdhLaINXW7ZrThLHvFqNvHIwHbo0Qi+7slxbk5RjGlLPvXiadTcGH
         hroUjLBTEqT41edPRHwFzLX7BaTv+KhqY6fhgTUDXkxvlONyxTAUgK2g2s2cTg9TQVPA
         e/li/8Z4t7YuQOw5HEm26JVY45fZ6b259TfGqaS7vi3SGoQoPQO8aTg2m+QeMQx8vPf7
         zZlBw1PeZoeLPPG4RuUqouudTUGjU0HbEDIKhWaq1Hc2mZduezzcoHT+hAsg7U5+X+2B
         ULGw==
X-Gm-Message-State: APjAAAUGIDrs5Ylrh5PksWsZ+VDt2heQ3ZUJI+dF2bClgcXF6xx87Xbj
        NrCl/j8t1BbmqzRompiJCYQGrhiQShp08+rTC+Y=
X-Google-Smtp-Source: APXvYqxIXLVM6e9Cd0PvKo8U2jwBqn1fDpadkb/s3M2zNmRTxnE/C0zaL4Y6+XA3oqXRyIcYfyzQxHt1ooMsBJciHlQ=
X-Received: by 2002:a05:6830:237d:: with SMTP id r29mr8845480oth.0.1572272835772;
 Mon, 28 Oct 2019 07:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191026235214.GA11702@cristiane-Inspiron-5420>
In-Reply-To: <20191026235214.GA11702@cristiane-Inspiron-5420>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 28 Oct 2019 10:27:04 -0400
Message-ID: <CAGngYiV0hCjXigVhijoTmwMfS4mM+hC-aVFsu6VDT-WmKsNsJQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: use devm_platform_ioremap_resource
 helper
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 7:52 PM Cristiane Naves
<cristianenavescardoso09@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource helper which wraps
> platform_get_resource() and devm_ioremap_resource() together. Issue
> found by coccicheck.
>
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>

This is a duplicate of:
https://www.spinics.net/lists/linux-driver-devel/msg129526.html
and
https://lore.kernel.org/patchwork/patch/1140024/

When you find an issue, please search the mailing list(s) first to check
if it is being discussed already.
