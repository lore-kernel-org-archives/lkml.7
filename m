Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5229D2433B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172327;
	bh=wAD+EIEQl2C9vRdtH40yHMviHxF32uLp+NaZyCvtvNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cE7hhJk7aL2rbNVzRaUeoWp7tBWQ0JaCdn0aXgRSg8tkYiO0cYvU52dh7rpDLriQy
	 4sD2TkHyJ5aPtnVycaQG58pIcD4nsy1hvzSUVly5Q6fPBBoylKv8zQHZxjX1P1HiIy
	 qM7pgpSwgS8MH2R3R+nk24JMPZOuy0TsnC3EMpbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfE2XZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:25:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MWu4b2HnNsZ9u5zNAl68rcYIhiC5L6PnTagFV0A6q48=; b=K1nGrVDBAQC7pk/EbproUAqI1+
        upbz7pNriyhWhaB2djiqMSec90VJVZNZZQPTxHoyvwBeSb9+4/hq+nlbEJx6hWgnrNMbstaqTQ2Li
        x95HPcTDap7E9vEkVXSmTqcpKPKNdypHBw28S7sw2iKBBJx6roKQC1lG1NCQ+VAp1fwwUY2bJs2uM
        qtsk7hulpXxFuLqZQ+pQa47pL/YruplXP3XL1FDPwK2lKynAPopb/tnWEzUdfY0aK6MyIBcZxCfwP
        GHdDcThp2iYi2b7AlAsn+Jgw59ilxzNgwTeed6QXQAuZzz8ggkE5NTJ/U48CU67QHRBmSCslEw14l
        AWEac4qA==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Ro-9e; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xQ-P9; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/22] gpu: amdgpu: fix broken amdgpu_dma_buf.c references
Date:   Wed, 29 May 2019 20:23:42 -0300
Message-Id: <f7378a751557277eab6f37f3f5692cf5f1aff8c6.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was renamed, but docs weren't updated accordingly.

	WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function PRIME Buffer Sharing ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' failed with return code 1
	WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' failed with return code 2

Fixes: 988076cd8c5c ("drm/amdgpu: rename amdgpu_prime.[ch] into amdgpu_dma_buf.[ch]")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpu/amdgpu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index a740e491dfcc..a15199b1b02e 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -37,10 +37,10 @@ Buffer Objects
 PRIME Buffer Sharing
 --------------------
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
    :doc: PRIME Buffer Sharing
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
    :internal:
 
 MMU Notifier
-- 
2.21.0

