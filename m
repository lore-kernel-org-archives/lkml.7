Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D613C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39F52075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hlN9OyIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCLPBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:01:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33393 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfCLPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:01:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id z39so2913836qtz.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ErdqKHK18Tk8nK2Np5nMnkY1oJcMXq4/vBBdKNs+Xdw=;
        b=hlN9OyIMG47Cc2e06xCkgQOCSse0ZVsbyJToGFamS5XN2ZksIUlmw+JB0TOaDf9tQY
         OGceAyx0Vy9AnJsI2QCiGCBxQyrV9W65Ivfs3lyvKb/v2ZDxWfbMHNImYClWV5/hxj4+
         JaUxtTLj9KlVpQMLYtB8a9qvwBUm/uRQGIA30JlD+MCl3oDvs8H4I3tHjKbDK4f2FpxH
         TqMU47PJzh2FdDfADXqOMVX5ESvxb841VeoD7wshB2QN+VQjuJ3JeVP/Nz95+mNXrKjv
         dPSVvLl8MpXJsaXXkui3rAKa9zq5VN1UlvTE6/BaSpw14IImsZeU9LrXDdKiSvRDvzW4
         dGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErdqKHK18Tk8nK2Np5nMnkY1oJcMXq4/vBBdKNs+Xdw=;
        b=lEhoNGK3gc+GbheUntlzpWq6TSX5zTDB1SPPUsU1A4dJQr5E6nInTCMobmlJa6YTSv
         RogOLAQ0U8ute5dLgcuu2qSXFDy5lsEIXzWRyTprnfvg+0GXrSvWDt93Axkczqhp3+fB
         d3IBYhCXgVioulTM+/OlI8mcwVXvs6n+PC4IlZvWWQRGbLoMSIVSIQ7bI/F9ZPdyYzZ8
         TseJaszgj0n7Q6NoBY2uPHzZmw6BgoylFOmk16CsMCBovo8Vhim3YcfbO5iuNPVgESaZ
         V81IymhCDFt+b3mUTzjGKkkvHo1vFmIGiQrbLFa9P+SdD8ti4ph7SWvUrovjKXVg3s8c
         iexA==
X-Gm-Message-State: APjAAAXIQ2OCv7Vay2ZtHsJZ92YrPFeVZsP6r0LzUtIjwvOD+YTlt8hB
        2PIvASk5tYIszQf4fmeC+HtDcTgnDAuTsw==
X-Google-Smtp-Source: APXvYqwVMOdBIJbwWhKbM6CpKEOWUwFezgLmsZj59Q7a7eY/3cO37jqF9aaQ9qBvQM+DMEdZiJ+f6g==
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr31255773qvc.239.1552402874041;
        Tue, 12 Mar 2019 08:01:14 -0700 (PDT)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id j34sm5255144qte.49.2019.03.12.08.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:01:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h3iu0-0007Zx-61; Tue, 12 Mar 2019 12:01:12 -0300
Date:   Tue, 12 Mar 2019 12:01:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: i40iw: fix potential NULL pointer
 dereferences
Message-ID: <20190312150112.GA29101@ziepe.ca>
References: <20190309052750.16139-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309052750.16139-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 11:27:50PM -0600, Kangjie Lu wrote:
> alloc_ordered_workqueue may fail and return NULL. Let's check
> its return value to ensure it is not NULL so as to avoid
> potential NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> index 206cfb0016f8..ad9b4f235e30 100644
> +++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> @@ -3256,9 +3256,21 @@ void i40iw_setup_cm_core(struct i40iw_device *iwdev)
>  
>  	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
>  						    WQ_MEM_RECLAIM);
> +	if (!cm_core->event_wq) {
> +		i40iw_debug(cm_core->dev,
> +				I40IW_DEBUG_CM,
> +				"%s allocate event work queue failed\n",
> +				__func__);
> +	}
>  
>  	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
>  						      WQ_MEM_RECLAIM);
> +	if (!cm_core->disconn_wq) {
> +		i40iw_debug(cm_core->dev,
> +				I40IW_DEBUG_CM,
> +				"%s allocate disconnect work queue failed\n",
> +				__func__);
> +	}
>  }

Same no as the mlx patches - handle the error or don't bother

Jason
