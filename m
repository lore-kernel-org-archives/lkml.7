Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9909C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E95206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OPer1vth";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gM0tk3Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfHPCs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:48:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfHPCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:48:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B28C6083E; Fri, 16 Aug 2019 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565923707;
        bh=wv59p8ClltpNozpwVUS0BK+L2Q/WPAN3/oCedbCshwY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OPer1vth8AKGaeueSjSM+6gvV8NnKFqUBwOK+yPuXZ4v0Bv+2j6DamKlZmH0daVkR
         TN1AIz5oTzvkpeNB0hgeQbI2Pb2fLbOsuywqWa7D2AiD+DbDR+ygBXR6jgVnecFQdX
         vEaDeUn6CeYKMJu6P0Ot3rzKreCb36lT3ad3rIZU=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D7E1606DB;
        Fri, 16 Aug 2019 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565923706;
        bh=wv59p8ClltpNozpwVUS0BK+L2Q/WPAN3/oCedbCshwY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gM0tk3Wi4Q8+oFl6VSvmxzpShyviw4d6tiu9LlckLobAQGZkiSLIxC4AtZOteo9mU
         DSOqOPc1pIYas7JuN00wKvpHTjcT0FpuLq35gGe/hNnSvPEYV39aDmn3EeJamBXKnz
         68/i6EVvA3q95YbeKT3l05fTbSVoVyOrS31JkN1I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D7E1606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 4/4] clk: qcom: Remove error prints from DFS registration
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20190815160020.183334-1-sboyd@kernel.org>
 <20190815160020.183334-5-sboyd@kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <9e92bf38-0513-cd9a-f178-6a791b15fba5@codeaurora.org>
Date:   Fri, 16 Aug 2019 08:18:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815160020.183334-5-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2019 9:30 PM, Stephen Boyd wrote:
> These aren't useful and they reference the init structure name. Let's
> just drop them.
> 
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Acked-by: Taniya Das <tdas@codeaurora.org>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
