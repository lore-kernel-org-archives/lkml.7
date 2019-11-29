Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F2207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys0RyOq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfK2Vf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727399AbfK2VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+epP0ZJNrOuBWj/134Gm2Sk2TIexg1BXp/mPjOqGz4M=;
        b=Ys0RyOq6u5l5ECYQNMneGWUBUPi9YLZq+WiaTSnR+HvktuSTZWDJJlJYPYxxqMpdy9w5Os
        +1u+rh3LxlUgCsi9xg3/vCa7GD33kSRL2JDjN9e+q99ya2CoSwfk/QxSz/A/j/hPGuUpB4
        96WJcc0kt5l9Dg6t3jniuqsRRuv0xYs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-SNDMeLHnM8SGy03a7DJh2A-1; Fri, 29 Nov 2019 16:35:23 -0500
Received: by mail-qk1-f197.google.com with SMTP id v2so7660676qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvCZjak4fUQXL1Tj0+D6gDZOBS7ZBlh7A3EqUR5B3UM=;
        b=bOFqYXnIXI2/Fk2Q/EJyRSF+dxm395C1rDpOWxpfO11iIXcbdfZ1jsGlui40AVaCKF
         s9AsrIkKFsNZ0BT/cZplgj957ELxF0UsY70MdZMdQipjsTaZMj62dotrrmzhak+gF/ik
         4TVt2IUCvLM4bOzq1FfXJ0rkIQTHQvbJXvk/Hk4YkiCyoAo2Q4pmoZBd003IgIQYCbey
         Smcvx5G9h0vh6FKBl/TE/+JhK9AWEeekey4W2ZHZyV74CN9L+TfvLfMwnfB3fSMDGxx7
         +CCBzDWNDEjHCWdA35oMOYbfist5amlCdU08i0/bk2h5N3wovcgwRi1s7MtFNznmjDrJ
         aPvg==
X-Gm-Message-State: APjAAAXnPRPplNInj2m8daaB5Cj2YRAHbLmXIuaCIQj9ccEU2NQLWl/5
        MsW9F6igKQ5cKBPf3l0xjqFcWxpD7k9s2/TgWAa+/gkGEeoQLLeB5yWxG8r6qiUXHSA4S+hZqKT
        8CvYvNgNoN9mwlf8DJhp960an
X-Received: by 2002:aed:2041:: with SMTP id 59mr53330737qta.79.1575063322428;
        Fri, 29 Nov 2019 13:35:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwlnBfGzVgTWxwT4m5yNzjwn1Ma5s2++ZIonxctUkmfr8RexiTx7Q64cvVDuUWaR5tujaL0Kg==
X-Received: by 2002:aed:2041:: with SMTP id 59mr53330724qta.79.1575063322256;
        Fri, 29 Nov 2019 13:35:22 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:20 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 08/15] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Fri, 29 Nov 2019 16:34:58 -0500
Message-Id: <20191129213505.18472-9-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: SNDMeLHnM8SGy03a7DJh2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/s=
elftests/kvm/dirty_log_test.c
index 5614222a6628..3c0ffd34b3b0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -197,7 +197,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 =09=09=09=09    page);
 =09=09}
=20
-=09=09if (test_bit_le(page, bmap)) {
+=09=09if (test_and_clear_bit_le(page, bmap)) {
 =09=09=09host_dirty_count++;
 =09=09=09/*
 =09=09=09 * If the bit is set, the value written onto
--=20
2.21.0

