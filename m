Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4B62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfC0OUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:20:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:60359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfC0OUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:20:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 07:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="156266525"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2019 07:20:38 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 310F0207E2; Wed, 27 Mar 2019 16:20:37 +0200 (EET)
Date:   Wed, 27 Mar 2019 16:20:37 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Message-ID: <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > Add two convenience functions for accessing node's parents:
> > 
> > fwnode_count_parents() returns the number of parent nodes a given node
> > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > from the node itself.
> > 
> > Also reorder fwnode_get_parent() in property.c according to the same order
> > as in property.h.
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 8b91ab380d14..61eb6ceacc3f 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> >  
> >  /**
> > - * fwnode_get_parent - Return parent firwmare node
> > - * @fwnode: Firmware whose parent is retrieved
> > + * fwnode_count_parents - Return the number of parents a node has
> > + * @fwnode: The node the parents of which are to be counted
> >   *
> > - * Return parent firmware node of the given node if possible or %NULL if no
> > - * parent was available.
> > + * Returns the number of parents a node has.
> >   */
> > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> >  {
> > -	return fwnode_call_ptr_op(fwnode, get_parent);
> > +	unsigned int count;
> > +
> > +	fwnode_handle_get(fwnode);
> > +
> > +	for (count = 0; fwnode; count++)
> > +		fwnode = fwnode_get_next_parent(fwnode);
> 
> Is it guaranteed that all parents stay when
> fwnode_get_next_parent() releases the reference count
> for each counted member?

fwnode_get_next_parent() only releases the child node after it has acquired
the parent. The only implementation with refcounting for single nodes is
actually OF.

> 
> > +
> > +	return count - 1;
> 
> We could start counting from count = -1;

We could, but then count would need to be made signed (unless overflowing
is preferred instead).

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
