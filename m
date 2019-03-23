Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE172218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bhlj7KgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCWDKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:10:39 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54878 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfCWDKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:10:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C6C55D86
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TpwKOKU4S8nJ for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:10:37 -0500 (CDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 8A595E06
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:10:37 -0500 (CDT)
Received: by mail-pf1-f197.google.com with SMTP id v16so4103969pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jJgHy7gHwC/3SwgWJ/R44EEFiOns4ovdwlj/ixoMTEA=;
        b=bhlj7KgVGjE0pJfFFn7zSsTFN4oOYhlrfGFtmKN6+H9HCUQkxaPqiWJ8iXTiBpVBz3
         i8T8+S2Z3GAV7UsLUsa3sB3PPw8xccpcljifzAai3m+iuuZxiQtC5DCQhOGCUe3rqR1y
         VTR71ZeQle5FSQnTvFh6p0c64Hn+ziys5tRERJlLK06S4ejyqkwwVhemVgWrtNcQg56W
         aPBZzJe8jLC3jiyPeol9ZVQ8Z6bP883Iq4F1ItntFlFN6fU5Vr/fFwAXVQO91XREAnju
         PwBwBun5Jzty+7L/m3zSkIT+Ob+b/LRDkDg4ZBuMEgfq5iFASBOG0clENcn5PX+57mJU
         9r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jJgHy7gHwC/3SwgWJ/R44EEFiOns4ovdwlj/ixoMTEA=;
        b=HHk5HMhqghPUcxCPXlWW9Hcegy6N3xN3XNkD5vuIzJVVNBbjOwBnSK6/87vOCdxbYx
         QG5iL6YCkOcVTY5F8omHcW/pVrm6bOGaOmPp8cu8ixG3xszrp2e8ZEE8BP3yHoJpU8Ce
         XiQkj036kpb2v+XTFq4njgNF3+fuIhVDF3Gx5ZEhJh6BZM3xwYGrmMmpm0XG0GAUk7R8
         47nbYsIVuHix7VV+sLBy5tSGuLxpFuZwRIRCbqIOlaj3GPs+a1V54pv2BjmBrzSpMmp5
         OFyiWRelcL4b/tG1xrCKk6YZ4k31WLple8QaBAA5p3Q7VJh21mmT1huK0GR1pnnYP5Y5
         V56g==
X-Gm-Message-State: APjAAAW1sxli8cb+EAZHbEIdGc9GiJLzAkJ4F0pLen7Ww67sRWwSdIEE
        W/JK5iS+HX9vtVJnUta5XULOFaG1Ma4qfUs+cgiVF7oCwDLL3aRvhweXb9OFlN6nuNbfRLgtuA6
        B/+W2EapT6BYhnlygGwMoYj4DIQoB
X-Received: by 2002:aa7:92c1:: with SMTP id k1mr12644414pfa.246.1553310636929;
        Fri, 22 Mar 2019 20:10:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaQBYQVE+rBTbbM/4N9zt77L0Z6d3Cb86iiCeKDkeSMBO2Jr+PeFfhuLGZdayorkX3m7A03g==
X-Received: by 2002:aa7:92c1:: with SMTP id k1mr12644395pfa.246.1553310636722;
        Fri, 22 Mar 2019 20:10:36 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id b8sm10222491pgq.33.2019.03.22.20.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:10:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: spi: fix a potential NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190310075735.3392-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:10:36 -0500
Cc:     pakki001@umn.edu, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Wei Liu <wei.liu2@citrix.com>, Joe Perches <joe@perches.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5465C285-BE0C-4FEF-B732-18B5A8F44C8D@umn.edu>
References: <20190310075735.3392-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 10, 2019, at 1:57 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> 
> In case alloc_workqueue fails to allocate the work queue and
> returns NULL, the fix releases the resources and returns
> -ENOMEM.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/net/can/spi/mcp251x.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index e90817608645..2737b9a20dfe 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -962,6 +962,14 @@ static int mcp251x_open(struct net_device *net)
> 
> 	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
> 				   0);
> +	if (unlikely(!priv->wq)) {
> +		dev_err(&spi->dev, "failed to allocate work queue\n");
> +		mcp251x_power_enable(priv->transceiver, 0);
> +		close_candev(net);
> +		ret = -ENOMEM;
> +		goto open_unlock;
> +	}
> +

Can someone review this patch?


> 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
> 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
> 
> -- 
> 2.17.1
> 

