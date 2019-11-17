Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E566CC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC920855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf0+ba82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKQRZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:25:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41634 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfKQRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:25:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so8281708plj.8;
        Sun, 17 Nov 2019 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av+HK2/LnryCPXE2pMFULV8E1x0dPwk+5aKFWr2QtjI=;
        b=Mf0+ba82SJuPDW/KRGoJ39qEHaJN1XyFmnTe/sOHGfrL/G03s5sXKSh636lcKRh/A2
         6f85D4EHRB7ZJiv8318Mo5zm4amTsR104icW1n+9iIJTYZnK4f/rZQ8HniteumeBacW1
         Sy6pH5BCjfW+XSgZzGLRfofHtkiC6OHGiGo/mBGtzAfUf46g8rU3e6+ugDO/u5b2H7He
         9Z0NV3LlVgJEa0/hfrbv1elnOG48S2hDBTUqxer6zl46RvHc9z2ay5nfsHlK6ZRWhrTb
         aK7T7SlO8WRlnd+HX+hS8D2XzbPUYyBrGiI3Lm5L/mJElj4EAya1RS2iXH52GFhtAcUS
         ui8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av+HK2/LnryCPXE2pMFULV8E1x0dPwk+5aKFWr2QtjI=;
        b=Dk91wfpGbXQSHqvjacirDHE4tyzYkhnMAm0GPZCorMCAy6IZVwYcDQhnw62GwDXxc/
         DbBigLJ59zDLcHZ8NG/XBEyHcqWG2Tyw8GIRSqsSHxFQO0wDakFzo35gGIAmUjNzJZNO
         dsZTREJRtKgnieyFxTWC988tr8goYKOYc5flNsDI0Ge4ErhLjpWcrcs3h1Wvn2kjKv3L
         Pswq2lAwoSFQnv1iS3pePSzP+o72xu01+UGGCqKbeHbF3hYz/HNGcTnzISCYy7QJCGJ7
         DGjOpWfJCDu7BU3TPe87CLJYo6jwYKFtK5HOCr2p4r3gBuf79QiW4wO1zPryoFjv9IUl
         ZSCw==
X-Gm-Message-State: APjAAAUazL7/lk7LwI921SWrPvuto2vfkhHfgkjE8xBfY7AnfbqRQtBO
        6Il1BECtI6qWeT0GjJk/rfY=
X-Google-Smtp-Source: APXvYqzqvLaGSfdo9LbLHMOc1Z7izkzBhpQYaSmZrWQF98SMARgzygYTo/2wpu3igIOVsfjsI9ETBQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13mr12997470pll.28.1574011522589;
        Sun, 17 Nov 2019 09:25:22 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:ba74:f9a6:2aa3:8a9a:5581])
        by smtp.googlemail.com with ESMTPSA id x13sm18146302pfc.46.2019.11.17.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:25:22 -0800 (PST)
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     corbet@lwn.net
Cc:     raven@themaw.net, akpm@linux-foundation.org,
        jaskaransingh7654321@gmail.com, mchehab+samsung@kernel.org,
        neilb@suse.com, christian@brauner.io, mszeredi@redhat.com,
        ebiggers@google.com, tobin@kernel.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 2/3] docs: filesystems: Update code snippets in autofs.rst
Date:   Sun, 17 Nov 2019 22:54:35 +0530
Message-Id: <20191117172436.8831-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
References: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the struct definitions now have an autofs packet header.
Reflect these changes by adding a definition of this header and
place it wherever suitable.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 Documentation/filesystems/autofs.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 6702a5f61f50..2f704e9c5dc0 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -322,8 +322,7 @@ notification messages to this pipe for the daemon to respond to.
 For version 5, the format of the message is::
 
 	struct autofs_v5_packet {
-		int proto_version;		/* Protocol version */
-		int type;			/* Type of packet */
+		struct autofs_packet_hdr hdr;
 		autofs_wqt_t wait_queue_token;
 		__u32 dev;
 		__u64 ino;
@@ -335,6 +334,13 @@ For version 5, the format of the message is::
 		char name[NAME_MAX+1];
         };
 
+And the format of the header is::
+
+	struct autofs_packet_hdr {
+		int proto_version;		/* Protocol version */
+		int type;			/* Type of packet */
+	};
+
 where the type is one of ::
 
 	autofs_ptype_missing_indirect
@@ -395,8 +401,7 @@ The available ioctl commands are:
 	anything suitable to expire.  A pointer to a packet::
 
 		struct autofs_packet_expire_multi {
-			int proto_version;		/* Protocol version */
-			int type;			/* Type of packet */
+			struct autofs_packet_hdr hdr;
 			autofs_wqt_t wait_queue_token;
 			int len;
 			char name[NAME_MAX+1];
-- 
2.21.0

