Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7491BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4167A206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWIgEVDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfK2VfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727351AbfK2VfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeO3g+8EGPox+V7IC6l3NZw9JSTY7gBZHk7XmDQfPZM=;
        b=QWIgEVDtJ9pfJoBjfxcVb+kbDx+Bd9hXz6eibB09qYziLt6wodTFs15iiJibXTAULaS6DE
        cXDp1Uz9yZ+CPJADdYYTMg4wjtNt2ER7Xyoohv4927CEZS4WQMpi0bNgp3kgT5DJ1ZhRfT
        UskpEdim+HkVNmh5jDax+kj63gCtLQw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-RRNn806iM5u4aQs755LlOw-1; Fri, 29 Nov 2019 16:35:13 -0500
Received: by mail-qv1-f71.google.com with SMTP id g6so2656543qvp.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRodLl/V9ZOtTlsVO+ztnjUNpRnKukvb2eZH8xGgAiY=;
        b=tHXeJgnkkMmPmBWGjbYsN//1sLLSRPOzeC0BmQp7s8WCzbGfZAuj4Ub3dS74U57m/S
         3WZn5PdbZ20p32TGuHTIZfB1yyCRDtF0eqjj21MyPc0aKS/A3IijYKo4vqwKMzTyDa3x
         cHor8MRqZMTI7Daklkr6eC4g2oSpxOSJrjSGBVinUW146+ndn0TpyUr6d2FgiVipNPUh
         XMtTcIWzb02uuk2qencpDgHvOVrlNuTv/+Guo1VXDhIlNdYsx6rJg2SRD0rS3SAVGgIN
         vpeA9w5HQphvN1cTKAdjNisXsoELki08CdzfW9JaAy6TPYP7f/XFTKxwlhm+2gfWu8xa
         Rt0A==
X-Gm-Message-State: APjAAAVFzdot5HO1xvzHoT1R3Q9fgN6SD1ASlF+87uqtnsl7J82fozEL
        AXacYywoN5IgghernRXTqI3Hlh63Vn6fSVLg95Cb3pJw7jvDAyskkNp/xhHbbSpn9GYIkjl/RD+
        6UCuNEvc6b+YCzfq4ySnMeZCe
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr14299261qka.31.1575063312368;
        Fri, 29 Nov 2019 13:35:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGqiYFQUWgvgas2yyRUTgB8tPpZ6d427pLUydcx4nN9XKk1dNq0eHIFESm5vWkr4DFME/SSg==
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr14299242qka.31.1575063312153;
        Fri, 29 Nov 2019 13:35:12 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:11 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 03/15] KVM: Add build-time error check on kvm_run size
Date:   Fri, 29 Nov 2019 16:34:53 -0500
Message-Id: <20191129213505.18472-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: RRNn806iM5u4aQs755LlOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already going to reach 2400 Bytes (which is over half of page
size on 4K page archs), so maybe it's good to have this build-time
check in case it overflows when adding new fields.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8f8940cc4b84..681452d288cd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -352,6 +352,8 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kv=
m, unsigned id)
 =09}
 =09vcpu->run =3D page_address(page);
=20
+=09BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
+
 =09kvm_vcpu_set_in_spin_loop(vcpu, false);
 =09kvm_vcpu_set_dy_eligible(vcpu, false);
 =09vcpu->preempted =3D false;
--=20
2.21.0

