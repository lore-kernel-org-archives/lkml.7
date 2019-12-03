Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA68C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F280206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtZfHsHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLCQ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:59:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727166AbfLCQ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575392350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kn/llSEPws9Kaihse6HkAcboPO6kvjhOBVqBu50kJWM=;
        b=AtZfHsHHjqnUlLGpKpb6eZI+/geWxML182skjGbCec9i0zNJncY+Kh9uoXLuLKOlAAoxQp
        RajA8MpwWVwnwM1ThQGEkJGzbDJmv/RdRVKl+u6khYWXAZ89uWHYXBU0BNuB4GnBt4c1Wx
        dowooXiRIP5Q4pT9ZLvz9Na6FqbhaVU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-m3IAcfcyO5ulUkf1mPvdcQ-1; Tue, 03 Dec 2019 11:59:07 -0500
Received: by mail-qk1-f197.google.com with SMTP id q13so2604805qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDMFszQpTCz8aKUy2p2BRtrOo8b1SfrY7qPPp6I+jnk=;
        b=VH5o913467WW9iaAUv8owc41+2diOcGI46F8vTeivSse4jhZdq8LmWWirFBlaJmT72
         YSWMv1v2DbqcjZi6DlTSJqLIwP7ze9qIrPtCgormGMqZR4/BYvLIQPlbI98hKu9B/en4
         JcWLdZNXZLa7QPULbBiMEc6GTnVQwyk2h767Qx6qZDN508C9X46BJ/yAkdLAJ1h+pj27
         YfU3ZzfRhzZTrHVFGAcGVDR1cLTdf3q/Ba/LTxAELZ8mz3z9d5be1LoMGTxWQ+g3RQWl
         rGNZc5mGeYUksY/GD5k1guvKCiiHN8LruYPILRFUnW84FYNBYEclOFKGTsZirSzwwkoJ
         UKQw==
X-Gm-Message-State: APjAAAU2Q/JjiOf7e083/LbhImQOHRMxM1SkTHXYlYcavgFHR8XJDP7O
        5JI1TJIc9lLl/jTilj8ylTLTnov+3oBnO56Im5tfmncImJnRyCzX/KsHzoDyxusLitWDoxEfxyM
        6RuNeQME23tAcr2cUF75RH63K
X-Received: by 2002:ac8:1017:: with SMTP id z23mr5821774qti.94.1575392347081;
        Tue, 03 Dec 2019 08:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg/JOE/OtM1jHS/faP8zXtfiNcD6HKzy7U3+/q3M6bfRuQ5NZYhl14b7ItPtyjdu5wi5+3bg==
X-Received: by 2002:ac8:1017:: with SMTP id z23mr5821756qti.94.1575392346887;
        Tue, 03 Dec 2019 08:59:06 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a16sm482585qkn.48.2019.12.03.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:59:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 1/6] KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
Date:   Tue,  3 Dec 2019 11:58:58 -0500
Message-Id: <20191203165903.22917-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203165903.22917-1-peterx@redhat.com>
References: <20191203165903.22917-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: m3IAcfcyO5ulUkf1mPvdcQ-1
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

