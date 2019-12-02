Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4123C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786AB20848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmII3saK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfLBUNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728003AbfLBUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575317599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1fy9n7dcmvJgMCcJNV0TpfIBPUc+H1bj0IMdTlJT67Y=;
        b=bmII3saKDLpzteGJDBOgdIAx5/dr4tDOpSczhIoxICRiE/F9SuZL/Pves55zOQh/b3cxV9
        GWV+8T0iG39SHy16Y2zgMDLEp8haqng7L4RQulbplHCL+1kX8iHoZ2WoJyzhFb+cHqEXjQ
        PiJJ0cx5btiKgDO9jTdsVEdB+ncgBPo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-jYE96Lk4M-C2xeF0rqcPRQ-1; Mon, 02 Dec 2019 15:13:18 -0500
Received: by mail-qv1-f72.google.com with SMTP id y9so530753qvi.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G46phdLsdELb62aYURKq9FYQ6hJlvcecU9Mkr0WukfA=;
        b=Z7mWEL26LbFtW2nWhwvjCi/0tI3pF9y56hb+PiyV4Rrs1XTlMJnIBIQOVcjaU96D63
         qvKLIigRpJ4EVQimD51HKYVNmboHhi4m5wmeR/+xSDGTHwPacU5kgk06FHuTDRzekPa+
         9vhpbKwqISE427gz/WguhihUcWsTBxX4CRUpQRHbGrjGM2TZwe4kBHuPqoLA2o3TM1jd
         6GPd2pWmbBVWiTGNdQAsXTWOKJi5K9tUZAWR81gJooKk+rlNtpas+dngzKsNc8+CueVW
         nmvtyh7s3gkVqajx3cHZGYIp0yoFW6Xe8vujEmqG+I8aZ6gxJtrYzYmuVMpPg5Cmd7yV
         +33A==
X-Gm-Message-State: APjAAAUYzv8M337ZSpuM1pbUUTMO7cmw/b1uQO84WqUdVL0LZi3OFQZU
        GHbL1LvRzn9uWyThbfDhsVt1H3Qsos5hb5P1mEX/3WllUrQlAUIsFPywOx4q190NIo9RFslRcjg
        AuqOUr8pWIlPZ6GFwcwPAl4VO
X-Received: by 2002:a37:8fc7:: with SMTP id r190mr802096qkd.57.1575317598023;
        Mon, 02 Dec 2019 12:13:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyXV9FRZwo488kcpWWx8NKtpTc+Mn5z7ZJGiXXUVERX6ZlH3itwmcb06sFXIkKThyWsyuWdw==
X-Received: by 2002:a37:8fc7:: with SMTP id r190mr802057qkd.57.1575317597756;
        Mon, 02 Dec 2019 12:13:17 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b6sm342410qtp.5.2019.12.02.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:13:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 1/5] KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
Date:   Mon,  2 Dec 2019 15:13:10 -0500
Message-Id: <20191202201314.543-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202201314.543-1-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: jYE96Lk4M-C2xeF0rqcPRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3rd parameter of kvm_apic_match_dest() is the irq shorthand,
rather than the irq delivery mode.

Fixes: 7ee30bc132c683d06a6d9e360e39e483e3990708
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

