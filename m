Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA9C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525CB20863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu55dkKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfEYRoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:44:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfEYRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:44:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so5433759plb.5;
        Sat, 25 May 2019 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HBBbVG82QaZnu+ByWQxbSng2FF/splMwlHyR9tDwYd4=;
        b=Mu55dkKEf3Q0XHw1cx3eLiYIjHMoihyXfRYsyq2xBoW17W5etjNHXjPTO6n/jIS/Cx
         4keoFkMisEQxIQHTSfqVGCzyD/uLioOCzIQRqIWy85iLttEbdeRdau8pikqSiVZOf0Es
         6aew72FVU4pRYxhwDVah62vMZdtm8qblWq4Bh2jeRjlH9oz4z0zA4t52c9IlOKB/6Swu
         Q2XmvmJn+g5m+4Ub8wojUtrnVRHa8m9r8t51BeOIfurEqf4siJV1tettNa6wJ8dWuAdL
         wo03+vOhZHXn9L1YsqRO93JAYWcyTLXUMG/oAwav15ep2VoJ6xxHuWkfd6zebreIEChc
         3w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HBBbVG82QaZnu+ByWQxbSng2FF/splMwlHyR9tDwYd4=;
        b=I1JWzcBhyPx+cVUdBZ2UO15fN86Mpc9sINgNZ2SoxBV8me+apurA6Swq0IdZnM5m0A
         n3JpncdBZS2GCmT9wSYYDq8BlqQSon/9X9LB9pdllqb4Gfsl3SccxEvg3nY9Obn1WGh0
         Drshm06qUKyF+Q14b/XOLnwzUosKcRFky2cim1b89/Wqvnu264NmxWZV/BYtQgdNdDWL
         AiyQAWua9n9xTStt7pTtfd236OjUhvR9cqE4xE7co2er0FszRgHkyE2o9WcjoiuPoA2K
         EQXvLyRsQiYAG20PKlUN0vx8uLXJSK24EuOme6n0NBE4xh72lJuBi2tjLDrch267deHK
         eA8A==
X-Gm-Message-State: APjAAAXSpBJryK8B3JqShLpgw0Oitu2w9XYjyDpivohCf1bmrv3RCmKw
        e032RV/k0XyICVZc+n5ghl0=
X-Google-Smtp-Source: APXvYqwR/AYBys7vAhckZqKznuWDoJXs7aeyZs2h5ID5Khi81ZvERndEb8ALKTHiMkm0p7kAs87ztw==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr73906099pla.72.1558806261207;
        Sat, 25 May 2019 10:44:21 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id a12sm3624932pgq.0.2019.05.25.10.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:44:20 -0700 (PDT)
Date:   Sat, 25 May 2019 23:14:16 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] target/iscsi: fix possible condition with no effect (if ==
 else)
Message-ID: <20190525174416.GA21510@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/target/iscsi/iscsi_target_nego.c:175:6-8: WARNING: possible
condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 8a5e8d1..b6fb70a 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -168,12 +168,7 @@ static u32 iscsi_handle_authentication(
 	else if (strstr("CHAP", authtype))
 		return chap_main_loop(conn, auth, in_buf, out_buf,
 				&in_length, out_length);
-	else if (strstr("SPKM1", authtype))
-		return 2;
-	else if (strstr("SPKM2", authtype))
-		return 2;
-	else if (strstr("KRB5", authtype))
-		return 2;
+	/* ret 2 in  SPKM1,SPKM2,KRB5 cases */
 	else
 		return 2;
 }
-- 
2.7.4

