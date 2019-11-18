Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2CEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F196208CE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0lCJRdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKRVwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:52:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28590 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbfKRVwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574113956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37fM1KMKYNrGbiZSg07VSdDytySB2r4xXsbLO3HzSdo=;
        b=J0lCJRdgC8PhMrgAyDwWRmhXrFgWVpNYHxg2Q4g+XiFyf9bWBGg18b4Ofx3In0uCLckhoR
        DWuCUZj9Tobh0q3rgGVqQauk+qgQcVgmza7nvHnnF2i4PaZ3SUloFhCDdOk8LtfzsWSyDR
        h/7uY5Yjdu0vFBsVbi2GWKyYnIJ9y0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-fJFIxhqENmWVImvxdMKnew-1; Mon, 18 Nov 2019 16:52:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C4C477;
        Mon, 18 Nov 2019 21:52:34 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 669B25DD98;
        Mon, 18 Nov 2019 21:52:24 +0000 (UTC)
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7b412d15-b796-3b8d-0e98-22362377093f@redhat.com>
Date:   Mon, 18 Nov 2019 16:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191113102855.925208237@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fJFIxhqENmWVImvxdMKnew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 5:21 AM, Peter Zijlstra wrote:
> @@ -130,20 +131,12 @@ static inline void percpu_rwsem_release(
>  =09=09=09=09=09bool read, unsigned long ip)
>  {
>  =09lock_release(&sem->dep_map, ip);
> -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> -=09if (!read)
> -=09=09atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
> -#endif
>  }
> =20

This is the only place that set RWSEM_OWNER_UNKNOWN. So you may as well
remove all references to it:

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 00d6054687dd..8a418d9eeb7a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -53,12 +53,6 @@ struct rw_semaphore {
=C2=A0#endif
=C2=A0};
=C2=A0
-/*
- * Setting all bits of the owner field except bit 0 will indicate
- * that the rwsem is writer-owned with an unknown owner.
- */
-#define RWSEM_OWNER_UNKNOWN=C2=A0=C2=A0=C2=A0 (-2L)
-
=C2=A0/* In all implementations count !=3D 0 means locked */
=C2=A0static inline int rwsem_is_locked(struct rw_semaphore *sem)
=C2=A0{
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index eef04551eae7..622842754c73 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -660,8 +660,6 @@ static inline bool rwsem_can_spin_on_owner(struct
rw_semapho
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ret =3D true;
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & =
RWSEM_NONSPINNABLE));
-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (need_resched()) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lockevent_inc(rwsem_opt_fail);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return false;

Cheers,
Longman

