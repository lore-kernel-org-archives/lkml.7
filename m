Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1232AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C020700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PuKLOkrF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RL4tMN4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfC0MNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:13:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0MNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:13:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2485460E3F; Wed, 27 Mar 2019 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688815;
        bh=7KP3YDZ/m+akhRhTO0w7B3BXCduUCx2d0p/1Kedy5ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PuKLOkrFahWJ2SKpkzp32W9YFAaG9FgwcEFgYs5cLTv6a4bJ6kmljuxnneWo9zDeg
         4frSd/uej9Xz0eSFXRdaS3sipRoghe3qQ9R9xYqmXij0PfFPKI/Zv/UjGmoN6AOtJc
         eCZW5FS4GhougrACyFsfMLxqkyqyeuhogHskx50E=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E757D609D4;
        Wed, 27 Mar 2019 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688814;
        bh=7KP3YDZ/m+akhRhTO0w7B3BXCduUCx2d0p/1Kedy5ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RL4tMN4UNgcsuAli3KdaaTniTVyJKIf9CXd8X66pWFAI45w4A5Yk+xesHmvZg7fB+
         w0H1/McTKOJ/nSbjIoEmI8KOyzS4ylWqimYyMKXlvDZWuEgvyGFgR2XSYTOT0af+L4
         qz+PD+1zIuyrkHj4t7cbgU25ipgmRy/cu/8O8VTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E757D609D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309051921.15212-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7e949cd4-8ef7-a29b-83a0-9c15b68499e5@codeaurora.org>
Date:   Wed, 27 Mar 2019 17:43:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190309051921.15212-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/9/2019 10:49 AM, Kangjie Lu wrote:
> get_skb may fail and return NULL. The fix returns "ENOMEM"
> when it fails to avoid NULL dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


> ---
>   drivers/infiniband/hw/cxgb4/cm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 8221813219e5..502a54d57e2c 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
>   	int win;
>   
>   	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
>   	req = __skb_put_zero(skb, sizeof(*req));
>   	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
>   	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
