Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BA020663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gcEZXi3x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gcEZXi3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCFVsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:48:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCFVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:48:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE6A860A24; Wed,  6 Mar 2019 21:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551908894;
        bh=cANxGSSTXHyzwV+Tt6cQA8GympnTj06r9H9sxkbuDUA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gcEZXi3xHz0L0jSch8TJ6PnITxSnPec0eegbc3AveLroKbmVKx35LY1yVAStM3yIT
         dF9n8mjR49LWm2rKugIiK7RUbEHOraT3u1gR7yM3KOg3Nn1puGbgn9+JByDW9Vrm03
         tXyvg/p6VRcMw+1uY6ZJk/U3SSHm3gcl4+j3d/xo=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6B56604BE;
        Wed,  6 Mar 2019 21:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551908894;
        bh=cANxGSSTXHyzwV+Tt6cQA8GympnTj06r9H9sxkbuDUA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gcEZXi3xHz0L0jSch8TJ6PnITxSnPec0eegbc3AveLroKbmVKx35LY1yVAStM3yIT
         dF9n8mjR49LWm2rKugIiK7RUbEHOraT3u1gR7yM3KOg3Nn1puGbgn9+JByDW9Vrm03
         tXyvg/p6VRcMw+1uY6ZJk/U3SSHm3gcl4+j3d/xo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6B56604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1] clk: Probe defer clk_get() on orphans
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <873279a6-0755-2094-ec99-d9e5f6c963dd@codeaurora.org>
Date:   Wed, 6 Mar 2019 14:48:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

Stephen, I know as this depends on your clock parent handling series 
(happens to apply just fine to v2), its not going to be accepted until 
that gets sorted out, but do you have any thoughts on if this seems like 
an appropriate thing to do, or if you'd like to see a different solution?

On 2/11/2019 11:57 AM, Jeffrey Hugo wrote:
> If a parent to a clock comes from outside that clock's provider, the parent
> may not be present at the time the clock is registered (ie the parent comes
> from another driver that has not yet probed).  The clock can still be
> registered, and a reference to it obtained, however that clock may not be
> fully functional - ie get_rate might return an invalid value.
> 
> This has been a problem that has resulted in the UART console breaking on
> some Qualcomm SoCs, as the UART baud rate is based on a clock that is the
> child of XO.  Due to the large chain of dependencies, its possible that the
> RPM has not provided XO by the time that the UART driver probes, gets the
> baud rate clock, and calls get_rate - which returns 0 and results in a bad
> configuration.
> 
> An orphan clock is a clock that is missing a parent or some other ancestor.
> Since the parent is defined, we can assume that it is expected to appear at
> some point in a properly configured system (all bets are off if a required
> driver is not compiled, etc), and it is unlikely that the clock can be
> properly consumed during the time the clock is an orphan.  Therefore,
> return EPROBE_DEFER for orphan clocks so that consumers wait until the
> parent chain is established, and proper clock operation can occur.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> 
> This is based upon the "Rewrite clk parent handling" series at [1], and assumes
> that the suspected missing line commented on at [2] is added.
> 
> The idea for this solution came from [3] and [4].
> 
> [1] https://lore.kernel.org/lkml/20190129061021.94775-1-sboyd@kernel.org/T/#u
> [2] https://lkml.org/lkml/2019/2/11/1634
> [3] https://lkml.org/lkml/2019/2/6/382
> [4] https://lkml.org/lkml/2015/12/27/209
> 
>   drivers/clk/clk.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 34e9524ea25d..cf71e0614282 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3405,6 +3405,10 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>   		return ERR_CAST(hw);
>   
>   	core = hw->core;
> +
> +	if (core->orphan)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
>   	clk = alloc_clk(core, dev_id, con_id);
>   	if (IS_ERR(clk))
>   		return clk;
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
