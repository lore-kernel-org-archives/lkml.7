Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B786C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67368205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpShI3pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEPIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:40:22 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37304 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:40:22 -0400
Received: by mail-pg1-f181.google.com with SMTP id e6so1218167pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qucPwOXzUMdB8r6/rIr/ipDc05rKwLATQUHRFg3Vz7U=;
        b=NpShI3pRzuxbiGHz/d+EKq6zUIrgrBqPjOZAwy8KzM10VagyYAl+zLLvoMBbnrPgoE
         G6KMXtBOWXklBi5FSMubHLq6K2q54xj9XSDxtGRpd0y8JdWz9pV6QVtmkaGFtCgExh4P
         uqiU1AWPumgrkdD8scx4SZhel6sFrKnw+QB8/LgtCujdnb3dB8dlH2bmmt0qRPx2v6sa
         i1g093NHAoqrDAXNgxvodhOqpoIEWDGsFdn1H018goLxrUL0z8rutu6AwWurg/JasLb8
         jKNqKrUMZiXYvhUXgCn33NUdQOxk4YcHqinAeDIBA8ARisD/D2HN7VzhOwTYq21OdbIz
         CHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qucPwOXzUMdB8r6/rIr/ipDc05rKwLATQUHRFg3Vz7U=;
        b=RUGAUFpmd3U0SA8WjjB5Di2qo4Q9UVu1PHXPdFmlUYUlxZspwf8A8weOerrDN4zGXQ
         v7Shl2kHbwCtSYw9cpdRjFwqJZWW5dClSOgoVT+pIks3Rgko7A99+j0v5/x1r5yXTP3H
         fnx2Nb3QNxCG9VYeae/WW27ifkVXh/jBMCFv3CQ1AbdSvNfsX9W1ASe7E0IHDpK3PICY
         STmty6wLG5tyg9bTRN5sIJrcn1eNMJ/7dAMwGcexRazU6O/qigCUClLjDkxL0qk1f9/z
         PrHJ1ZY6MciIwSKUkAlv3haPzs2K1tmY3p7VxC6QDOrbeLupKsY0fPV1MuQxXVl5j3FV
         SyDQ==
X-Gm-Message-State: APjAAAU3uMS9x0mrbhkCc4QGqMlQsId5Cqo0AHdkb3qvD1W9nks61Zxf
        A0GMtwxWbvil6FToAyr8KZU=
X-Google-Smtp-Source: APXvYqz9+WWctldPXr83wGxtrfi84sPH9dqWXGoaWfejzpIreuG0ooNmjc3VRGcuYIChuYpHM8t2YQ==
X-Received: by 2002:a63:db4e:: with SMTP id x14mr33465425pgi.119.1557996021480;
        Thu, 16 May 2019 01:40:21 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 63sm6072791pfu.95.2019.05.16.01.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:40:20 -0700 (PDT)
Date:   Thu, 16 May 2019 16:40:03 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch] hdac_sysfs: Fix a memory leaking bug in
 sound/hda/hdac_sysfs.c file of Linux 5.1
Message-ID: <20190516084003.GA20821@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree->root and tree->nodes are allocated by memory allocation 
functions. And tree is also an allocated memory. When allocation of 
tree->root and tree->nodes fails, not freeing tree will leak memory. 
Thus we should free tree in this situation.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa34..5d8a939 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -370,12 +370,12 @@ static int widget_tree_create(struct hdac_device *codec)
 
 	tree->root = kobject_create_and_add("widgets", &codec->dev.kobj);
 	if (!tree->root)
-		return -ENOMEM;
+		goto free_tree;
 
 	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
 			      GFP_KERNEL);
 	if (!tree->nodes)
-		return -ENOMEM;
+		goto free_tree;
 
 	for (i = 0, nid = codec->start_nid; i < codec->num_nodes; i++, nid++) {
 		err = add_widget_node(tree->root, nid, &widget_node_group,
@@ -393,6 +393,9 @@ static int widget_tree_create(struct hdac_device *codec)
 
 	kobject_uevent(tree->root, KOBJ_CHANGE);
 	return 0;
+free_tree:
+	kfree(tree);
+	return -ENOMEM;
 }
 
 int hda_widget_sysfs_init(struct hdac_device *codec)
---
