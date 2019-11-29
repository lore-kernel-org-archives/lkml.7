Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8174FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C13206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY1BFyLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfK2VfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbfK2VfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUDNloV8++elS+YB1xoQTLeI0C6RrQjWp10JVReyn5w=;
        b=XY1BFyLZSk5Bu0VglWwMEbpax8DXzqnX7GKHUQRFQIll9RpygN83pmRvu3+S2ORyC76b5A
        sh5MXP3jLr5DZdVjin3aObRTqdH7rubLpExlBIOUxUVP5kMqOLdA8nkeklRNiyvKVCVJ2H
        o7SyfDixIgvGBJRYlsfqn6w/aWGZFPU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-eopn9RipOyCcmbfL4gE_qA-1; Fri, 29 Nov 2019 16:35:16 -0500
Received: by mail-qt1-f200.google.com with SMTP id k27so14362612qtu.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NO+3fvoemBR5nsjjdrhR5UeVlYU30oVRytgNjHOWnCo=;
        b=tcwxIjzRG1iuiD8Qx9Bgjaqj5cmD/Bcj8kcYhBTqw+Wo6H7O/AIZ6rbel6Yx3NikEN
         5v0XfKPbb6tw4pNG6NUgGbAaI5WC32rkQ+t5Olz6c+BU/w0tqkib3VlMHnb1bpfoI62e
         C8BgX7ZvYhq7iBMZDBx3a2qt4+Mcnn7VUgnCCEmJ5GgRFMZBYju7sfYVk31tS2eWgvRj
         Iakcmk6WV/GjXfuQPBSSQ6hU7HcKbjsO8tB5s5waKanTye+MAtZAMfMj0XXg1LrS6hFN
         07oDTeqBko4n/ISOYpck3nCdl5oho1jZh54kF5oWg5o5tJ5kR+1tF+QKpVgR96MneHPE
         er6g==
X-Gm-Message-State: APjAAAWLT2ZlsJFI7NuL4cJgQVCkk/MX58a3Vy+NMg8Lt9dPTLJ4l1Pd
        CBMfypcPiOJMTUDXybPD72fDdeWnGCpcnL0aCJ9wqdMY2cOgazc2fS4qO5n0Zw90cMBh4hT2AuY
        HQUoFchArzJEYqEb+m6KGdaH5
X-Received: by 2002:ac8:7a83:: with SMTP id x3mr42376745qtr.141.1575063315146;
        Fri, 29 Nov 2019 13:35:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+Fj4K6gOnpyuxoxJo2w18VCH+besA2qvETUFyxVvcVY7e7/PmCE7wMyTDBAnPDr+9SenrOw==
X-Received: by 2002:ac8:7a83:: with SMTP id x3mr42376726qtr.141.1575063314922;
        Fri, 29 Nov 2019 13:35:14 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 05/15] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Fri, 29 Nov 2019 16:34:55 -0500
Message-Id: <20191129213505.18472-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: eopn9RipOyCcmbfL4gE_qA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no good reason to use both the dirty bitmap logging and the
new dirty ring buffer to track dirty bits.  We should be able to even
support both of them at the same time, but it could complicate things
which could actually help little.  Let's simply make it the rule
before we enable dirty ring on any arch, that we don't allow these two
interfaces to be used together.

The big world switch would be KVM_CAP_DIRTY_LOG_RING capability
enablement.  That's where we'll switch from the default dirty logging
way to the dirty ring way.  As long as kvm->dirty_ring_size is setup
correctly, we'll once and for all switch to the dirty ring buffer mode
for the current virtual machine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.txt |  7 +++++++
 virt/kvm/kvm_main.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.tx=
t
index fa622c9a2eb8..9f72ca1fd3e4 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -5487,3 +5487,10 @@ with the exit reason set to KVM_EXIT_DIRTY_LOG_FULL,=
 and the
 KVM_RUN ioctl will return -EINTR. Once that happens, userspace
 should pause all the vcpus, then harvest all the dirty pages and
 rearm the dirty traps. It can unpause the guest after that.
+
+NOTE: the KVM_CAP_DIRTY_LOG_RING capability and the new ioctl
+KVM_RESET_DIRTY_RINGS are exclusive to the existing KVM_GET_DIRTY_LOG
+interface.  After enabling KVM_CAP_DIRTY_LOG_RING with an acceptable
+dirty ring size, the virtual machine will switch to the dirty ring
+tracking mode, and KVM_GET_DIRTY_LOG, KVM_CLEAR_DIRTY_LOG ioctls will
+stop working.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8642c977629b..782127d11e9d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1236,6 +1236,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 =09unsigned long n;
 =09unsigned long any =3D 0;
=20
+=09/* Dirty ring tracking is exclusive to dirty log tracking */
+=09if (kvm->dirty_ring_size)
+=09=09return -EINVAL;
+
 =09as_id =3D log->slot >> 16;
 =09id =3D (u16)log->slot;
 =09if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOTS)
@@ -1293,6 +1297,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 =09unsigned long *dirty_bitmap;
 =09unsigned long *dirty_bitmap_buffer;
=20
+=09/* Dirty ring tracking is exclusive to dirty log tracking */
+=09if (kvm->dirty_ring_size)
+=09=09return -EINVAL;
+
 =09as_id =3D log->slot >> 16;
 =09id =3D (u16)log->slot;
 =09if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOTS)
@@ -1364,6 +1372,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 =09unsigned long *dirty_bitmap;
 =09unsigned long *dirty_bitmap_buffer;
=20
+=09/* Dirty ring tracking is exclusive to dirty log tracking */
+=09if (kvm->dirty_ring_size)
+=09=09return -EINVAL;
+
 =09as_id =3D log->slot >> 16;
 =09id =3D (u16)log->slot;
 =09if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOTS)
--=20
2.21.0

