Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001F92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806628;
	bh=yFz7mf582VIah1G03076oUHRNaFg2u1aaFc2TEYEWfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ez1PA5X/BIxn3NWM1x8x2ADzMgNh5jXL+TT6pNTN4aIB2U/oDHToelpWQsGwaXy9v
	 JTDZsX0IYRV7aVB++5+a8hTSNe2wFESTwgw3lTfJbOeu7oX3BgDV6DOYnuTrvCLBf6
	 crgLjQYAty38Rc1+LHIdmiwSwArIhp+wVEu6ftzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfFQVXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbfFQVXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32148206B7;
        Mon, 17 Jun 2019 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806623;
        bh=yFz7mf582VIah1G03076oUHRNaFg2u1aaFc2TEYEWfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEuc7RN/NYG9m/56xR8lGD6YL0zOC7EeyoILy3e3K9+ZsGH6+6JoBeH6NV4SJh/2p
         1vdxOm5iLTd4x0l9bh2GJhvWSFbEUVbAMQ/kff5xKak/9SEAC/ZsMWzD9diTGC4PwO
         42AYIOZAZkf+Sxj6beiCKmE2NgyW7GYrxTGn5Jl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 092/115] kvm: selftests: aarch64: dirty_log_test: fix unaligned memslot size
Date:   Mon, 17 Jun 2019 23:09:52 +0200
Message-Id: <20190617210804.625344902@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bffed38d4fb536c5d5d6c37846a7fb8fde1452fa ]

The memory slot size must be aligned to the host's page size. When
testing a guest with a 4k page size on a host with a 64k page size,
then 3 guest pages are not host page size aligned. Since we just need
a nearly arbitrary number of extra pages to ensure the memslot is not
aligned to a 64 host-page boundary for this test, then we can use
16, as that's 64k aligned, but not 64 * 64k aligned.

Fixes: 76d58e0f07ec ("KVM: fix KVM_CLEAR_DIRTY_LOG for memory slots of unaligned size", 2019-04-17)
Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 93f99c6b7d79..a2542ed42819 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -292,7 +292,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	 * A little more than 1G of guest page sized pages.  Cover the
 	 * case where the size is not aligned to 64 pages.
 	 */
-	guest_num_pages = (1ul << (30 - guest_page_shift)) + 3;
+	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
 	host_page_size = getpagesize();
 	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
 			 !!((guest_num_pages * guest_page_size) % host_page_size);
-- 
2.20.1



