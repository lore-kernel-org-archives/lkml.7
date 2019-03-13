Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E002EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D50620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LvPrR6bo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dc/gN6xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfCMGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:01:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfCMGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:01:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F2E4609CD; Wed, 13 Mar 2019 06:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552456862;
        bh=1DpymPIntb4hChHfE/YHrxYiXXtxKErjp4lax41Ufqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LvPrR6bozb4ZodpscbOH5Kq+uZ1fNzTx7xlPd4/KfyJlAAkiPtf3aD0Igp4oKoY+K
         P8hqPj0hiABQuOK/Z6XzmzB0REaWxceOaj2lLEBNaF4kaNfbHmxdi4FvjoGNpp4jmP
         cKaIczuqQZyMxjxLYKZ1qrPbfY6Pia8FDFVxBz9g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 647E360767;
        Wed, 13 Mar 2019 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552456861;
        bh=1DpymPIntb4hChHfE/YHrxYiXXtxKErjp4lax41Ufqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dc/gN6xmATJETCZdjuXQv/G8hszFKL15gUn0i3Zlfkt6fR5L8nJbjJCbleLaoj9B+
         LJUWR/SiFjd86nTKsgzG1+2UL9H88Qoqbel0TqtFSy9Br0UPKk61e1fqdzlFrrV80S
         pFSOOiqdbjUCp2fGDJend3J7M1ek4VHrHuSDJ/II=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Mar 2019 11:31:01 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     myungjoo.ham@samsung.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v5] PM / devfreq: Restart previous governor if new
 governor fails to start
In-Reply-To: <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
References: <20190311100630.12952-1-sibis@codeaurora.org>
 <CGME20190311100759epcas5p41fc634cd67a99b39cd25c4129e489c4c@epcms1p2>
 <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
Message-ID: <2b78582a74ae7a17ed2f27187f3f32f4@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-12 12:47, MyungJoo Ham wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>> 
>> If the new governor fails to start, switch back to old governor so 
>> that the
>> devfreq state is not left in some weird limbo.
>> 
>> [Mjungjoo: assume fatal on revert failure and set df->governor to 
>> NULL]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> I'll modify WARN->ERROR for the case when it's fatal:

Sure, thanks.

> 
>> +		if (ret) {
>> +			dev_warn(dev,
>> +				 "%s: reverting to Governor %s failed (%d)\n",
>> +				 __func__, df->governor_name, ret);
>> +			df->governor = NULL;
>> +		}
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> 
>> ---
>> V5:
>> * assume fatal on revert failure and set df->governor to NULL
>> 
>> V4:
>> * Removed prev_governor check.
>> 
>> V3:
>> * Fix NULL deref for real this time.
>> * Addressed some style preferences.
>> 
>> V2:
>> * Fixed typo in commit text
>> * Fixed potential NULL deref
>> 
>> drivers/devfreq/devfreq.c | 16 ++++++++++++++--
>> 1 file changed, 14 insertions(+), 2 deletions(-)
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
