Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C406821D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL6srznp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfKGIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:35:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44669 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfKGIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:35:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so1248839ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWbS4SdBYwL/ccROShNKX81fMjG6lxwrEjt2noFM/g4=;
        b=VL6srznpuYCV6D/0lZVlzDN+dlBUW4KvdMm/FC0QPAchGwVCGmPRjDRkZOrwPG+bUb
         mNYDV75Rh9xdzW2sxvyv3ZLhGTEliWMqctGp3AcrRZso3pAuFdFIZaQ8EAjHPdDBttto
         d5xpGBhs9szzSBHAxyLA1Ijgkm/emiQCBJprzDHKVgPRZ6UHUOugftCl7bhusCW5Sw+O
         anCvH2HLSKaTShd2wpaPlo3ztvLzJxsEW2rDXvluQx8Kzym4Slex22gz04piaWkfObU5
         paEuwRx3DOdxXNsfLj1qWXuKfJFLfh11I1KqhIh9IZCs3Yxq7rbejByObTbbHOs5Z9sT
         g6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWbS4SdBYwL/ccROShNKX81fMjG6lxwrEjt2noFM/g4=;
        b=kFqF5gV94cRUFP7CrXXP1RzVhNa2jLBrKBNXUOdmK8+Qeuq7kv6k8e5YoDg+OzAe2I
         T0OZC2UNlnfSqzrKOy1+favz64EZb33mkXD0EVdt4Ph3X8IYTRH8DuBxhIvYPwn1f0Ld
         lCws3vorKrzaLGRs8/h/yoshK3DxcfLZz8sxOSU+tTg3cgmGyUCBZo2KEvhzgsyA2FEW
         QYq1Ni30uf5IFgRiUEiGD8fnJugPUJR7jqfAHmaGrnx9SomVhUxk1BF4KPaj6BOx+YBu
         6Kj13qDg/qc247Flrojb7QRNSWlkDYddiOTOpBMxAAXMUoFtmjIoCue2pA88ZanVCtET
         r77A==
X-Gm-Message-State: APjAAAX98RQ0C7THmqSmhIBp7ylLgPeoJYgx9MwO5lLAmTAslQl95Dra
        g/woDZiRbtdW7xI6xiL+tdZka8ioEistiOfZLMnRFe8G7N8=
X-Google-Smtp-Source: APXvYqzLDy5kAcOhUPus7hOmfrlIFJdTpXZx1CGpWRbjO0h59ftvmHkp6F8fGRO+IoMHNXYUgHfXo8+pTOKnk5Y6Zyk=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr1400915lji.191.1573115738391;
 Thu, 07 Nov 2019 00:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20191105174359.01cb034f@canb.auug.org.au>
In-Reply-To: <20191105174359.01cb034f@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:35:27 +0100
Message-ID: <CACRpkdbhKF_N_ydVLPzCBnaV12fJWRSkmun9uaH1vhbxSwGmuA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 7:44 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the gpio tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> WARNING: vmlinux.o(.data+0xbd3f4): Section mismatch in reference from the variable bcm_iproc_gpio_driver to the (unknown reference) .init.rodata:(unknown)
> The variable bcm_iproc_gpio_driver references
> the (unknown reference) __initconst (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> (and similar for x86_64 allmodconfig)
>
> Introduced by commit
>
>   6a41b6c5fc20 ("gpio: Add xgs-iproc driver")

Mark Brown finally hunted this down and fixed. It should be
fine in my for-next branch now.

Yours,
Linus Walleij
