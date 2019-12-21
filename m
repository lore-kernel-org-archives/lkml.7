Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EFC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3605206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkJllmV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLUCEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:04:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbfLUCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576893891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=NkJllmV3LMVlHBKyuh9RpcXtTkK1FhjxmKtp0PkhSD+K0f9QT4nvDmY0FmzCSjxNK1zF0a
        By2W9UjuSqMs08+0hjcZlqqByrJZ7oScCY9Deapr/7FCylGWhdqDKqDtjnHLuV/0JTUUx4
        qjWuTjXckLTvr9sSmqo7waBxZBZm9eM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-qOZq2dkkPCOYL4mUH64Ijg-1; Fri, 20 Dec 2019 21:04:48 -0500
X-MC-Unique: qOZq2dkkPCOYL4mUH64Ijg-1
Received: by mail-qt1-f198.google.com with SMTP id b7so4201012qtg.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 18:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=GSCllQRbAQRFkKshqv4s1g0TMGsr+QOACI/vR1PkdOVPelt/N21v7UU/FtA8j9LuzE
         GgtQZG/kgVeKYAGNPkjksU3AOcduHKKgk9VfJNhm6SaMYiio0UHvhd6b0cwm2zrRn3mB
         qW18nHfxENTQNfhmYFoOl+f53ScLx/1N0twOy5EzObk2mJIn3qC29Zp8tBxD9DkVO+Ng
         qcO2cPNCp4k5X91tZdTbaGoMu5pV5i1Jr1UmX8bdmRiOe84kuICEJ4t7wvB0S9B2K1jS
         Z2zXWmnJXJrCh9LrXW9XL2gASHwM4fxfjYkJURbenZSA+uZvBszl68AA4BXDccDHWj8N
         HkBw==
X-Gm-Message-State: APjAAAVsAxEUUjE2PFTR18afCNH0zPyfSJPWX3SYve1S1rc8AQKxDr0H
        OIdKRAbdu7EyDjI/ua8OXyj0v6u7RT0oJ31Sd/oQRt4q4IC/2SH6AbEl6wm9AEqj501OGFGhe2p
        xG6rX7Nu1X7bFdhfmPnv8yq5Y
X-Received: by 2002:a37:9f94:: with SMTP id i142mr16440043qke.244.1576893887904;
        Fri, 20 Dec 2019 18:04:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAc0EzsGK9bY8N26qIUJFdrrvHPxY+4cO8RSeHg/vjXPvoekteyflvW9c5b2yOsbwWGQ07Xw==
X-Received: by 2002:a37:9f94:: with SMTP id i142mr16440025qke.244.1576893887691;
        Fri, 20 Dec 2019 18:04:47 -0800 (PST)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id t7sm3400114qkm.136.2019.12.20.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 18:04:47 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dr David Alan Gilbert <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RESEND v2 11/17] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Fri, 20 Dec 2019 21:04:39 -0500
Message-Id: <20191221020445.60476-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222a6628..3c0ffd34b3b0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -197,7 +197,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.24.1

