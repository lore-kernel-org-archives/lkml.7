Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C94120855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LTHZLeSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfDDLcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:32:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34089 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfDDLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:32:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so1388444qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SBbFV1QAq5JTIyQLfkIpk5gWtE+FjIbvYNO5CHm6/Y8=;
        b=LTHZLeSxTPViTlAy/Evaor2kDkZCufeWEul3E4CCjj6R95lSeMX1LpE514BmvMyara
         eRjC74Alm5Y4xpsZB76SctI1g4Hh4kmwR2D30KlDeEwvnUtkNaFUMSRnRCR+pNXuhhen
         AdwhlLeEcVoWMwp+/oaw55S0Ky86hPR7DDppPgRTE4UQ7hgXWwK9D3EIf7m/PlHIQ0Tx
         FmeAK4b+Vm1EKaBdcZDuifkG/S3izuLX1Ge1wNfQ3BVL4dgbMtSsN+FJmgDyImpXPUG7
         Cc0Yl9I+Gf9y+mAUMcyD6Ez1wrOGI1JexOzxTMxYRPCiu/kOOCeafu3/ux/RzEYdOnFh
         noIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBbFV1QAq5JTIyQLfkIpk5gWtE+FjIbvYNO5CHm6/Y8=;
        b=oGTfTpYPb+Z1SwjZCiHHQ8g77/jjXlg8TQcquqXYVe4LKYbTpwEBJ+lL0Te7MB+zju
         AIks+zEirVNZdZLrBysRDlySm2cwKmU51N36n7/udLxKrg4hCpyIGb3s9MpwESNPd5iz
         n7/ntpoHaRGXsPAC/FOZfiwAL/xCe0B/QEG4g2W6ZYLyPdys8DHL6bffg8GdeLoSWDGL
         Ukcs0nUkmkus5Te/jEeleNitqrUu1YCVIdCTpjAYEsDVv7rK2nu852eG4AEFXwjm2cMZ
         p84Ev/cDo33C6TRFN+jZJU2d0ahGVZ1BDj8jsRS8MfUbxhy4/bHMqLNQdU1b5n1vxcdy
         TPKA==
X-Gm-Message-State: APjAAAV3euzTUa09YZzTsh7WIdbtiwINtg+QWgfBm8ZBcAV1OcF6x0si
        qOdXFmqyTAJRPfTwxkrUXduVPw==
X-Google-Smtp-Source: APXvYqxzL7SUdlzQdKMcoahnxobXJgUv+3zsgmm277Z/Fmt5WwPdJQJFL0sxdNh8SOpoxp1vxLP0JA==
X-Received: by 2002:a37:9f11:: with SMTP id i17mr4671580qke.47.1554377535460;
        Thu, 04 Apr 2019 04:32:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id p6sm12261503qtk.70.2019.04.04.04.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:32:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hC0bN-00014S-OT; Thu, 04 Apr 2019 08:32:13 -0300
Date:   Thu, 4 Apr 2019 08:32:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Colin King <colin.king@canonical.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] opa_vnic: fix check on record->event, incorrect
 operator used
Message-ID: <20190404113213.GA2798@ziepe.ca>
References: <20190404100439.19696-1-colin.king@canonical.com>
 <fb140949-383e-731b-95b1-c75c2f85dadd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb140949-383e-731b-95b1-c75c2f85dadd@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:23:45AM -0400, Dennis Dalessandro wrote:
> On 4/4/2019 6:04 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The check on record->event is always true because the wrong operator
> > is being used, used && instead of ||
> > 
> > Addresses-Coverity: ("Constant expression result")
> > Fixes: fae7a699a925 ("opa_vnic: Convert vport_idr to XArray")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >   drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> > index 76cd09410d9a..be5befd92d16 100644
> > +++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> > @@ -869,7 +869,7 @@ static void opa_vnic_event(struct ib_event_handler *handler,
> >   	      record->event, dev_name(&record->device->dev),
> >   	      record->element.port_num);
> > -	if (record->event != IB_EVENT_PORT_ERR ||
> > +	if (record->event != IB_EVENT_PORT_ERR &&
> >   	    record->event != IB_EVENT_PORT_ACTIVE)
> >   		return;
> > 
> 
> Missed this in code review. Thanks!
> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Applied to for-next, thanks

Jason
