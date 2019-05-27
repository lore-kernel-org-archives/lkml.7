Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E22C282E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BBC2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3+uRtfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfE0A5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 20:57:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42338 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfE0A5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 20:57:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 33so5129415pgv.9;
        Sun, 26 May 2019 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BdjqEMSeAFloAhLZoevUhTsAoKWad+eEnvBrlK9h5Ls=;
        b=Z3+uRtfpG79M7BNLIRnXyfJ9sPDoZrhkSCxOgvoFc9SEyNIX2smauSYR+5ZY3OLoe0
         UZChnQV1zzNhZrbp/xrh9u26hkGf8dUSGIBdoNVwci9UKzRHSrKOaCkru8Lluk2UE4/D
         bmLzhEnYbWZXEw/3ywuMnG4N9Zxzpkve9Rftj4M6o6ixVFRKcB+7QZnfEnIklbbWAret
         faFm7mAtkrGKATtivbzexGyhYujoiW//bfBGlZoQuYtCW7odICmr5TLt32KzrW+EOdmg
         U2VVdTyZ6ymi4MnJ9oUpFBvLouEDvK1yC7tNdLZ02mL9oJ9K+l2LEouEYzD+IwFRYtgn
         z0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BdjqEMSeAFloAhLZoevUhTsAoKWad+eEnvBrlK9h5Ls=;
        b=lgKJuLSfvo/LvK0JmVwdXgX34K+0+15hukgFztvIqzSraUPshALQbYNBm+9+J45CJe
         EgO02HaglqWEGzsTaPkHN6Yac+j2i895pFg97aixOAduy7CyKPk1NH/8x+PfCkUUtrJX
         sZQBPvgbHYYjmIlldRcnMjeVidpjt3wFc81mLwhBklQdWZ1tONKaatBGxDGlIIsqb3K+
         mapGwGYn4zTWos2bHUJr/r0iTqQ4htSWhUsw0ujqRb955Iwy+qfKFNvu/IG+Pk7NJF3N
         SgekBT4g7ubifL2H3M6vdkKF9CZFctK4DKsDmOy22PcM/kyB3Y8iQPDlTN3t8Y0PD+jp
         eI1Q==
X-Gm-Message-State: APjAAAVmVW6uLZ2sHLEnTX0D54ufVNo7X7y10BL8BT0uogLrmI/t4aEL
        qqvQ/1XYy24DcJAAKInPnrY=
X-Google-Smtp-Source: APXvYqzy0BSN74KBEcCSKAmYIkrOIxBJWNt1E4+MRrkVmkqFsW4+GF+XXP/1yV6kW5FKUr5oW2NP2w==
X-Received: by 2002:aa7:8a11:: with SMTP id m17mr110690092pfa.122.1558918655871;
        Sun, 26 May 2019 17:57:35 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e123sm8962355pgc.29.2019.05.26.17.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 17:57:35 -0700 (PDT)
Date:   Mon, 27 May 2019 08:57:16 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
Message-ID: <20190527005716.GA17015@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from 
userspace. 'ioctl_header.ioc_number' is then checked. The legal result 
is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
fetched again from the userspace. Then _ctl_do_mpt_command() is called,
'ioc' and 'karg' as inputs.

However, a malicious user can change the 'ioc_number' between the two 
fetches, which will cause a potential security issues.  Moreover, a 
malicious user can provide a valid 'ioc_number' to pass the check in 
first fetch, and then modify it in the second fetch.

To fix this, we need to recheck the 'ioc_number' in the second fetch.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c..5181c03 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
 			break;
 		}
 
+		if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
+			ret = -EINVAL;
+			break;
+		}
 		if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
 			uarg = arg;
 			ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
