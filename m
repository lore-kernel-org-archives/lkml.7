Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2184C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791C420828
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="STMumYTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfGWKLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:11:12 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6448 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732954AbfGWKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:11:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d36dd3f0000>; Tue, 23 Jul 2019 03:11:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 03:11:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 03:11:10 -0700
Received: from [10.25.72.214] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 10:11:08 +0000
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
From:   Viswanath L <viswanathl@nvidia.com>
Message-ID: <fe7a0f13-4e85-56db-7629-92c6a8f67014@nvidia.com>
Date:   Tue, 23 Jul 2019 15:41:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <11288075-f34a-222c-66da-2bfd13db987c@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563876671; bh=TrDkC7hsFFcEl4fFQwj2yJrxHnLvANWklBQezwVn45M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=STMumYTjuQ59pk4DtURsj11uADdFVJMqM26OY1UrP8Sm1C9yLu2I6YnwZ8035SmY8
         mtbuwEFCzmwj7jQRRjTLWZeGb2pYQ3TcOHRfsQcy5a6Gvj06na0kKlNYlYkhuM72EL
         bmb8Dek5nTPO/FK0DUKaGzxqZFAjMwm9V5F0LNm2mQC81FhK8pZnyiZnZ9Yizszpe4
         NJP4caAFZsIlBi6pldh/I6RXJVhAOXBKkRAaj1HczD8SpXJYTv5+g8KH/8leFDkRda
         fYWOiqfP741uoeLIqjespDjldVE079J6XDehaMCqcY5Iq3Hctrn9iJdQtKL/IZBZNZ
         8feLpogYx22ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments, Dmitry. Please see my responses inline.

On 7/23/2019 6:00 AM, Dmitry Osipenko wrote:
> 22.07.2019 12:27, Viswanath L =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> HDMI plugout calls runtime suspend, which clears interrupt registers
>> and causes audio functionality to break on subsequent plugin; setting
>> interrupt registers in sor_audio_prepare() solves the issue
> Hello Viswanath,
>
> A dot should be in the end of sentence, please. And should be better to
> s/plugin/plug-in/ in the commit's message/title because 'plugin' sounds
> as a noun.
[VL] Yes, I'll make the above changes.
>
> Please don't version patch as v2 if v1 wasn't ever sent out.
[VL] Now that I have sent v2, shall I continue with v2 for the next=20
patch? Apologies for this oversight.
>
> You should add a stable tag here to get patch backported into stable
> kernel versions:
>
> Cc: <stable@vger.kernel.org>
[VL] Yes, will add.
>
>> Signed-off-by: Viswanath L <viswanathl@nvidia.com>
> The kernel upstreaming rules require a full name. I'm pretty sure that L
> isn't yours surname.
[VL] My name appears as "Viswanath L" in all company records and email=20
lists. I would strongly prefer to keep it this way, unless that is an=20
absolute no-no.
>> ---
>>   drivers/gpu/drm/tegra/sor.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
>> index 5be5a08..0470cfe 100644
>> --- a/drivers/gpu/drm/tegra/sor.c
>> +++ b/drivers/gpu/drm/tegra/sor.c
>> @@ -2164,6 +2164,15 @@ static void tegra_sor_audio_prepare(struct tegra_=
sor *sor)
>>  =20
>>   	value =3D SOR_AUDIO_HDA_PRESENSE_ELDV | SOR_AUDIO_HDA_PRESENSE_PD;
>>   	tegra_sor_writel(sor, value, SOR_AUDIO_HDA_PRESENSE);
>> +
>> +	/*
>> +	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
>> +	 * is used for interoperability between the HDA codec driver and the
>> +	 * HDMI/DP driver.
>> +	 */
>> +	value =3D SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
>> +	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
>> +	tegra_sor_writel(sor, value, SOR_INT_MASK);
>>   }
>>  =20
>>   static void tegra_sor_audio_unprepare(struct tegra_sor *sor)
>> @@ -2913,15 +2922,6 @@ static int tegra_sor_init(struct host1x_client *c=
lient)
>>   	if (err < 0)
>>   		return err;
>>  =20
>> -	/*
>> -	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
>> -	 * is used for interoperability between the HDA codec driver and the
>> -	 * HDMI/DP driver.
>> -	 */
>> -	value =3D SOR_INT_CODEC_SCRATCH1 | SOR_INT_CODEC_SCRATCH0;
>> -	tegra_sor_writel(sor, value, SOR_INT_ENABLE);
>> -	tegra_sor_writel(sor, value, SOR_INT_MASK);
>> -
>>   	return 0;
>>   }
>>  =20
>>
