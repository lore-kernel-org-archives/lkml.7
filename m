Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02958C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31852173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FePPX7KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfC1MlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:41:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41219 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfC1Mkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:40:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so22803716qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6DVhwVJVFnt/qR4NlkKVT65qRRUJH/QGAgjVa2FWik=;
        b=FePPX7KEZtkAEVcVUuaJOEfFh5B5964j80qC0PIp8z5Xr1ymm4bQRTz5WjTp1CmXpP
         N8toA7mxM+En8DxcOULVQhPrpb+m6z3u3qj2fiwvT1X74du+INo/nPHQ2PAugpLHdgaP
         3zyNtH6uTakMyWICzpVjERZVthHh3pn5RRMFZUrk/DL+28kH5oLJRJISw5mji/xsfem/
         wbfR8X59ygGBj2kaa6VdBUdVE4lEjlRqkQb2qW0O8/qXl86HI25mXSBvdtdUSqMhuHwz
         1vMvee2bhH65sFtUesP8yBUKcwNgeSmlMHAvFcihWPzAJw7BE1MMQJJDqNrwzMYxI0vA
         WnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6DVhwVJVFnt/qR4NlkKVT65qRRUJH/QGAgjVa2FWik=;
        b=YSonN3qWMOTnCTUsam+bIR3+bWl/yypPMd//YyFmtjzLg1ZmAd5F/i8bMlNK5gMbhI
         jpAhFcsSPqvp5u5ovXystcSKIb2gbS1i7U8UYjlzLSbpDN3Pp87T4Om3y8VX3Afp6zXt
         Los0TG+KVXNnXgDTXpt74dyJnvrJKuKravUTQ6OzFBZ9ci1FUOM1LtFrCw9a394oePIU
         29tsJ8/QhbDyoWRdo77O/budYAA3qNDLUOfCmncO0O8g6nvIrBxkpYwhg2gKhDKkyAPs
         JJkLA35sBlUjqsNabuwbJvdQQv+VBj0VbGCL/uMU32VBGGQId4Vm1MpT4W+j/akOt1aq
         rpvg==
X-Gm-Message-State: APjAAAVz7qRZQBognISqX2L1TcjMHJ6UaLdCKSFFux/DZQ8IJQ44hLbw
        KDT62aJjXfgPps622wfJhYZ6LA==
X-Google-Smtp-Source: APXvYqycz/huoW2ngU/SymzdNjh5ZCLoEirqJ1MXpqB9bzALdBeGbmlWP6iDor3/QUo+2M6hfCAGPA==
X-Received: by 2002:a0c:e5c7:: with SMTP id u7mr35964941qvm.44.1553776845468;
        Thu, 28 Mar 2019 05:40:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id w127sm14775948qka.46.2019.03.28.05.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 05:40:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h9UKj-0007DO-V3; Thu, 28 Mar 2019 09:40:37 -0300
Date:   Thu, 28 Mar 2019 09:40:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, "pakki001@umn.edu" <pakki001@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
Message-ID: <20190328124037.GJ21008@ziepe.ca>
References: <20190309051921.15212-1-kjlu@umn.edu>
 <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
 <20190327133728.GA26660@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327133728.GA26660@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:08:54PM +0530, Potnuri Bharat Teja wrote:
> On Saturday, March 03/23/19, 2019 at 08:07:46 +0530, Kangjie Lu wrote:
> > 
> > 
> > > On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
> > > 
> > > get_skb may fail and return NULL. The fix returns "ENOMEM"
> > > when it fails to avoid NULL dereference.
> > > 
> > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > drivers/infiniband/hw/cxgb4/cm.c | 3 +++
> > > 1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > > index 8221813219e5..502a54d57e2c 100644
> > > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > > @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
> > > 	int win;
> > > 
> > > 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> > > +	if (!skb)
> > > +		return -ENOMEM;
> > > +
> > 
> > Can someone review this patch? Thanks.
> 
> Sorry for the late response.
> I recommend an error print before the return.
> if (!skb) {
> 	pr_err("%s - failed to alloc skb\n", __func__);
> 	return -ENOMEM;
> }

no error prints on memory allocation failure, the kernel already
prints enough on this

Jason
