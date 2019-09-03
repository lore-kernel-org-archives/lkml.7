Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B77C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C35D23717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c48Gvms/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="avYu6TG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfICPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:52:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:52:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 13FD66076A; Tue,  3 Sep 2019 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567525940;
        bh=xELRIzX5ix1iHVQhh0r8DllAwIsyg8XuG2EhPbwexW8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c48Gvms/P9zhw/nQ0OvZC2/7trYLOAL16vUVR5/i0Fzn/H5i52EfhJf7LenIAV7EJ
         fSGrUrYve8tQJmMj22+FZYm5sKhw4Cgqtd5736feN5DIQ+5XUSihT/R73CJieD/pFu
         kcinhF/uvDi56KLJzgrzfZuaGiyAw/w7iz8CkRas=
Received: from [10.79.164.101] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E560602A9;
        Tue,  3 Sep 2019 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567525939;
        bh=xELRIzX5ix1iHVQhh0r8DllAwIsyg8XuG2EhPbwexW8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=avYu6TG+28F9mAiVZQyjCuYUl85FvTRw5L3aaNARDjEvlyA5ADuSYcZRgbAV8enJC
         X0nzHyJHcWeEyl3nJ9O9FGNoaiNbXlz3gHy+fX5X7kI1WByXf9w7ikjMHlt2uJapsd
         uSFqb1BkUFekLsoL1Tn+LVVHhXi76Aba4vqny3TY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E560602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20190830195142.103564-1-swboyd@chromium.org>
 <CAD=FV=Vr5o-b86588qe--bVZ5YjKVB3gzaoYa6YcqCd9smkxVg@mail.gmail.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <93435591-152a-46fd-4768-78f5e7af77ed@codeaurora.org>
Date:   Tue, 3 Sep 2019 21:22:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vr5o-b86588qe--bVZ5YjKVB3gzaoYa6YcqCd9smkxVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/2019 3:04 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 30, 2019 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Some MMC cards fail to enumerate properly when inserted into an MMC slot
>> on sdm845 devices. This is because the clk ops for qcom clks round the
>> frequency up to the nearest rate instead of down to the nearest rate.
>> For example, the MMC driver requests a frequency of 52MHz from
>> clk_set_rate() but the qcom implementation for these clks rounds 52MHz
>> up to the next supported frequency of 100MHz. The MMC driver could be
>> modified to request clk rate ranges but for now we can fix this in the
>> clk driver by changing the rounding policy for this clk to be round down
>> instead of round up.
> 
> Since all the MMC rates are expressed as "maximum" clock rates doing
> it like you are doing it now seems sane.
> 
> 

Looks like we need to update/track it for all SDCC clocks for all targets.


>> Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
>> Reported-by: Douglas Anderson <dianders@chromium.org>
>> Cc: Taniya Das <tdas@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>
>> I suppose we need to do this for all the sdc clks in qcom driver?
> 
> Seems like a good idea to me.
> 
> 
>>   drivers/clk/qcom/gcc-sdm845.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> 
> -Doug
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
