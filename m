Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB8B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Xr5Hzs6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfJVHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:31:12 -0400
Received: from mout.web.de ([212.227.15.4]:55503 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfJVHbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571729439;
        bh=wX/j8gqDrwb6uhsmDcjCsRdsbSyGM1iP6fEUbeerslQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Xr5Hzs6avALwbk5kmzQqX5cMDup5CO0WGjoVnfUNdBDS0YgGtvBjZHrfjL1YsYQuP
         bJX128Ceq6HFAczPx+CPUMMJMMNjN4imvz5ekB17jcxpoPJ88/zE0KQVqD1nS+LY7P
         Mlue8fms10x4Y9+8NQfi29FA77H5t6sX6yROZmKk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.150.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7blv-1i8ADR447r-00xJlH; Tue, 22
 Oct 2019 09:30:39 +0200
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Iago Toral Quiroga <itoral@igalia.com>
References: <20191021185250.26130-1-navid.emamdoost@gmail.com>
 <a28f12a8-49c4-30f0-cc86-6a41ded96ab2@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f5c228b6-eb9b-445d-3055-bb966e1c5deb@web.de>
Date:   Tue, 22 Oct 2019 09:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a28f12a8-49c4-30f0-cc86-6a41ded96ab2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jab4DaQA76l4zX5Oew7DX1U+G/IN8y1j8LpNCgH8IzQHj5pVbC
 cIz+jnBjNsQN8y4YtiF450ijd/qZZKp4EiR+VXw+kRF6b9MkmFPabRbOvX5AD1sTH7N5hGC
 NhprSmRGqs99LbTdIZRg+Qu5qvrWn5Ev5pmBBto4Qk/3vYwnwmWadfQOfJhLrgIPd3F99Vh
 jMfXUUlnOULgPWniWw0JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kpO/68BQcpA=:8qyyuGOwWphzHADKG4Uq/F
 bhTfg7RlODvFuQ5kqcd4dBLnEXRNRcoWRyHrKk6eVj6naVklsdMeMqyy6uwy6TN61WmBnKnDX
 9IIm+XgsHhBd1uUgrZJeMOOYjfVthWh75UljpSLEbqfdBwXy0b4Of3F/75OFWREKDk3CRCg9o
 zMcGmTOjVicRHoVkkzyBv4iR5YljSyImFF1ubpTkqA9EB3jKCcrLNeXeZ88mu6DVPGnUAk7H9
 tmhJl4WfiQPBOQyoiPh68R4yztZxOO8AkX5joGPqyzzF0BQ2tc+XdptK8AwFPpHK3LKqUMN/a
 2aOvNAwZAidZ/KkHXP/GXu7qTULO/cA1YeJBSGvNtpmoutvYDBgYQM/uTeQhrHgKteORocXnO
 TKcfXCQOwTxGXc81HhCLDUBjiIlG4HT/zbjDJZ3c0o1/3UOo+wk5rFrCOX8EQu9uKdOH/W7WB
 cBAbUtjtSqJMa2dkrV77E6xPz9L02wp+jDoGeBwi5vjVKpdSIDOPf1fzd4LdIQALXJSZYeuKY
 KWy5NTwF/y8hhpzR6ziIrT/SdIX0Y0I00PPj4fL1LYYjE2e0q7AZZ/aF/Wh+0dtxWwPNO1q2K
 iN4f6qgo2QC6gcQMES+SlXQ+LPeuxuT1W+M9Rhv9jmpDJ2WPcTn9GYj0d/wgzzVFJEizZGVWd
 osSQ2WhwZvkN3zuFUGR2IifL2oJ4tQgOZQoAisGz001PjoyqASE64FY3YnA47F3nFcTVZQCqD
 SqhBWnUzsdYivY7+4mVlDL1qiH9Wcv6P1rh4af3BF/Pq2rb0dWttrbSd5+YTDECjhgmCGendh
 pO1nlSNSDnvDSJdZxwUozNRPaOEc3aiiRwKXfl6NkTPp+mujUj4lRaX0yXnYfnBFNNTHwuJ84
 5ob2HuXUlUgsvpnGQXnyAJNG4ChX/XavTaX5Qvm23rZB/Hg2ybpx14cHEdS4fkmNFNvRXQfUj
 DHOA4uKKQMnW1HUtaR4nM3KaCLsS/SsUYnCEnzRxE8PLqs/Nzes0GbOipPzsw/u6343FRGAae
 3tIK8/NRiBjnAsOsa0HQxJdVFqimq8bEN2fIXXef+RlvcXQdbamNUjazoy9ti7vhlqsL0UZ8m
 xgd5sDJJtZBxUIbUAUvoo2VcAMGoR4g6fmzSRr7hH42yAxAVVy7GTim/1oepEDGxmrCWNJ1fz
 8aWBGgFBK6ymJHztDSD5YG7SLfngcBHCfsmv6222bs5pxncDk7xO99SykEh8OX+VSU2nOIgV3
 iZeBIRKZ9QHku1NZT3kdfxC32xn/bqMZfcU6wKlcwEBzg/mWd4Bilf0dJUzw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void =
*data,
> =E2=80=A6
>>  		if (ret) {
>>  			v3d_job_put(&render->base);
>> +			kfree(bin);
> =E2=80=A6
>
> Can it be helpful to move the added function call before the other
> in this if branch (if you prefer to avoid the addition of a jump target =
here)?

I got into the mood to take another look at these implementation details.
I suggest then to look at the commit 0d352a3a8a1f26168d09f7073e61bb4b328e3=
bb9
("drm/v3d: don't leak bin job if v3d_job_init fails." from 2019-09-18)
once more.

With which software versions did you perform your source code analysis?

Regards,
Markus
