Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D2C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34B20726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="geLxmcZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOQq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:46:26 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55074 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfLOQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:46:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47bVfT5cKxz9vKZD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 16:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3XO2GuLoB92c for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 10:46:25 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47bVfT4TFxz9vKZ4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:46:25 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id x186so4648642yba.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qe+Uav0n6Sb4lk25AgUnese0gA+AsOsF8bWtX8C1yxg=;
        b=geLxmcZCOawsEqsPRQUBN+/+zKoVbXdbZUPrh4w0BeJxhJLLy4PkzAZgGBIxCmGrhI
         BC5kuVlKVF6URRzJ3kvupYBS7s+u6TShLmsEd7NObNdnM1/aDvX6YlORBzvP+pE0C3Kz
         OJVgjLIhA/BxACFlDbIAagX68/bLyW69AqNwrFjMGJJFC1XcLSMB4khfN4Y656nGVGTK
         dmaXkSzj5uyj2pGDfw/9nxMA8g4J4/O0AVxfUcARKwfGdObnLbA4/jcTKkr5edBj+kSM
         lt/iYPNozm1BziQe3yK17ASpFOCRgocFxOk0y2jpGNV8eBIM2JHTZ+70mBRal9lmyX7P
         7s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qe+Uav0n6Sb4lk25AgUnese0gA+AsOsF8bWtX8C1yxg=;
        b=b7FDehXmLT7Alnr+vMFzGnERx4GU4iMZgqn0e9ZjouxZoBQACLiqZTbcOrNzNZXvST
         OVvK8YPOcUku3oAqFGH8rJ4ODKO7DgFD5JDphLl8ibYCGJYRkNbqXMT6RW0Kq2qZ3wVu
         LAyHtaIqHkmVBCj2Pe6aJ18T/qj45soz3Z8LI74dI76nGUYyvGLCoZnlOfVBLT7mIGI3
         xSzvXb2AUqJGHjGo3DlOQFtJqMtijXDL1rEw0IMm1q+OxTsJNecCAsCn3Y8rKbABh3um
         6dUkLGITUnQT+cnGfFCU6cM082Lyl/56QyN1JaSq6QOQvtSrbwKWrrjQQ7curb/ROD4l
         w50Q==
X-Gm-Message-State: APjAAAVADvZJYW/aM58YCjgKjnWSyDroH1GszGmDExscJ31M3Fl5YdoK
        MPXxlw+dtHdl/4etF2i1sgh8j584w/FbUJS4XMEzpYMD9NXr/LpzXc5q4XgKVR9/uDFoG51UcQJ
        PaK4NP+FTXZQ6lC1lP8Y+YI1nY5CQ
X-Received: by 2002:a81:3a0b:: with SMTP id h11mr16718848ywa.217.1576428385132;
        Sun, 15 Dec 2019 08:46:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0he0c+V89zl40cSAULuSQ6fzVPtpuzFAtxEGcaiXM5OmacimtBQk2SMZ+2yDZrAXlQvxdkg==
X-Received: by 2002:a81:3a0b:: with SMTP id h11mr16718840ywa.217.1576428384872;
        Sun, 15 Dec 2019 08:46:24 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i81sm6961408ywa.103.2019.12.15.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:46:24 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: remove assertion when journal_info is not empty
Date:   Sun, 15 Dec 2019 10:46:21 -0600
Message-Id: <20191215164621.25828-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfs2_trans_begin, avoid crashing when current->journal_info
is not empty. The patch fixes  the error by returning -EINVAL
instead of crashing.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/gfs2/trans.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 9d4227330de4..cef8816ae0b4 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -31,7 +31,9 @@ int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
 	struct gfs2_trans *tr;
 	int error;
 
-	BUG_ON(current->journal_info);
+	if (current->journal_info)
+		return -EINVAL;
+
 	BUG_ON(blocks == 0 && revokes == 0);
 
 	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
-- 
2.20.1

