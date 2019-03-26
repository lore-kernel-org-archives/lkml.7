Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C670EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C222070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582332;
	bh=OBUSxS5Pd1Gs1n/kLZ7PrbncXkdSTFuyCZIszl8f32k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HLKfIQwxfxZWdK7QzepuHBEXIPpMCboHbaNPQG7u7wYbQN234knBMrRDhiPY1iko6
	 hGtaEyjqjWqz/CbqnPRNQMcpIiodMbs4RzFq4ixhwm53T7qC6ZuScL35NPi+9APwiZ
	 ATMBMuiVrK9U17bRqTkm8mFHJohGC0lc3yFVoXSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfCZGiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbfCZGis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:48 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2422E2070B;
        Tue, 26 Mar 2019 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582327;
        bh=OBUSxS5Pd1Gs1n/kLZ7PrbncXkdSTFuyCZIszl8f32k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOEvSoAThDbC74dmWmZWoi0+YIt0ZeaNAMX+e+ox1mD9iujmU8DmUx4nlviA1MoqF
         To4ZteA08ZiVhVJ8VZpdZLsiXySyzDHjmVLD0DDfmTfeiCXBvj7gnuTGLc9DYbsCRN
         /AtcaI6WNroTEhjSUJ2fAKvkU/d+KkuiH2r0q694=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.0 07/52] drm/amdgpu: fix invalid use of change_bit
Date:   Tue, 26 Mar 2019 15:29:54 +0900
Message-Id: <20190326042701.327682053@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 72464382fc2d3673eb51f21a57f2c0a320c1552f upstream.

We only need to clear the bit in a 32bit integer.

This fixes a crah on ARM64 and PPC64LE caused by
"drm/amdgpu: update the vm invalidation engine layout V2"

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -738,7 +738,7 @@ static int gmc_v9_0_allocate_vm_inv_eng(
 		}
 
 		ring->vm_inv_eng = inv_eng - 1;
-		change_bit(inv_eng - 1, (unsigned long *)(&vm_inv_engs[vmhub]));
+		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);


