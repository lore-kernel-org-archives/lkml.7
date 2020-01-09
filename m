Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E3BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC21C20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu8wbKMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgAIO5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43184 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728737AbgAIO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEeMY0L9h1cGjmSmJRSArJW3guXbSNp3v29BbhovZjg=;
        b=Eu8wbKMzvp6p2BuPxNtnWI8QpSYlLuM5zBH1ErhZju51aqRtOj8NWLoczScZeLvSNuLx4s
        pL/HES5j9emHteSTIZ8KCVIm5B3zN02eDovnTlJiswSaw+hFmSevRnBsOUkrI5R+NqbFRL
        pOxSG/BU+teF1cQej8tComDMTJMkHbg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-1JOHk5uJMq2dGQulJ485mA-1; Thu, 09 Jan 2020 09:57:39 -0500
X-MC-Unique: 1JOHk5uJMq2dGQulJ485mA-1
Received: by mail-qk1-f199.google.com with SMTP id a73so4321234qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEeMY0L9h1cGjmSmJRSArJW3guXbSNp3v29BbhovZjg=;
        b=CFyBr9Kd3rVLQCSbx7RBrGmarwYqrU5TSOOhjipmpJAXWrAXI7wGpYcva8eDUEyd5H
         TYcE62yig5aXfFfImdwLZ2n/DkhfBE/ZsepzZBgeh5TkIJinfS5gFnekrFfp1l9Nr5e/
         JTapVv2mplKi6T3FvFHQa5LAe4Qs5X+6rEb6c4+oNg9nEJU/NkVriG4EBt+f9WDAC1OF
         HjB9Nt9X4pI/xrn5DqFQ0/KizLWAg59MZtd+lg6T77nN7/bBLqUuv6od6GiTkqQZKbz+
         WfQGt4CTcCo/bpzhmctxGp3wRx7/fQ/w29/vRexdURS27hA879U+DxvrBWX6JffElu7y
         1IMw==
X-Gm-Message-State: APjAAAWyAvufAXKTtuX31VedILaB2xWsMc00iIOvI9gaDMZ435TlTjmA
        PC/67AiZnUM08PQG7vVd6ZIm2mMlkiqkH0b6UTiB1xzK3il8KXCbkROP+hfbuWwEH+DjKfl820q
        llOWEaS10QprJ4J+FD+/YLfsf
X-Received: by 2002:a37:9ed1:: with SMTP id h200mr10197426qke.390.1578581858650;
        Thu, 09 Jan 2020 06:57:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyTk3NXqX9G3kGKxoo4ojyuQTBdPfBxO21UKAMm33TtYTFwDUkwRRvpBGjneEqklTgj8BP9w==
X-Received: by 2002:a37:9ed1:: with SMTP id h200mr10197404qke.390.1578581858408;
        Thu, 09 Jan 2020 06:57:38 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 02/21] drm/i915/gvt: subsitute kvm_read/write_guest with vfio_iova_rw
Date:   Thu,  9 Jan 2020 09:57:10 -0500
Message-Id: <20200109145729.32898-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

As a device model, it is better to read/write guest memory using vfio
interface, so that vfio is able to maintain dirty info of device IOVAs.

Compared to CPU side interfaces kvm_read/write_guest(), vfio_iova_rw()
has ~600 cycles more overhead on average.
-------------------------------------
|    interface     | avg cpu cycles |
|-----------------------------------|
| kvm_write_guest  |     1546       |
| ----------------------------------|
| kvm_read_guest   |     686        |
|-----------------------------------|
| vfio_iova_rw(w)  |     2233       |
|-----------------------------------|
| vfio_iova_rw(r)  |     1262       |
-------------------------------------

Comparison of benchmarks scores are as blow:
---------------------------------------------------------
|  avg score  | kvm_read/write_guest   | vfio_iova_rw   |
---------------------------------------------------------
|   Glmark2   |         1132           |      1138.2    |
---------------------------------------------------------
|  Lightsmark |        61.558          |      61.538    |
|--------------------------------------------------------
|  OpenArena  |        142.77          |      136.6     |
---------------------------------------------------------
|   Heaven    |         698            |      686.8     |
--------------------------------------------------------
No obvious performance downgrade found.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[peterx: pass in "write" to vfio_iova_rw(), suggested by Paolo]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 3259a1fa69e1..5fb82f285b98 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1968,31 +1968,18 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
 			void *buf, unsigned long len, bool write)
 {
 	struct kvmgt_guest_info *info;
-	struct kvm *kvm;
-	int idx, ret;
-	bool kthread = current->mm == NULL;
+	int ret;
+	struct intel_vgpu *vgpu;
+	struct device *dev;
 
 	if (!handle_valid(handle))
 		return -ESRCH;
 
 	info = (struct kvmgt_guest_info *)handle;
-	kvm = info->kvm;
-
-	if (kthread) {
-		if (!mmget_not_zero(kvm->mm))
-			return -EFAULT;
-		use_mm(kvm->mm);
-	}
-
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = write ? kvm_write_guest(kvm, gpa, buf, len) :
-		      kvm_read_guest(kvm, gpa, buf, len);
-	srcu_read_unlock(&kvm->srcu, idx);
+	vgpu = info->vgpu;
+	dev = mdev_dev(vgpu->vdev.mdev);
 
-	if (kthread) {
-		unuse_mm(kvm->mm);
-		mmput(kvm->mm);
-	}
+	ret = vfio_iova_rw(dev, gpa, buf, len, write);
 
 	return ret;
 }
-- 
2.24.1

