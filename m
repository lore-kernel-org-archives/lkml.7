Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511432077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2d+h5Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfLDUs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:48:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727961AbfLDUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fi+iH2WNUp9ArXpenr/WTfC70sq/cA3J8MYZu5XIifI=;
        b=L2d+h5MmWwSpbZEv2QiY7pgpRt0XztufmiEZnc2KswTvdo8hzu5s79L5mI+gSx+TK61v3B
        M8wl3DjQsPeDtFNUQvDZBuZ38VvvBjmRlNcgyTUkUUK/ZEyc1NQkijY7U4awOhKjdajk5Q
        WH0r/98iczQWmnBRnLdmGOjr5sxUJCU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Wgwym-nbMdalAcsh_0Sp7g-1; Wed, 04 Dec 2019 15:48:26 -0500
Received: by mail-qv1-f69.google.com with SMTP id g15so648360qvq.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szcVrB/vhwnsVwNPePyokXdoFWkLFoOQYKT5PyFKc2M=;
        b=p8rMs/kXr2pVIMLHPg10qnx+efymAb4dDdxSxEQeu5b2U5HJdxtPWJBcFCs1ONVczx
         Vcl4ScQBsK3+Hynq/RNr09qxqO5l9Qb9z+8Eoe2nweesb1uCDtyDMhi3bQ6qds70xMe4
         JLrAbwOF05xnysBqI8aBMRTBsSzbrzfZ3h+8FABwPpMZDKp0QFSB62FxSlj0d5lINNSs
         EsPnL/Sl3BDHDwcGw+RaOYVFp5qiQrJBc2g4uFrJamLJ7e5D0HzIxHoWe+b0zCHCkrnL
         A+Xt6RftshgjghL2tDif+hhP7ousaAHv+fok5DNPV/JNcR/aXP/hJFQNk64OVVhwQcSW
         0aww==
X-Gm-Message-State: APjAAAV7CF9TSKzUtPkwksunY73pUuThcEFIh99pOEiXhzqM3ittLFiu
        V72ErMJ0WmVM2nMZVLK4NF4AmxceKm7ytTN2ltvnCYQKBnsYpW1oWQshjfrdOceYRmBKueZWxHH
        mpsRN6jHlEhV5PXoHgxR3e52B
X-Received: by 2002:ac8:3f33:: with SMTP id c48mr4727975qtk.108.1575492505380;
        Wed, 04 Dec 2019 12:48:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTtUNHMoYhd2iy9Ft3Xyw24MqSjCrk37QJMT8SUtJP0ErMH4rC+8O1i8W0/P7eF6Vb5OiIfg==
X-Received: by 2002:ac8:3f33:: with SMTP id c48mr4727966qtk.108.1575492505143;
        Wed, 04 Dec 2019 12:48:25 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 3sm4305700qth.2.2019.12.04.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 12:48:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] smp: Allow smp_call_function_single_async() to insert locked csd
Date:   Wed,  4 Dec 2019 15:48:23 -0500
Message-Id: <20191204204823.1503-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: Wgwym-nbMdalAcsh_0Sp7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we will raise an warning if we want to insert a csd object
which is with the LOCK flag set, and if it happens we'll also wait for
the lock to be released.  However, this operation does not match
perfectly with how the function is named - the name with "_async"
suffix hints that this function should not block, while we will.

This patch changed this behavior by simply return -EBUSY instead of
waiting, at the meantime we allow this operation to happen without
warning the user to change this into a feature when the caller wants
to "insert a csd object, if it's there, just wait for that one".

This is pretty safe because in flush_smp_call_function_queue() for
async csd objects (where csd->flags&SYNC is zero) we'll first do the
unlock then we call the csd->func().  So if we see the csd->flags&LOCK
is true in smp_call_function_single_async(), then it's guaranteed that
csd->func() will be called after this smp_call_function_single_async()
returns -EBUSY.

Update the comment of the function too to refect this.

CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Nadav Amit <namit@vmware.com>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---

The story starts from a test where we've encountered the WARN_ON() on
a customized kernel and the csd_wait() took merely forever to
complete (so we've got a WARN_ON plusing a hang host).  The current
solution (which is downstream-only for now) is that from the caller's
side we use a boolean to store whether the csd is executed, we do:

  if (atomic_cmpxchg(&in_progress, 0, 1))
    smp_call_function_single_async(..);

While at the end of csd->func() we clear the bit.  However imho that's
mostly what csd->flags&LOCK is doing.  So I'm thinking maybe it would
worth it to raise this patch for upstream too so that it might help
other users of smp_call_function_single_async() when they need the
same semantic (and, I do think we shouldn't wait in _async()s...)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/smp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..dd31e8228218 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -329,6 +329,11 @@ EXPORT_SYMBOL(smp_call_function_single);
  * (ie: embedded in an object) and is responsible for synchronizing it
  * such that the IPIs performed on the @csd are strictly serialized.
  *
+ * If the function is called with one csd which has not yet been
+ * processed by previous call to smp_call_function_single_async(), the
+ * function will return immediately with -EBUSY showing that the csd
+ * object is still in progress.
+ *
  * NOTE: Be careful, there is unfortunately no current debugging facility =
to
  * validate the correctness of this serialization.
  */
@@ -338,14 +343,17 @@ int smp_call_function_single_async(int cpu, call_sing=
le_data_t *csd)
=20
 =09preempt_disable();
=20
-=09/* We could deadlock if we have to wait here with interrupts disabled! =
*/
-=09if (WARN_ON_ONCE(csd->flags & CSD_FLAG_LOCK))
-=09=09csd_lock_wait(csd);
+=09if (csd->flags & CSD_FLAG_LOCK) {
+=09=09err =3D -EBUSY;
+=09=09goto out;
+=09}
=20
 =09csd->flags =3D CSD_FLAG_LOCK;
 =09smp_wmb();
=20
 =09err =3D generic_exec_single(cpu, csd, csd->func, csd->info);
+
+out:
 =09preempt_enable();
=20
 =09return err;
--=20
2.21.0

