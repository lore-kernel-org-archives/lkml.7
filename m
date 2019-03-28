Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eyIdRhVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1O0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:26:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35393 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfC1O0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:26:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so5956866qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSSJl5k+JHXJbUBMkVEY30j0tn+xj0+/g+GAmzVURx8=;
        b=eyIdRhVddDzLcAltkAXSsIe0M5Zz6R7DiWNOaWJAgakFtDUlAxSZcpPKUlCZXXXolJ
         86klGvD5SPsL+ZEc6dT0c4Rgjbom432Q3GPXWHUqbDQZ+lG+58EIIIzqiM6L3Z9ptxCK
         twxpXQCRK9neDt8H1FnrC1HguYTp6S+UHIwD/LsB1xvvn+nCunWwZc4lpttzNwkT/6bj
         C+ChfeunFary1JptX6hhG06MSKzyBlq2wQ1JseEcGYt6Ti7uQUtUnTSzfzOk/wLKGWyQ
         zkAeS8cuNaloiYYGgFUL96eikAB3R+7RYdLcgWnQcmGUvRsr2Z5Itjt5b/LySy5BGFq+
         i1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSSJl5k+JHXJbUBMkVEY30j0tn+xj0+/g+GAmzVURx8=;
        b=JPJCr1k6knI1OVIjmbneIE58GcgkVVyfNGFNPx3dMGJH+qB8kKY40I6LzMfcxqxMYF
         XQbsanquhjtToYZuB8mHAx+misexpz9ZIkRo7cWzmNdx0ft2L9XpMFjaejUckiCyeKFN
         Ty6R4kxvTnPIg4mzMlDRMtFBBXYqNYXJuHrkYBCMVuzP+kO06H9vms+gyeOZr1d1Pbsf
         rok+TvJYEblHVC/XxVtfiehJa9Ez48P1Uk3uGcDmLfxgZc8DSmetLRRIN1jhupNX64wW
         MdS5sS4Fjse6PjHGFwD9CEcnIgK3uQfd785LCkN1lgHRHTa3otjjgYF/by4UVxrLGR6S
         mYNQ==
X-Gm-Message-State: APjAAAU7pXrNJrU9oKFprd76e+HD8RP25QSihottH6LCQBOD6K48FFTx
        iiRjEduiJUnOYumJrQqjUklDng==
X-Google-Smtp-Source: APXvYqwgBQP7hG/fkiLQVL2rV9JAA0eLEwthlmWE9GOVIl/d/5+iv13/9Q2rP0C49uTjXpwiMIAmWA==
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr32793504qkf.107.1553783169526;
        Thu, 28 Mar 2019 07:26:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id m93sm945409qte.74.2019.03.28.07.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 07:26:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h9Vyp-0002OO-Mp; Thu, 28 Mar 2019 11:26:07 -0300
Date:   Thu, 28 Mar 2019 11:26:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, "pakki001@umn.edu" <pakki001@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
Message-ID: <20190328142607.GM21008@ziepe.ca>
References: <20190309051921.15212-1-kjlu@umn.edu>
 <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
 <20190327133728.GA26660@chelsio.com>
 <20190328124037.GJ21008@ziepe.ca>
 <20190328142022.GA13931@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328142022.GA13931@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:50:23PM +0530, Potnuri Bharat Teja wrote:
> On Thursday, March 03/28/19, 2019 at 18:10:37 +0530, Jason Gunthorpe wrote:
> > On Wed, Mar 27, 2019 at 07:08:54PM +0530, Potnuri Bharat Teja wrote:
> > > On Saturday, March 03/23/19, 2019 at 08:07:46 +0530, Kangjie Lu wrote:
> > > > 
> > > > 
> > > > > On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
> > > > > 
> > > > > get_skb may fail and return NULL. The fix returns "ENOMEM"
> > > > > when it fails to avoid NULL dereference.
> > > > > 
> > > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > > drivers/infiniband/hw/cxgb4/cm.c | 3 +++
> > > > > 1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > > > > index 8221813219e5..502a54d57e2c 100644
> > > > > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > > > > @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
> > > > > 	int win;
> > > > > 
> > > > > 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> > > > > +	if (!skb)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > 
> > > > Can someone review this patch? Thanks.
> > > 
> > > Sorry for the late response.
> > > I recommend an error print before the return.
> > > if (!skb) {
> > > 	pr_err("%s - failed to alloc skb\n", __func__);
> > > 	return -ENOMEM;
> > > }
> > 
> > no error prints on memory allocation failure, the kernel already
> > prints enough on this
> Ok.
> 
> Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>

It needs to be resent with Bart's comment addressed, and all the tags collected.

Jason
