Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E813DC2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BC820842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU2NII8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgAAW0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:44 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:52864 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgAAW0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:42 -0500
Received: by mail-pj1-f41.google.com with SMTP id a6so2501290pjh.2;
        Wed, 01 Jan 2020 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uR3f0Y5+qpw7GzuSpDtOazUC6VJQJeKwTwbFDTwTBCA=;
        b=CU2NII8FZa30KDpLnt4mEcuPIpi6mpwLeoCKYIBiXi3+iSRhIei0bSqwbxV2qYZfed
         sc41uaPx22YpIt0MXVb6aK3b6qAIZfGojA4YfXCs3BgYffpDkz2kmqgUe0UqezAOHkHg
         MU1JwErrD1K7so4R11sRKdfDO4ZGk3XH1HLONH33gt/fRagYhkiPI9toEJ3HMb59ne56
         AFeGX0D8lDfgFY/x6LabxN6rdoUERq4w97MBYmUn5Sl4F0V5JgCLfpzCg0+6YGwDIXyT
         b2Dfl8ADA1G/nQtR0arOzR1QRTWAt514tmhNLPqjCMwUbhyOdbaklG0GpWZt8znPOMLQ
         O69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uR3f0Y5+qpw7GzuSpDtOazUC6VJQJeKwTwbFDTwTBCA=;
        b=rCSktpSHPkyunwE+Ave655NuUE0zVssWzu8Xp49RPUSob+7YgdANYu5mdapB3vsCS9
         bEJXDJIoFnGsSSS7wPa0E3FhVLVkdLSLbMohBizA5fR4lCKIvdVPw8Z2d5E4gQoCKfI1
         eIBJwdhA/4osTLUhcfgJQazUOtNsK30As6UHY2k1wALpfmTF25i+RP+uRmjT2qx3nWRT
         h9PnefZql72KTmrxM1MoAcwnMiHUxfJOdCBQxOJW3cKaDKpkUBF4fiT9t2ALq8PdZGp6
         4E+Ao4EC0E236fxG4Q/C45dfHPRwGuKDLOzubhdR0VMZxIy93cRRW0xTwDxrGK+hos8S
         ZItw==
X-Gm-Message-State: APjAAAWCE6MiVnKLlOhuIUmurUUm/5LuMFF1w5+fmZpWcIrkpVvhgvbi
        Gy2v9mlLaaoJY97vVr8Auuw=
X-Google-Smtp-Source: APXvYqzFV5/vapp2l/MuTd3YII852BC68hlAN9vrJVp1+3M/ConLSkSObBsC6TtqYoyx7U9b049mRw==
X-Received: by 2002:a17:90a:1992:: with SMTP id 18mr16205859pji.46.1577917601778;
        Wed, 01 Jan 2020 14:26:41 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:40 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 5/8] Documentation: nfs: idmapper: convert to ReST
Date:   Wed,  1 Jan 2020 19:26:12 -0300
Message-Id: <0173f92fceb3648b1840d4a8d29d29191bf473a3.1577917076.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577917076.git.dwlsalmeida@gmail.com>
References: <cover.1577917076.git.dwlsalmeida@gmail.com>
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

