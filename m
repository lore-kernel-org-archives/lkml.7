Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F4206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rR94uEkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfHTKzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:55:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55460 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfHTKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:55:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7KAsPxD060128;
        Tue, 20 Aug 2019 05:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566298465;
        bh=bpcY5wifZty9jijmJU2k4dWWpDJaZNKUQLEAWp7YByQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rR94uEkQPE+7AALBFWAn0eGFJA9a44v/MqfcieqW673uIk1GEpQLsu2MrzMckN35V
         m4SsX5eaNEoixsxdDh+Gd2ES31N2PIWGvz+6MFb3YLttqjBmVY3SoOdicqoCO+3qBh
         d/iCZzTs1YzciJo9SqA3iwdXYSj5uikjuJ0hdRQg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7KAsPt9042225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Aug 2019 05:54:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 20
 Aug 2019 05:54:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 20 Aug 2019 05:54:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7KAsMrx083814;
        Tue, 20 Aug 2019 05:54:23 -0500
Subject: Re: [kbuild-all] [PATCH] fix odd_ptr_err.cocci warnings
To:     Rong Chen <rong.a.chen@intel.com>
CC:     Julia Lawall <julia.lawall@lip6.fr>, <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, <kbuild-all@01.org>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
 <20190809123112.GC3963@sirena.co.uk>
 <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
 <alpine.DEB.2.21.1908091519400.2946@hadrien>
 <297e44a8-e08d-ddf2-e5e8-b532965b4a8d@intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c3779fa2-3aab-3ba2-518d-9675591787af@ti.com>
Date:   Tue, 20 Aug 2019 13:54:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <297e44a8-e08d-ddf2-e5e8-b532965b4a8d@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On 20/08/2019 11.41, Rong Chen wrote:
> Hi Peter,
> 
> We have updated to only send the reports to you, please see
> https://github.com/intel/lkp-tests/blob/master/repo/linux/omap-audio

Thank you very much!

> 
> Best Regards,
> Rong Chen
> 
> On 8/9/19 9:21 PM, Julia Lawall wrote:
>>
>> On Fri, 9 Aug 2019, Peter Ujfalusi wrote:
>>
>>>
>>> On 09/08/2019 15.31, Mark Brown wrote:
>>>> On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
>>>>
>>>>> tree:   https://github.com/omap-audio/linux-audio
>>>>> peter/ti-linux-4.19.y/wip
>>>>> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
>>>>> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new
>>>>> machine driver wip
>>>>> :::::: branch date: 20 hours ago
>>>>> :::::: commit date: 20 hours ago
>>>>>
>>>>>   j721e-evm.c |    4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> --- a/sound/soc/ti/j721e-evm.c
>>>>> +++ b/sound/soc/ti/j721e-evm.c
>>>>> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
>>>> This file isn't upstream, it's only in the TI BSP.
>>> Yes, it is not upstream, but the fix is valid.
>>>
>>> Julia: is it possible to direct these notifications only to me from
>>> https://github.com/omap-audio/linux-audio.git ?
>>>
>>> It mostly carries TI BSP stuff and my various for upstream branches
>>> nowdays.
>> Please discuss it with the kbuild people.  They should be able to set it
>> up as you want.
>>
>> You can try lkp@intel.com
>>
>> julia
>> _______________________________________________
>> kbuild-all mailing list
>> kbuild-all@lists.01.org
>> https://lists.01.org/mailman/listinfo/kbuild-all
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
