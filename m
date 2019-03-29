Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F4E218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfC2XC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:02:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52674 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfC2XC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:02:26 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 6c13e98e850288f5; Sat, 30 Mar 2019 00:02:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing node's parents
Date:   Sat, 30 Mar 2019 00:00:21 +0100
Message-ID: <4059126.EBkttauCCI@aspire.rjw.lan>
In-Reply-To: <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com> <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com> <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 29, 2019 2:15:07 PM CET Sakari Ailus wrote:
> On Thu, Mar 28, 2019 at 03:52:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Petr,
> > > > >
> > > > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > > > > > > Add two convenience functions for accessing node's parents:
> > > > > > >
> > > > > > > fwnode_count_parents() returns the number of parent nodes a given node
> > > > > > > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > > > > > > from the node itself.
> > > > > > >
> > > > > > > Also reorder fwnode_get_parent() in property.c according to the same order
> > > > > > > as in property.h.
> > > > > > >
> > > > > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > > > > index 8b91ab380d14..61eb6ceacc3f 100644
> > > > > > > --- a/drivers/base/property.c
> > > > > > > +++ b/drivers/base/property.c
> > > > > > > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > > > > > >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > > > > > >
> > > > > > >  /**
> > > > > > > - * fwnode_get_parent - Return parent firwmare node
> > > > > > > - * @fwnode: Firmware whose parent is retrieved
> > > > > > > + * fwnode_count_parents - Return the number of parents a node has
> > > > > > > + * @fwnode: The node the parents of which are to be counted
> > > > > > >   *
> > > > > > > - * Return parent firmware node of the given node if possible or %NULL if no
> > > > > > > - * parent was available.
> > > > > > > + * Returns the number of parents a node has.
> > > > > > >   */
> > > > > > > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > > > > > > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> > > > > > >  {
> > > > > > > -   return fwnode_call_ptr_op(fwnode, get_parent);
> > > > > > > +   unsigned int count;
> > > > > > > +
> > > > > > > +   fwnode_handle_get(fwnode);
> > > > > > > +
> > > > > > > +   for (count = 0; fwnode; count++)
> > > > > > > +           fwnode = fwnode_get_next_parent(fwnode);
> > > > > >
> > > > > > Is it guaranteed that all parents stay when
> > > > > > fwnode_get_next_parent() releases the reference count
> > > > > > for each counted member?
> > > > >
> > > > > fwnode_get_next_parent() only releases the child node after it has acquired
> > > > > the parent. The only implementation with refcounting for single nodes is
> > > > > actually OF.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +   return count - 1;
> > > > > >
> > > > > > We could start counting from count = -1;
> > > > >
> > > > > We could, but then count would need to be made signed (unless overflowing
> > > > > is preferred instead).
> > > >
> > > > What if there are no parents?
> > > >
> > > > Or is it guaranteed that there always will be at least one?
> > >
> > > If there are no parents, the function will return 0 --- the node itself is
> > > counted in the loop, too, hence the need to decrement by one.
> > 
> > Right, sorry.
> > 
> > Then I don't see why count cannot be int.  Or call it "iter" to avoid
> > confusion with negative "counts". :-)
> 
> Another option would be changing where the counting starts --- the first
> parent. I.e.
> 
> fwnode = fwnode_get_parent(fwnode);
> 
> for (count = 0; fwnode; count++)
> 	fwnode = fwnode_get_next_parent(fwnode);
> 
> return count;

LGTM, thanks!

