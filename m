Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29570C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DD42084A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098955;
	bh=QCqvO5K1yok0S3RV5/Q5vyE2p0EZLifLOGIWOa9loGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wTYm5ZJlxiMa3cTl/qSTU/R3mWCtgCSevp1TVkj5pJwZGpoYYwEtzuBuR5B7E1keM
	 42M9AjL2t7e10wjLrAEATTN6yptGs6JbPtkpCyQjloDAFSNtMLvuPwCucrrZqHub2k
	 N4efDwe6GJ+SXGjbDsplHy6KrBtbiDqzCtD6ZfsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfFIQtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbfFIQtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C802070B;
        Sun,  9 Jun 2019 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098945;
        bh=QCqvO5K1yok0S3RV5/Q5vyE2p0EZLifLOGIWOa9loGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiJZOAJ8nbtNg80/ggmxBS0XlEPes4uDbxfzGKhTQnFvW2ZECw9p0x1GKj9k6y+6e
         BRm2+SPKXHKtswP+Tw+PjDwkc1JxaTNWRZGOiYxZ286KnADk2byxGBDANnfOWZOdd4
         Ez7WGIGzxGkM63tYUf6/Ul9uv6LaAGBqROkYz1sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amber Lin <Amber.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 46/51] drm/amdgpu/soc15: skip reset on init
Date:   Sun,  9 Jun 2019 18:42:27 +0200
Message-Id: <20190609164130.489004849@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 5887a59961e2295c5b02f39dbc0ecf9212709b7b upstream.

Not necessary on soc15 and breaks driver reload on server cards.

Acked-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/soc15.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -495,6 +495,11 @@ int soc15_set_ip_blocks(struct amdgpu_de
 		return -EINVAL;
 	}
 
+	/* Just return false for soc15 GPUs.  Reset does not seem to
+	 * be necessary.
+	 */
+	return false;
+
 	if (adev->flags & AMD_IS_APU)
 		adev->nbio_funcs = &nbio_v7_0_funcs;
 	else if (adev->asic_type == CHIP_VEGA20)


