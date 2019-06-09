Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1246C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4320833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098791;
	bh=8Meu+dYFXkLHrYLx5N70A08mc//2OwgdQeTvibI2VBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zoFBhzFWRfQXMuQj5mYCO52GMondpAJl/ZHb8g72U4yUMh9nDx/ZYjrK/dGk5Z26u
	 qwJHe5CjREPHElsdfwf9+zBU99/mjDmqIYzaT4s8PRZo2Cx3JAU79zaR40tqRzoH0L
	 5E7YXDL6vYLjwuZLN8v9ngVXhDzlhGDl9QhyDlxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfFIQqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfFIQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A91D20833;
        Sun,  9 Jun 2019 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098787;
        bh=8Meu+dYFXkLHrYLx5N70A08mc//2OwgdQeTvibI2VBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOb8J8PsGfdrMajjWrecvKwiYsN54sxCuccu1bqlDsNVlYjUnwpxfxzo2cr5tM0kD
         l9R4HEnYQYY0DSV/Nj6Fq6L0ScZEIt2GjqoYk+tXPs5V5ymZZmKP3uwzUfSZ0qDnmJ
         yHcWoBOqOyMhYuRhCa/aJeiTvgylMyoH5Gr8UKxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amber Lin <Amber.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.1 61/70] drm/amdgpu/soc15: skip reset on init
Date:   Sun,  9 Jun 2019 18:42:12 +0200
Message-Id: <20190609164132.590111880@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
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
@@ -713,6 +713,11 @@ static bool soc15_need_reset_on_init(str
 {
 	u32 sol_reg;
 
+	/* Just return false for soc15 GPUs.  Reset does not seem to
+	 * be necessary.
+	 */
+	return false;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 


