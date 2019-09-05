Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85589C3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5692080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jimHFne4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I/NK+a4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfIEJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:23:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:23:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1BED2602CA; Thu,  5 Sep 2019 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567675381;
        bh=7ypJps6zFJj4YltG8z6hvxZoqSqppwU70RqRpC2SsMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jimHFne4Kt5HXtBpi5xq9hTho2mFISTwUBioDQx+mWP1xBRDvsNd41/7DxVOvqagl
         sKm9kYQj9rfX2bJ03J3uf9NbSdxog8O95ZeuiErv2tQqpuNEgglLG9sUNGf65/0vHZ
         EpY+vetsEsdvksdeQOqAe1bCojJMwqzu6xhyDY/A=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23043602CA;
        Thu,  5 Sep 2019 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567675379;
        bh=7ypJps6zFJj4YltG8z6hvxZoqSqppwU70RqRpC2SsMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I/NK+a4ORwfviEMsa2+lIlMltI3le1EKEMvmn7fYR47Yk5p1zDCcqUOwRd4VthyYp
         3u0EnJWcR0zMTijI7QBNz5hXl/oftIVQlcEy8JutJYxWqO04/A+Qm6zAgKePlBQ1Kx
         zZVLxjHUtNaL2Xo8XXMcu/rnrTtZNPWIdGeqiQ8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23043602CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
To:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20190830195142.103564-1-swboyd@chromium.org>
 <CAD=FV=Vr5o-b86588qe--bVZ5YjKVB3gzaoYa6YcqCd9smkxVg@mail.gmail.com>
 <93435591-152a-46fd-4768-78f5e7af77ed@codeaurora.org>
 <5d6eed69.1c69fb81.b7ca5.7345@mx.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <ea8bbff0-5461-7551-0e55-3810229ed53a@codeaurora.org>
Date:   Thu, 5 Sep 2019 14:52:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d6eed69.1c69fb81.b7ca5.7345@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2019 4:17 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-09-03 08:52:12)
>> Hi,
>>
>> On 8/31/2019 3:04 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Aug 30, 2019 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>>>>
>>>> Some MMC cards fail to enumerate properly when inserted into an MMC slot
>>>> on sdm845 devices. This is because the clk ops for qcom clks round the
>>>> frequency up to the nearest rate instead of down to the nearest rate.
>>>> For example, the MMC driver requests a frequency of 52MHz from
>>>> clk_set_rate() but the qcom implementation for these clks rounds 52MHz
>>>> up to the next supported frequency of 100MHz. The MMC driver could be
>>>> modified to request clk rate ranges but for now we can fix this in the
>>>> clk driver by changing the rounding policy for this clk to be round down
>>>> instead of round up.
>>>
>>> Since all the MMC rates are expressed as "maximum" clock rates doing
>>> it like you are doing it now seems sane.
>>>
>>>
>>
>> Looks like we need to update/track it for all SDCC clocks for all targets.
>>
> 
> Yeah. It would be great if you can send the patches. Otherwise I'll
> throw it on my todo list named 'forever'.
> 

Sure Stephen,  would send out the patches fixing them.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
