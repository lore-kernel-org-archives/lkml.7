Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96698FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9721848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rbWocP/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392918AbfJPMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:15:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41308 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfJPMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:15:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GCFeI1060048;
        Wed, 16 Oct 2019 07:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571228140;
        bh=wKieuGRLvabSjHqoDmCuf3EOS6/B7AT44LWOVpIWWSk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rbWocP/cCJ35PiwrODNVJT6UIxprruGA7w5KlUufch+W1YKxtaXJkHBhD9PdBE57r
         FBhphP90YDRSP6TAbIhQjccQ9uIUiMx9KPKynlWRQsn+ICILE9xXIADrBzwQ8ZK14I
         03koi9WPlYuCwNxZcNBMgfiWNAZrwkbfBuNR1Jys=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GCFe23011353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 07:15:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 07:15:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 07:15:33 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GCFb4j082576;
        Wed, 16 Oct 2019 07:15:38 -0500
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <asutoshd@codeaurora.org>,
        <riteshh@codeaurora.org>, <venkatg@codeaurora.org>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
 <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <2275bfdc-ff30-719e-ae78-8c8bd20b8c80@ti.com>
Date:   Wed, 16 Oct 2019 17:46:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 15/10/19 7:15 PM, Adrian Hunter wrote:
> On 15/10/19 10:55 AM, Faiz Abbas wrote:
>> Hi,
>>
>> On 15/10/19 12:08 AM, Faiz Abbas wrote:
>>> Add a write memory barrier to make sure that descriptors are actually
>>> written to memory before ringing the doorbell.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>
>>> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
>>> I have been seeing after enabling command queuing for J721e.
>>> Also looking at memory-barriers.txt and this commit[1],
>>> it looks like we should be doing this before any descriptor write
>>> followed by a doorbell ring operation. It'll be nice if someone with more
>>> expertise in memory barriers can comment.
>>>
>>> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>>>     doorbell")
>>
>> So I see that cqhci_readl/writel() use readl/writel_relaxed() which
>> seems to be causing this issue. Should I just fix this by converting
>> those to readl/writel with memory barriers instead?
> 
> Perhaps we could do both changes i.e. add wmb() and convert to non-relaxed
> readl/writel
> 

readl is implemented as  readl_relaxed(); __rmb();
and
writel is implemented as wmb(); writel_relaxed();

I think another wmb() before writel will be redundant.

Maybe this patch is good enough in itself.

Thanks,
Faiz
