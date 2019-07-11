Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D76C74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A61C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="bYHNLj25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfGKNEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:04:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40242 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfGKNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:04:34 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so12309225iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=bYHNLj2555c6nQAGFXIgsx02XGYUdwS5556hzj7AhU7eSNV5HudXIMxO9o/Tg+vHvR
         J/JU8/EISnQ35BHU84MseRjDJTTCks5voIBeOq6zBVfTXscVdANrtBX/Ly5lUjLkkPYz
         qLX9cR8Tku9cfQgOFkbDXFy20RvQEPcn7JRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=RuJHIedNgzAvEHrMC7ooLYmI3HlwV6uWkuQc7YBuE8ZrCBN5ORMpzw/K+BZFZ7dca2
         AT16wvkGLeLJoB7KYiXO32t+zgE7xqwjuQb0Evi7SFbFHvBA9Q9pCwgDitVMB/6Cyvnc
         2gYAviM1oa7Fx47flwn3Q9vkM+NJlCBPNrjcM8Pay7wCsOGx9VrwEBKiRH1kclo/srXa
         Nl5/CdxTKhvN6cvnYDpQAuOwLFrTI0RJX+Pzr8giq/DFGHNXtst/F4iAx3jSU5xBKmtj
         X1klWZr+ONvx969OXYBNsfx0bZYKiehbzlr5Cj6gNhYdWtv0aQYub/qpt6chllc1Kw/D
         TJIA==
X-Gm-Message-State: APjAAAVKk+O6CoHYjD9GtQp+H5N97B53vJ0iNSnsMgE55Q1TVAil7coE
        6mNoYUanbyazfXxU9wv8V0LUog==
X-Google-Smtp-Source: APXvYqzKJRu7RRE0OzusmNdv5ntOQE2Vuy0JDu0xeE9VyYwevfdkM4d9gSmDfN4PNtDu81ZjH3M9/w==
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr4220181ior.163.1562850273790;
        Thu, 11 Jul 2019 06:04:33 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id l11sm4051951ioj.32.2019.07.11.06.04.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:04:33 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH 2/2] udf: support 2048-byte spacing of VRS descriptors on 4K media
Date:   Thu, 11 Jul 2019 08:04:10 -0500
Message-Id: <20190711130410.13047-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711130410.13047-1-steve@digidescorp.com>
References: <20190711130410.13047-1-steve@digidescorp.com>
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
