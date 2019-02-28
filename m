Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811972171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW9dLhzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfB1O0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfB1O0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so9803421pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=TPH1F6QaQBZy0OXRSFkFddIPa1FgO4WXkmvghRdHxvw=;
        b=nW9dLhzwtKcSF+9EcYgMks9YJfTfXaGZWsLZvdaKyOpc4zAMiW/DxV5nxG3ALRkTlV
         4Pta6iIdHT1UTIrcDuzjWLL6M4oEDi+9A3dR2GVhins4FO+kVC+MEwlzq/JJX5EdZF1v
         7sq3sqTazQScjcLk6gGpdNu3dNaOgxPh6gnyTRYXSZ7roZZ2Q1IUlcfWqOMij29id0Y5
         a+11h/1vpI5pHjJuOpLl61xEhQ76FFqgeY4jN24eoi/2X6z/GO5ORoNF4wCuhs/D/e7y
         AC2llNwgJD8M7xesx2imWhdPinAOxXzdS1PmbF7GIGNjN64vWV3DAscmQ/pUBpEGYEqo
         YStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=TPH1F6QaQBZy0OXRSFkFddIPa1FgO4WXkmvghRdHxvw=;
        b=t2Igu7DiqeWaVM+HN+nhACXrxDN5EBTch1hxlH5nVu4Taw5vasaWUlsuwKJbu4t7Vr
         GQ1Mh68F7yAGYh5O/ZmAhBRRUpLAXNSpEhKWpzXWqIFnAbe9X0SVrDUa15yTup2SXJLC
         hx2267Y/NyFdaZzJXIczT/bxGDqOe0Nri7bGRfopjbVcnyB+vtoWM5wmXhy8TNx+dusU
         1vt75NTUBX99zIealStvdNDmTwi/4xOmGNyN1ZSdtsvbHvQ9fCp8O1DHZn+DS4HNL8k5
         c5fM/m7OG3iM948vf2thYLKvhaAc79yNG0zJRNrxA4Zlwtg7MlVJIPRvYfqHRDf5qWGj
         Y8Fg==
X-Gm-Message-State: AHQUAubo0X7qvUIFk8WPCifm7m/fqlzBLzfkj/HKIYME5k9wTfXiabIQ
        Auq/dmWaoCFSwF/ah6LWy0M=
X-Google-Smtp-Source: AHgI3IaIfiBa+SKpNvdBXqmBfF/E2jePBuz8TGy/jNmYQrv/IjNM7Es/QWtYG24547o5JdQDK9ur5A==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr8924602pgr.48.1551363965942;
        Thu, 28 Feb 2019 06:26:05 -0800 (PST)
Received: from ikegamiPC ([240b:10:2720:5510:f9b9:4f97:abd5:501b])
        by smtp.gmail.com with ESMTPSA id y70sm22777080pgd.6.2019.02.28.06.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:26:04 -0800 (PST)
From:   "Tokunori Ikegami" <ikegami.t@gmail.com>
To:     "'Liu Jian'" <liujian56@huawei.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <joakim.tjernlund@infinera.com>, <ikegami@allied-telesis.co.jp>,
        <keescook@chromium.org>, <vigneshr@ti.com>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
In-Reply-To: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
Subject: RE: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Thu, 28 Feb 2019 23:25:54 +0900
Message-ID: <016001d4cf71$865e7b60$931b7220$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHOptjmAmqem5WpXlLpfOi8uScBsaYBk5wg
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf
> Of Liu Jian
> Sent: Tuesday, February 26, 2019 11:01 PM
> To: dwmw2@infradead.org; computersforpeace@gmail.com;
> bbrezillon@kernel.org; marek.vasut@gmail.com; richard@nod.at;
> joakim.tjernlund@infinera.com; ikegami@allied-telesis.co.jp;
> keescook@chromium.org; vigneshr@ti.com
> Cc: linux-mtd@lists.infradead.org; liujian56@huawei.com;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
> 
> In function do_write_buffer(), in the for loop, there is a case
> chip_ready() returns 1 while chip_good() returns 0, so it never
> break the loop.
> To fix this, chip_good() is enough and it should timeout if it stay
> bad for a while.
> 
> Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer to check
> correct value")
> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
> ---
> v2->v3:
> Follow Vignesh's advice:
> add one more check for check_good() even when time_after() returns true.
> 
>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6..3da2376 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -1876,7 +1876,7 @@ static int __xipram do_write_buffer(struct map_info
> *map, struct flchip *chip,
>  			continue;
>  		}
> 
> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> +		if (time_after(jiffies, timeo) && !chip_good(map, adr,
> datum))

  Just another idea to understand easily.

    unsigned long now = jiffies;

    if (chip_good(map, adr, datum)) {
        xip_enable(map, chip, adr);
        goto op_done;
    }

    if (time_after(now, timeo) {
        break;
    }

Regards,
Ikegami

>  			break;
> 
>  		if (chip_good(map, adr, datum)) {
> --
> 2.7.4
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

