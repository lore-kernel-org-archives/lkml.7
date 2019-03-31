Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92D92146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HfCSW14F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fo/cpGft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCaIII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 04:08:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCaIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 04:08:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26A1B60790; Sun, 31 Mar 2019 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554019687;
        bh=pYoka4C0tMmi8FoqANEVgvqpYyifIDHM/jG2c5vVgBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HfCSW14F/DhX2rhOWv2gldVUnnUfu5M1FMYCPc95svmf4tvx8OUxO39mo4UHdSX27
         F+6MXq74V+eXp4dZUiOr8rG34D1kaIxEmmXi/SlyeFkzhTpA7qaxjEhe0Xdxkqdnhs
         SJO2tfnTjvQAnsXmu0B1pKy5VL/btU8AYhARcb9s=
Received: from [10.79.166.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C198960712;
        Sun, 31 Mar 2019 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554019686;
        bh=pYoka4C0tMmi8FoqANEVgvqpYyifIDHM/jG2c5vVgBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fo/cpGft3C3a7zgWhkAwBdV81PdtlgP4tZCRR8ENHadjlXNBTpPiNlT5NyKJgkYgh
         Zl+/UDfkaevYAN9U3PC/rps1ql48M7UkwKhisSt+j2EE+4Srq6ZPZhdG+T195QS4/u
         O5UK8F5XeFxlHo0RzA1ZWGSEY/4M0JpFxXRu5bbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C198960712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] tty: rocket: Fix a kernel address leak in rp_ioctl
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
References: <20190331053207.17337-1-huangfq.daxian@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <84f8695e-eb0a-6fe3-eb5c-f7c0af6c4644@codeaurora.org>
Date:   Sun, 31 Mar 2019 13:37:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331053207.17337-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 11:02 AM, Fuqian Huang wrote:
> If the cmd is RCPK_GET_STRUCT, copy_to_user will copy
> info to user space. As info->port.ops is the address of
> a constant object rocket_port_ops (assigned in init_r_port),
> a kernel address leakage happens.
>
> This patch sets all the pointer fields to NULL before copy the
> object to user space to avoid kernel address leakage.


Should not this be done like provide userspace the stuff they want?

>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   drivers/tty/rocket.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index b121d8f8f3d7..a7bcf44b61bd 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1271,6 +1271,34 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
>   	return 0;
>   }
>   
> +static int get_struct(struct r_port *info, void *argp)
Should not this void * argp be struct r_port __user ?
> +{
> +	struct r_port *new;
> +	int ret = 0;
> +
> +	new = kzalloc(sizeof (struct r_port), GFP_KERNEL)

why there is space before sizeof everywhere ?

> ;
> +	if (!new)
> +		return -ENOMEM;
> +	memcpy(new, info, sizeof (struct r_port));
> +	new->port.tty = NULL;
> +	new->port.itty = NULL;
> +	new->port.ops = NULL;
> +	new->port.client_ops = NULL;
> +	memset(&new->port.open_wait.head, 0, sizeof (struct list_head));
> +	memset(&new->port.delta_msr_wait.head, 0, sizeof (struct list_head));
> +	memset(&new->port.mutex.wait_list, 0, sizeof (struct list_head));
> +	memset(&new->port.buf_mutex.wait_list, 0, sizeof (struct list_head));
> +	new->port.xmit_buf = NULL;
> +	new->port.client_data = NULL;
> +	new->ctlp = NULL;
> +	new->xmit_buf = NULL;
> +	memset(&new->write_mtx.wait_list, 0, sizeof (struct list_head));

Are we sure nothing is missed ?

Are the other information use by userspace ?


> +	if (copy_to_user(argp, new, sizeof (struct r_port)))
> +		ret = -EFAULT;
> +	kfree(new);
> +	return ret;
> +}
> +
>   /*  IOCTL call handler into the driver */
>   static int rp_ioctl(struct tty_struct *tty,
>   		    unsigned int cmd, unsigned long arg)
> @@ -1284,8 +1312,7 @@ static int rp_ioctl(struct tty_struct *tty,
>   
>   	switch (cmd) {
>   	case RCKP_GET_STRUCT:
> -		if (copy_to_user(argp, info, sizeof (struct r_port)))
> -			ret = -EFAULT;
> +		ret = get_struct(info, argp);
>   		break;
>   	case RCKP_GET_CONFIG:
>   		ret = get_config(info, argp);
