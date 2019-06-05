Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FDDC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D6206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gqPaAvyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFEMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:02:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52116 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:02:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x55C2lC3059447;
        Wed, 5 Jun 2019 07:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559736167;
        bh=jLcEIwqk+N/JppM4RqOqttYG4b9AoePGDagEKBj7OCU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gqPaAvypQnQfK0rYuk8QetQqaIACZUTDtmN5DvSbrXyJVgHe0hsejSCbl19LJXBju
         xE9jOJXGE/SCLV9DkTi85VTOJobU8xt4xmy8Hdsn+fMOqMRPKU1YnwGEODjMOrp4Qz
         GjVp0fHON8VdiQarDtzMlc8Sq5rAvIKSFzk/OFCE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x55C2ldG066912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 07:02:47 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 07:02:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 07:02:46 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x55C2kIK030582;
        Wed, 5 Jun 2019 07:02:46 -0500
Subject: Re: [PATCH v5 1/6] regulator: lm363x: Make the gpio register enable
 flexible
To:     Mark Brown <broonie@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lgirdwood@gmail.com>, <lee.jones@linaro.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190604174345.14841-1-dmurphy@ti.com>
 <20190604174345.14841-2-dmurphy@ti.com> <20190605100132.GL2456@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7ba7a633-1a39-adcc-e942-12c0eb7c3b16@ti.com>
Date:   Wed, 5 Jun 2019 07:02:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605100132.GL2456@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/5/19 5:01 AM, Mark Brown wrote:
> On Tue, Jun 04, 2019 at 12:43:40PM -0500, Dan Murphy wrote:
>> The use of and enablement of the GPIO can be used across devices.
>> Use the enable_reg in the regulator descriptor for the register to
>> write.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> ---
>>
>> v5 - No changes to the patch changes requested in this patch were done in
>> patch 4 of this series - https://lore.kernel.org/patchwork/patch/1077408/
> I was expecting this patch to just be completely dropped?  It looks like
> the end result is very similar, we're still using enable_reg to get the
> register and I don't see new validation added in patch 4.

I can squash patch 1 into 4.

Also not sure what you mean by new validation.

Please comment on patch 4 to what you are looking for

Dan

