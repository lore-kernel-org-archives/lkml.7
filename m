Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22437C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4432072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxajOEqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgAIO6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732100AbgAIO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5/gZPNP/QItlxsKYnUSc3SUeJf7pxYxkCxufAe+9+I=;
        b=BxajOEqEIJ7ndmuFZpDL/qhxSK08cCt+pyK/7sg3V8B6ay4Qub3mnd6275EUZUmIv5UceU
        0CA1Nz3PYMfrVVzauLLRwIDPyDezP13fXxq1Bb0N2Oys+UtbW2c6c0n7iv8hAcFiRNj4t+
        XVaLJI315PpXjeJ5D3ECcgEJRsdyPVE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-3DP7y0xXMpiorYRP7j_QXw-1; Thu, 09 Jan 2020 09:58:23 -0500
X-MC-Unique: 3DP7y0xXMpiorYRP7j_QXw-1
Received: by mail-qt1-f200.google.com with SMTP id m15so3691001qtc.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5/gZPNP/QItlxsKYnUSc3SUeJf7pxYxkCxufAe+9+I=;
        b=rzNRGEnuqT6eBxkikJC1ZMT1mj3NI5NW5Vxz+bK3KTfrDvWGE99XLlH6FOK2/jR3QW
         Os4WJ8PovVQ81EYlyEmXAC/JjAuDxbDkm2s2qTNmG9B1UuHTwPCP+s6ea6MgAI+fpgID
         RgqJmw/EtCQ0ABLUkCFowQ10pcuWp78FIXeeQPaTHCNagzMnuMcP7mPlXnGITzHvh925
         63Q+1X7irJlzG07At4ibNBuONLthoE9j5kfvcrLEpZ/QZNZ6zEzG1Hnuc1pKq/pdeMlh
         EvajeCk3y86JVe3zF9egt0qxJKvBt4eFWMdyzc0Oy6qEKAedCS0KIn4+lhnNDYmB3hNW
         oT3A==
X-Gm-Message-State: APjAAAVZaF3hQu+IzMRQ9xqcFBpjwvpMppa21onHfg7wUEdrnSyGe1KH
        8tFBwe2G+LD8DER+7TbfGFc1Yir3h+hJpPrzKac566K6GST2MPEGj6ZtB9EjSyZKDI3fdhqBHj5
        CsQOILgiDBXkh5TyZwWi5U5Om
X-Received: by 2002:a05:620a:1108:: with SMTP id o8mr9361843qkk.118.1578581903455;
        Thu, 09 Jan 2020 06:58:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbk+PEzju7o1lLOeEMcQhDn/PrsxAenkqs3X56jNWYL+hX9tnG49Zv7cb0rnQ4BjnnJdD5RQ==
X-Received: by 2002:a05:620a:1108:: with SMTP id o8mr9361819qkk.118.1578581903204;
        Thu, 09 Jan 2020 06:58:23 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:22 -0800 (PST)
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
Subject: [PATCH v3 21/21] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Thu,  9 Jan 2020 09:57:29 -0500
Message-Id: <20200109145729.32898-22-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used to override the existing dirty ring size/count.  If
with a bigger ring count, we test async of dirty ring.  If with a
smaller ring count, we test ring full code path.  Async is default.

It has no use for non-dirty-ring tests.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 6da97e4a9408..fb6c33dbaf35 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -163,6 +163,7 @@ enum log_mode_t {
 /* Mode of logging.  Default is LOG_MODE_DIRTY_LOG */
 static enum log_mode_t host_log_mode;
 pthread_t vcpu_thread;
+static uint32_t test_dirty_ring_count = TEST_DIRTY_RING_COUNT;
 
 /* Only way to pass this to the signal handler */
 struct kvm_vm *current_vm;
@@ -235,7 +236,7 @@ static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 	 * Switch to dirty ring mode after VM creation but before any
 	 * of the vcpu creation.
 	 */
-	vm_enable_dirty_ring(vm, TEST_DIRTY_RING_COUNT *
+	vm_enable_dirty_ring(vm, test_dirty_ring_count *
 			     sizeof(struct kvm_dirty_gfn));
 }
 
@@ -260,7 +261,7 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	DEBUG("ring %d: fetch: 0x%x, avail: 0x%x\n", index, fetch, avail);
 
 	while (fetch != avail) {
-		cur = &dirty_gfns[fetch % TEST_DIRTY_RING_COUNT];
+		cur = &dirty_gfns[fetch % test_dirty_ring_count];
 		TEST_ASSERT(cur->pad == 0, "Padding is non-zero: 0x%x", cur->pad);
 		TEST_ASSERT(cur->slot == slot, "Slot number didn't match: "
 			    "%u != %u", cur->slot, slot);
@@ -723,6 +724,9 @@ static void help(char *name)
 	printf("usage: %s [-h] [-i iterations] [-I interval] "
 	       "[-p offset] [-m mode]\n", name);
 	puts("");
+	printf(" -c: specify dirty ring size, in number of entries\n");
+	printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
+	       TEST_DIRTY_RING_COUNT);
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
 	printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
@@ -778,8 +782,11 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hi:I:p:m:M:")) != -1) {
+	while ((opt = getopt(argc, argv, "c:hi:I:p:m:M:")) != -1) {
 		switch (opt) {
+		case 'c':
+			test_dirty_ring_count = strtol(optarg, NULL, 10);
+			break;
 		case 'i':
 			iterations = strtol(optarg, NULL, 10);
 			break;
-- 
2.24.1

