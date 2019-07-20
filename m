Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D2C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D4A217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfqRLGij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfGTRah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 13:30:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfGTRag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 13:30:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so35184591wrf.11;
        Sat, 20 Jul 2019 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fJgbCuAECmv3kfB4MA6EgJmQcyRpzLZ4WuJAsybRjN8=;
        b=lfqRLGij66+60MA1k3iSArOGdlftIxVMkYCNSD6Tf9o+qfWgcYv9oqnMy7NFIXS6W/
         uxeiqyZqFcZJD9JSxHt1ciJ3HODq1d2ondO7jsAVs/egRkxk7B8bd5wKzjI4ZJ5OiL1V
         G8gsQgKqyKpBTSHAt5TePhfPZi+Y0Nvbyl6ReV+TrzQmqT8VZyqJndA/pjCdA32PTAtx
         yFM59ewhYyZqNM1/hUkGFwahnnWUvlDn6/cjUBBfFeGCfzPMFuZO0hVPaI9pFjDSFU3l
         O5abER266f855VAySy0xTTnuSr3zrao0ClFxX/NsoM/K3EC4QvN864avUuWx8o2exWyx
         Ggtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fJgbCuAECmv3kfB4MA6EgJmQcyRpzLZ4WuJAsybRjN8=;
        b=V6LjHM9/90kzJ/DNELidRCTT0a1P1QNwEhqzyKKBigrTxGR9uKEXUKHpVJs27RzUml
         M0A6USivEvj8IPi+dpyTdRTdrZSXmoR7mBRel8doZQT6q1IqB+IP+2/BBwq4kav8nIKr
         LyAQ79bxrLQY+M3KFchKAfOrcjqKFYgt+LwgiveVTuDvURr0ifDLPTYZbQwn56qns7sS
         eXUn24Dm0wKmbGttQzGDH8XyGs1saJJNc9H3Hg5K8wL8j3RsubkU4MO7hOkmebap7i3b
         ajl0pAVozR8NxZ7M1W8HuE14j6MX1znId5nf7+JlMLsFusBPWzIKD1BXhqeHOVE3MYDx
         nEOw==
X-Gm-Message-State: APjAAAWl4O3UKMa/ufSlmYwNrbTX8ZaV/Ali43gfQOamcutk8GT+LFZO
        mOTiUfHmhNAybir6kPvAjYM=
X-Google-Smtp-Source: APXvYqwUxTYruLPCW55tBDAGwuiBWOVp31p2bzpwjwwxF9Jb0vJWD5gDw1GmdN3LKODR216InlwDpA==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr26986126wrw.64.1563643834525;
        Sat, 20 Jul 2019 10:30:34 -0700 (PDT)
Received: from localhost ([129.205.112.209])
        by smtp.gmail.com with ESMTPSA id d16sm26820447wrv.55.2019.07.20.10.30.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 10:30:33 -0700 (PDT)
Date:   Sat, 20 Jul 2019 18:29:15 +0100
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: filesystem: fix "Removed Sysctls" table
Message-ID: <20190720172857.GA24988@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the "Removed Sysctls" section is a table - bring it alive with ReST.

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---
 Documentation/admin-guide/xfs.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index e76665a8f2f2..fb5b39f73059 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -337,11 +337,12 @@ None at present.
 Removed Sysctls
 ===============
 
+=============================	=======
   Name				Removed
-  ----				-------
+=============================	=======
   fs.xfs.xfsbufd_centisec	v4.0
   fs.xfs.age_buffer_centisecs	v4.0
-
+=============================	=======
 
 Error handling
 ==============
-- 
2.22.0

