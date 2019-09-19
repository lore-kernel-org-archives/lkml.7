Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE01214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391892AbfISRLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:11:48 -0400
Received: from mail.netline.ch ([148.251.143.178]:43747 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfISRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:11:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 3ADAB2AA0FB;
        Thu, 19 Sep 2019 19:11:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id x1F0UOtU4EPY; Thu, 19 Sep 2019 19:11:42 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id C1D592AA0C6;
        Thu, 19 Sep 2019 19:11:42 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.92.2)
        (envelope-from <michel@daenzer.net>)
        id 1iAzy2-00041o-Fl; Thu, 19 Sep 2019 19:11:42 +0200
Subject: Re: [PATCH] drm/radeon: fix a potential NULL pointer dereference
To:     Allen Pais <allen.pais@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <1568824282-4081-1-git-send-email-allen.pais@oracle.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <5603dddb-8ae3-e145-69af-c6ccea68ca1b@daenzer.net>
Date:   Thu, 19 Sep 2019 19:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568824282-4081-1-git-send-email-allen.pais@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-18 6:31 p.m., Allen Pais wrote:
> alloc_workqueue is not checked for errors and as a result,
> a potential NULL dereference could occur.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  drivers/gpu/drm/radeon/radeon_display.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index bd52f15..1a41764 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -683,6 +683,10 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
>  	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
>  	radeon_crtc->crtc_id = index;
>  	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
> +	if (unlikely(!radeon_crtc->flip_queue)) {
> +		kfree(radeon_crtc);
> +		return;
> +	}
>  	rdev->mode_info.crtcs[index] = radeon_crtc;
>  
>  	if (rdev->family >= CHIP_BONAIRE) {
> 

I'm afraid just silently leaving the CRTC uninitialized isn't a good way
to handle this. The failure would need to be propagated, probably
resulting in the driver aborting its initialization altogether.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
