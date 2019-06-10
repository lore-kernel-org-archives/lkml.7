Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA120862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yiQa/bzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFJQfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:35:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53906 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfFJQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:35:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5AGZbqf048436;
        Mon, 10 Jun 2019 11:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560184537;
        bh=Pjc4DG4VaIY3HIjpSsdWHxC5fbapRyXHz4RqfmSktJs=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=yiQa/bzzV4Ah+D9TaXx7GW1nf6HYctpuXwQCaK5x3+0Clg2JcmlAaONu/zVgPlIqD
         6vjQj/DN9DrQ1oTvkESU0ptXn+vkXnZDASZvVYVNpHcRpPqaHJYBP3v6ToxO2h10v7
         gr7Ps6M6mne5N0QqsVBAudQbHCgQNLh/SKntXGo0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5AGZbxG037980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 11:35:37 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 11:35:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 11:35:37 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5AGZa2p116934;
        Mon, 10 Jun 2019 11:35:36 -0500
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
Message-ID: <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
Date:   Mon, 10 Jun 2019 11:35:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump

On 6/6/19 8:16 AM, Dan Murphy wrote:
> Marc
>
> Bump
>
> On 5/31/19 6:51 AM, Dan Murphy wrote:
>> Marc
>>
>> On 5/15/19 3:54 PM, Dan Murphy wrote:
>>> Marc
>>>
>>> On 5/9/19 11:11 AM, Dan Murphy wrote:
>>>> Create a m_can platform framework that peripheral
>>>> devices can register to and use common code and register sets.
>>>> The peripheral devices may provide read/write and configuration
>>>> support of the IP.
>>>>
>>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v12 - Update the m_can_read/write functions to create a backtrace 
>>>> if the callback
>>>> pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
>>>>
>>> Is this able to be merged now?
>>
>> ping
>>
>>
>>> Dan
>>>
>>> <snip>
