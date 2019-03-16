Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C225DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972392190A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq8Z5xDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCPR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44299 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfCPR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so8571344pgh.11;
        Sat, 16 Mar 2019 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=bq8Z5xDLMUpVyZDmZKNrHca9f4h2TOgOFC6MAyvLeNJ8msBy0iw/h5Qpkhwh9OYK5R
         dedffsd1mwPJM+1TT3RBPzFwbLsksOqJP8wax3iRSkiec7k3l19tX2XK55YxlREUHAaH
         QgzOcK34ZFqwLybW9vS9/zFRmbD+BWTdYNHYLFQ7qNL9iSIq4mGukaAg5zd+YLvdDfQH
         U6oke1JAM3t00xbVb0CAngbd/x7FYbffMDxttxK5hzwDSFa25G0q1xxJAqUau5/SWlX6
         zHgNHPylL8SrbIg67pcedzdjjW/s3C1kOv+AHFrPKtSOg0oVFzl0ZhEQqNqXMMta2nTR
         EAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=oHHMCP9+s+TyJNo7ggIUEYUnUPBsYT6IPfZlysxI06AZfo9GobFBaQ4YPaNbjeyUEi
         blIIQQ0YK5uTV7aHXQgOYuSEbTHAimFJInfuEkeA4/NS6nl8PaNMXmJsRtm3yUOBgfCw
         fVZKFjvjvs8G5zsUagJqRaTts9Dq6iPlwMNFaYuiDDKD4lUwksu42U2DCaF7q4yknf57
         wiCSF3CQPX+2Zz/ig62R09JS4J32OpM+Sj3ZzZECIskXFEYnFnQY5I2fV/gP682sX5PH
         kV1V7aKcmS3dxnFl+5aloJE3vVbZMrPRhIQgFDO7AycU3/GBKtPaYg4HvZDFfwEf2aAX
         YAQw==
X-Gm-Message-State: APjAAAXH3Hb9kZXaIAomnnprMKewO0WcuPiko3y+afdG+KGXRK1rWoFC
        IwJfo83wlN3rjy8+m6c+tZY=
X-Google-Smtp-Source: APXvYqzbtQgkg75MepPz3Rdsyo2uJzcezugEBhKq0wcwZ4AHdyVZaC4w6Uu5dvmZuUcuSiqhmoyUBA==
X-Received: by 2002:a17:902:a24:: with SMTP id 33mr10382469plo.275.1552759110593;
        Sat, 16 Mar 2019 10:58:30 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:29 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v9 9/9] cgroup: document cgroup v2 freezer interface
Date:   Sat, 16 Mar 2019 10:58:12 -0700
Message-Id: <20190316175812.6787-10-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 61f8bbb0a1b2..78f078ddbe9c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -864,6 +864,8 @@ All cgroup core files are prefixed with "cgroup."
 	  populated
 		1 if the cgroup or its descendants contains any live
 		processes; otherwise, 0.
+	  frozen
+		1 if the cgroup is frozen; otherwise, 0.
 
   cgroup.max.descendants
 	A read-write single value files.  The default is "max".
@@ -897,6 +899,31 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+  cgroup.freeze
+	A read-write single value file which exists on non-root cgroups.
+	Allowed values are "0" and "1". The default is "0".
+
+	Writing "1" to the file causes freezing of the cgroup and all
+	descendant cgroups. This means that all belonging processes will
+	be stopped and will not run until the cgroup will be explicitly
+	unfrozen. Freezing of the cgroup may take some time; when this action
+	is completed, the "frozen" value in the cgroup.events control file
+	will be updated to "1" and the corresponding notification will be
+	issued.
+
+	A cgroup can be frozen either by its own settings, or by settings
+	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
+	cgroup will remain frozen.
+
+	Processes in the frozen cgroup can be killed by a fatal signal.
+	They also can enter and leave a frozen cgroup: either by an explicit
+	move by a user, or if freezing of the cgroup races with fork().
+	If a process is moved to a frozen cgroup, it stops. If a process is
+	moved out of a frozen cgroup, it becomes running.
+
+	Frozen status of a cgroup doesn't affect any cgroup tree operations:
+	it's possible to delete a frozen (and empty) cgroup, as well as
+	create new sub-cgroups.
 
 Controllers
 ===========
-- 
2.20.1

