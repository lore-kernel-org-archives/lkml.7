Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9534C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767EE2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jt8oTMv7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fs5Lon0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCTMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:09:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:09:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 721F261132; Wed, 20 Mar 2019 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553083791;
        bh=AYlVRFsJ1EMDkewEnL7RGOeKBt+otADotoLzbyCJOww=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jt8oTMv7s7im0/EH4Kv2veP2Y+lSY4Azqfa0jnhJZjC/d+9k4EBnA+88ijTF5V/ev
         xuqxdVHQpcdbJjE3VJjacgtMfpxHXs6TGK8eUNeezuSSLAVoBqKltigr/N/5xZIFkG
         tJo0torcvxP1HnS8YlY0TI3xFnaL+1cYjcZTcqAI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5F1360E59;
        Wed, 20 Mar 2019 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553083789;
        bh=AYlVRFsJ1EMDkewEnL7RGOeKBt+otADotoLzbyCJOww=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fs5Lon0credtjwGh2UCZ8s9yTdBeLL15nZHksfBMJtUf1hfpo6G0jm7DTYMtxvuMi
         biljnfeH2zkvRQK5b69mA6r3+k/mLiCZ1ar1bVOXQG3w3LyRNqPYeB2W+MPl/+DxaY
         vJ/63TLcg2m01RygEp+/ppd7rwtnbIazuwR3GINI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5F1360E59
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] thunderbolt: Fix to check for kmemdup failure
To:     Aditya Pakki <pakki001@umn.edu>, pakki001@um.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190318224417.7500-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3984668e-9ac6-1e47-01fc-dfab8cd77cae@codeaurora.org>
Date:   Wed, 20 Mar 2019 17:39:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190318224417.7500-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/2019 4:14 AM, Aditya Pakki wrote:
> Memory allocated via kmemdup might fail and return a NULL pointer.
> This patch adds a check on the return value of kmemdup and passes the
> error upstream.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/thunderbolt/switch.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index cd96994dc094..c05d77073ee7 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1294,13 +1294,13 @@ int tb_switch_configure(struct tb_switch *sw)
>   	return tb_plug_events_active(sw, true);
>   }
>   
> -static void tb_switch_set_uuid(struct tb_switch *sw)
> +static int tb_switch_set_uuid(struct tb_switch *sw)
>   {
>   	u32 uuid[4];
>   	int cap;
>   
>   	if (sw->uuid)
> -		return;
> +		return 0;
>   
>   	/*
>   	 * The newer controllers include fused UUID as part of link
> @@ -1323,6 +1323,9 @@ static void tb_switch_set_uuid(struct tb_switch *sw)
>   	}
>   
>   	sw->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
> +	if (!sw->uuid)
> +		return -ENOMEM;
> +	return 0;
>   }
>   

Change looks good to me.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

but, we should add check for `tb_sw_read  ` this as well.


Cheers,
Mukesh


>   static int tb_switch_add_dma_port(struct tb_switch *sw)
> @@ -1372,7 +1375,9 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
>   
>   	if (status) {
>   		tb_sw_info(sw, "switch flash authentication failed\n");
> -		tb_switch_set_uuid(sw);
> +		ret = tb_switch_set_uuid(sw);
> +		if (ret)
> +			return ret;
>   		nvm_set_auth_status(sw, status);
>   	
>   
> @@ -1Reviewed-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>422,7 +1427,9 @@ int tb_switch_add(struct tb_switch *sw)
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
