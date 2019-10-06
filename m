Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FBC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2AF2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384576;
	bh=GMQqub5xp0/4XAi4fDZg0COcqBv/GhT/CjZ1rK/+jCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZsIR7P01qf8GRTZAJ4SNCEHIBO92Xk9ZmqpSuaN5HuhRFSsCmoUeNv1NHgEUTyy3
	 wdPq+J1s9On5DezzMKI3A3ze2DoddFp5vqH9IsVkEXd22TqhrFTnR9QNmu9vf32Cc9
	 SJ7JOUq2AayH45ti0WYmOCGNUhWEaxR4Rehlg9QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfJFRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbfJFRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:35:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034FC2080F;
        Sun,  6 Oct 2019 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383327;
        bh=GMQqub5xp0/4XAi4fDZg0COcqBv/GhT/CjZ1rK/+jCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJ3gAGAgWdZI3via41frmM/MVxcBcF/eIBPUy7S/FrKVCa8/bLlq/ZD8djwWio7xS
         mh2w3nlP3t2XKQ5IWFQz4B0otjjLSEEXm2RQ1leETSnuukBNBHMLeMJeWVdkIpZQPO
         Otk8yw3ftsmM4QoWYdC9JttxQahkSW9YnlQH9ao4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 063/137] drm/nouveau/kms/tu102-: disable input lut when input is already FP16
Date:   Sun,  6 Oct 2019 19:20:47 +0200
Message-Id: <20191006171213.981899559@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 1e339ab2ac3c769c1b06b9fb7d532f8495ebc56d ]

On Turing, an input LUT is required to transform inputs in fixed-point
formats to FP16 for the internal display pipe.  We provide an identity
mapping whenever a window is enabled for this reason.

HW has error checks to ensure when the input is already FP16, that the
input LUT is also disabled.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 283ff690350ea..50303ec194bbc 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -320,7 +320,9 @@ nv50_wndw_atomic_check_lut(struct nv50_wndw *wndw,
 		asyh->wndw.olut &= ~BIT(wndw->id);
 	}
 
-	if (!ilut && wndw->func->ilut_identity) {
+	if (!ilut && wndw->func->ilut_identity &&
+	    asyw->state.fb->format->format != DRM_FORMAT_XBGR16161616F &&
+	    asyw->state.fb->format->format != DRM_FORMAT_ABGR16161616F) {
 		static struct drm_property_blob dummy = {};
 		ilut = &dummy;
 	}
-- 
2.20.1



