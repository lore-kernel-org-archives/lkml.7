Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CCBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A55206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUkexObA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfC1RLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:11:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41698 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1RLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:11:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so23964539qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRYwax0kQAHs7i/AToycFYMMekLbKQthj/x21KvD3wA=;
        b=sUkexObACcAfZD2urDVfEId6jq5nRGOxa7kyNdanirygu+PAyM6xKqmwIxl8PxXrtN
         2Yxde0AuSyYlmUv2DXfwJ5qLGzS9psriTZkUBSyUlQKWfJCM1E7tSrB15ZMNtz+U3TlB
         /S6Mw1VVrppcBwTG9ktcxLXlHdBAs0k9P61SP0Q3Jsj+4+Xq9OwToYf1MJukd73gEp1Y
         +0IUOaFrzmCGuhmAMSQXZYyso7ARy4jONEaiShhZyrSRMikyVIiGx0ieuxpnh1/IIRsg
         YgiPjUR2R2xJtzyeZxP9YVvw7cCq0pX/YGHZqbLRTeZPNfv7vkAldyv37IobhGSWYXuJ
         W/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRYwax0kQAHs7i/AToycFYMMekLbKQthj/x21KvD3wA=;
        b=W8iE0VTE/QnZrvv98Hy3Yo9JG+IswRGEN6vU6oAoS9+MJff1c7fRzLFE1XR0u0SbK4
         ryZgpo5ZHbDZwgmGfUgLZAbFmTtUOUtQSoeY1pc4LQTsAutKPOY8p7e9vyzEmGu6dazE
         IVh3drZUWEoHrve3fUnZmnMl3v3TE/TP3Ln2HK2hjVD5f5ebc2qYBu/NTStBKOzuzUHX
         vLAkC5XPU48QhAapqdgfTICA7K2iD99PwNrTNtdyJU15RR3PrNHuzVHo6LAI54LyFe8Q
         tvZApEUlHniskOlkVUOM/b2V875ptPub6yogw9Gda0dzILTb00siyAPqUx9sKxEiNYSu
         QyjQ==
X-Gm-Message-State: APjAAAXf4Q1HpvSLds75o0KB0O83Ab1gpWJHl55KTrs07f1cG18miAy4
        JpRgIFawT9nAa56P0JbbCUY=
X-Google-Smtp-Source: APXvYqxWEAKXKUFQlvzH03afcTgnT7YozgsDScCmbEfyFrG7LXsHGAVCQXNWBo0UJutgkYwWWnjGuA==
X-Received: by 2002:a0c:d2b9:: with SMTP id q54mr36617006qvh.196.1553793076404;
        Thu, 28 Mar 2019 10:11:16 -0700 (PDT)
Received: from gravicappa.gravicappa.info (pool-72-74-132-209.bstnma.fios.verizon.net. [72.74.132.209])
        by smtp.gmail.com with ESMTPSA id r53sm5386988qtr.80.2019.03.28.10.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:11:15 -0700 (PDT)
From:   Vitaly Mayatskikh <v.mayatskih@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: initialize vhost_vsock->hash
Date:   Thu, 28 Mar 2019 13:10:57 -0400
Message-Id: <1553793057-24002-1-git-send-email-v.mayatskih@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CAGF4SLiZxXcWskZXmGbwO11MnwyMAK_Bpbn0ugZzK6jSMHdiog@mail.gmail.com>
References: <CAGF4SLiZxXcWskZXmGbwO11MnwyMAK_Bpbn0ugZzK6jSMHdiog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no current valid use case when uninitialized hash can be read
before being written, however let's keep every vhost_vsock field
initialized just for clarity.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bb5fc0e..f43f4ed 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -537,6 +537,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	spin_lock_init(&vsock->send_pkt_list_lock);
 	INIT_LIST_HEAD(&vsock->send_pkt_list);
 	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
+	INIT_HLIST_NODE(&vsock->hash);
 	return 0;
 
 out:
-- 
1.8.3.1

