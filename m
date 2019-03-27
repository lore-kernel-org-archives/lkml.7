Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882232087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gwf9H2HA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GNWfaxUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfC0Op4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:45:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfC0Opx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:45:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C5F8960A60; Wed, 27 Mar 2019 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697952;
        bh=duLL1CPWxrVpesOV7NaJDQiBU+y0GBOY+Chd5dVRZjM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gwf9H2HA4GMaRgujZu2nVAsY5AzH5wNXXtNenItHGd1eqzcVpmkQuBzRNBD/ZjlC6
         mURvAeghJM9CcSMpErJV7asXeFHTNeIgRjbG/FpYEk0oeKk5C+5y9WLwqLdpIyE1gv
         9unnsmjLU72gtMj/tT1yU42Mc3r48yUP9TTN2uxg=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA87360A50;
        Wed, 27 Mar 2019 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697951;
        bh=duLL1CPWxrVpesOV7NaJDQiBU+y0GBOY+Chd5dVRZjM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GNWfaxUsZ6xxrO8O+iit0zT09BeGf9GXT8md8zqp9sOImwHuWfhIuXkURYmkuKVwh
         5tpp2eu1MMGdvOHgjOeUWn1Xcl/10659gvnVocXD1odQGiCPfJq0lKeqJd5DxyANwv
         wN4ySLe3hyzVIYQHueZBYexDEaxYRtQT6xmeZRMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA87360A50
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] thunderbolt: property: fix a buffer overflow and a
 missing check
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190324224916.1389-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9a518b6f-0036-2425-a40e-68d1f5f8d5c4@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:15:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324224916.1389-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:19 AM, Kangjie Lu wrote:
> First, no memory is allocated for "property->value.text"; the
> following strcpy will lead to a buffer overflow.

Fix the commit text as there is no  overflow.

only the check and resource cleanp is the fix.

>
> Second, no check is enforced for the return value of kzalloc,
> which may lead to NULL-pointer dereference.
>
> The patch fixes the two issues.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu
Otherwise looks good.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/thunderbolt/property.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index 841314deb446..d5b0cdb8f0b1 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -587,7 +587,12 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
>   		return -ENOMEM;
>   
>   	property->length = size / 4;
> -	property->value.data = kzalloc(size, GFP_KERNEL);
> +	property->value.text = kzalloc(size, GFP_KERNEL);
> +	if (!property->value.text) {
> +		kfree(property);
> +		return -ENOMEM;
> +	}
> +
>   	strcpy(property->value.text, text);
>   
>   	list_add_tail(&property->list, &parent->properties);
