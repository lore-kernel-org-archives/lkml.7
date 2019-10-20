Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A3CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88912190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq/XcSfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfJTPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:46:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726383AbfJTPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571586383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NYB5YLU3InOkXCV2AcZVtukurd9BwBDSqfTnbkNJyC8=;
        b=bq/XcSfkXbhphf9CLs5z6dK3sKoTap6FyvaWccsshUz0wmjjMZ64ssyLZw8ZbEomNiKZAX
        Jkn6k4RzARE/B/zunKnBSgQcIvXcYZR8QMrzBcXVKaZi4Zz5tdAKJ6xLtLtP04Ya8FxVrN
        RYQ2QxhLuzmA68of5b34iDv8qM1pSSg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-u8pBYw6VMEGmEOPvYo7TJw-1; Sun, 20 Oct 2019 11:46:22 -0400
Received: by mail-yb1-f197.google.com with SMTP id j2so7734308ybm.14
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 08:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Alu6ppHvSW114ed3pBahWURj9wM8iWBEEGZ8MLoKgAk=;
        b=qvlDVc6Sb+cCQQ1tiz7wADQxmEZpfhfcPNk0tKeR4VF/XMZtL6ucbbVf+bxUoChMsr
         0mEmEFDukZixb80TXzD2q4xGYnqyr3qGBnJv28LvkorvjErQScRUWF4g6HOa2XwmuAbc
         fGNNoeFcc8ThoBbtc4oI0YtBz1zN5E/5YFwG0T7YaeWSXF7a6LbL78CWCVUG/MT9Gwrv
         evWSFRnM0FxoT3qwzkMVLGkCOXNWJ82Q9pHiwlfhG9pORc4TakGHPb+TuTPj/8/KcqNP
         MybodTOQiRKy+hT7dxDIp+E7gdqkJBr96SXiFYG5qCoJ6hz7drZQfKYvILlQwy09y7LQ
         l9Yw==
X-Gm-Message-State: APjAAAVGLWMXo/9XiLWYh82an62g5KfwWk5rKI4w3PjGHXwlQDD9o6HX
        hx6ZH4ocbGCBu2AfW7HWKZv8NhaRvcGtEn7UkNds7wRA5Z4E5IP8uyPA1tkDug/iLU7XiqeB6Iq
        k6ntNT7FC0OOpKTMF0mp2sSNSBTlrtTID8w3GeAvV
X-Received: by 2002:a25:2005:: with SMTP id g5mr11581343ybg.233.1571586381778;
        Sun, 20 Oct 2019 08:46:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyKemkRcFRU3wzlgi/T4+K9AZ2BopYayuoVNBd36p+ggns4HBGKTFdfgg55BfQj8iXlviOeklLwD73HIE9Azs=
X-Received: by 2002:a25:2005:: with SMTP id g5mr11581330ybg.233.1571586381452;
 Sun, 20 Oct 2019 08:46:21 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Rix <trix@redhat.com>
Date:   Sun, 20 Oct 2019 08:46:10 -0700
Message-ID: <CACVy4SVuw0Qbjiv6PLRn1symoxGzyBMZx2F5O23+jGZG6WHuYA@mail.gmail.com>
Subject: [PATCH] xfrm : lock input tasklet skb queue
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-MC-Unique: u8pBYw6VMEGmEOPvYo7TJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT_FULL while running netperf, a corruption
of the skb queue causes an oops.

This appears to be caused by a race condition here
        __skb_queue_tail(&trans->queue, skb);
        tasklet_schedule(&trans->tasklet);
Where the queue is changed before the tasklet is locked by
tasklet_schedule.

The fix is to use the skb queue lock.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/xfrm/xfrm_input.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 9b599ed66d97..226dead86828 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -758,12 +758,16 @@ static void xfrm_trans_reinject(unsigned long data)
     struct xfrm_trans_tasklet *trans =3D (void *)data;
     struct sk_buff_head queue;
     struct sk_buff *skb;
+    unsigned long flags;

     __skb_queue_head_init(&queue);
+    spin_lock_irqsave(&trans->queue.lock, flags);
     skb_queue_splice_init(&trans->queue, &queue);

     while ((skb =3D __skb_dequeue(&queue)))
         XFRM_TRANS_SKB_CB(skb)->finish(dev_net(skb->dev), NULL, skb);
+
+    spin_unlock_irqrestore(&trans->queue.lock, flags);
 }

 int xfrm_trans_queue(struct sk_buff *skb,
@@ -771,15 +775,20 @@ int xfrm_trans_queue(struct sk_buff *skb,
                    struct sk_buff *))
 {
     struct xfrm_trans_tasklet *trans;
+    unsigned long flags;

     trans =3D this_cpu_ptr(&xfrm_trans_tasklet);
+    spin_lock_irqsave(&trans->queue.lock, flags);

-    if (skb_queue_len(&trans->queue) >=3D netdev_max_backlog)
+    if (skb_queue_len(&trans->queue) >=3D netdev_max_backlog) {
+        spin_unlock_irqrestore(&trans->queue.lock, flags);
         return -ENOBUFS;
+    }

     XFRM_TRANS_SKB_CB(skb)->finish =3D finish;
     __skb_queue_tail(&trans->queue, skb);
     tasklet_schedule(&trans->tasklet);
+    spin_unlock_irqrestore(&trans->queue.lock, flags);
     return 0;
 }
 EXPORT_SYMBOL(xfrm_trans_queue);
--=20
2.23.0

