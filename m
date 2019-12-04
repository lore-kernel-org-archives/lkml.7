Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C43C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310A32077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrD+oDZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfLDRXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:23:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727033AbfLDRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575480195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/ijlA2Y8tQ65LgRVW6J4BfY/7PWvTIeCK61lJ/PdESM=;
        b=CrD+oDZBaxW4pXqFvJjLEUt6gowQGtqFYv1d7PQFfDobn18wdpEF2efDhQSzClqAqX1Qr9
        QIQnZ/dKcJyXcYix5uEYHkhG+sfkwhsMFTD1uA74ypRNzgxaeIpptmU8SCv9g3QopQR+gO
        Ust9fEdmCRy7jWF14zWNRJQ2onCUxKc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-i0WXJIHWMYKmw-OksvUNPQ-1; Wed, 04 Dec 2019 12:23:14 -0500
Received: by mail-qk1-f197.google.com with SMTP id a186so177177qkb.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WImDtnT/OC0iIgg7U312qsc7ZNGeTEU307A4KTpQNWQ=;
        b=kMLj/WuP15lJHX60zVipWRYLPTs6QMN9RspnykHVgn3RwdwiGCJ07bJxHey0uYsEkJ
         mN9ETegckwvdq+HZkmX5skW85db66UiRUSamckH4wL/2NfxeRq/86jmRO5Ta2LESt255
         OKeDOY6bWIrnnGNgzxqjiMXEVBk1mcyK7asXx/mI18rGPaRv9uB/69MtoxHw0ytkdkID
         jWjQVXvhHKb5kHK6c9AW3pAoO9AwWt8rs6a1dJOeYiUCPSSA+vKpOFl32mlzxznj8YJN
         6ZFUP2SJZrnZ8iUgXriuES2+FV/JdTY22QbdMVwDNGxpHLC/9eMEB0kYNneo/3Hr/ZOV
         DxCw==
X-Gm-Message-State: APjAAAWySucqpY3i/gqplXrLtRlB40DsLR1jBmXA4NiCKxqj53c1xrVG
        1tLhWz9V1VZS9+f5C5dCJLYWoJEQ4Dzn/aTvSLybHzs3SkrYfUQUGnLu+T8TGGxehUEZQDp2iPS
        IE1C672BpA1UuLj/8LMSNn/9+
X-Received: by 2002:ac8:5448:: with SMTP id d8mr3793159qtq.205.1575480194386;
        Wed, 04 Dec 2019 09:23:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjZllkTJMVO8gUft4TF37TJtGxExThuw0OqUtgK8eLV5ii8XWfVEyUSs8xU1asSX8TohyEuQ==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr3793143qtq.205.1575480194184;
        Wed, 04 Dec 2019 09:23:14 -0800 (PST)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d13sm3964871qkk.136.2019.12.04.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 09:23:13 -0800 (PST)
From:   trix@redhat.com
To:     bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH RT 5.2] signal: remove noop call to __sigqueue_free
Date:   Wed,  4 Dec 2019 09:22:42 -0800
Message-Id: <20191204172242.21058-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
X-MC-Unique: i0WXJIHWMYKmw-OksvUNPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

By inspection, this call does not do anything.

static void __sigqueue_free(struct sigqueue *q)
{
=09if (q->flags & SIGQUEUE_PREALLOC)  <-- redundant flag check --+
=09=09return;                                               |
=09atomic_dec(&q->user->sigpending);                             |
=09free_uid(q->user);                                            |
=09kmem_cache_free(sigqueue_cachep, q);                          |
}                                                                     |
                                                                      |
static void sigqueue_free_current(struct sigqueue *q)                 |
{                                                                     |
=09struct user_struct *up;                                       |
                                                                      |
=09if (q->flags & SIGQUEUE_PREALLOC)  <-- first flag check ------+
=09=09return;                                               |
                                                                      |
=09up =3D q->user;                                                 |
=09if (rt_prio(current->normal_prio) && !put_task_cache(current, |
=09=09atomic_dec(&up->sigpending);                          |
=09=09free_uid(up);                                         |
=09} else                                                        |
=09=09__sigqueue_free(q);  <--- this call will noop --------+
}

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7bf4b399d307..4389cfde3f86 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -486,8 +486,7 @@ static void sigqueue_free_current(struct sigqueue *q)
 =09if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
 =09=09atomic_dec(&up->sigpending);
 =09=09free_uid(up);
-=09} else
-=09=09  __sigqueue_free(q);
+=09}
 }
=20
 void flush_sigqueue(struct sigpending *queue)
--=20
2.18.1

