Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3F3C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19B218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="oOz5/INU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfGDQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:22:22 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:50264 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfGDQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:22:22 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id DA27920218;
        Thu,  4 Jul 2019 18:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1562257334; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jaFxumsbIvgDr1oe7Gu7eEItmhTPfpnc41s1w8Cw8C8=;
        b=oOz5/INU3oEaMkX8uIJCsxzJMHv+cm/MtyDtpqKDGEfZFTtBX3FBswAPSfdn3kJJsMjhtd
        Hc2CS0nhd66uaF4cZEJqZofQohfkywmbqwJQtHO6sy0q/2NUlUIgPL76l0osm+2Myu+0/8
        DpQkPr5p2OF7sCHAH/Xm7e+3OPt1qtkIEoMtecfgDjghxuXjoBMhMER2QQMgbK21Zn/cLM
        WCFwSPRb9Z6xtwqDDbZpdwq+COl+OSyxhD5rJl7ZzgiQjYjIuuOJ0vwc5+YnxK5muRmlOQ
        gEz8B/HkVChsUqQN/4VQww02A72N8q/uUbyK7a0DB3IDas170rRZWE/6ljk3sg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 36779BEEBD;
        Thu,  4 Jul 2019 18:22:13 +0200 (CEST)
Message-ID: <5D1E27B4.9000003@bfs.de>
Date:   Thu, 04 Jul 2019 18:22:12 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvDtg==?= =?UTF-8?B?bmln?= 
        <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amdgpu/psp: fix incorrect logic when checking
 asic_type
References: <20190704142329.22983-1-colin.king@canonical.com>
In-Reply-To: <20190704142329.22983-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_SOME(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.999,0];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 04.07.2019 16:23, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check of the asic_type is always returning true because
> of the use of ||.  Fix this by using && instead.  Also break overly
> wide line.
> 
> Addresses-Coverity: ("Constant expression result")
> Fixes: dab70ff24db6 ("drm/amdgpu/psp: add psp support for navi14")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 527dc371598d..e4afd34e3034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -540,7 +540,8 @@ psp_v11_0_sram_map(struct amdgpu_device *adev,
>  
>  	case AMDGPU_UCODE_ID_RLC_G:
>  		*sram_offset = 0x2000;
> -		if (adev->asic_type != CHIP_NAVI10 || adev->asic_type != CHIP_NAVI14) {
> +		if (adev->asic_type != CHIP_NAVI10 &&
> +		    adev->asic_type != CHIP_NAVI14) {
>  			*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
>  			*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
>  		} else {
> @@ -551,7 +552,8 @@ psp_v11_0_sram_map(struct amdgpu_device *adev,
>  
>  	case AMDGPU_UCODE_ID_SDMA0:
>  		*sram_offset = 0x0;
> -		if (adev->asic_type != CHIP_NAVI10 || adev->asic_type != CHIP_NAVI14) {
> +		if (adev->asic_type != CHIP_NAVI10 &&
> +		    adev->asic_type != CHIP_NAVI14) {
>  			*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
>  			*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
>  		} else {


maybe it is better to use
		if (adev->asic_type == CHIP_NAVI10 ||
		    adev->asic_type == CHIP_NAVI14) {

i guess tha was intended here and it is more easy to read.
ppl are bad in non-non reading.

re,
 wh
