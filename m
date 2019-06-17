Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB02C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8165620673
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806549;
	bh=UId77BICZEpA/UsvGVGQRGAbedVI4rYAgNUJ5+/5NQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FGymU7GR/c4s0Ihq7rBBnZarxAe0ZvtEbUpFlFwKIiAar0RtxLeUdXQSFaZ1uDLZs
	 kQCmfkbXY/jqllW0pc4/JPC3EBVFR2SqmnoHyQ4ilTVl3BoHWvUd5NnGMbMZchrK8d
	 8eB5p2xWu4QIhhJPMZZMyAvoKRisH1NHbWJAxgn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfFQVW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFQVWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440EA208E4;
        Mon, 17 Jun 2019 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806539;
        bh=UId77BICZEpA/UsvGVGQRGAbedVI4rYAgNUJ5+/5NQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxWu7WK61k0oqYoDw7cz04cRe+YaopyWVl1acL37jz8EISVP80/4zYMXzugRtM4vh
         ckezjaZmzIGWCopUrvKTNTZkV+gAVjDSBIIpyj+RvDwVPzQSCI27LQCizw3LgNNzXa
         V7O7iWaVYxKIpgQPANhtZxQTpNiTas9ZAklSTUTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 085/115] KVM: selftests: Fix a condition in test_hv_cpuid()
Date:   Mon, 17 Jun 2019 23:09:45 +0200
Message-Id: <20190617210804.324541692@linuxfoundation.org>
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

[ Upstream commit be7fcf1d1701a5266dd36eab4978476f63d1bd57 ]

The code is trying to check that all the padding is zeroed out and it
does this:

    entry->padding[0] == entry->padding[1] == entry->padding[2] == 0

Assume everything is zeroed correctly, then the first comparison is
true, the next comparison is false and false is equal to zero so the
overall condition is true.  This bug doesn't affect run time very
badly, but the code should instead just check that all three paddings
are zero individually.

Also the error message was copy and pasted from an earlier error and it
wasn't correct.

Fixes: 7edcb7343327 ("KVM: selftests: Add hyperv_cpuid test")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 9a21e912097c..63b9fc3fdfbe 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -58,9 +58,8 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 		TEST_ASSERT(entry->flags == 0,
 			    ".flags field should be zero");
 
-		TEST_ASSERT(entry->padding[0] == entry->padding[1]
-			    == entry->padding[2] == 0,
-			    ".index field should be zero");
+		TEST_ASSERT(!entry->padding[0] && !entry->padding[1] &&
+			    !entry->padding[2], "padding should be zero");
 
 		/*
 		 * If needed for debug:
-- 
2.20.1



