Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEDE22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mogqm3X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfIDTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:49:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfIDTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:49:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so8329618pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=MJZ59OzDe/mWiaBLP8jVMpUtkGX1PofiwqpjWM71xRs=;
        b=mogqm3X+Rch8sVC/xusY+3xSkTL37ezlnaM47EZw9OfMVezEYCUSs/FG5vdl7MUPX7
         QmQEzuiCg8Lry0hMmkMejJqeKcbfGDsB746Aj1Shx4mVe770eFR0kRiVJzcRSlW5mDuj
         jY7mARh/mZmxyceKWn0NobxwgLKC3+U36hKiQsrHSq5uSsvyfFjvkXvR4Ifl5ZI6R+/z
         KgI1dK5KqRpOkuSJ9NeHS5EAOas0i22dkvkVlruesul/iriYXoFZpojSIlRAKnb/oVTe
         eF1MQRe+xAh1ciyZkbcGnY0l+gG01QLHYV5D8pKCQvJ3pq0acnOmh355G37ucRU7Ltzm
         v5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=MJZ59OzDe/mWiaBLP8jVMpUtkGX1PofiwqpjWM71xRs=;
        b=Q33NOAvt/nirwXdZY9p4zZC4lIB/hh+XhU1e75WL2xf6jluOov80wh5fYh0poGC76M
         p9NKk+YAwEXPz5tprHosECKd6RbVz1Slfaa4PsAwA4sRDWre+I6kUF2oU1pNmox/XfDG
         lKXPzE5o3cLnMvuxC18RW51m7Olh2EAs+Q8OBYqdV0P6Umd7fDIklj8QYJf87YUKDVOB
         Ow2PNeel6C4LUe3HJRxhdzR8ntyulbS8sOJglX5M4YUFlY7CmnloSNHC4vt0C0P0VPux
         8PFsO3g4wpzTWXSzEsLzlL/Z9i+nDeF0hnlfOs/sxwbKL2LzfXm7JBNQOvTzwJXrzLA9
         +phA==
X-Gm-Message-State: APjAAAX2DQDnXJX0/P93Zhe9XL2sjuIkoufbVdu88shP2tRE0Cn+UusN
        4RHVBSo7IPi7xIdsxxSy7HwC
X-Google-Smtp-Source: APXvYqwmOdnog1Tt35IIPB+oPdZuaX+clxfT0GSE87X07y62HoChl0HSmZq2tosZO3IAaK0o3gSTCA==
X-Received: by 2002:a17:90a:8911:: with SMTP id u17mr6973459pjn.128.1567626574655;
        Wed, 04 Sep 2019 12:49:34 -0700 (PDT)
Received: from ?IPv6:2409:4072:994:cdd3:65d0:8a4e:9992:92e2? ([2409:4072:994:cdd3:65d0:8a4e:9992:92e2])
        by smtp.gmail.com with ESMTPSA id y194sm613378pfg.186.2019.09.04.12.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:49:33 -0700 (PDT)
Date:   Thu, 05 Sep 2019 01:19:27 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20190904130457.24744-1-yuehaibing@huawei.com>
References: <20190904130457.24744-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] scsi: ufs-hisi: use devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com,
        dimitrysh@google.com, kjlu@umn.edu, tglx@linutronix.de,
        yuehaibing@huawei.com, stanley.chu@mediatek.com, arnd@arndb.de
CC:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <56F1F139-26BD-42D6-8C24-118DEC0D0B97@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 September 2019 6:34:57 PM IST, YueHaibing <yuehaibing@huawei=2Ecom> w=
rote:
>Use devm_platform_ioremap_resource() to simplify the code a bit=2E
>This is detected by coccinelle=2E
>
>Reported-by: Hulk Robot <hulkci@huawei=2Ecom>
>Signed-off-by: YueHaibing <yuehaibing@huawei=2Ecom>

Acked-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg>

Thanks,=20
Mani
>---
> drivers/scsi/ufs/ufs-hisi=2Ec | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufs-hisi=2Ec b/drivers/scsi/ufs/ufs-hisi=2E=
c
>index f4d1dca=2E=2E6bbb167 100644
>--- a/drivers/scsi/ufs/ufs-hisi=2Ec
>+++ b/drivers/scsi/ufs/ufs-hisi=2Ec
>@@ -447,13 +447,11 @@ static int ufs_hisi_resume(struct ufs_hba *hba,
>enum ufs_pm_op pm_op)
>=20
> static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
> {
>-	struct resource *mem_res;
> 	struct device *dev =3D host->hba->dev;
> 	struct platform_device *pdev =3D to_platform_device(dev);
>=20
> 	/* get resource of ufs sys ctrl */
>-	mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>-	host->ufs_sys_ctrl =3D devm_ioremap_resource(dev, mem_res);
>+	host->ufs_sys_ctrl =3D devm_platform_ioremap_resource(pdev, 1);
> 	if (IS_ERR(host->ufs_sys_ctrl))
> 		return PTR_ERR(host->ufs_sys_ctrl);
>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
