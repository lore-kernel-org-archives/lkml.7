Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6011206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsV5MQdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfK2VfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727420AbfK2VfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpuq/G52YR/EWKqC8iBbbYIDe0A7Qxl+akM4QmK5sAQ=;
        b=IsV5MQdMvWoeT3YXs6nBL4TeNiJ9K2VvhIR6oFGBuRaeIvXEcuvIv5W+3R5dkStloGyVWs
        8HkdZWnLC56enNO1PMRjHAQJctp004nvx62G6fUN1tk9mYGyoX+CMBg62SL1LST4QAMGld
        +p3H5PVN416aDV33v0JSzXkP/5n6vEM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-WmObVU-yMfqLotsAxli5Bg-1; Fri, 29 Nov 2019 16:35:19 -0500
Received: by mail-qv1-f72.google.com with SMTP id w7so19666263qvs.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Lbo6nzRM/DONZbraTRbxGKXPq3mYjZEFxLpZd/H6rg=;
        b=LrxqIcX3AKAiO/77vbKiBU9ZWsv3+Xs9tp8w/YuQldp5ZKNZ2f18nyFv4uSW0GvgIX
         Lqaks0hpj2OzdNa/pWHuOuaeWGr9ndJCAM+iKcfxq6gZMAPnHhGxvKdVh5riO5/ngotU
         bwSif56nDKZ1xu33e/YNyUOzctcaGSUnZI2nVq4iLbK09041arpzG6tHMQVl2ZIwn/fz
         nsghDIVzhP14brsV/OA30twlCvyhlShVHQh4fZRZys1QEYxXL6V5OKNHbFENCvx3FnxD
         DnDFPT4kQbRr1z91SX7hfFgtm4mX0YetmxQs5zONXJyWNj4QD2TmWvKyVkvbabRibhxO
         DQDg==
X-Gm-Message-State: APjAAAVYHTExYF6a3t6NMlugrP2YP10JhjN8PsQYntaAqlOoWlyGp/IJ
        KMJP2QUtJgvpnTLH/O7CaUC9ABdeb1z4yuOLjOFkRdEfB5gjZOL6evrWDPUzmjZQY8glZDD+XzQ
        9dEEN/vRcfYjvpMQdaTPhWyU2
X-Received: by 2002:a37:9c52:: with SMTP id f79mr5140324qke.371.1575063318368;
        Fri, 29 Nov 2019 13:35:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxA2Tpilr33v3WBbCSOmy0Z41+CrMJLbX94grlSi+qC20mb3boDfiw5uhwYkHYd+rVpjUCwXg==
X-Received: by 2002:a37:9c52:: with SMTP id f79mr5140295qke.371.1575063318117;
        Fri, 29 Nov 2019 13:35:18 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 06/15] KVM: Introduce dirty ring wait queue
Date:   Fri, 29 Nov 2019 16:34:56 -0500
Message-Id: <20191129213505.18472-7-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: WmObVU-yMfqLotsAxli5Bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dirty ring is completely full, right now we throw an error
message and drop the dirty bit.

A better approach could be that we put the thread onto a waitqueue and
retry after another KVM_RESET_DIRTY_RINGS.

We should still allow the process to be killed, so handle it explicitly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b747bc9ff3e..a1c9ce5f23a1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -508,6 +508,7 @@ struct kvm {
 =09struct kvm_vm_run *vm_run;
 =09u32 dirty_ring_size;
 =09struct kvm_dirty_ring vm_dirty_ring;
+=09wait_queue_head_t dirty_ring_waitqueue;
 };
=20
 #define kvm_err(fmt, ...) \
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 782127d11e9d..bd6172dbff1d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -722,6 +722,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 =09mutex_init(&kvm->irq_lock);
 =09mutex_init(&kvm->slots_lock);
 =09INIT_LIST_HEAD(&kvm->devices);
+=09init_waitqueue_head(&kvm->dirty_ring_waitqueue);
=20
 =09BUILD_BUG_ON(KVM_MEM_SLOTS_NUM > SHRT_MAX);
=20
@@ -3370,16 +3371,23 @@ static void mark_page_dirty_in_ring(struct kvm *kvm=
,
 =09=09is_vm_ring =3D true;
 =09}
=20
+retry:
 =09ret =3D kvm_dirty_ring_push(ring, indexes,
 =09=09=09=09  (as_id << 16)|slot->id, offset,
 =09=09=09=09  is_vm_ring);
 =09if (ret < 0) {
-=09=09if (is_vm_ring)
-=09=09=09pr_warn_once("vcpu %d dirty log overflow\n",
-=09=09=09=09     vcpu->vcpu_id);
-=09=09else
-=09=09=09pr_warn_once("per-vm dirty log overflow\n");
-=09=09return;
+=09=09/*
+=09=09 * Ring is full, put us onto per-vm waitqueue and wait
+=09=09 * for another KVM_RESET_DIRTY_RINGS to retry
+=09=09 */
+=09=09wait_event_killable(kvm->dirty_ring_waitqueue,
+=09=09=09=09    !kvm_dirty_ring_full(ring));
+
+=09=09/* If we're killed, no worry on lossing dirty bits! */
+=09=09if (fatal_signal_pending(current))
+=09=09=09return;
+
+=09=09goto retry;
 =09}
=20
 =09if (ret)
@@ -3475,6 +3483,8 @@ static int kvm_vm_ioctl_reset_dirty_pages(struct kvm =
*kvm)
 =09if (cleared)
 =09=09kvm_flush_remote_tlbs(kvm);
=20
+=09wake_up_all(&kvm->dirty_ring_waitqueue);
+
 =09return cleared;
 }
=20
--=20
2.21.0

