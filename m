Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54046C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2405A20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q909PukS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q909PukS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCaJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:55:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCaJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:55:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D541160769; Sun, 31 Mar 2019 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554026154;
        bh=Of9ozZMKmyvN3SEz0Igitn/Y2I2FX6IYRp4WvaWpgK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q909PukSlNdEBB5fSd4zge8m5XF5M0WtdiwXG/HnL0XoAo2EHnXi7dluAS9lR0ZWz
         GruxFtc07jzKMhwG3GZ1OtNMPSz5GGrTBOdMNzLlDhOOtNktTbg6PYHy2ESn3coS6Y
         9m7vw4ivxh8/GVRIxkdFMec6IOG8L5VN7I8kbJg0=
Received: from [10.79.173.225] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07C3560769;
        Sun, 31 Mar 2019 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554026154;
        bh=Of9ozZMKmyvN3SEz0Igitn/Y2I2FX6IYRp4WvaWpgK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q909PukSlNdEBB5fSd4zge8m5XF5M0WtdiwXG/HnL0XoAo2EHnXi7dluAS9lR0ZWz
         GruxFtc07jzKMhwG3GZ1OtNMPSz5GGrTBOdMNzLlDhOOtNktTbg6PYHy2ESn3coS6Y
         9m7vw4ivxh8/GVRIxkdFMec6IOG8L5VN7I8kbJg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07C3560769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] net: dsa: fix negative loop bound error on for loop
To:     Colin King <colin.king@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330214241.15311-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3723042a-88db-fa87-02ec-4ff231bbaff2@codeaurora.org>
Date:   Sun, 31 Mar 2019 15:25:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330214241.15311-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 3:12 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the for-loop using an unsigned int for the loop counter
> which is problematic when comparing it to the signed int count
> This is an issue because if the signed int is negative then
> the negative loop bound is implicitly cast to an unsigned int on
> the comparison to loop counter i and will yield a very large value,
> eventually causing an error when memmove/memcpy'ing outside the
> allocated region pointed to by ndata.
>
> Fix this by simply making the loop counter i a signed int;
>
> Fixes: f2f2356685bc ("net: dsa: move master ethtool code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   net/dsa/master.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/dsa/master.c b/net/dsa/master.c
> index c58f33931be1..1b659647a303 100644
> --- a/net/dsa/master.c
> +++ b/net/dsa/master.c
> @@ -87,8 +87,7 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
>   	struct dsa_switch *ds = cpu_dp->ds;
>   	int port = cpu_dp->index;
>   	int len = ETH_GSTRING_LEN;
> -	int mcount = 0, count;
> -	unsigned int i;
> +	int mcount = 0, count, i;

This looks fine but why the return value checking for the negative will 
not be good here ?
  count = ds->ops->get_sset_count(ds, port, stringset);


Cheers,
Mukesh


>   	uint8_t pfx[4];
>   	uint8_t *ndata;
>   
