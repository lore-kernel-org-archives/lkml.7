Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfC1LcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:32:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:27204 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1LcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:32:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 04:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126604879"
Received: from pmangere-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.62.244])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 04:32:00 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 24F2021E50; Thu, 28 Mar 2019 13:31:57 +0200 (EET)
Date:   Thu, 28 Mar 2019 13:31:56 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/6] device property: Add fwnode_get_name for
 returning the name of a node
Message-ID: <20190328113156.o5wfxcww5mphmd6i@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gUZaxyp0Hb228F_PuBhshmQ8v7VFYtv75oZg_Hpo8RTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUZaxyp0Hb228F_PuBhshmQ8v7VFYtv75oZg_Hpo8RTw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, Mar 28, 2019 at 10:45:57AM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 1:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > The fwnode framework did not have means to obtain the name of a node. Add
> > that now, in form of the fwnode_get_name() function and a corresponding
> > get_name fwnode op. OF and ACPI support is included.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
> >  drivers/base/property.c  | 11 +++++++++++
> >  drivers/of/property.c    |  6 ++++++
> >  include/linux/fwnode.h   |  2 ++
> >  include/linux/property.h |  1 +
> >  5 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 77abe0ec4043..8c9a4c02cde2 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1291,6 +1291,29 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> >                                                   args_count, args);
> >  }
> >
> > +static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
> > +{
> > +       const struct acpi_device *adev;
> > +       struct fwnode_handle *parent;
> > +
> > +       parent = fwnode_get_parent(fwnode);
> > +       /* Is this the root node? */
> > +       if (!parent)
> > +               return "\\";
> > +
> > +       fwnode_handle_put(parent);
> > +
> > +       if (is_acpi_data_node(fwnode)) {
> > +               const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
> > +
> > +               return dn->name;
> > +       }
> > +
> > +       adev = to_acpi_device_node(fwnode);
> > +
> > +       return adev ? acpi_device_bid(adev) : NULL;
> 
> I would do
> 
> if (WARN_ON(!adev))
>          return NULL;
> 
> return acpi_device_bid(adev);

Done.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
