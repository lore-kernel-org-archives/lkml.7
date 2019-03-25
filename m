Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F172C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006A720883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HHWJD6ig";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gRMta95R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfCYGp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:45:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:45:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E57C360312; Mon, 25 Mar 2019 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553496328;
        bh=aARSQyq5Fgdwgd4A3EeTZD2+IQbttbtbeR3xJGhGQwE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HHWJD6igRWbcq6TzmBELc8EE9znmN1A7zjRYMK5w1dwdxh5ZjdEphIFmIGAbwf+2s
         NjLtVgJ3LdRzEIvDbCnGl+8m2RphMnuhqFouilFe+7Rl4dfYZlFrl00jGpc3NFw+FR
         ghj+mDfNVq4I0NeSs2rmpTNfFa9DnS71tjmQPtbg=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE72C60159;
        Mon, 25 Mar 2019 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553496327;
        bh=aARSQyq5Fgdwgd4A3EeTZD2+IQbttbtbeR3xJGhGQwE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gRMta95RnHekkLpyqsoqOQaaAVymDAy37SldhV78OQLv9ZmrzMGJv49lz5qpZxPhC
         pCt0Te+c4BDZIg23rKrLrnpqToPfuVGaLElKnBwdFR1ShU03qwI1T0GeshkLKeHS5G
         o5Jyn2nL4yqH53DX/skYqHbnvWBoRH1FqfCYZCTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE72C60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] sound: codecs: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190324231237.2246-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4fa0e2cb-7044-12e1-33b3-14015c94e48d@codeaurora.org>
Date:   Mon, 25 Mar 2019 12:15:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324231237.2246-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:42 AM, Kangjie Lu wrote:
> In case devm_kzalloc fails, the patch returns -ENOMEM to avoid
> potential NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   sound/soc/codecs/rt5663.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
> index da6647015708..909ab99a1995 100644
> --- a/sound/soc/codecs/rt5663.c
> +++ b/sound/soc/codecs/rt5663.c
> @@ -3480,6 +3480,8 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
>   		table_size = sizeof(struct impedance_mapping_table) *
>   			rt5663->pdata.impedance_sensing_num;
>   		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
> +		if (!rt5663->imp_table)
> +			return -ENOMEM;

add checks in rt5663_parse_dp  as well.

Thanks.
Mukesh


>   		device_property_read_u32_array(dev,
>   			"realtek,impedance_sensing_table",
>   			(u32 *)rt5663->imp_table, table_size);
