Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9615F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AAJToONA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VgtcJ2Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfFTQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:10:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:10:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E3E816090F; Thu, 20 Jun 2019 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561047019;
        bh=c+3aFyFm/rHxZsXwmsaa8gZe+tDKRvfjN/JtdoBhohk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AAJToONAZdgHDZhyzwm16hq7ikjQrFqnVcNAr2ejhWHeVcGNAcAjUvTlDAw87MYmM
         kWSyGUPi2LyhgPx9XvV8xt4gMhgD4VeHEQRa1WbaGolsHxlgWsHBJyRmV88bpEFxgX
         riejGTFKaRnEv/NP9XDQf3Xu73xowmbne5MQp7tw=
Received: from [10.79.136.27] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADB4B6087F;
        Thu, 20 Jun 2019 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561047018;
        bh=c+3aFyFm/rHxZsXwmsaa8gZe+tDKRvfjN/JtdoBhohk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VgtcJ2Oid3anwp7PhUeB1dWBnTG33+bPyT5WuNkyCiIo93T/o0/7d543tHKIvEErv
         QUbewcFV9GRlsJ/M6Ao80aJTPhqBjQTkiAJVq73sW2+W3b8tFuhtfcjAI6SDTcp8+F
         MGBuINdqojz0F0bRBc8y6DLvGS/MhKDzg25Jzd7c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADB4B6087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/2] coresight: Abort probe for missing CPU phandle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, david.brown@linaro.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1561037262.git.saiprakash.ranjan@codeaurora.org>
 <d93e28fc80227f9a385130a766a24f8f39a1dcf0.1561037262.git.saiprakash.ranjan@codeaurora.org>
 <1ddee3c1-8299-1991-eb88-151b9c3ee180@arm.com>
 <e3e13629-a723-8b08-cbae-5a3295170900@codeaurora.org>
 <0182216b-5495-bcf7-bb0e-869133b24830@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <ff99f1b5-7a04-a11a-7bbc-1a6a68908113@codeaurora.org>
Date:   Thu, 20 Jun 2019 21:40:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0182216b-5495-bcf7-bb0e-869133b24830@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/2019 8:53 PM, Suzuki K Poulose wrote:
> 
> 
> 
> Please wait for Mathieu's thoughts on it. And in general I would wait
> for feedback from the people in a version, before posting another one,
> to reduce the number of respins.
> 

Mathieu already said he was OK in the other thread, but I will wait for
some more feedbacks.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
