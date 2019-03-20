Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D82EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D449C218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg0Hyeg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCTSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:06:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37264 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCTSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:06:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id v21so2818478edq.4;
        Wed, 20 Mar 2019 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie/gO33ummQZ9638dodi7nVWJf2BdsHZwgBEndrbI2g=;
        b=Rg0Hyeg+v4P3KDeVUWR9x1ENh4cN9DLVjpEJmzuJ4Be3QZu9Vj2XSyqd7L1zCBdrF8
         YuqDg9kFDWEPJU19OSgS8NB5Ucn/lLEw0qahth5hpcs97IEmkTC1w//y5GCQPe+qVvPi
         7jeZcfOO3F+RV6Ee0f84/FovCxdbDV3GbQKIftf0prcUgLDf/nI/UX6ZIF16QeciO90D
         jC4tUd9SnZMPd+ZGSwU/UQAHLi9azeXBVKcvThNsElvS+C+W7Bx0tLcz/m94Q05rbKsX
         duy6onivQcfyNp7PvgTzJtm1oxe82myCF1pcYNDx17L0mtI5IsooYMKBJs/BaPZEK7lU
         Ip6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie/gO33ummQZ9638dodi7nVWJf2BdsHZwgBEndrbI2g=;
        b=GwfVKhdJqu5yWFjUWZ7srB4zvfOXBWHCF/Qs5zfnUQ3mKdZrfoUs8sQL7yQKS0BySV
         LScfMbDuyIDgmVUBs/cb+tTKzqhgvpDfmIDb3FCBqfjSAfRRSVAJj0c25BYLSgUF4dh6
         YbqnO8DBvtR9Gj3BD2WLgDSp0ZnGvsyxWqI63NPQ6O665e5W3/QNHFqqAvrRJil6wyj9
         s6WIFjyo9XNVJc1c9MuYhmzMpjGim3M4d27GH2Y0OzMIcnpjNuvrYD6BF5c1RKX+oi5P
         0A8iR12mmyFMaf42o4am/XmuGtoHhuk7RKk53HzA6lKyPiua42gC7ZvMvkUfJ869Jfmf
         4ACg==
X-Gm-Message-State: APjAAAUG5c22ailF50yFqoCRwBTrBrVkIClpE8KXZGaN3E0ePuMLyPgn
        G53mYdOBFOo5Yt7AGJEzzcM=
X-Google-Smtp-Source: APXvYqzGIvKMAv6dC9dmfcKFY3a3fP1SjMU+t+sa/mE4H6tu88/HIv297uk+s5jYNNE2HQ0u+5Tv2Q==
X-Received: by 2002:a05:6402:3cd:: with SMTP id t13mr21467312edw.281.1553105206072;
        Wed, 20 Mar 2019 11:06:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id t17sm549148ejb.24.2019.03.20.11.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:06:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: ufs-mediatek: Avoid using ret uninitialized in ufs_mtk_setup_clocks
Date:   Wed, 20 Mar 2019 11:03:40 -0700
Message-Id: <20190320180340.25795-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/scsi/ufs/ufs-mediatek.c:112:7: warning: variable 'ret' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
                if (on)
                    ^~
drivers/scsi/ufs/ufs-mediatek.c:120:9: note: uninitialized use occurs
here
        return ret;
               ^~~
drivers/scsi/ufs/ufs-mediatek.c:112:3: note: remove the 'if' if its
condition is always true
                if (on)
                ^~~~~~~
drivers/scsi/ufs/ufs-mediatek.c:108:7: warning: variable 'ret' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
                if (!on)
                    ^~~
drivers/scsi/ufs/ufs-mediatek.c:120:9: note: uninitialized use occurs
here
        return ret;
               ^~~
drivers/scsi/ufs/ufs-mediatek.c:108:3: note: remove the 'if' if its
condition is always true
                if (!on)
                ^~~~~~~~
drivers/scsi/ufs/ufs-mediatek.c:96:9: note: initialize the variable
'ret' to silence this warning
        int ret;
               ^
                = 0
2 warnings generated.

Remove the default case and initialize ret to -EINVAL to properly fix
this warning.

Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
Link: https://github.com/ClangBuiltLinux/linux/issues/426
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/ufs/ufs-mediatek.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index c3b78fc83d3f..34aecad04468 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -93,7 +93,7 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 				enum ufs_notify_change_status status)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
-	int ret;
+	int ret = -EINVAL;
 
 	/*
 	 * In case ufs_mtk_init() is not yet done, simply ignore.
@@ -112,9 +112,6 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 		if (on)
 			ret = phy_power_on(host->mphy);
 		break;
-	default:
-		ret = -EINVAL;
-		break;
 	}
 
 	return ret;
-- 
2.21.0

