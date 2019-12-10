Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58471C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243A206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLJSyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:54:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:33480 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:54:44 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 67B43200D1;
        Tue, 10 Dec 2019 19:54:39 +0100 (CET)
Date:   Tue, 10 Dec 2019 19:54:38 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 0/8] Add Unisoc's drm kms module
Message-ID: <20191210185438.GA13884@ravnborg.org>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=VvfsPnTBGurI0KqpiJ4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin.

Thanks for this new driver.
A few somments triggered alone from the diffstat.
> Kevin Tang (8):
>   dt-bindings: display: add Unisoc's drm master bindings
>   drm/sprd: add Unisoc's drm kms master
>   dt-bindings: display: add Unisoc's dpu bindings
>   drm/sprd: add Unisoc's drm display controller driver
>   dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
>   drm/sprd: add Unisoc's drm mipi dsi&dphy driver
>   dt-bindings: display: add Unisoc's generic mipi panel bindings
>   drm/sprd: add Unisoc's drm generic mipi panel driver
> 
>  .../devicetree/bindings/display/sprd/dphy.txt      |   49 +
>  .../devicetree/bindings/display/sprd/dpu.txt       |   55 +
>  .../devicetree/bindings/display/sprd/drm.txt       |   18 +
>  .../devicetree/bindings/display/sprd/dsi.txt       |   68 +
>  .../devicetree/bindings/display/sprd/panel.txt     |  110 ++

New bindings in metaschema format (.yaml).
And panel bindings in display/panel/

>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/sprd/Kconfig                       |   14 +
>  drivers/gpu/drm/sprd/Makefile                      |   17 +
>  drivers/gpu/drm/sprd/disp_lib.c                    |  290 ++++
>  drivers/gpu/drm/sprd/disp_lib.h                    |   40 +
>  drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
>  drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
>  drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  640 +++++++++
>  drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
>  drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
>  drivers/gpu/drm/sprd/dpu/Makefile                  |    8 +
>  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                | 1464 ++++++++++++++++++++
>  drivers/gpu/drm/sprd/dsi/Makefile                  |    7 +
>  drivers/gpu/drm/sprd/dsi/core/Makefile             |    3 +
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1186 ++++++++++++++++
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 +++++++++++++++++++
>  drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  392 ++++++
>  drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
>  drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
>  drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dphy.c                   |  235 ++++
>  drivers/gpu/drm/sprd/sprd_dphy.h                   |  121 ++
>  drivers/gpu/drm/sprd/sprd_dpu.c                    | 1152 +++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h                    |  217 +++
>  drivers/gpu/drm/sprd/sprd_drm.c                    |  287 ++++
>  drivers/gpu/drm/sprd/sprd_drm.h                    |   19 +
>  drivers/gpu/drm/sprd/sprd_dsi.c                    |  722 ++++++++++
>  drivers/gpu/drm/sprd/sprd_dsi.h                    |  210 +++
>  drivers/gpu/drm/sprd/sprd_gem.c                    |  178 +++
>  drivers/gpu/drm/sprd/sprd_gem.h                    |   30 +

>  drivers/gpu/drm/sprd/sprd_panel.c                  |  778 +++++++++++
>  drivers/gpu/drm/sprd/sprd_panel.h                  |  114 ++
Please move panels to drivers/gpu/drm/panel/ and make sure to utilize
the drm_panel infrastructure.

	Sam
