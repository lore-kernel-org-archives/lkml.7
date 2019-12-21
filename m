Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDAFC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64D206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3+h+HBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLUCFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24048 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726936AbfLUCFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576893900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AXOUsRryqKjAteH3ZGpL2igYSciQ5+eIxg15f7PMTs=;
        b=E3+h+HBpLh5lIu7byCdWdOWVnkDDYpu0OGpDiAo5AGp/wMXprSaiLEzGFtvRVLew2Hinle
        RHpjjZBMxAslcQ0g2O9c2LBAEJpbvcw+huGuBJH1TT/ibRniPqiWTJjg+7ibYhvMdwofYy
        c/GmGJ4KnDSa34yjgWG6Pa7vOVRwjg8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-sKLYOX96N7Wn2tfrYYmlCg-1; Fri, 20 Dec 2019 21:04:59 -0500
X-MC-Unique: sKLYOX96N7Wn2tfrYYmlCg-1
Received: by mail-qv1-f71.google.com with SMTP id j10so365757qvi.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 18:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AXOUsRryqKjAteH3ZGpL2igYSciQ5+eIxg15f7PMTs=;
        b=EpJj1N6GXz/33xziCJdw7g15wsMLT6q3V37Fgyoks6v9GBqVQzgBfZuDNVdjyIQWAy
         2hgSAxi9sJWXj9VB1J+Z6+LNJI3KQdQGAZd8gG/Wlln/r96fotTcZA98Z9xzs5gzKYgx
         siJ2E55MmuirHT98VXToFiDifXeohA+zx2qTKVrIgFaRBna6QEVJLxKRXZRAyyNOP5r3
         hI45Aid0BEVJYWk8sKwJZTKEfYWBUTIjB7jYlkaJxOm+xqAQCuggHRyEbnTY7p3T7Qes
         SzaTOfujsJ3B1K54INXMUGs2X6C+btGmDWgJO7RPJhaOM6ifVacN8QngJFzwq9jcaJwB
         XjbA==
X-Gm-Message-State: APjAAAVkUnhrqecdNDo0Bilm5DUMUwVShp2QwfdyjiQU5tJVgg7+RRNd
        CWqYDJVcqPdz5Oc7cFhtusUFPs1eFm3tCEAb4hIyE1LxpZvzEdAN5wNELutIw2td8u9tARRBR5A
        cpSrxgLa9gcQH0ZGOaPPDINz1
X-Received: by 2002:ac8:7446:: with SMTP id h6mr4848821qtr.274.1576893899276;
        Fri, 20 Dec 2019 18:04:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7mCEEH7P71Ua3bJQg30Nbdfqj7jsDcLyCeU6SRd+ba4CAKL8QnQEnh20BOPcL0SFIEUGPhw==
X-Received: by 2002:ac8:7446:: with SMTP id h6mr4848806qtr.274.1576893899045;
        Fri, 20 Dec 2019 18:04:59 -0800 (PST)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id t7sm3400114qkm.136.2019.12.20.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 18:04:58 -0800 (PST)
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
Subject: [PATCH RESEND v2 17/17] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Fri, 20 Dec 2019 21:04:45 -0500
Message-Id: <20191221020445.60476-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221020445.60476-1-peterx@redhat.com>
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
index 4403c6770276..fde3fa751818 100644
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

