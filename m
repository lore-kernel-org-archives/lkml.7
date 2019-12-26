Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C4C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B40420828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAkqAQb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLZVUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:20:24 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43727 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfLZVUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:20:23 -0500
Received: by mail-pf1-f175.google.com with SMTP id x6so12659206pfo.10;
        Thu, 26 Dec 2019 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uR3f0Y5+qpw7GzuSpDtOazUC6VJQJeKwTwbFDTwTBCA=;
        b=TAkqAQb8No2gy7WzN1sJvFtaIfh8yR6jVnzKPh7zRvKgXiQxja4X2M/R8OI1JXRqfF
         iYtXBLMIgVSmOF6z2BWWtb//uG//yPyUnGgUaCULLT9gLIx0jgoQSpZ53pZciMn5M4Ip
         J2fcJY0R8UBSDb4eX338kif7aYA4OnO8vcfsRqUtKLnF6ok1zB5UAqBExVRgryuD17bB
         sthhKA+lkMr3qV6t/6S939dSTXV4j3np3q/S82YHeePtaOZpB0XuoXUJUaQ+F5ut0JaJ
         6apzLl8L2g2eormOs4rfwrb9M7OGtUGOwZBFoVZHIWtwdKFT2oonqMf+B1q44eafBbdF
         gtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uR3f0Y5+qpw7GzuSpDtOazUC6VJQJeKwTwbFDTwTBCA=;
        b=td2R5zRMn1DTJxK88/rPSbUQsAZxBcxkCKAzVT6UBG3Yj8o2D9Tgytng1mA4DNJ8n0
         whATARcTWs2bkP1Hq+lFcJTom+9qXZye7DELA80a6iyM08VK8LkCDonp0OAN339EBKTN
         BperQN90UFezhzuxCf2VzBPKEjUwXC2HnvzcgqeIV/IK81gGFL0Yyp/9LQ55yiZwLJET
         qk6nMaVQUNumBFaBaXq+bXwsp9hNRMNlnkS0opqtnDuoyvLmaQTqHSQsbifRxOEv/8ip
         6DB1g8Ymuh0JGMy/XoBz4yxN9yzuJ0zz8bwru5Q3twHn/Alyau8q9DB3HFinn4zSzraY
         5sHg==
X-Gm-Message-State: APjAAAU+o/Abz1xgEVrUXY3vaVuU/vU36wMny59enV65pcap/H/8fRLC
        SKlydtS4X3wJd2iFFTYouME=
X-Google-Smtp-Source: APXvYqyorNqryvPglf+3L6Xcx1pzgUGp18X2qoTYM00yT7qKT8hr4MaI5L+8dEWB6eb3t6lIXDxQKg==
X-Received: by 2002:aa7:9296:: with SMTP id j22mr21795997pfa.201.1577395222683;
        Thu, 26 Dec 2019 13:20:22 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id b22sm35114380pft.110.2019.12.26.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:20:22 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 5/5] Documentation: nfs: idmapper: convert to ReST
Date:   Thu, 26 Dec 2019 18:19:47 -0300
Message-Id: <0063476e939087c87678a68dfd7fbab2e2d57bb9.1577394517.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577394517.git.dwlsalmeida@gmail.com>
References: <cover.1577394517.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert idmapper.txt to ReST and move it to admin-guide.
Content remains mostly unchanged otherwise.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |  1 +
 .../nfs/nfs-idmapper.rst}                     | 31 ++++++++++---------
 2 files changed, 18 insertions(+), 14 deletions(-)
 rename Documentation/{filesystems/nfs/idmapper.txt => admin-guide/nfs/nfs-idmapper.rst} (81%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index c73ba9c16b77..c90fd5ebc640 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -9,4 +9,5 @@ NFS
     nfsroot
     nfs-rdma
     nfsd-admin-interfaces
+    nfs-idmapper
 
diff --git a/Documentation/filesystems/nfs/idmapper.txt b/Documentation/admin-guide/nfs/nfs-idmapper.rst
similarity index 81%
rename from Documentation/filesystems/nfs/idmapper.txt
rename to Documentation/admin-guide/nfs/nfs-idmapper.rst
index b86831acd583..58b8e63412d5 100644
--- a/Documentation/filesystems/nfs/idmapper.txt
+++ b/Documentation/admin-guide/nfs/nfs-idmapper.rst
@@ -1,7 +1,7 @@
+=============
+NFS ID Mapper
+=============
 
-=========
-ID Mapper
-=========
 Id mapper is used by NFS to translate user and group ids into names, and to
 translate user and group names into ids.  Part of this translation involves
 performing an upcall to userspace to request the information.  There are two
@@ -20,22 +20,24 @@ legacy rpc.idmap daemon for the id mapping.  This result will be stored
 in a custom NFS idmap cache.
 
 
-===========
 Configuring
 ===========
+
 The file /etc/request-key.conf will need to be modified so /sbin/request-key can
 direct the upcall.  The following line should be added:
 
-#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...
-#======	=======	===============	===============	===============================
-create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600
+``#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...``
+``#======	=======	===============	===============	===============================``
+``create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600``
+
 
 This will direct all id_resolver requests to the program /usr/sbin/nfs.idmap.
 The last parameter, 600, defines how many seconds into the future the key will
 expire.  This parameter is optional for /usr/sbin/nfs.idmap.  When the timeout
 is not specified, nfs.idmap will default to 600 seconds.
 
-id mapper uses for key descriptions:
+id mapper uses for key descriptions::
+
 	  uid:  Find the UID for the given user
 	  gid:  Find the GID for the given group
 	 user:  Find the user  name for the given UID
@@ -45,23 +47,24 @@ You can handle any of these individually, rather than using the generic upcall
 program.  If you would like to use your own program for a uid lookup then you
 would edit your request-key.conf so it look similar to this:
 
-#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...
-#======	=======	===============	===============	===============================
-create	id_resolver	uid:*	*		/some/other/program %k %d 600
-create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600
+``#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...``
+``#======	=======	===============	===============	===============================``
+``create	id_resolver	uid:*	*		/some/other/program %k %d 600``
+``create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600``
+
 
 Notice that the new line was added above the line for the generic program.
 request-key will find the first matching line and corresponding program.  In
 this case, /some/other/program will handle all uid lookups and
 /usr/sbin/nfs.idmap will handle gid, user, and group lookups.
 
-See <file:Documentation/security/keys/request-key.rst> for more information
+See Documentation/security/keys/request-key.rst for more information
 about the request-key function.
 
 
-=========
 nfs.idmap
 =========
+
 nfs.idmap is designed to be called by request-key, and should not be run "by
 hand".  This program takes two arguments, a serialized key and a key
 description.  The serialized key is first converted into a key_serial_t, and
-- 
2.24.1

