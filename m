Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DA4207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dIL+XSpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfI0Qh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:37:59 -0400
Received: from mout.web.de ([212.227.15.4]:59107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0Qh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569602259;
        bh=qJ8sK+Y+0J00l/ur+PK+VM0mN+AD/veeiKCxwnwLXA4=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=dIL+XSppQKGtKmy3NS+d4eUPrRG+zEFxN+5efeyrDJb0+gsYw3Jdx2sgwQF47nxH6
         o+81eO+d6qnqrk/buzfXiyDlCuO5Tx5GiXCi1eEM3sLKyPyR40/5AFrmuV8A+YbQej
         rY6Q0F1pCmTfOyLWyUPnKMjx7zyNT3R/a4iJDCp8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.191.8]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MD8Au-1iNjYN24gG-00GXHM; Fri, 27
 Sep 2019 18:37:39 +0200
Cc:     Chunming Zhou <David1.Zhou@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen A McCamant <smccaman@umn.edu>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190918190529.17298-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1cc7e3f9-69fb-e8dc-4bfc-dbb69de66ec7@web.de>
Date:   Fri, 27 Sep 2019 18:37:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190918190529.17298-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x3y4px5Ca6A9Tjc7OU4XF0XzHzgfug9dGxj2aIp6hdiDS2oAeaw
 23aISDl82ZH+CWFFDyXLbXI1b9sYjA3fDs6C+S1267j6PIHkeYjzXbq0ZUch4U9fHEdj7Ci
 purT5BZE1UgtejLFp5n+qo97nZUBXaA9+5xYUi3Ev+l+vSa+YNvBWoYpCXFtvdI73s4Azb5
 1+8nKVzxd7ifeAOXWSuNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3txmecOp1X4=:rpCh3k9mOLXjje/Af+wkK8
 E+Kl/K1amNOP15t6BJWHfNfAC1yva6bNz98vV4juh2dIbN+qtVgORh7yslVd388k3VhVz6FW+
 UI+/tDCoATtmgoWDZsE1s8+leooRRaRhpc9mFFwTrMBHUHQAIi+eeBGKyhN1GM8IMvGSPjc7y
 QspLvUwG8BZY7cYdS/cFSdhDzpcKCn5rVzo+xyVMpb5sDDkunaWXBRLsd5vj2dEFIwSzv9tlD
 q2CmG7UmvDaA9lYVN2KnRI+ltXDUoAbaFbT/T4ybuJdKGlcgB0VXB/fnW1FJxgQLNAv7FF1kr
 K7I+d9VA7ydiGo9upEVvHvMmH6vTUkif/5GArqNBJLaHLVaNh16Ws99WQWUUQkQKipS7fJ3JN
 Nf27S9SXQqPUNQV65kDfVt2c2sluizpy9u4MNjh6c56hQd9Mv2SaI9gj1Sqew+0WVkahHg2hv
 UGfPNSfrMotdPPc3kq9wB95xpXviWg4KVSJnI4wLpMMWjDXyVIizuiarA6F7G76ShRooSVxod
 zPCaEHkvgqEwPxz4tZ97Jihi9UxHl8t8isBiKhntU0zeQXbxE2EbZqb/58js8Xwh0tPMJWP33
 NJiba8lRPiid/hK3T6K8NiPINIvT+umm1V4mA/3Ddp1FsbC+PRWrk7YWaXK9HLyYt/XybRe+m
 vgCto8YseUoCZC7ujwpx/Vnj1hnwLxQ948RXxi30W96xw1icD1SSmjM5m+vF6FIgzDRFGAQgx
 EvQJq0Ky4Xb7yAojHRwNvSRPGeK/oU+jr7QH25MiXnTu8HAosBrf6e2Sxu0dhkdc1Abb7AIIt
 5CjU1zOQyw0l1PYA6a0MsjAUS3My/3wSp22xz7c2V5v3y9Qmh5mQTEnjT7/N/R4QonE249+NH
 0rng5QhdacyuKV5OGIQjNMtlQQRhr8zSkm35JZ9pGwPkeocdqpM/kZ731I1O3DK+lS1OcnqHN
 C8WCnDGK+2GHLBm9EmN4uiF/kWjua9oUlBFazLThpjqPVufgFdlMrXJlWdOKQb9FjqyglPdhW
 v2v0obn9OWt+XqOBESA9Gg/DroPf6fSuwdW7dLOdY64uWEl905m8loGmbJAkgT79TZD1zqwvT
 /jR60bwxOgqzbVemO+hYC2iGYYobgWYOAQ4OzHq92bXpdR3V/KH/hWt98BZt1Vk2t+eVswrl3
 v2bIkrTXsxFT10IUa1iVKOh0uwwlU7/SCHQZL/lcNqfCHXzGCfOcn3kxyl7owtUMasMzOUCHc
 xQ+5NCp+HXGgCVBiBUMrcZ8UcsWR4fiN9XM/RurxolXf0VlbZybHAyfGjOQY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> v2: moved the released into goto error handlings

A better version comment should be moved below the triple dashes.


Will the tag =E2=80=9CFixes=E2=80=9D be added?


> @@ -393,6 +395,16 @@ static int acp_hw_init(void *handle)
>  	val &=3D ~ACP_SOFT_RESET__SoftResetAud_MASK;
>  	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>  	return 0;
> +
> +out4:
> +	kfree(i2s_pdata);
> +out3:
> +	kfree(adev->acp.acp_res);
> +out2:
> +	kfree(adev->acp.acp_cell);
> +out1:
> +	kfree(adev->acp.acp_genpd);
> +	return ret;
>  }
>
>  /**

I suggest to reconsider the label selection according to the Linux coding =
style.

Regards,
Markus
