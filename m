Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30652C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045D02084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IB4B3//Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGXGlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:41:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6374 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:41:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d37fd8d0002>; Tue, 23 Jul 2019 23:41:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 23:41:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 23:41:19 -0700
Received: from [10.24.46.79] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 06:41:16 +0000
Subject: Re: [PATCH v2] drm/tegra: sor: Enable HDA interrupts at plugin
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1563787632-19762-1-git-send-email-viswanathl@nvidia.com>
 <11288075-f34a-222c-66da-2bfd13db987c@gmail.com>
 <fe7a0f13-4e85-56db-7629-92c6a8f67014@nvidia.com>
 <5281fd84-bbe8-8482-0224-068b87349aaa@gmail.com>
From:   Viswanath L <viswanathl@nvidia.com>
Message-ID: <5142f8d7-a387-a556-8209-536439be4925@nvidia.com>
Date:   Wed, 24 Jul 2019 12:11:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5281fd84-bbe8-8482-0224-068b87349aaa@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563950477; bh=g96D4ApIOGkTzcjdy6YtT9b/KtR9E/nksr8Tz76ZlKY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=IB4B3//Zn56Hj/tus4pf69WYZzx2eWrV1celvtp+CrKNjYMeOQweQI2Gw+JydwvvF
         i+/KcylKF4DPnfQMaYzyGrtW2vQmR/yfr1SGo/rEPrzT8GaXB+HORffU9Q5d2s64XL
         G3eClMqwnORXr15sf2AAV4d7yaEpbYRoxmHNh9Nuaf7BsJROmNyYjr42clgpqdv+mp
         vhHJ4LaZna1plLDmxgMu05ckg1jVvNEbe6SckH4p5uHUEyozNWFkFjQAbjGeqMt4WC
         gh/LFGuMU6JXntxvDrjP8sZY9lXdKJvEE3T4yEJwh4UV2PcFcORU3TgttBX6L9E4UV
         dLAfmyZu4DixA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry, I have pushed new patch set v3=20
(https://patchwork.ozlabs.org/patch/1135605/). Request you to kindly review=
.

Thanks.

On 7/23/2019 3:48 PM, Dmitry Osipenko wrote:
> 23.07.2019 13:11, Viswanath L =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Thanks for your comments, Dmitry. Please see my responses inline.
>>
>> On 7/23/2019 6:00 AM, Dmitry Osipenko wrote:
>>> 22.07.2019 12:27, Viswanath L =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> HDMI plugout calls runtime suspend, which clears interrupt registers
>>>> and causes audio functionality to break on subsequent plugin; setting
>>>> interrupt registers in sor_audio_prepare() solves the issue
>>> Hello Viswanath,
>>>
>>> A dot should be in the end of sentence, please. And should be better to
>>> s/plugin/plug-in/ in the commit's message/title because 'plugin' sounds
>>> as a noun.
>> [VL] Yes, I'll make the above changes.
>>> Please don't version patch as v2 if v1 wasn't ever sent out.
>> [VL] Now that I have sent v2, shall I continue with v2 for the next
>> patch? Apologies for this oversight.
> v3 should be good.
>
>>> You should add a stable tag here to get patch backported into stable
>>> kernel versions:
>>>
>>> Cc: <stable@vger.kernel.org>
>> [VL] Yes, will add.
>>>> Signed-off-by: Viswanath L <viswanathl@nvidia.com>
>>> The kernel upstreaming rules require a full name. I'm pretty sure that =
L
>>> isn't yours surname.
>> [VL] My name appears as "Viswanath L" in all company records and email
>> lists. I would strongly prefer to keep it this way, unless that is an
>> absolute no-no.
> I guess it should be okay, but a full name is much more preferable.
