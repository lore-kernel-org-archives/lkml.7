Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED494CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE732089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FaujRgc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504595AbfJRHWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:22:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32928 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfJRHWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:22:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9I7M5W9067649;
        Fri, 18 Oct 2019 02:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571383325;
        bh=RpPaRO7ZRWVjZleEqs7yCJlM2aZ2GVtQ8fqMaEjjlng=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=FaujRgc91+0rgOSAbvs+IcSplygQYruOhGbBB3c2sjxyKiw0dySB04Z+NgWZnjuvN
         HbYCn/yQGyXHrnE39etIcQ1hoDjXKtAfrc8scoyQ6epA51c6WgqnlQWuBy3o8ZeYuW
         TD3nKvH0274m9rkG5xsF8wIGmTrKpXwvn2us83zw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9I7M5s0128202
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Oct 2019 02:22:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 02:21:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 02:21:57 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9I7M2Gn120859;
        Fri, 18 Oct 2019 02:22:03 -0500
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <asutoshd@codeaurora.org>,
        <riteshh@codeaurora.org>, <venkatg@codeaurora.org>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
 <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
 <2275bfdc-ff30-719e-ae78-8c8bd20b8c80@ti.com>
Message-ID: <8fba4072-a252-7397-15b2-791e2619024d@ti.com>
Date:   Fri, 18 Oct 2019 12:52:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2275bfdc-ff30-719e-ae78-8c8bd20b8c80@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 16/10/19 5:46 PM, Faiz Abbas wrote:
> Adrian,
> 
> On 15/10/19 7:15 PM, Adrian Hunter wrote:
>> On 15/10/19 10:55 AM, Faiz Abbas wrote:
>>> Hi,
>>>
>>> On 15/10/19 12:08 AM, Faiz Abbas wrote:
>>>> Add a write memory barrier to make sure that descriptors are actually
>>>> written to memory before ringing the doorbell.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>
>>>> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
>>>> I have been seeing after enabling command queuing for J721e.
>>>> Also looking at memory-barriers.txt and this commit[1],
>>>> it looks like we should be doing this before any descriptor write
>>>> followed by a doorbell ring operation. It'll be nice if someone with more
>>>> expertise in memory barriers can comment.
>>>>
>>>> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>>>>     doorbell")
>>>
>>> So I see that cqhci_readl/writel() use readl/writel_relaxed() which
>>> seems to be causing this issue. Should I just fix this by converting
>>> those to readl/writel with memory barriers instead?
>>
>> Perhaps we could do both changes i.e. add wmb() and convert to non-relaxed
>> readl/writel
>>
> 
> readl is implemented as  readl_relaxed(); __rmb();
> and
> writel is implemented as wmb(); writel_relaxed();
> 
> I think another wmb() before writel will be redundant.
> 
> Maybe this patch is good enough in itself.
> 

Do you agree?

Thanks,
Faiz
