Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F03C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ae3j5C5f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YbUI9Fz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGPETR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:19:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGPETQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:19:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40DBA611D1; Tue, 16 Jul 2019 04:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563250755;
        bh=asziNOotswwKQNcqM8Xvjaq2EHtX2p3jxb3vhqL9DsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ae3j5C5fVIQstLd5hj1CoNUaGfGz2s/PwZJoghSZKKEvg01QlQyPeq4uFW0s7okZj
         5QuxNscxKvTN/H+XnPV3rgOKbczxFC71BPbhvcobVofgv3XwLv8zA5Umr+0U5WOesh
         8ZXFxXR1scvC6Rp0ZKyZOcctsgeze3X7UWWF++X4=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB59661798;
        Tue, 16 Jul 2019 04:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563250747;
        bh=asziNOotswwKQNcqM8Xvjaq2EHtX2p3jxb3vhqL9DsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YbUI9Fz83TyJdxEUPOirR+5Yg9RylDLu+TtxSC4JImbVr29bM/rz04HoRxeqUnwU/
         mkDjYh9IKS0g4cBjZkSl2/hINbyZy4Ez73qb1s3u5uGj1cZ4Pbn6jh7l82blpjEf4N
         6G46W0SUQ7sSU5vaw0EKhHkj+MAgdJIgxTw6Uj/o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB59661798
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 2/3] clk: qcom: rcg2: Add support for hardware control
 mode
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557339895-21952-1-git-send-email-tdas@codeaurora.org>
 <1557339895-21952-3-git-send-email-tdas@codeaurora.org>
 <20190715225219.B684820665@mail.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <916e2fb3-98b9-c4e3-50e0-3581a41609d6@codeaurora.org>
Date:   Tue, 16 Jul 2019 09:49:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190715225219.B684820665@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for your review.

On 7/16/2019 4:22 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2019-05-08 11:24:54)
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 57dbac9..5bb6d45 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -289,6 +289,9 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
>>          cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
>>          if (rcg->mnd_width && f->n && (f->m != f->n))
>>                  cfg |= CFG_MODE_DUAL_EDGE;
>> +       if (rcg->flags & HW_CLK_CTRL_MODE)
>> +               cfg |= CFG_HW_CLK_CTRL_MASK;
>> +
> 
> Above this we have commit bdc3bbdd40ba ("clk: qcom: Clear hardware clock
> control bit of RCG") that clears this bit. Is it possible to always set
> this bit and then have an override flag used in sdm845 that says to
> _not_ set this bit? Presumably on earlier platforms writing the bit is a
> no-op so it's safe to write the bit on those platforms.
> 
> This way, if it's going to be the default we can avoid setting the flag
> and only set the flag on older platforms where it shouldn't be done for
> some reason.
> 

Not all the subsystem clock controllers might have this hardware control
bit set from design. Thus we want to set them based on the flag.

>>          return regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
>>                                          mask, cfg);
>>   }
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
