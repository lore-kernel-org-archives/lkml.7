Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B54C74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F621019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="J6xUpl3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGKNjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:39:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39340 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfGKNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:39:49 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so12586865ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=J6xUpl3LGrcfXZq9XYXjgjQhRvk3EDm/aUvIPtVRdsn6YwB6MeoOX1bVjlXjCz7GyE
         mhN/3QX3ZTDmfEXUyCsrpXqJ3Y9OCtW321tJHFk+zDlCzYd7UO0cQrTZADPvDL0x7au8
         5bqEPMKZS6j4jyKs2f5KGpgI2P4Z2U2RLtUhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=M9zu9pPE5l6jjZMz0JCT//1BzVf1kyYofzWz/XbkB+hPGA8Eea4nSHbOuow99Lt4Ri
         TyxB+RLZx+JU5YTje7sUClsQTsMRV2Pca7dl4NcBanyQV0J3i7tGwntUr5OikCK+A2oF
         VmsssgBXgL1X2q0vuHNe0HswPcau88p5G9lX835JdRB8CcD0O2Q6hWuJoGh5my9Q3fLU
         RQg1AL0dly8T9Snp8a17tQZhMryZj5nBfDujcVCnbyCyBbMZWSxhAQUSyg47mUKopG0L
         MBmbLALZ0gZaPufviPg0PxgtKHllFr3DfQNoeiH/brjZj1cA9Hkf6dp8UPn6zCueI1br
         FEmQ==
X-Gm-Message-State: APjAAAXL3+IYxdTKhckM4YmIkV0Sp6VN7lCOTUXQlJ4G5f+auEZrhUEZ
        W2ctSDqmzrva+88ayQrM9xfnMA==
X-Google-Smtp-Source: APXvYqwqul/LDm81/jCmBsHIlGWxPfbJ84LDnGDdpTrjfTFg+kRxMtPm19SEDIvbJTj8KkcITbgJrQ==
X-Received: by 2002:a6b:5115:: with SMTP id f21mr4493812iob.173.1562852388663;
        Thu, 11 Jul 2019 06:39:48 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id u4sm6035902iol.59.2019.07.11.06.39.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:39:48 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors on 4K media
Date:   Thu, 11 Jul 2019 08:38:52 -0500
Message-Id: <20190711133852.16887-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711133852.16887-1-steve@digidescorp.com>
References: <20190711133852.16887-1-steve@digidescorp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UDF creators (specifically Microsoft, but perhaps others) mishandle
the ECMA-167 corner case that requires descriptors within a Volume
Recognition Sequence to be placed at 4096-byte intervals on media where
the block size is 4K. Instead, the descriptors are placed at the 2048-
byte interval mandated for media with smaller blocks. This nonconformity
currently prevents Linux from recognizing the filesystem as UDF.

Modify the driver to tolerate a misformatted VRS on 4K media.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/super.c	2019-07-10 20:55:33.334359446 -0500
+++ b/fs/udf/super.c	2019-07-10 21:20:58.138382326 -0500
@@ -741,6 +741,7 @@ static int udf_check_vsd(struct super_bl
 	int sectorsize;
 	struct buffer_head *bh = NULL;
 	int nsr = 0;
+	int quirk_nsr = 0;
 	struct udf_sb_info *sbi;
 
 	sbi = UDF_SB(sb);
@@ -780,11 +781,27 @@ static int udf_check_vsd(struct super_bl
 		if (vsd_id > nsr)
 			nsr = vsd_id;
 
+		/* Special handling for improperly formatted VRS (e.g., Win10)
+		 * where components are separated by 2048 bytes
+		 * even though sectors are 4K
+		 */
+		if ((sb->s_blocksize == 4096) && (quirk_nsr < 2)) {
+			vsd_id = identify_vsd(vsd + 1);
+			if ((nsr == 1) || (quirk_nsr == 1)) {
+				/* BEA01 has been seen, allow quirk NSR */
+				if (vsd_id > quirk_nsr)
+					quirk_nsr = vsd_id;
+			} else if (vsd_id > 3)
+				quirk_nsr = vsd_id;  /* 0 -> 255 */
+		}
+
 		brelse(bh);
 	}
 
 	if ((nsr >= 2) && (nsr <= 3))
 		return nsr;
+	else if ((quirk_nsr >= 2) && (quirk_nsr <= 3))
+		return quirk_nsr;
 	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
 			VSD_FIRST_SECTOR_OFFSET)
 		return -1;
