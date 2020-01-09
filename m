Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B42072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fejB4S7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgAIO5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731918AbgAIO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm8O4Xii0OuE4zFVyte5k6dYfDYh4EMQdTOkPftgaqU=;
        b=fejB4S7Zcfeq7czzSrZeICFBGTJNZDrYZHr/HyonuzeqtfBPaNsEXzEa4lJUAEnBssIULh
        +bXgw6wUo6uh+ae4HGD2ObpTMNKhgwMiB4hUUECVbJ4qgD9er4d3semINJZ9mH7n7Zs8bI
        wW9jcEQZJ7F73ekv+6rnugZhksO0BTI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-nGFyknB0N9OtlZNjCwJ4UQ-1; Thu, 09 Jan 2020 09:57:46 -0500
X-MC-Unique: nGFyknB0N9OtlZNjCwJ4UQ-1
Received: by mail-qv1-f69.google.com with SMTP id g6so4275792qvp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nm8O4Xii0OuE4zFVyte5k6dYfDYh4EMQdTOkPftgaqU=;
        b=l2rNwxv1MDnfsbYUC4hVLErX0dc4TaAy6yWskGcbiu0dQ1+MgV2v4fPB3cj+rzUx7R
         WPzdeItIbCBxmM05ZXWxNDFl51Sqf/bub9pern8g7aUsXk8KBJl3zlB06In6SH6bwPr7
         f2+vNRxr5BNOawGkEaPdbxtEoG5tEvtRU2T+ny6Rr/13mvptbZX6KJQPOnyPVoUK7wj3
         bMqJspUjRmDPhzJ3VtIK2C4B3Pg6yBWGL2XEVcstfiOK1NrbM9R5e/diN8u2959P6Oki
         +fiSjctgrU9/V+Eh8JGBkM81vtVP9H0H2u2ggVwPrIUvfG6z/reMkZtEu2BhTlIM/x5R
         Hgew==
X-Gm-Message-State: APjAAAVOK3Vmil9IJpELc05ulpYhDdvcB/xs7HZ2V8/0vPuJRT4hhzAK
        zZggeo4RmXGe5mYoP+2e3MLyl7y4BrUKq5mjZE5U3lxEPuI8ONITPdETbA8q8+T4Xs95jRRGvx0
        NmkcNQ+A9g0ahRQTrhAAB0AkE
X-Received: by 2002:ae9:ec01:: with SMTP id h1mr10129983qkg.33.1578581864674;
        Thu, 09 Jan 2020 06:57:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNTAs/SAnbPG+ivO60ziyJlazNT+NDxUAFeemJ1UyIi2OiGROdyCVheaB21amr6IgdyN2YNA==
X-Received: by 2002:ae9:ec01:: with SMTP id h1mr10129964qkg.33.1578581864482;
        Thu, 09 Jan 2020 06:57:44 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:43 -0800 (PST)
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
Subject: [PATCH v3 04/21] KVM: Add build-time error check on kvm_run size
Date:   Thu,  9 Jan 2020 09:57:12 -0500
Message-Id: <20200109145729.32898-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already going to reach 2400 Bytes (which is over half of page
size on 4K page archs), so maybe it's good to have this build-time
check in case it overflows when adding new fields.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 24c9cf4c8a52..70b78ccaf3b5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -338,6 +338,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->pre_pcpu = -1;
 	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
 
+	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
-- 
2.24.1

