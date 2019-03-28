Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E651C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553784769;
	bh=rIJTOrRSephfoMdltM2zLSL7p2nSZdpbqc1Y3NRNJcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W2+TdJtCD01L2FhS3iFxQV/36OA8inmNOQC/glehgcncrP0Ab67Yf9Oq3ylAbHqGt
	 2jWdKLHVbSGGk6LnfbKdiOBIo0O9AqY8tIzz7EFqG8708hC0zXWiJpHBsbMypnu8dV
	 +2/KaiLXmGEWl1AC0Ms9+mQ5RkeCT+L6hZIB6nj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Ows (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:52:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43481 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfC1Owr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:52:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so1198269oig.10;
        Thu, 28 Mar 2019 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E911CWzs/+2n77dTZmEFdqRla0C817VcK6z4wkGgNjU=;
        b=bFN1/jw5yU1NwZj3Hnv0+T+0jskuXpCSio8cZsdaa3bNN1ZJZa3CVZ4HxxFGSfuY0k
         a1uMO2Aj+Y0rH0B33z2LWWPH5q4YmCwn0k6EuiAM08kTTCVC6x4f60vGXtVcglzf7/K1
         igmeNN/i007roNC0YLthND1tUyOXkosVdiNwKBPh6rA7ROH7Nt97s0Q3KAibWdw4DUCT
         hsOzP6HrzrLcTt8jW0Lw9R9SCoTnY6h+KL0EdYiR7Zk+T4fYJolqeGinU2DB7XxGWC9a
         PKMpce4lR8BrkPmpGVtadv2PKDIvd3du0CyeRmWwsxneshlbe/lSJci7SgrH+0vhred+
         geuQ==
X-Gm-Message-State: APjAAAUHZ9lJvmkl0OCykAzTyPPD6+DvtW0BdFDp7FqL+VuLfm2sp6AX
        alko8gFHXnT6VOYDZkXRDfWdhERpXBqdfBEW6mQ=
X-Google-Smtp-Source: APXvYqw74uuVq0bIutSLeQ3Rw2vwV3A1OuOal5mMpnwnuxna27ygsfSVR6nrg1Ss5ZxPBqujxWG5HcIuJtFdNR2GtbY=
X-Received: by 2002:aca:355:: with SMTP id 82mr314837oid.30.1553784766711;
 Thu, 28 Mar 2019 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com> <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com> <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
 <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
In-Reply-To: <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Mar 2019 15:52:35 +0100
Message-ID: <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Petr,
> > >
> > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > > > > Add two convenience functions for accessing node's parents:
> > > > >
> > > > > fwnode_count_parents() returns the number of parent nodes a given node
> > > > > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > > > > from the node itself.
> > > > >
> > > > > Also reorder fwnode_get_parent() in property.c according to the same order
> > > > > as in property.h.
> > > > >
> > > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > > index 8b91ab380d14..61eb6ceacc3f 100644
> > > > > --- a/drivers/base/property.c
> > > > > +++ b/drivers/base/property.c
> > > > > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > > > >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > > > >
> > > > >  /**
> > > > > - * fwnode_get_parent - Return parent firwmare node
> > > > > - * @fwnode: Firmware whose parent is retrieved
> > > > > + * fwnode_count_parents - Return the number of parents a node has
> > > > > + * @fwnode: The node the parents of which are to be counted
> > > > >   *
> > > > > - * Return parent firmware node of the given node if possible or %NULL if no
> > > > > - * parent was available.
> > > > > + * Returns the number of parents a node has.
> > > > >   */
> > > > > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > > > > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> > > > >  {
> > > > > -   return fwnode_call_ptr_op(fwnode, get_parent);
> > > > > +   unsigned int count;
> > > > > +
> > > > > +   fwnode_handle_get(fwnode);
> > > > > +
> > > > > +   for (count = 0; fwnode; count++)
> > > > > +           fwnode = fwnode_get_next_parent(fwnode);
> > > >
> > > > Is it guaranteed that all parents stay when
> > > > fwnode_get_next_parent() releases the reference count
> > > > for each counted member?
> > >
> > > fwnode_get_next_parent() only releases the child node after it has acquired
> > > the parent. The only implementation with refcounting for single nodes is
> > > actually OF.
> > >
> > > >
> > > > > +
> > > > > +   return count - 1;
> > > >
> > > > We could start counting from count = -1;
> > >
> > > We could, but then count would need to be made signed (unless overflowing
> > > is preferred instead).
> >
> > What if there are no parents?
> >
> > Or is it guaranteed that there always will be at least one?
>
> If there are no parents, the function will return 0 --- the node itself is
> counted in the loop, too, hence the need to decrement by one.

Right, sorry.

Then I don't see why count cannot be int.  Or call it "iter" to avoid
confusion with negative "counts". :-)
