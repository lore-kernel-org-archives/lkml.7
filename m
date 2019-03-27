Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA738C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CBB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfC0Nj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:39:59 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:34294 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfC0Nj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:39:58 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x2RDctrM026024;
        Wed, 27 Mar 2019 06:38:55 -0700
Date:   Wed, 27 Mar 2019 19:08:54 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
Message-ID: <20190327133728.GA26660@chelsio.com>
References: <20190309051921.15212-1-kjlu@umn.edu>
 <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 03/23/19, 2019 at 08:07:46 +0530, Kangjie Lu wrote:
> 
> 
> > On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
> > 
> > get_skb may fail and return NULL. The fix returns "ENOMEM"
> > when it fails to avoid NULL dereference.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/infiniband/hw/cxgb4/cm.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > index 8221813219e5..502a54d57e2c 100644
> > --- a/drivers/infiniband/hw/cxgb4/cm.c
> > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
> > 	int win;
> > 
> > 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> 
> Can someone review this patch? Thanks.

Sorry for the late response.
I recommend an error print before the return.
---
if (!skb) {
	pr_err("%s - failed to alloc skb\n", __func__);
	return -ENOMEM;
}
---
Thanks for the patch!
- Bharat.
> 
> > 	req = __skb_put_zero(skb, sizeof(*req));
> > 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
> > 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
> > -- 
> > 2.17.1
> > 
> 
