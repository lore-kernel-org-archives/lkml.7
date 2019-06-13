Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA563C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26720866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442043;
	bh=nZ9mjRNW1Bgexwp8v7itdN7Ro72sgff9guZIoOH2c2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4WWYq6X9wyKb2VWKdynLdlfnaN/Qsw6y88Pr2xJCONAjYkZ1FjNnVoXFYBfewndu
	 TLdfFmwo7dXkPuda/dIoe+hwDG7B3/l+SsS2RGBbr0zIwgSLPOM/nuo0ia4mUh02LO
	 GDkgC5cztaBDFZd8OmFhiU3DcJkjLty6pPmUT2l4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbfFMQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbfFMIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FFD20851;
        Thu, 13 Jun 2019 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415530;
        bh=nZ9mjRNW1Bgexwp8v7itdN7Ro72sgff9guZIoOH2c2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDfkENeapAzeb7QQphLa0rh1oJIgLl4G3BvOdzkTN0AOZfHuY5fHm+tge5as8iwzc
         4RVeRb8119W2u3Utp8qyzQEQbzPJarBCiHBqwyfXGi3pevhW1XA54bkW/bEfk2rDMw
         IKR2QxS1ll1fyRCCv1rW51gqGINlyroD5w5NTAlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Peteris Rudzusiks <peteris.rudzusiks@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 033/155] drm/nouveau: fix duplication of nv50_head_atom struct
Date:   Thu, 13 Jun 2019 10:32:25 +0200
Message-Id: <20190613075654.866267624@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c4a52d669690423ee3c99d8eda1e69cd0821fcad ]

nv50_head_atomic_duplicate_state() makes a copy of nv50_head_atom
struct. This patch adds copying of struct member named "or", which
previously was left uninitialized in the duplicated structure.

Due to this bug, incorrect nhsync and nvsync values were sometimes used.
In my particular case, that lead to a mismatch between the output
resolution of the graphics device (GeForce GT 630 OEM) and the reported
input signal resolution on the display. xrandr reported 1680x1050, but
the display reported 1280x1024. As a result of this mismatch, the output
on the display looked like it was cropped (only part of the output was
actually visible on the display).

git bisect pointed to commit 2ca7fb5c1cc6 ("drm/nouveau/kms/nv50: handle
SetControlOutputResource from head"), which added the member "or" to
nv50_head_atom structure, but forgot to copy it in
nv50_head_atomic_duplicate_state().

Fixes: 2ca7fb5c1cc6 ("drm/nouveau/kms/nv50: handle SetControlOutputResource from head")
Signed-off-by: Peteris Rudzusiks <peteris.rudzusiks@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 8efb778a3b20..06ee23823a68 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -413,6 +413,7 @@ nv50_head_atomic_duplicate_state(struct drm_crtc *crtc)
 	asyh->ovly = armh->ovly;
 	asyh->dither = armh->dither;
 	asyh->procamp = armh->procamp;
+	asyh->or = armh->or;
 	asyh->dp = armh->dp;
 	asyh->clr.mask = 0;
 	asyh->set.mask = 0;
-- 
2.20.1



