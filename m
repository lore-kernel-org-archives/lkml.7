Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD9DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562BC2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497350;
	bh=cIA2Er4jQ/jeqXZOLNDmggGDCTaLVlwFasMubnHygrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gUre00wks5dSu+yxIJ0rrzZDFMXF4vJuXzH909KZjGtcsIsAWDVBydKvv9W8KI5mZ
	 95XGcBp0wUbwXBVJJGS2uWA9UaxvEDlFFPfRF9b9840GaX862BXmHI1H/Gc7tyHJTO
	 eZ3c/VBRKzbOXx8R9TIq48cRjjCKOufQwu3NKm0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKKSfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbfKKSfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:35:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E352173B;
        Mon, 11 Nov 2019 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497343;
        bh=cIA2Er4jQ/jeqXZOLNDmggGDCTaLVlwFasMubnHygrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zBUmLrDynvq+kcDj8ImZ1bwf8T8BC0OdzBjkYnP3L5DY62PS/P6mysFGM1xKZcA4l
         QdwVEuFzoeBDr1phL9jc4R8KD7ri1BgQFBUJYYJSBJ1Ymi8io0eG0VsK2gXNbS7j2B
         Cudq6BV8lJmGQtrT6jKsmuFZgkcQ9K1m4AXjJgtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yong Zhao <yong.zhao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 021/105] drm/radeon: fix si_enable_smc_cac() failed issue
Date:   Mon, 11 Nov 2019 19:27:51 +0100
Message-Id: <20191111181435.385078451@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 2c409ba81be25516afe05ae27a4a15da01740b01 upstream.

Need to set the dte flag on this asic.

Port the fix from amdgpu:
5cb818b861be114 ("drm/amd/amdgpu: fix si_enable_smc_cac() failed issue")

Reviewed-by: Yong Zhao <yong.zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -1956,6 +1956,7 @@ static void si_initialize_powertune_defa
 		case 0x682C:
 			si_pi->cac_weights = cac_weights_cape_verde_pro;
 			si_pi->dte_data = dte_data_sun_xt;
+			update_dte_from_pl2 = true;
 			break;
 		case 0x6825:
 		case 0x6827:


