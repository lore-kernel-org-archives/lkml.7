Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B0C26E97
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR1AMqG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEaTub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:50:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38208 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEaTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:50:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so7245079wrs.5;
        Fri, 31 May 2019 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RVkr0XInUNyl73v5Q20EHBEIvHgWD0JChBEkwLcMlCU=;
        b=JR1AMqG+gsNO6iUVE9pphCh47QKqXSCYN0IjqRX5/+KgaVtfK81iDB5c3Z3zNBt3MF
         y2UGPZT38xPel/Ce7mzrpSADLEQbBcbi0Q+45dHgPwbf9WG7VH9EjOhvQ1auCCkDoOzi
         DB+h1uQfNrPq30KPXK1w3JlNdh4aCpmoBblrUX8A5Y7vJ/LZkOrqUbD7QQ4dOPWrKvIy
         oO8h5jGGY3cNRjtXWWO0tk/qAxYL2ubzf1z8OOgZnyuJidlUQsgGCfYguArKw4zJ1UJf
         ALOdKTnUsGTVurCpcgUlOUlwVntLPfGjgRidYF9s9GpOoMZ1fhXyU+ERx8pMdgTRF2l3
         FB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVkr0XInUNyl73v5Q20EHBEIvHgWD0JChBEkwLcMlCU=;
        b=PuZD0bCqylW/XZPBngF2R5gmntzxBe7vYhSAUfPqv3ke9vt/8bJN1F1BNjGQuDSIHN
         TyRfHKHhrOdYilFm7f9wwvL/7Zg28Z+KMtQCvn5jwHwo/zD6PVK8Q2rzrqyXF+gtFnx7
         k/4apD2ii4Qin64+nvsBcCD8ojvwRqG9+8FTGTfD4BqMo0b64oWykdfxjwdvb/yMlSU/
         G7TPFaupS0DMHwSPhZqr6GfuxM3zDF/V8ch+Kz7YOaXpc3K5zsJcluEYIhAFubpVT2ll
         LAm28Yh8CnzsjK4H5POztUhMvAfEIVLqotU8eHpWb2A2FTh1ff997S88DxzQNYPD8cil
         9x5w==
X-Gm-Message-State: APjAAAWiFWtkUjW2/rLUj11LJpKbSLWLKFlTKu9L0iYn8j+xst0Ilzae
        1Vc1g2/JOZT32RnwDvjq0gc=
X-Google-Smtp-Source: APXvYqxUDh2jM8Hk8W5ZA3ySnBjYUfvxJ8bKkV8tPpVjwyasAXZcuqS0jVWOwC7DNv7oDH6tzZAQmA==
X-Received: by 2002:adf:c606:: with SMTP id n6mr7619911wrg.62.1559332225543;
        Fri, 31 May 2019 12:50:25 -0700 (PDT)
Received: from Thor.lan (89.red-2-139-173.staticip.rima-tde.net. [2.139.173.89])
        by smtp.gmail.com with ESMTPSA id y1sm4716107wma.14.2019.05.31.12.50.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 12:50:24 -0700 (PDT)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     albertvaka@gmail.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mbrugger@suse.com
Subject: [PATCH v3 3/3] Documentation for /proc/sys/user/*_inotify_*
Date:   Fri, 31 May 2019 21:50:16 +0200
Message-Id: <20190531195016.4430-3-albertvaka@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531195016.4430-1-albertvaka@gmail.com>
References: <20190531195016.4430-1-albertvaka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added docs for the existing and new inotify-related files

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
---
 Documentation/sysctl/user.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/sysctl/user.txt b/Documentation/sysctl/user.txt
index a5882865836e..99c288d39cf6 100644
--- a/Documentation/sysctl/user.txt
+++ b/Documentation/sysctl/user.txt
@@ -30,11 +30,26 @@ user namespace does not allow a user to escape their current limits.
 
 Currently, these files are in /proc/sys/user:
 
+- current_inotify_watches
+
+  The number of inotify watches in use in the current user namespace.
+  Calling inotify_add_watch() increases this.
+
 - max_cgroup_namespaces
 
   The maximum number of cgroup namespaces that any user in the current
   user namespace may create.
 
+- max_inotify_instances
+
+  The maximum number of inotify instances that any user in the current
+  user namespace may create. Calling inotify_init() uses an instance.
+
+- max_inotify_watches
+
+  The maximum number of inotify watches that any user in the current
+  user namespace may create. Calling inotify_add_watch() uses a watch.
+
 - max_ipc_namespaces
 
   The maximum number of ipc namespaces that any user in the current
-- 
2.21.0

