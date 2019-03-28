Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71287C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F63121773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553765900;
	bh=z6eKA+vz9LV5DMmR05CRU/qLRr7UYcaF04ibNGvJgPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rlu6mkDMk3nSnlPykgzkiBKTrLAMbHCYi8Mv8dJXuofN2gwWRDsOvnRmDn5VsTHbt
	 aXwGpoIjAXCFsPe6FICQQ1yGLF0FjQsV3UvHQ/9VkhxlFAmLS0RIIja8QwkduRB40T
	 sdUxgzDetQnv9z6HfM9DA+tQ8//fPHpnLNVakSSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1JiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:38:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36449 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfC1JiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:38:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id o74so17695275ota.3;
        Thu, 28 Mar 2019 02:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ7fIl++RFJO6H6EfToIiHmaKT0kEj9tGqKMI0mv1Pc=;
        b=IPI2JZvqaY0ylStcMCmGlPmSKsyKlkKlmDnMLLj2rE8UZ8OFsm/E5mvxYCV7tVoCYe
         FY+Vo7UvXY+z7iR5Rq7WsrR+SWv+NoCkiAUyodVo0NilcM+Id+SKJQfPbBLNtkdcVi3U
         D4wZElifUJAJoPm/8yFUjnwxgKJaAfedwIs1F4l5F8lClrl87+C6XugLVAkxS+ukWKWa
         7abJrB7mJIPqw+aDRV98R87f2urckoBpKQoZctPWZxij4oS5y3gc3dV5T2cQm+SISIOr
         NDsPTtTEWuCuFXqy495s0R7O3TAwrc05Js73yF79Ec32ydAIMM7LyNTi+EJ8dPSE0OPg
         hssA==
X-Gm-Message-State: APjAAAWSgI0ywG7BOrHy34s4uVSZqETKXCHY4Ik1BD4NdatwrxVgrZt0
        Hv6DcwNIxHRSW36QrhIH1iyQYfcczHoLqwTuHiQ=
X-Google-Smtp-Source: APXvYqwQoSXi0PLziHB+9XcTmsVrIHU9Su7AS1RplysG33B8COs8gji+Nm0GkUh8DdPPETE9SxuxN8+5JSojr6Hz4os=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr30869903otl.343.1553765893121;
 Thu, 28 Mar 2019 02:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com> <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
In-Reply-To: <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Mar 2019 10:38:01 +0100
Message-ID: <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Petr,
>
> On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > > Add two convenience functions for accessing node's parents:
> > >
> > > fwnode_count_parents() returns the number of parent nodes a given node
> > > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > > from the node itself.
> > >
> > > Also reorder fwnode_get_parent() in property.c according to the same order
> > > as in property.h.
> > >
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index 8b91ab380d14..61eb6ceacc3f 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > >
> > >  /**
> > > - * fwnode_get_parent - Return parent firwmare node
> > > - * @fwnode: Firmware whose parent is retrieved
> > > + * fwnode_count_parents - Return the number of parents a node has
> > > + * @fwnode: The node the parents of which are to be counted
> > >   *
> > > - * Return parent firmware node of the given node if possible or %NULL if no
> > > - * parent was available.
> > > + * Returns the number of parents a node has.
> > >   */
> > > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> > >  {
> > > -   return fwnode_call_ptr_op(fwnode, get_parent);
> > > +   unsigned int count;
> > > +
> > > +   fwnode_handle_get(fwnode);
> > > +
> > > +   for (count = 0; fwnode; count++)
> > > +           fwnode = fwnode_get_next_parent(fwnode);
> >
> > Is it guaranteed that all parents stay when
> > fwnode_get_next_parent() releases the reference count
> > for each counted member?
>
> fwnode_get_next_parent() only releases the child node after it has acquired
> the parent. The only implementation with refcounting for single nodes is
> actually OF.
>
> >
> > > +
> > > +   return count - 1;
> >
> > We could start counting from count = -1;
>
> We could, but then count would need to be made signed (unless overflowing
> is preferred instead).

What if there are no parents?

Or is it guaranteed that there always will be at least one?
