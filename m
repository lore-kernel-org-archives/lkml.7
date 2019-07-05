Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD48C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B1021852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGEBlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:41:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57257 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726871AbfGEBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:41:05 -0400
Received: (qmail 1325 invoked by uid 500); 4 Jul 2019 21:41:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Jul 2019 21:41:04 -0400
Date:   Thu, 4 Jul 2019 21:41:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
In-Reply-To: <20190704172435.GA11673@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1907042138091.840-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019, Suwan Kim wrote:

> On Mon, Jun 24, 2019 at 01:24:15PM -0400, Alan Stern wrote:
> > On Mon, 24 Jun 2019, Suwan Kim wrote:
> > 
> > > > > +	hcd->self.sg_tablesize = ~0;
> > > > > +	hcd->self.no_sg_constraint = 1;
> > > > 
> > > > You probably shouldn't do this, for two reasons.  First, sg_tablesize
> > > > of the server's HCD may be smaller than ~0.  If the client's value is
> > > > larger than the server's, a transfer could be accepted on the client
> > > > but then fail on the server because the SG list was too big.
> > 
> > On the other hand, I don't know of any examples where an HCD has 
> > sg_tablesize set to anything other than 0 or ~0.  vhci-hcd might end up 
> > being the only one.
> > 
> > > > Also, you may want to restrict the size of SG transfers even further,
> > > > so that you don't have to allocate a tremendous amount of memory all at
> > > > once on the server.  An SG transfer can be quite large.  I don't know 
> > > > what a reasonable limit would be -- 16 perhaps?
> > > 
> > > Is there any reason why you think that 16 is ok? Or Can I set this
> > > value as the smallest value of all HC? I think that sg_tablesize
> > > cannot be a variable value because vhci interacts with different
> > > machines and all machines has different sg_tablesize value.
> > 
> > I didn't have any good reason for picking 16.  Using the smallest value 
> > of all the HCDs seems like a good idea.
> 
> I also have not seen an HCD with a value other than ~0 or 0 except for
> whci which uses 2048, but is not 2048 the maximum value of sg_tablesize?
> If so, ~0 is the minimum value of sg_tablesize that supports SG. Then
> can vhci use ~0 if we don't consider memory pressure of the server?
> 
> If all of the HCDs supporting SG have ~0 as sg_tablesize value, I
> think that whether we use an HCD locally or remotely, the degree of
> memory pressure is same in both local and remote usage.

You have a lot of leeway.  For example, there's no reason a single SG
transfer on the client has to correspond to a single SG transfer on the
host.  In theory the client's vhci-hcd can break a large SG transfer up
into a bunch of smaller pieces and send them to the host one by one,
then reassemble the results to complete the original transfer.  That
way the memory pressure on the host would be a lot smaller than on the
client.

Alan Stern

