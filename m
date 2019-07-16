Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F286EC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KxyVTtnV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KxyVTtnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfGPEWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:22:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPEWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:22:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D25CB605FE; Tue, 16 Jul 2019 04:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563250926;
        bh=gMr1kGTRi06a6sSsz7Od65gf4AEFcJB1U/xs+pRKtSU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KxyVTtnV0rY9Js4Uqjdck4ZoazH6qLq5UoB1hwrmdTTqRwcmneo1rQIluMrvyT3fZ
         s3KO9b8cHFoMaUKt/BYUbmzjguMPznGBcptny2wa0Q2+OuCsRG0p57Ikq/GgLysvzy
         ZF7iMRyUHSx78oD1j01DiB7WO0fBF6HoNHMQINPs=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3644605FE;
        Tue, 16 Jul 2019 04:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563250926;
        bh=gMr1kGTRi06a6sSsz7Od65gf4AEFcJB1U/xs+pRKtSU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KxyVTtnV0rY9Js4Uqjdck4ZoazH6qLq5UoB1hwrmdTTqRwcmneo1rQIluMrvyT3fZ
         s3KO9b8cHFoMaUKt/BYUbmzjguMPznGBcptny2wa0Q2+OuCsRG0p57Ikq/GgLysvzy
         ZF7iMRyUHSx78oD1j01DiB7WO0fBF6HoNHMQINPs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3644605FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 3/3] clk: qcom: rcg: update the DFS macro for RCG
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557339895-21952-1-git-send-email-tdas@codeaurora.org>
 <1557339895-21952-4-git-send-email-tdas@codeaurora.org>
 <155742286525.14659.18081373668341127486@swboyd.mtv.corp.google.com>
 <07bcd2df-a786-ea52-8566-70f484248952@codeaurora.org>
 <155751085370.14659.7749105088997177801@swboyd.mtv.corp.google.com>
 <f65811f8-42ea-6365-7822-db662eaea228@codeaurora.org>
 <20190715224441.F12122080A@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <243de3a4-292b-77c0-6232-0b38d124d183@codeaurora.org>
Date:   Tue, 16 Jul 2019 09:52:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190715224441.F12122080A@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the review.

On 7/16/2019 4:14 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-05-12 20:44:46)
>> On 5/10/2019 11:24 PM, Stephen Boyd wrote:
>>>>>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>>>>>> index 5562f38..e40e8f8 100644
>>>>>> --- a/drivers/clk/qcom/clk-rcg.h
>>>>>> +++ b/drivers/clk/qcom/clk-rcg.h
>>>>>> @@ -171,7 +171,7 @@ struct clk_rcg_dfs_data {
>>>>>>     };
>>>>>>
>>>>>>     #define DEFINE_RCG_DFS(r) \
>>>>>> -       { .rcg = &r##_src, .init = &r##_init }
>>>>>> +       { .rcg = &r, .init = &r##_init }
>>>>>
>>>>> Why do we need to rename the init data?
>>>>>
>>>>
>>>> We want to manage the init data as the clock source name, so that we
>>>> could manage to auto generate our code. So that we do not have to
>>>> re-name the clock init data manually if the DFS source names gets
>>>> updated at any point of time.
>>>>
>>>
>>> Why is the clk name changing to not have a _src after the "root" of the
>>> clk name? As long as I can remember, RCGs have a "_src" postfix.
>>>
>>
>> Yes, the RCGs would have _src, so we do want the init data also to be
>> generated with _src postfix. So that we do not have to manually clean up
>> the generated code.
>>
> 
> Please manually cleanup the generated code, or fix the code
> generator to do what you want.
> 

Fixing the code manually is not what we intend to do and it is time 
consuming with too many DFS controlled clocks. This really helps us 
align to internal code.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
