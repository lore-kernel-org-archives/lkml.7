Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A585C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC12206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTSlqHga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfDDSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:00:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43197 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:00:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so2192484qkc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=kq/wjeN8F4rA9HOB0Z1tV1Vf3x7Te/GvuR/6Hjg2whM=;
        b=WTSlqHgafEG2oGzO98VxHt8la29Tlp6kFCi0PiXMFNA/3HpmJsiZp0dA070KiPn1nd
         +TZmf0H1RMnqHsDOIskcsifOXoiLdXd34zYmsIsT7TO6+5PsZ3YVf7mru6FrGuzGv6lh
         DnjX0COtYuEfe2sabnyzC5ocUvOAKmuPWx8sbF1Bt1y4yPbvlO6YOogKAdlN6qqsNASa
         7ebumpY21xPxHecGgmpFW4e1unolMfiHgODKoKA3rMD+bDiQsPkZmV0pvp9vbV1WuFHC
         Xp5HPOT2wSD8465Isuvx/RVhhOd2SfZvjXxe4b3NineruletIA9HQRLpJkmBK+25cyDz
         UEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=kq/wjeN8F4rA9HOB0Z1tV1Vf3x7Te/GvuR/6Hjg2whM=;
        b=fvwwu3hMamST2gDwg0KBVTHIoV/SiSIwVE5N9bUVra+qPeolJSJARXjjM8S7X6M6f+
         kpTfe220/TOCA22MqdHFa69ZUOO7u7cDnG2tdSwcE13U9hzmrldHP2/T7Z6Arre0wMU2
         8LVYsbignjdq+EVW/k9a75I625nOSnIJKA29Y8fo3RvIi3ulQnhko05jRzWx3CMEhVPP
         tng7xrP+uf8BiNqbpozaCxsqAn8ro/8xmp36z8pPOtrt4qMBrMIQJ2q5P9DGvk+9WCSV
         mgdAuppuJ8ZUIz+0fbkyx5jhWDsTbEGAHYOwu3o8yJpYY4G8knIT48IYISRnL6YfXA10
         +HEw==
X-Gm-Message-State: APjAAAWKXKo6/tFvN3vTTjcHCHYWzlkzbqxQUAtrjG2F3SogBfyLgLPn
        DUxAEGhui5KWD/ipzETNwIQuMC8+
X-Google-Smtp-Source: APXvYqyZ/pgbt1p6y2U6rzuAd6lfugaWvVSapsM2kuIKxyCgdCf+6M1x6mFIenYSa88T9eT48EKieg==
X-Received: by 2002:a05:620a:30a:: with SMTP id s10mr6251639qkm.54.1554400814929;
        Thu, 04 Apr 2019 11:00:14 -0700 (PDT)
Received: from BatteryKernelELD.corp.eldorado.org.br ([200.148.226.100])
        by smtp.gmail.com with ESMTPSA id m189sm11505742qkf.2.2019.04.04.11.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:00:13 -0700 (PDT)
From:   Cesar Santos <dev.cmsantos@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] [PATCH] staging: vt6655: upc: remove double blank lines
Date:   Thu,  4 Apr 2019 14:59:08 -0300
Message-Id: <20190404175908.14283-1-dev.cmsantos@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning "CHECK: Please don't use multiple blank lines"
on upc.h

Signed-off-by: Cesar Santos <dev.cmsantos@gmail.com>
---
 drivers/staging/vt6655/upc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index d028ad2ba0d4..e086ec6e77f7 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,10 +20,8 @@
 
 /*---------------------  Export Definitions -------------------------*/
 
-
 /* For memory mapped IO */
 
-
 #define VNSvInPortB(dwIOAddress, pbyData) \
 	(*(pbyData) = ioread8(dwIOAddress))
 
-- 
2.17.1

