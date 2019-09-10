Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE49C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A50206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393775AbfIJPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392769AbfIJPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:12 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CACE81F19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:12 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o11so9115054wrq.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrqaTrvxa7VaAlf71OLZqePQvcrU6r13R8Bqx0ichEU=;
        b=ZkjmWY2xldno+uqbNeszfcKCIsn2zRERjIF/mbgmke2C0UxIXjb3fa4RpeOrUsLGth
         hDbse6bMsbyjmorBynVJRx/4NImSd/szGIyQO9T8hh426thoqfpaZYxwESaL054GtQ+G
         mdOw8nvmiupSU6FNkFi7La8TrPdiZnwNg+amu9OquoqAZhojkDQI4zjfL0PWtIlmeSmh
         LMlt6sYk99mxchcul2ru+hlw5a8dDivZClGTFnN040J0tEUH7uFhzci3a2aSzjy9mwXu
         LNGYhlBPxZVn7TU+Xtp0S+Bg6utou+Jjx7bHzw3uLQzHvC6aysXSTu0AIQzLbVjE1i3u
         LCdQ==
X-Gm-Message-State: APjAAAVyEM49dC36AVjg25Oc3QGWjXY5HZaBEOv/Syi7i+uvbFRXFY03
        mMZwMw0jGuNAFM62CFxQR/7MwBk90NN+qZyZUIE+cRLHOESflGKqDdEgF6J1k9/O9pwO1ORyPW/
        PHqyhwkZvy/n/BuKr8jA3ZqXt
X-Received: by 2002:a7b:c054:: with SMTP id u20mr1673wmc.11.1568128330959;
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWeg/w8Vqy0703RcJM9HuLu+OSLqPixswfN1pv0bUZuNqcYM+945Q0W3J0uRRmaWdkr1fPhA==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr1659wmc.11.1568128330796;
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 1/4] fuse: reserve byteswapped init opcodes
Date:   Tue, 10 Sep 2019 17:12:03 +0200
Message-Id: <20190910151206.4671-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
References: <20190910151206.4671-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio fs tunnels fuse over a virtio channel.  One issue is two sides might
be speaking different endian-ness. To detects this, host side looks at the
opcode value in the FUSE_INIT command.  Works fine at the moment but might
fail if a future version of fuse will use such an opcode for
initialization.  Let's reserve this opcode so we remember and don't do
this.

Same for CUSE_INIT.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..df2e12fb3381 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -425,6 +425,10 @@ enum fuse_opcode {
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	CUSE_INIT_BSWAP_RESERVED	= 1048576,	/* CUSE_INIT << 8 */
+	FUSE_INIT_BSWAP_RESERVED	= 436207616,	/* FUSE_INIT << 24 */
 };
 
 enum fuse_notify_code {
-- 
2.21.0

