Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B4C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DD422DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfIDMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfIDMgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:36:39 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C3D1C05686D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 12:36:39 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id b67so10689943qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 05:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y7+4jzmWO4GQ/wOMEZ/4ITLQiTP1h3eEC+zHNesrpcA=;
        b=EvmoBczvCCsNLAeKGo9l6AfKROCwK4mCDvR01D/DSQY1BmAZM8hh1jDY2asMD02Jze
         9BoxxzAzotpvrurclOaqVIXwRzlZyEs7NK98c7ivj4OHkEDKu1kTXOEinKQBBvZzUFQU
         ObtiK+FBMNx0fAARUmqUZWnwf2v/3loJApebMgFtFDKTmi3pH+a1Ny71j4kpFFuk163H
         hqSkf5VN+s1O6Skv9p5Hm0Y9HyWSId2f8uURCYAVpbK+DQ4h/vf+ISq56ZBiPu2wRpP2
         YKTXe8AliVaML3tNNdx4Jh8zX7/D1tutjygsDFWrPHQb/+Eil6/VK49tTuaRlkrf8mpZ
         mm4Q==
X-Gm-Message-State: APjAAAWENZcqJiGC667+KxJHU9O5gxESw4WbGvRJY/x127+hG/V8pa2+
        mXlJ8mKryFjPx0NyNqW60mqgy+VX8tVsShupXjvg34kA+OgSOno+6NYv0lgeM/BLrKn2WrB4+F3
        zw6Jwh2peixYO8q+IhSRfjTih
X-Received: by 2002:ac8:5388:: with SMTP id x8mr37130972qtp.26.1567600598619;
        Wed, 04 Sep 2019 05:36:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEZra2IRRbs1ImLBTb5SFO4EmzxasydlkHZDaR00UT9cJoLOJxESMOITKvTaUwBGo07h4nzg==
X-Received: by 2002:ac8:5388:: with SMTP id x8mr37130953qtp.26.1567600598487;
        Wed, 04 Sep 2019 05:36:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id s23sm11658356qte.72.2019.09.04.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 05:36:37 -0700 (PDT)
Date:   Wed, 4 Sep 2019 08:36:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH] fuse: reserve byteswapped init opcodes
Message-ID: <20190904123607.10048-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio fs tunnels fuse over a virtio channel.  One issue is two sides
might be speaking different endian-ness. To detects this,
host side looks at the opcode value in the FUSE_INIT command.
Works fine at the moment but might fail if a future version
of fuse will use such an opcode for initialization.
Let's reserve this opcode so we remember and don't do this.

Same for CUSE_INIT.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/fuse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..f042e63f4aa0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -425,6 +425,10 @@ enum fuse_opcode {
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	FUSE_INIT_BSWAP_RESERVED	= 26 << 24,
+	CUSE_INIT_BSWAP_RESERVED	= 16 << 16,
 };
 
 enum fuse_notify_code {
-- 
MST
