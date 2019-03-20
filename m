Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1684218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A4YZZ+J8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A4YZZ+J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfCTVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:02:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTVCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:02:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D37C8602FC; Wed, 20 Mar 2019 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553115754;
        bh=+lEa27KuJhVU67Y8NBHPSYtnTJtsuuFgYCg88I7aTr8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A4YZZ+J8y4APs+IXfo4y6fNH9hzcs9a9QoRaKvnvUX6h44oH2X6l+lrAOrhRN+dx0
         ztlzjpyMBD9h8GPCS1mA6V3WNl5ezfQOYXtNI0TQvoIUYVf+vF9MarlJLqyVn2We5b
         orQ5nhV1mQgCpNfAzT0wl1rG52qxLpoI3nvkzrhM=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19AE060237;
        Wed, 20 Mar 2019 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553115754;
        bh=+lEa27KuJhVU67Y8NBHPSYtnTJtsuuFgYCg88I7aTr8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A4YZZ+J8y4APs+IXfo4y6fNH9hzcs9a9QoRaKvnvUX6h44oH2X6l+lrAOrhRN+dx0
         ztlzjpyMBD9h8GPCS1mA6V3WNl5ezfQOYXtNI0TQvoIUYVf+vF9MarlJLqyVn2We5b
         orQ5nhV1mQgCpNfAzT0wl1rG52qxLpoI3nvkzrhM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19AE060237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] thunderbolt: Fix to check for kmemdup failure
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190320155754.29731-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b9901208-9808-1112-a3e3-f4b842323732@codeaurora.org>
Date:   Thu, 21 Mar 2019 02:32:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320155754.29731-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 9:27 PM, Aditya Pakki wrote:
> Memory allocated via kmemdup might fail and return a NULL pointer.
> This patch adds a check on the return value of kmemdup and passes the
> error upstream.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v1: Missed check on tb_sw_read, suggested by Mukesh
> ---
>   drivers/thunderbolt/switch.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index cd96994dc094..504365d46827 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1294,13 +1294,14 @@ int tb_switch_configure(struct tb_switch *sw)
>   	return tb_plug_events_active(sw, true);
>   }
>   
> -static void tb_switch_set_uuid(struct tb_switch *sw)
> +static int tb_switch_set_uuid(struct tb_switch *sw)
>   {
>   	u32 uuid[4];
> -	int cap;
> +	int cap, ret;
>   
> +	ret = 0;
>   	if (sw->uuid)
> -		return;
> +		return ret;
>   y
>   	/*
>   	 * The newer controllers include fused UUID as part of link
> @@ -1308,7 +1309,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
>   	 */
>   	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
>   	if (cap > 0) {
> -		tb_sw_read(sw, uuid, TB_CFG_SWITCH, cap + 3, 4);
> +		ret = tb_sw_read(sw, uuid, TB_CFG_SWITCH, cap + 3, 4);
> +		if (ret)
> +			return ret;
>   	} else {
>   		/*
>   		 * ICM generates UUID based on UID and fills the upper
> @@ -1323,6 +1326,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
>   	}
>   
>   	sw->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
> +	if (!sw->uuid)
> +		ret = -ENOMEM;
> +	return ret;
>   }


Thanks for doing the change.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


-Mukesh



>   
>   static int tb_switch_add_dma_port(struct tb_switch *sw)
> @@ -1372,7 +1378,9 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
>   
>   	if (status) {
>   		tb_sw_info(sw, "switch flash authentication failed\n");
> -		tb_switch_set_uuid(sw);
> +		ret = tb_switch_set_uuid(sw);
> +		if (ret)
> +			return ret;
>   		nvm_set_auth_status(sw, status);
>   	}
>   
> @@ -1422,7 +1430,9 @@ int tb_switch_add(struct tb_switch *sw)
>   		}
>   		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
>   
> -		tb_switch_set_uuid(sw);
> +		ret = tb_switch_set_uuid(sw);
> +		if (ret)
> +			return ret;
>   
>   		for (i = 0; i <= sw->config.max_port_number; i++) {
>   			if (sw->ports[i].disabled) {
