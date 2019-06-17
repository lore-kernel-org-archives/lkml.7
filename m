Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D02C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4602084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q3hRNc+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFQMKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:10:37 -0400
Received: from mout.web.de ([212.227.15.14]:56253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFQMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560773412;
        bh=mlYu8JItkzkaUEYK3B9di0oUcsYk/xS6Vlr7z6Eo05s=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=Q3hRNc+jeb6z1AfmmAn42HSzGeI+Ugm1iRy6uWK4nBibU9atJ9WBx7QmE25VSdg/6
         5i6KqCKdjs9E8vgQggssB5B6COykILAiOKJaBiOer1YMkelFChcDaaHI5cCausSz3r
         sz39Dv3FsSBHDIJjrVNhfzD3CIB9OLJ6/1db03ds=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.164.208]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LopMx-1iHhfD2r7b-00gtNY; Mon, 17
 Jun 2019 14:10:12 +0200
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amd/display: Delete a redundant memory setting in
 amdgpu_dm_irq_register_interrupt()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <3900e9c8-4905-1704-686d-90ccf3b00a88@web.de>
Date:   Mon, 17 Jun 2019 14:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gINRoyvJBwA0izvAsysZLEiAXPyc0PdK7XoWn/NowK86RvwMyOB
 CDcFSV0P3DUUQmM4Fcv2MU5A8vQ10pKfKw9Pa/u0V68halCVosCNq746NnxQqiaqWzbLxDQ
 bSeCbhoRexPtceXKYDQosgcEUzltxy/McyIqVP96TZtbM6UVk1dUaYAlz9mImpmY0sstTDv
 /IlwrJ03OZcDRZ/eltzxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CJ9U0fhgAi0=:qWDICxmE9F1Ky0JwFFP9lE
 tJbAE5Ltaft6uibCP+CbM8PaHzvkkG0+qU6KsHdBlV7tNWrcb2j+FPtpWBpetGqVF5TyZF2UN
 eLEKTWokKzrFOpLQ7ydnNy3zp9GtYp1Yxze2Pnj0OxE2lZwiIVEEA+BVP46vdeLvd1ZGRmmxo
 kILYrtRJNqs4oxhM+Wn3KH2PdLsDFEqKbLPNw19reUYDdagQes8wd4v60YfRG5RYLI4H8R4ED
 TOsIfkrkgTPCtbiAEB8pRo/tZoylixlqvO7+Y+7MNM4Gbmnfxg7+CBv5AIfqb1lWVgonYk2N8
 1BqB0a0mXgzb+nBSMmmsI5qdQkUDgeuJ5Mm9Zgy9db8dDjfUB5RtFOoS0iwgxiCnPh85NW1dT
 S2HNXdcX8sz9BxkM0b5ST9HwaTjYKSU//zI94Mjlk5Tf+MmRIV5SSQjvLMMRolLsx3pLoOEjw
 pgnCERXZxLCE1G9nyJ94EuvhjkouE9uNkfMlemTeWuzMkGB+wFZROgbTJ3kOpZlDovx05mn2C
 TBn5gwImeEzxUnv6xBvInSvQpcRFctHD2Z5ZWUco5O05MtuO6wcR5/KLWc0EKQC5kzFS2CRlK
 aqA1vC/kVJcDeRnDdUKonrPO2hBHQ/+a/C/0gO+Laab9B95eeWi9qqegqAqXay/vSPVjeG07l
 aFEMHP2mEyihRGbb8D6B/rDYC/kptauSFteDkS3yGOI8zg/Jiio/lZo0kEY06SgPyTkiDveds
 el72kdFSQu6G/LMBSBbs9UvrUwlFD5DguJf6fLOakJqraMwMHciiyU/A1liBnbxymmg8bti9q
 wkmAqbByTgFKVm6l/cWgvX7hUFPm+lvGNAf7+YtARy8+MM3UxrdwSSsiB/pOFsA9CDu+4uk6q
 dbLQvgVNVf/E3s5FEXrcZmzDD7dEYe7PuFixPTIvZcVLayfYpdcFZXqJgvEXqS7Ef0si2OHHW
 xscmmYXC5SOyAeWcN12sHMhI3ZGPdIWMu7duCIIJDm1tdUH0I6v7C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Jun 2019 13:56:39 +0200

The memory was set to zero already by a call of the function =E2=80=9Ckzal=
loc=E2=80=9D.
Thus remove an extra call of the function =E2=80=9Cmemset=E2=80=9D for thi=
s purpose.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 1b59d3d42f7b..fa5d503d379c 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -277,8 +277,6 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_d=
evice *adev,
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 	}

-	memset(handler_data, 0, sizeof(*handler_data));
-
 	init_handler_common_data(handler_data, ih, handler_args, &adev->dm);

 	irq_source =3D int_params->irq_source;
=2D-
2.22.0

