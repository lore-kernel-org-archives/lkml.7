Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62921C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3898C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EwFFDpXe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gxd8DUT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfG3KvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:51:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfG3KvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:51:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F8F76037C; Tue, 30 Jul 2019 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564483872;
        bh=DL9JmuEtXCegm37XBTQk4cwqN21AEw0lJCHHuENxGEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EwFFDpXePhSxoi4TZSnCmO4z8mYMr2gquZT7CyX8yPK6nvu38IDn3WC+45jQMARN8
         zSqz0a19MfY3Ba2czYG6r4y1NwYgjFS+xdA7zaIov2O6Wr2Pjc9n7pUDO6we/wmNnN
         zBfe9wXfnvKOj8K7PL7LHF8lnGRcq7RVAlFx/JsU=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 422F76030E;
        Tue, 30 Jul 2019 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564483871;
        bh=DL9JmuEtXCegm37XBTQk4cwqN21AEw0lJCHHuENxGEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gxd8DUT15qHAT/4ioLaszCzORntzwEC4bG0AqkjF0SHVmoqNTKBUinQYKS4RoGruI
         L+KDdPHRmmZ//fS6BTeHiUnd4Ui26EI086YzJiQOfCwj/5CzsTduwtMRwQ84YpKJ0b
         nlRwvYn/S5Uw+vqkovCal5hp5H7NT6/3+y1IlsPo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 422F76030E
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
 <243de3a4-292b-77c0-6232-0b38d124d183@codeaurora.org>
 <20190716232228.2B84F2173E@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <63d15392-f296-cd13-7821-61d59d568347@codeaurora.org>
Date:   Tue, 30 Jul 2019 16:21:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716232228.2B84F2173E@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2019 4:52 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-07-15 21:22:02)
>> Hello Stephen,
>>
>> Thanks for the review.
>>
>> On 7/16/2019 4:14 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2019-05-12 20:44:46)
>>>> On 5/10/2019 11:24 PM, Stephen Boyd wrote:
>>>>> Why is the clk name changing to not have a _src after the "root" of the
>>>>> clk name? As long as I can remember, RCGs have a "_src" postfix.
>>>>>
>>>>
>>>> Yes, the RCGs would have _src, so we do want the init data also to be
>>>> generated with _src postfix. So that we do not have to manually clean up
>>>> the generated code.
>>>>
>>>
>>> Please manually cleanup the generated code, or fix the code
>>> generator to do what you want.
>>>
>>
>> Fixing the code manually is not what we intend to do and it is time
>> consuming with too many DFS controlled clocks. This really helps us
>> align to internal code.
>>
> 
> And you can't fix the code generator to drop the _src part of whatever
> is spit out for the DFS lines?
> 

Sure, will drop this.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
