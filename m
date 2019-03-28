Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5B621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfC1OV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:21:26 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:37054 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfC1OV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:21:26 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x2SEKNuJ001529;
        Thu, 28 Mar 2019 07:20:25 -0700
Date:   Thu, 28 Mar 2019 19:50:23 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kangjie Lu <kjlu@umn.edu>, "pakki001@umn.edu" <pakki001@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
Message-ID: <20190328142022.GA13931@chelsio.com>
References: <20190309051921.15212-1-kjlu@umn.edu>
 <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
 <20190327133728.GA26660@chelsio.com>
 <20190328124037.GJ21008@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328124037.GJ21008@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 03/28/19, 2019 at 18:10:37 +0530, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2019 at 07:08:54PM +0530, Potnuri Bharat Teja wrote:
> > On Saturday, March 03/23/19, 2019 at 08:07:46 +0530, Kangjie Lu wrote:
> > > 
> > > 
> > > > On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
> > > > 
> > > > get_skb may fail and return NULL. The fix returns "ENOMEM"
> > > > when it fails to avoid NULL dereference.
> > > > 
> > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > drivers/infiniband/hw/cxgb4/cm.c | 3 +++
> > > > 1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > > > index 8221813219e5..502a54d57e2c 100644
> > > > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > > > @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
> > > > 	int win;
> > > > 
> > > > 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> > > > +	if (!skb)
> > > > +		return -ENOMEM;
> > > > +
> > > 
> > > Can someone review this patch? Thanks.
> > 
> > Sorry for the late response.
> > I recommend an error print before the return.
> > if (!skb) {
> > 	pr_err("%s - failed to alloc skb\n", __func__);
> > 	return -ENOMEM;
> > }
> 
> no error prints on memory allocation failure, the kernel already
> prints enough on this
Ok.

Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
