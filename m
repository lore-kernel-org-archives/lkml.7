Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D4C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A141121901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfAfUuZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfGXNDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:03:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34152 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfGXNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:03:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so47794845otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=St0OD81vvxUjVHgZdUhOHp3xMGk7dggtbpwmHrGdlCs=;
        b=IfAfUuZNwlAO7G27XDwU/70KmfgndhtBPb/CVvFerZOY1UsTrBAZaBsxQUu4Uq2rWV
         VM6BynX+WW5IUD54TP9OSGt86xAG7c+3wb7rIFQ8aMuksZhdN/giH03bex2NMXVAALdp
         9bWMi6AiogYkRVi+2jUaIaILcA7nMoVXOKc4nT4Q/b6i2lbeilJGuvDLqqvqo/Obc3sw
         TvHtU3ZcgzNNH9ZhDf/9mNdOtrMC8djomF0r5uL9l0hHt8F6VLq2cTH413aZApemW5Iv
         1PLpjtob4WbpnpTR1RxCy69DKvcWcdwmu/0R+RriQz61AdIpwonqdGL2neGLwbF5ToFj
         XvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=St0OD81vvxUjVHgZdUhOHp3xMGk7dggtbpwmHrGdlCs=;
        b=szd44/+DnLmZxmxiu+Bu/nehuNRksFeZnwt+tTFj2s2IQrXtmKIXzi6riouv9maACJ
         zr9tJtd5zpvUF4hM/U3DmwSlifoLg4tYjvsBsg/ZHvua/4KLDlATIrf+VjJDxP5qRFOS
         BEkjAx2LXaP601RFH5+v6n6bPUNjPn9uPa0h17e853XyNdVOTfheZ/1FcIrIem1MjQOU
         OTj7VuwJevXyu80zLSZfKVaUC0d64ztPOKPYLKpOFjVfS4pcR5hmZnK0HQ8ZsaG2l9xd
         QdPZLPuuoKjlnEhJFpsIxvXk5MYvEUAJn3g/I1IgYzOqZrFOW1AN73QCYlyzPNfhDwCt
         hzMQ==
X-Gm-Message-State: APjAAAU6nOPCByCvSsayCiBmXYYgAkTAtiqb/mcMRfpc4kaWFlfWXF2A
        cKuO+z/oNZ99+3jNypHTFg==
X-Google-Smtp-Source: APXvYqwoqN64SzSosnuwzz9M5scf3EzvSuLj58zC6HvVED2/ou7nWq+PGi7bsI3eG18k3dsZrSjeyw==
X-Received: by 2002:a9d:4703:: with SMTP id a3mr33765462otf.183.1563973432330;
        Wed, 24 Jul 2019 06:03:52 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u139sm16367244oie.55.2019.07.24.06.03.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:03:51 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c4e8:4e9:949c:2f11])
        by serve.minyard.net (Postfix) with ESMTPSA id 08AF01800D1;
        Wed, 24 Jul 2019 13:03:51 +0000 (UTC)
Date:   Wed, 24 Jul 2019 08:03:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ipmi: Fix possible pointer dereferences in
 msg_done_handler()
Message-ID: <20190724130349.GI3066@minyard.net>
Reply-To: minyard@acm.org
References: <20190724102528.2165-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724102528.2165-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:25:28PM +0800, Jia-Ju Bai wrote:
> In msg_done_handler(), there is an if statement on line 778 to check
> whether msg is NULL:
>     if (msg)
> 
> When msg is NULL, it is used on line 845:
>     if ((result < 0) || (len < 3) || (msg->rsp[2] != 0))
> and line 869:
>     if ((result < 0) || (len < 3) || (msg->rsp[2] != 0))

You cannot get into those states without msg being set, so there
is no need to check for that msg is NULL there.  If you look
at those states elsewhere, you can see that curr_msg is set every
time you go into those states.

-corey

> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, msg is checked before being used.
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 305fa5054274..2e40a98d9939 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -842,6 +842,8 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  		break;
>  
>  	case SSIF_GETTING_EVENTS:
> +		if (!msg)
> +			break;
>  		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
>  			/* Error getting event, probably done. */
>  			msg->done(msg);
> @@ -866,6 +868,8 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  		break;
>  
>  	case SSIF_GETTING_MESSAGES:
> +		if (!msg)
> +			break;
>  		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
>  			/* Error getting event, probably done. */
>  			msg->done(msg);
> -- 
> 2.17.0
> 
