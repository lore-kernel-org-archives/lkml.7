Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D446C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DE22133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uOvMaopV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfB1Pjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:39:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47858 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfB1Pjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:39:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1SFdLS6025126;
        Thu, 28 Feb 2019 09:39:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551368361;
        bh=4h/YXT2t996UQpHBwnpjxFxbats7xfPuABZypiSvMKw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uOvMaopVDyJvIY88YnTpsYU6uKt6D3AJq3LRYW5zi875KW0a6AOH+Vb0Mex1x/dxP
         9PFdT+CuS4bK1cSILyhhMB9/zCqvB9dquP2M7yaBRNTuIGHArwjgxgoYeOjTpf9p4q
         1HHR/q2BBNSnVT4TgwHqu/lf4uYVb4ilTDGe68Uw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1SFdLVP116251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 09:39:21 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 28
 Feb 2019 09:39:21 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 28 Feb 2019 09:39:21 -0600
Received: from [172.22.127.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1SFdK58009865;
        Thu, 28 Feb 2019 09:39:20 -0600
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <52148371-16aa-b87a-02f0-9037d5d34988@ti.com>
 <43e01edf-9b9a-c68d-ec1a-218a8117f59e@grandegger.com>
 <50a3a5d6-9b83-f0aa-095c-13b6361236ab@grandegger.com>
 <b60b8781-d979-24e7-805a-95f9237c816e@ti.com>
 <d1a71f1f-55b8-0ff1-1507-75d7c6237d90@ti.com>
 <61d7c2c4-396c-b0a2-68d5-ace48e56c269@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <20576c37-bea8-f598-21e8-6e01c2e87e76@ti.com>
Date:   Thu, 28 Feb 2019 09:39:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <61d7c2c4-396c-b0a2-68d5-ace48e56c269@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 2/24/19 5:27 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 22.02.19 um 18:05 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 2/22/19 6:50 AM, Dan Murphy wrote:
>>> Wolfgang
>>>
>>> On 2/22/19 3:38 AM, Wolfgang Grandegger wrote:
>>>> Hello Dan,
>>>>
>>>> what kernel version is that patch series for. I have problems to apply it!
>>>>
>>>
>>> It is based off of Master
>>>
>>> commit 2137397c92aec3713fa10be3c9b830f9a1674e60 (linux_master/master)
>>>
>>> And I successfully rebased on top of
>>>
>>> commit 8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4 (linux_master/master)
>>> Merge tag 'ceph-for-5.0-rc8' of git://github.com/ceph/ceph-client
>>>
>>
>> I just pulled these patches and they applied fine to the top commit of linux master
>>
>> Do I need to rebase on top of a for-next branch for you?
> 
> No, I can apply the series now as well.
> 

Good.  Just commenting to bump this in my email list.

Waiting on comments.

Dan

> Wolfgang,
> 


-- 
------------------
Dan Murphy
