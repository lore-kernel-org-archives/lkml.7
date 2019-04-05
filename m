Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B295C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E2D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkTZWcoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfDERr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37894 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbfDERro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so3671956pfo.5;
        Fri, 05 Apr 2019 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPwqK0qKQccz1rnM8spQH4fx1OfXTPfbuyAOOQ+8AD0=;
        b=dkTZWcoctKvv3aWGfJ+h5Whk/0MAavdY7xUT5DQ7kJVHQtRlg/JrdskB3bZPgjs1g9
         76JbeYYkdvA3DNH5puqxF/F6SzZyGnHj9eYb675X5n6iCh1oBMzHxkRfLqOdf8www1U9
         gtf2W8hpXxXkz3nAtnnquaVQMjRIUeXi8DlGUcq63gCvLtE9nocg8Sl+OeWIte+gv7Hl
         YOOKnqHG/zX+haCgiYcilgCgt8MF5/EacFL+a112Z87UPWKCdDY0quZpZfJk61z6+Nyu
         jqjnjXr7OYBN/yVNHl0bn6hrM/Dl2RB3UOZPjy3VfA6I1UB0UzUaoOSfZ08vGZKTy22q
         yNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPwqK0qKQccz1rnM8spQH4fx1OfXTPfbuyAOOQ+8AD0=;
        b=rO2eW34r8UjChdINXjSqokYX4M3/Cf9PL6QhfVm+mM1zu/fPM8Q4egpnA5uZOq/FaY
         kcJe7GfXJ/cXjwhmhi87c9is/7hJ4QMRILcl57SLbQmfEfjBA5MhOH6CCiRNBPfcMMN3
         pfPo2d4gr0Z2YidbYzQnSevN13z9QfGbXcduBOd4u+E9wZxhkgeCr8mMQOiDes79JCgn
         ePcDvYiHT9y5+ouRZ10s+3bgea6Oh/rpu3c70w3hUMoOZZllwByxLljBm70arNd09EqS
         7XHfofSxM7CBzosTlLMtDfs2NJVlF8Wkjv0qRz3+p7PDvpicESh7ng42fGuZRrHd7Cq7
         6y2Q==
X-Gm-Message-State: APjAAAVYtxBvxe4qtL+xdzpt0+G/LeSgRP9LVPqHwDPcSaQzP4cESiGS
        oHGAXWzYBLWY/0Sd6Wj4k4QhBgu0WIA=
X-Google-Smtp-Source: APXvYqx5U4EYEL1jeJPCKaahsNc2CoXuxI0q37/vE4wAmhHSrfwXodXMhJH4J0nsHhaKpMEfO3ObHQ==
X-Received: by 2002:a62:5797:: with SMTP id i23mr13612319pfj.12.1554486463355;
        Fri, 05 Apr 2019 10:47:43 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:42 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v10 9/9] cgroup: document cgroup v2 freezer interface
Date:   Fri,  5 Apr 2019 10:47:08 -0700
Message-Id: <20190405174708.1010-10-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
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
index 20f92c16ffbf..88e746074252 100644
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

