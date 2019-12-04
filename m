Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2020803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE60+PtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfLDTH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57111 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728114AbfLDTH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575486446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kn/llSEPws9Kaihse6HkAcboPO6kvjhOBVqBu50kJWM=;
        b=XE60+PtPpG5RBtzjwEnpibLL9HujMvXUC29D61LgXW8sbvQA2b4QP1suqe/nJ+ttmOQSAn
        UhPUJsW9Z+io52M/lKxYr+3eJZL50zYJ5nHGsFgYKhj1lS5k4Qx4F2BKyJBFuRlZQJojjr
        6+SYebRiUIxsTF8rI/eRGU74r/uNieM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-jfPFQP_FNHCsyDLqqthwkg-1; Wed, 04 Dec 2019 14:07:25 -0500
Received: by mail-qv1-f70.google.com with SMTP id z9so466942qvo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDMFszQpTCz8aKUy2p2BRtrOo8b1SfrY7qPPp6I+jnk=;
        b=j2zg4IBY1qmi0vageRt2MsKKmvXj51K/7J0kw/nQEK+JXcr4OWbQ6kbz+qxEaZMAVK
         c5Jgb9bnDS3UA6FdgC2H/9YdJnNBrlS/wdT7GmojTWMPiRFkheB9F6RTQydkB+cN9na/
         As/X8F3GXX+HK2aiaqfdoylZZzY8fQ+2NOQ1d2MVmoIXK27L3FaqjkNhgqTT77eWD6Pn
         F6XjOHxuBL21nEyixvGzv8/CsnEqWpUi6LlfkWwL451QFb8NOnpKDfEotYEqxzPbJ6Hb
         w9XtJRAh22t9Gx4a/1E1psO/PBg8TLi+r5rh9Ao//HDFW5BdlEH0HqD6CSja1j+DYq7b
         n0pw==
X-Gm-Message-State: APjAAAUFUvA5ctgJuIDxVmhNCz2p50rmUpA2oZBzUSUDOfCyWO1TluxM
        DYnwkcyp0DIRjVu/q6oiXG55m+5DB86s5oluP4t5K8gq4gShuh/UNvX7OnLYw8SP7KH2sFc3eS0
        3EmmERjTVWFAsm9XdLG/HSlC0
X-Received: by 2002:a37:f605:: with SMTP id y5mr4645603qkj.59.1575486444772;
        Wed, 04 Dec 2019 11:07:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXcJerAYwuG8Nz4ZOyamZB1Cf11CnFdKyqm2/DvrswGbmWblNXhZd72Q8pcAs4X10qlKVa5A==
X-Received: by 2002:a37:f605:: with SMTP id y5mr4645584qkj.59.1575486444531;
        Wed, 04 Dec 2019 11:07:24 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y18sm4072126qtn.11.2019.12.04.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:07:23 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 1/6] KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
Date:   Wed,  4 Dec 2019 14:07:16 -0500
Message-Id: <20191204190721.29480-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191204190721.29480-1-peterx@redhat.com>
References: <20191204190721.29480-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: jfPFQP_FNHCsyDLqqthwkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3rd parameter of kvm_apic_match_dest() is the irq shorthand,
rather than the irq delivery mode.

Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target v=
CPUs")
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cf9177b4a07f..1eabe58bb6d5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1151,7 +1151,7 @@ void kvm_bitmap_or_dest_vcpus(struct kvm *kvm, struct=
 kvm_lapic_irq *irq,
 =09=09=09if (!kvm_apic_present(vcpu))
 =09=09=09=09continue;
 =09=09=09if (!kvm_apic_match_dest(vcpu, NULL,
-=09=09=09=09=09=09 irq->delivery_mode,
+=09=09=09=09=09=09 irq->shorthand,
 =09=09=09=09=09=09 irq->dest_id,
 =09=09=09=09=09=09 irq->dest_mode))
 =09=09=09=09continue;
--=20
2.21.0

