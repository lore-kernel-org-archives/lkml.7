Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4842CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884CD20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FZRWQGkL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aY/1cPIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfJaOR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:17:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:17:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3997960D7E; Thu, 31 Oct 2019 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572531444;
        bh=HXC8+viMGhThZbeYm9oP+pwlgdCRQlhDZ1MyTj/DxW8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FZRWQGkLGPdum23ncaSGTOawLN0vg/F1e8Gdw6C+VYg+JDWJLx9RrGthwQZKrenkd
         SDsgYsHz6aVhWbxEPk8/CF+JXDtmQV5bJgh6bBeMrK46t60NIgGGApFhAdSWGc1c3b
         GVeGq7A/WTHgkdNrGoCF/Im9MFdpWLEnsUHkrczA=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7DFC60AD7;
        Thu, 31 Oct 2019 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572531440;
        bh=HXC8+viMGhThZbeYm9oP+pwlgdCRQlhDZ1MyTj/DxW8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aY/1cPISfdI6fUglVleYhnEX6K5M9+aJKAWCkhd1/bduQSxy1mOEfTyznqbaCNXon
         fIkBjlJbtUCBvjfS7HlQqRnpImuaMumddmcnfI1wsPLs2K5ERjgVnC+3PiPnaejNRl
         hUgJf246hqRvwXu2vgryq2RGdYcDESaDxatS1Rw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7DFC60AD7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] arm64: cpufeature: Enable Qualcomm Falkor errata 1009
 for Kryo
To:     Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20191029232738.1483923-1-bjorn.andersson@linaro.org>
 <20191031132914.GD27196@willie-the-truck>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <24673fd9-3c1c-04f6-eb2e-525f8546ebf3@codeaurora.org>
Date:   Thu, 31 Oct 2019 08:17:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031132914.GD27196@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 6:29 AM, Will Deacon wrote:
> [+Jeffrey]
> 
> On Tue, Oct 29, 2019 at 04:27:38PM -0700, Bjorn Andersson wrote:
>> The Kryo cores share errata 1009 with Falkor, so add their model
>> definitions and enable it for them as well.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>
>> Changes since v1:
>> - Use is_kryo_midr(), rather than listing each individual model.
> 
> Cheers, I've queued this up as a fix.
> 
> I also updated the E1009 entry in silicon-errata.rst but, in doing so, I
> noticed that E1041 is listed there which apparently also affects
> Kry^H^H^HHydra [1].
> 
> At which point, maybe we should rename both Kryo and Falkor in the tree
> so that we consistently refer to Hydra as the underlying micro-architecture.
> Obviously not something for 5.4, but it would sure help me to understand
> what's doing on here.
> 
> Thoughts?

Unfortunately, Falkor is also an underlying micro-architecture, it just 
happens to be strongly related to Hydra so a fair amount of the errata 
affect both.

I don't want to be difficult.  For ultimate "correctness", Falkor and 
Hydra should probably be separate, however the Falkor architecture is 
not widespread and unlikely to have much churn going forward.  So I 
think if it makes life easier for you, all the Falkor stuff can probably 
be scrubbed and just merged into Hydra.

> 
> Will
> 
> [1] https://lore.kernel.org/kvmarm/20171115010505.GO11955@codeaurora.org/
> 


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
