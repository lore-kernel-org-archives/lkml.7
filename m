Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A9120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qzd1p/35";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qi5DAPfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfHTGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:20:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:20:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7792260907; Tue, 20 Aug 2019 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566282030;
        bh=zYwtPjOAPp+nohF9GhapdgbsQMYUWhazG4Ci319R0ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qzd1p/35qZCvYzjCNUbqex5GbF4BX61zNMBOaAqZWcGxQlE5F5CsxVOBXQpP1xh/J
         RuZRhoHDnDpA0pECGBW7cN5QoV9wGSk/C1+mOXUhlTfouKWHU0v2QzKYPW6TNMmA/S
         e6j7VNAFNsL3HBZSCneeN6CRrrM88m8eW2fGL73U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B4C3F608CE;
        Tue, 20 Aug 2019 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566282028;
        bh=zYwtPjOAPp+nohF9GhapdgbsQMYUWhazG4Ci319R0ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qi5DAPfJvC2xk14ux5LKKIhcs3bogmLKvZwDUaJxpFTR90z+1sxu+23BFHLn/gyPU
         mPva+aiH9cgXA0Pzmh30NCjlsEJyTbkWD8DeGBVFyzafCLu1HQtTcD/GwNGULnL8SQ
         XiGHEpfBMy/0Y+HtONAt82UNFCr6mPvktqzOl19A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Aug 2019 11:50:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] arm64: dts: qcom: sm8150: Add APSS shared mailbox
In-Reply-To: <20190819174107.GM12733@vkoul-mobl.Dlink>
References: <20190814125012.8700-1-vkoul@kernel.org>
 <20190814125012.8700-23-vkoul@kernel.org>
 <20190814171743.C38C4206C1@mail.kernel.org>
 <20190819174107.GM12733@vkoul-mobl.Dlink>
Message-ID: <179635ff3f55d5d121008d6193ea4120@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vinod,

There seems to be a mismatch
between the commit description
and the dt node (This is the
aoss qmp node not the APPS
shared node).


On 2019-08-19 23:11, Vinod Koul wrote:
> On 14-08-19, 10:17, Stephen Boyd wrote:
>> Quoting Vinod Koul (2019-08-14 05:50:12)
>> > @@ -338,6 +339,16 @@
>> >                         #interrupt-cells = <2>;
>> >                 };
>> >
>> > +               aoss_qmp: qmp@c300000 {
>> 
>> Node name of 'clock-controller', or 'power-controller'?
> 
> The orignal entry for sdm845 has no such statement, but yes it doesn
> makes sense. I am thinking power-controller.. Bjorn?

aoss_qmp registers both pd and
clock providers.

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
