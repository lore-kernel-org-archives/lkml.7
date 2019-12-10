Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835732077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPuLJsA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:19:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60472 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbfLJTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576005551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnsyvYeZzE6S32SgMSwQ6zWyKto3RJloVhRU6/uuYto=;
        b=IPuLJsA7WtWVoeMxcGC54+BBgnIqZb+tuzxGvkmY7gpbfwhrdvrKAE4RESCAly1+daF+ss
        jgNsiy1vZNAaexZowg7qcWmobfAwJXWkCzodyq1kI6WLpT5CTnxhMvR0JYDRKNtJhbuZEy
        00P1iDBJ8Woecs/D8ymNGUC8tmQVl50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-AL_l5ibVMIy76PZUvlkSqQ-1; Tue, 10 Dec 2019 14:19:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D3F107ACC5;
        Tue, 10 Dec 2019 19:19:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-205-240.brq.redhat.com [10.40.205.240])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB8AD5C1B0;
        Tue, 10 Dec 2019 19:19:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 10 Dec 2019 20:19:08 +0100 (CET)
Date:   Tue, 10 Dec 2019 20:19:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] sched/wait: fix ___wait_var_event(exclusive)
Message-ID: <20191210191902.GB14449@redhat.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
 <20191209102759.GA123769@gmail.com>
 <20191209130005.GB5388@redhat.com>
 <20191210072119.GA114501@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191210072119.GA114501@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AL_l5ibVMIy76PZUvlkSqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_wait_var_entry() forgets to initialize wq_entry->flags.

Currently not a problem, we don't have wait_var_event_exclusive().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/wait_bit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 45eba18..02ce292 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -179,6 +179,7 @@ void init_wait_var_entry(struct wait_bit_queue_entry *w=
bq_entry, void *var, int
 =09=09=09.bit_nr =3D -1,
 =09=09},
 =09=09.wq_entry =3D {
+=09=09=09.flags=09 =3D flags,
 =09=09=09.private =3D current,
 =09=09=09.func=09 =3D var_wake_function,
 =09=09=09.entry=09 =3D LIST_HEAD_INIT(wbq_entry->wq_entry.entry),
--=20
2.5.0


