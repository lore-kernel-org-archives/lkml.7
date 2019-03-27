Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9616C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FAE2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711309;
	bh=XAO67Mv40gK3aSrgJppV1unl5sD+k7grXLXBR8THqJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=njzw3ndwyc4mBUWycJ37Ftz5mM9z2cpO46VC4SI/ob+HoqriIRqjmJ6gconD13LlK
	 0MQ4uv+klGJmt+cxkmHEx61r7WPveSryPzCiY7gVHDdMD+vnxjxvYwl0G0viqx8s/e
	 CfLZGTbM4dgUpQwya872ZTY1d7svO9NpoJPlhopc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391891AbfC0S22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389733AbfC0S20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:26 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F81D20651;
        Wed, 27 Mar 2019 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711305;
        bh=XAO67Mv40gK3aSrgJppV1unl5sD+k7grXLXBR8THqJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv9VSlmN9H5h2vUanhe2jR2zBnQ0mUle+icZRfYzTjgXhXs/ml7TSbqOWlqiCmH4f
         MwD0+FvXnCCdTqEF3y/FLUxEH4BK4KVLH4+tdHxVEEqFU+g7qxeG1qcZ7BZPS1SoKK
         +CUWfc3XZzRee2ghTjxOnCgY1nLqktWWi1nBypGg=
Date:   Thu, 28 Mar 2019 01:34:23 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_cs: Fix memory leak in parport_config
Message-ID: <20190327163423.GA2969@kroah.com>
References: <20190321082628.14384-1-yuehaibing@huawei.com>
 <d59d35b9-7fb0-d1f0-b63c-4f7c2ff354e0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59d35b9-7fb0-d1f0-b63c-4f7c2ff354e0@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:39:17PM +0530, Mukesh Ojha wrote:
> 
> On 3/21/2019 1:56 PM, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > 
> > parport_probe() alloc parport device 'info',
> > but while parport_config failed it does not free it.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >   drivers/parport/parport_cs.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
> > index e9b52e4..e77044c2 100644
> > --- a/drivers/parport/parport_cs.c
> > +++ b/drivers/parport/parport_cs.c
> > @@ -158,8 +158,9 @@ static int parport_config(struct pcmcia_device *link)
> >       return 0;
> >   failed:
> > -    parport_cs_release(link);
> > -    return -ENODEV;
> > +	parport_cs_release(link);
> > +	kfree(link->priv);
> > +	return -ENODEV;
> >   } /* parport_config */
> >   static void parport_cs_release(struct pcmcia_device *link)
> 
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org
> <mailto:mojha@codeaurora.org>>

Please do not send html email for kernel patches :(
