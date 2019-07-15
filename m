Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3B2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fGqMiPsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfGONWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:22:18 -0400
Received: from mout.web.de ([217.72.192.78]:55561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbfGONWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563196929;
        bh=m3ETQIoQjM+lw0ppVqdyQxr42kV7UN1emuY55x6te74=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=fGqMiPsaImyFYkZkqESvPgHAzYglyDZZJRo/FAamAOucqo2QA/CNm0S1uAQ3GaNV4
         JPB5KtjckVFrtBasxQNB9r9+IBH7i6mfqPob4Ddu+CNPG2bU7wWT77wKh4ll6EG2xr
         o96licr9LrCHEoGOU0/VD8GKYpwzbu1l8BtOtI4k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.93]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls95v-1iSYdq1YpL-013rmK; Mon, 15
 Jul 2019 15:22:09 +0200
To:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>
References: <20190715114332.24634-1-huangfq.daxian@gmail.com>
Subject: Re: drm/amd/powerplay: remove redundant memset
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d74e5147-7429-8f11-a7dc-389714315e38@web.de>
Date:   Mon, 15 Jul 2019 15:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190715114332.24634-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:eYVxtKWpPIVM//grDzhiG+tY7JJ5HMsXKHXr4CQuneDbme5j7EC
 iIrveOorAUbirnp2M6dj3yXy/Bgx1NVCzmbkDi608QvcLUSYyA3JAR6ktvVNAqEP3gV9t85
 BIUqLE6tMZ8jPxzK8g2Upk43pMnAifv8jJP0PbmL99EDt5mZDsX11dTy6RaFwhzfm3jJLYh
 DSFch7UQTcbdDLr+sy92g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31K/B6G9VFw=:/Bv55V76Op7GnTaZc279wc
 rTWZa+tU96YWHfPjeICFIe7XtPOTuoOECnPkkPqWWNO7BhehXQvNsR+UuvNfMcBv7EKAmWCWA
 6QAWAszVDQcSTzStMtoZicC0vkqnwS6Wv0ygONPc1ZJFyi5F9J6eE5IYUWn5avjI2TlhiFXBr
 /z6AURuS0vEPdWOJkDj1Ih9oGP2+IRWjHA89rNiJksh6HmwoW8QGZiYLJMcloMtw+KUSIyEDF
 r3E0NdJhmPKGQEYydVCstE3v75ybLegY3Xv0plE8SHStgyY71A3QK/cP8loTlZka3cf0na4rW
 ELz8/kPiJKMqFBJrMV4ww08iCEQVtuL/G6kZXL+H8oa6k7Os7zdeiowcA32GaA2KUGxhFkyrM
 TfDrVpqeawhQh6Qq7v3/s0vn10WUM/XvTSPGkcDt4x2Y0iUR+mm55CGHy0c7CN9wcDiCyf4Cm
 ghYDdMr0e1v5vaqNBW/TkC786HniPZq0NqDrcVLyHxO1JtvxaOHTWaYSGGcDhDuvPYiiyAdsY
 mn+/svpnxFfIeYQGz9/nccJTYLShjOeebHufPLOOinvfRSu4GFhMI+OQRY2Gl5GcYMEx9hbaZ
 Q6+OOCIhly07QKF/Qe/9n2gGi/EGQVSlfgAAU/ltUMNqaml0yzb9gV8rXbrTM4olvuarY3lMq
 nsyzF/Ap3o5s+yG4KeUpKUN+lyho+8pjLvnFHza4w34IwA/vtAVthABk2aj8lOEtAafPo3yoG
 vgHJ/6M5DJ/zz3RxLwNNr29cwCJ1nng96cAcSTxgqWBVgXbHjSSFeHULOv8D4naFyARAQifHC
 FP3FWNBtEbTq1XG9k6fFWvfmazWQ89iphU+JJ9sRTx1jRxqj8rLUSSBp6KdSorFRuKkBCNlm4
 ddObrSfi/1F3mM7m0gSc8a8kf+V/MLma4AhLUTOaVzwLlU2laF/FCO6Wycd2s3rFXFW37aXbU
 ycy8KzCnn10HSBdsuh83DsIwc4+frYux1GNPuCQ22rsz3b2FVryAKtXE/lvgi9s+9ATOXgT0O
 rwqvX3/nsMVrVKxQ4oortKpFfeOh1SsQdhl968VIVQ/EJ7ik89mLiOoEjSIAjpVZ1Vck64q+F
 n4v9aIaZOFuLQdlJdJYJP3EqCvw8gESXiFx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kzalloc has already zeroed the memory.
> So the memset is unneeded.

See also a previous patch:
drm/amd/powerplay: Delete a redundant memory setting in vega20_set_default_od8_setttings()
https://lore.kernel.org/lkml/de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de/
https://lore.kernel.org/patchwork/patch/1089691/
https://lkml.org/lkml/2019/6/17/460

Regards,
Markus
