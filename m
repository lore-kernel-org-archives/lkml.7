Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B72C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC8C206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfDLLkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:40:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:50523 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfDLLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:40:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163784579"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Apr 2019 04:40:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 12 Apr 2019 14:40:16 +0300
Date:   Fri, 12 Apr 2019 14:40:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 04/12] software node: Implement .get_reference_args
 fwnode operation
Message-ID: <20190412114016.GB25743@kuha.fi.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
 <20190410152505.87041-5-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jTR6TqMxRoRhBzG8Rf8JgGfriuCLsGKBYxjBOZz_7yBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jTR6TqMxRoRhBzG8Rf8JgGfriuCLsGKBYxjBOZz_7yBA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 10:48:41AM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 10, 2019 at 5:26 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > This makes it possible to support drivers that use
> > fwnode_property_get_reference_args() function.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/base/swnode.c | 56 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 39b8f8f35cfe..d6a9b56cb073 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -534,6 +534,61 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
> >         return NULL;
> >  }
> >
> > +static int
> > +software_node_get_reference_args(const struct fwnode_handle *fwnode,
> > +                                const char *propname, const char *nargs_prop,
> > +                                unsigned int nargs, unsigned int index,
> > +                                struct fwnode_reference_args *args)
> > +{
> > +       struct software_node *swnode = to_software_node(fwnode);
> > +       struct software_node_reference *ref;
> > +       const struct property_entry *prop;
> > +       int ret = -ENOENT;
> > +       int i;
> > +
> > +       mutex_lock(&swnode->lock);
> > +
> > +       if (!swnode || list_empty(&swnode->references))
> > +               goto err_unlock;
> > +
> > +       if (nargs_prop) {
> > +               prop = property_entry_get(swnode->properties, nargs_prop);
> > +               if (!prop) {
> > +                       ret = -EINVAL;
> > +                       goto err_unlock;
> > +               }
> > +
> > +               nargs = prop->value.u32_data;
> > +       }
> > +
> > +       if (nargs > NR_FWNODE_REFERENCE_ARGS) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
note

> > +               ret = -EINVAL;
> > +               goto err_unlock;
> > +       }
> > +
> > +       list_for_each_entry(ref, &swnode->references, list) {
> > +               if (strcmp(ref->name, propname))
> > +                       continue;
> > +
> > +               if (index > (ref->nrefs - 1))
> > +                       break;
> > +
> > +               args->nargs = nargs;
> > +               args->fwnode = software_node_get(ref->args[index].fwnode);
> > +
> > +               for (i = 0; i < nargs; i++)
> > +                       args->args[i] = ref->args[index].args[i];
> 
> If nargs is provided by the caller, can't it be greater than the
> number of args[index].args[] entries?

No. They have NR_FWNODE_REREFECE_ARGS elements, and we check above
that nargs is not greater then that.


thanks,

-- 
heikki
