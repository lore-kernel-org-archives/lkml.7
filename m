Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427EBC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F64720675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483532;
	bh=wwf59jvlmgAHxBsSVCN3Drer6FJuWS1VyOrFqmPPIZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjeqnBFS3Pe/ld4dc08A8j8ZILX9GSbTcSmSbHYzXKYLiHQ5NSgokIpbmooqOf1Dm
	 9OaiNoWPA7ybz7KXMlbhH7drQ8hhUhAW6QAWSCZBsrbGIbeT9XyKFZ6FXI4K1NwoVw
	 2OORbL7wxbut3gEckSSzJrncM6r2ZLR5qLSgGce4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfLDSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731257AbfLDSKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:24 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0DE206DF;
        Wed,  4 Dec 2019 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483023;
        bh=wwf59jvlmgAHxBsSVCN3Drer6FJuWS1VyOrFqmPPIZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XA2ID4PgNDqMfteUxfkxqkwsTtwjWrVTOQAE+9bgegOT8qDOu1pv2BO5UbqnjqOlF
         5oFr9RUCloEGzMqa9cQFGDPmivLltw5MTP7vLjILhQoCHHq9N+4kgyt0ZPq6bjTK/x
         efbdK/UVLhqgxtWR9ap0lg9dEvufgf12DQS3WXsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 020/125] arm64: smp: Handle errors reported by the firmware
Date:   Wed,  4 Dec 2019 18:55:25 +0100
Message-Id: <20191204175318.319074728@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <Suzuki.Poulose@arm.com>

[ Upstream commit f357b3a7e17af7736d67d8267edc1ed3d1dd9391 ]

The __cpu_up() routine ignores the errors reported by the firmware
for a CPU bringup operation and looks for the error status set by the
booting CPU. If the CPU never entered the kernel, we could end up
in assuming stale error status, which otherwise would have been
set/cleared appropriately by the booting CPU.

Reported-by: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f0c41524b052f..b2d6de9f6f4fb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -173,6 +173,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		}
 	} else {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		return ret;
 	}
 
 	secondary_data.stack = NULL;
-- 
2.20.1



