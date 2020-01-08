Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8257BC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A0220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xq3DWXnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAHFgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:36:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47590 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgAHFgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:36:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0085aCIJ100921;
        Tue, 7 Jan 2020 23:36:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578461772;
        bh=HZPNRJuzdDiBHJDwYy9Z3EAqsCKdw2svb8xwWgVcoNQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xq3DWXnUUHz9GP1rVPMP1Jbe6mLEkncf6PFQTjuYLiiWQ/SZk81Q3BvS9XCwtbruM
         jHh8uHeqJVmIWBJoFSF43jJtuCtI6kCpXjYYkuS4P98sST/gCMzQ/PD7VHeEINhY+t
         Mk+KFY5YUFfB7bk2kPvJV6mvG18YkqQrCAvQYKsU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0085aCvP093219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 23:36:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 23:36:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 23:36:11 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0085a8TV003220;
        Tue, 7 Jan 2020 23:36:09 -0600
Subject: Re: [PATCH v3] phy: Add DisplayPort configuration options
To:     Jyri Sarha <jsarha@ti.com>, Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <maxime@cerno.tech>
CC:     <praneeth@ti.com>, <tomi.valkeinen@ti.com>, <mparab@cadence.com>,
        <sjakhade@cadence.com>
References: <1578313360-18124-1-git-send-email-yamonkar@cadence.com>
 <9d849a10-493f-e297-f4c3-b34a341635ed@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5e3853dd-719b-c6a0-4af0-04967a2c6e3a@ti.com>
Date:   Wed, 8 Jan 2020 11:08:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9d849a10-493f-e297-f4c3-b34a341635ed@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/20 12:22 AM, Jyri Sarha wrote:
> On 06/01/2020 14:22, Yuti Amonkar wrote:
>> Allow DisplayPort PHYs to be configured through the generic
>> functions through a custom structure added to the generic union.
>> The configuration structure is used for reconfiguration of
>> DisplayPort PHYs during link training operation.
>>
>> The parameters added here are the ones defined in the DisplayPort
>> spec v1.4 which include link rate, number of lanes, voltage swing
>> and pre-emphasis.
>>
>> Add the DisplayPort phy mode to the generic phy_mode enum.
>>
>> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> 
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
> 
> Kishon, can you still pick this for v5.6?

Thank you Jyri and Maxime for reviewing this.

Merged it now.

Thanks
Kishon
