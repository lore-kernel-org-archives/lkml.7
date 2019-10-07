Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56FBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED0206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfJGSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbfJGSaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:30 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64912C057867
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 18:30:30 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id n4so16218255qtp.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Veqvl+qM0CfutM3PPjJjEy4hKVrp4NP3ezEQkZHIQPg=;
        b=W7KZ2tl+eiV0fQHvK/R/EliMWSFNODJwS+YIB7s4NPMLyzIIPIAKfFWwO+f++qhUOZ
         nKOZh3k4Qnlu7eSTwU/oHwKZzRS08xa+dKFir77jvl4PvmHlnhcJUGRqEXuDUqbgvcUA
         MCqa1z9gX4r4/Pjg+9oJ+vte+TS/ys9ebLmi0wOWGHe0DOu9bVLFllrlJSKMBw5gOJS8
         eZyZrUu4cIuauXfdGXXlTFo0R1VUniF79vkDTlB8WA0I/nXNwDBh0P0huAZGawRc5+Xg
         7PI+YqpB8sW2jDtwcIYdw+zolRKd3h/+1E/KfvMFKWeTg3NukN0mgox41JcpPHDvpv4p
         hF/w==
X-Gm-Message-State: APjAAAX3QNLlb3KBKwnjQmR8zsj7A4nlhgCS31yvwAbx0S15pfyMHA6o
        O0UPlaEz8z/WDinhwpdkxISb3iSstXq7ZTlZCWPMhdQaPTV5j5oJd8CowrbypWQ9OMVEsF3TN0u
        B3NgmhOa3fJtCF/nM7tKofiF7
X-Received: by 2002:a37:8f86:: with SMTP id r128mr14609055qkd.392.1570473029367;
        Mon, 07 Oct 2019 11:30:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5hMQXVRiXUEyBzpDI1RwgrB4b7tr07l8zU3XqKSSML03JT2g+x+mug176n0y6vIeLAWA/TQ==
X-Received: by 2002:a37:8f86:: with SMTP id r128mr14609014qkd.392.1570473029025;
        Mon, 07 Oct 2019 11:30:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id s50sm9515361qth.92.2019.10.07.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:30:28 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:30:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] vhost/test: stop device before reset
Message-ID: <20191007183019.12522-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device stop was moved out of reset, test device wasn't updated to
stop before reset, this resulted in a use after free.  Fix by invoking
stop appropriately.

Fixes: b211616d7125 ("vhost: move -net specific code out")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 04edd8db62fc..e3a8e9db22cd 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -170,6 +170,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 
 	vhost_test_stop(n, &private);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
@@ -246,6 +247,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
 	}
 	vhost_test_stop(n, &priv);
 	vhost_test_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 done:
 	mutex_unlock(&n->dev.mutex);
-- 
MST
