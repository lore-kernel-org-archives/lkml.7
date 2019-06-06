Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48299C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A05D2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mE2ExLrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfFFNQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:16:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFFNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:16:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x56DGdCd105057;
        Thu, 6 Jun 2019 08:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559826999;
        bh=gNc+oO3ghLaZB8nWHGiSN1D1nntyfITwOC+PGqY/I1k=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=mE2ExLrE3/z+ERYMtKdRwxxRLxrBNtzLfvEQW9tj0sHNpBVfJ7/gXaz2FtqzuHYS/
         6pWZsakqdawZlgCx59JV0lYaQk54WnTjbIIoxdJ30/KR1EhA03hHDEzZtpfGljubKK
         iTRpCdvBYn+VfgaGgIkWT9bJdrXjGd2lqwWOLBAo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x56DGdP1099326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 08:16:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 08:16:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 08:16:39 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x56DGcRS034254;
        Thu, 6 Jun 2019 08:16:38 -0500
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
Message-ID: <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
Date:   Thu, 6 Jun 2019 08:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc

Bump

On 5/31/19 6:51 AM, Dan Murphy wrote:
> Marc
>
> On 5/15/19 3:54 PM, Dan Murphy wrote:
>> Marc
>>
>> On 5/9/19 11:11 AM, Dan Murphy wrote:
>>> Create a m_can platform framework that peripheral
>>> devices can register to and use common code and register sets.
>>> The peripheral devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v12 - Update the m_can_read/write functions to create a backtrace if 
>>> the callback
>>> pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
>>>
>> Is this able to be merged now?
>
> ping
>
>
>> Dan
>>
>> <snip>
