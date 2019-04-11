Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93611C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663962084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NxxHNqDY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XaGfZB3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKRcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:32:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:32:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FB9960A0A; Thu, 11 Apr 2019 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555003926;
        bh=Y8QIDyqGuX+LhBf+jXS2iWpsGrQdhW/DlNjuABId5WM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=NxxHNqDYzmiyxSKFJ+yH8Wbl/SfijJChKsauVzCcWqcugDTYdA36FUVzfcsv6htr+
         lgDf1I9qPvpk1YtVI+sZnONAHF1c1FeAhjl5W+jsUEQAUjo5MY1YBZUJpCV9ckwA5j
         C2UAQz4342Q3Vi5ZRRfebErnFdX3vz19Ril9ccBQ=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D12866055C;
        Thu, 11 Apr 2019 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555003925;
        bh=Y8QIDyqGuX+LhBf+jXS2iWpsGrQdhW/DlNjuABId5WM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=XaGfZB3KcBoy47IxLzcrWTllZKt2wa4Gyhq8+x8Lgn0dZsZI/fnpebI+N+FhlXXch
         bIDU7cHK4I/Imjf4JIsqsY2XRX9szsyKpop9zY6jip+SUvjDcLdRk1SJBOaL15yhpV
         +gaT89O2TyDGt/6xc0RizpIiDEudGRMh5IAs7wfA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D12866055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk
 drivers
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
 <20190404215344.6330-4-sboyd@kernel.org>
 <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
 <155491520049.20095.15953237372852019635@swboyd.mtv.corp.google.com>
 <c529d12b-5212-7198-4f70-a3f771c0901f@codeaurora.org>
 <155493274113.20095.6283192313107751284@swboyd.mtv.corp.google.com>
 <bba463e8-c4f6-720d-5a38-ae29d0979a9e@codeaurora.org>
Message-ID: <fd60da16-7531-ab0a-717f-bee1ca64e92d@codeaurora.org>
Date:   Thu, 11 Apr 2019 11:32:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <bba463e8-c4f6-720d-5a38-ae29d0979a9e@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 4:18 PM, Jeffrey Hugo wrote:
> On 4/10/2019 3:45 PM, Stephen Boyd wrote:
>> Quoting Jeffrey Hugo (2019-04-10 12:39:16)
>>> On 4/10/2019 10:53 AM, Stephen Boyd wrote:
>>>> Quoting Jeffrey Hugo (2019-04-08 14:46:11)
>>>>> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
>>>>>> In some circumstances drivers register clks early and don't have 
>>>>>> access
>>>>>> to a struct device because the device model isn't initialized yet. 
>>>>>> Add
>>>>>> an API to let drivers register clks associated with a struct 
>>>>>> device_node
>>>>>> so that these drivers can participate in getting parent clks 
>>>>>> through DT.
>>>>>
>>>>> NACK.  This patch broke boot for me.  I had to pull the below from 
>>>>> JTAG.
>>>>>     What do you need to debug this?
>>>>>
>>>>
>>>> Here's a patch to try to squash in:
>>>
>>> No dice.  Same issue.
>>
>> Argh! dev_of_node() doesn't check for NULL device. :-/ I want to be
>> extremely lazy! Let's get this merged too. Thanks for the testing.
> 
> Fixed.  Will continue to test the rest of the series and let you know.
> 

With the two changes we discussed, for the entire series:
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
