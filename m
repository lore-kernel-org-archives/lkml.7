Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4865C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A942089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556782955;
	bh=TTKkqMKRnS10zsZ6GIqwWKgzc1iZ0VEa/3aFdwJHGaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sAyOzkeu4vQ1akv3G7VAbJPzAIqbSa+gCKBJkbPOTnt1Wct5SNh0V5Z6zuslJ9tyL
	 WE43JsIcaHhl0R7IVJtsg0mQRM8OvKqy/hcaLwU3tTeXXufGso02+3wIRFwNM1lAvi
	 2/kkVZUjo1/SofPmbh3bU5/aCp1PTK10T6qvJOeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBHme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfEBHmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:42:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 803A820873;
        Thu,  2 May 2019 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556782953;
        bh=TTKkqMKRnS10zsZ6GIqwWKgzc1iZ0VEa/3aFdwJHGaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMmPcHFJ5qPEdNk1wLQ95fxfpyanD5o8FTZCmJhD7Ml76a8Z6H2fEJ3qiuGXwl2RA
         a+5/V6a/gxtms62G4dmua1GFV5CRZbSumjLWfdA1WDCmCQwg+uRWU7NQSQHJgbrql4
         b4PTBSAx7/6Bb4cD4W50uBM2qGutKPgm3v7/4F5M=
Date:   Thu, 2 May 2019 09:42:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] livepatch: Do not manually track kobject
 initialization
Message-ID: <20190502074230.GA27847@kroah.com>
References: <20190502023142.20139-1-tobin@kernel.org>
 <20190502023142.20139-6-tobin@kernel.org>
 <20190502071232.GB16247@kroah.com>
 <20190502073044.bfzugymrncnaajxe@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502073044.bfzugymrncnaajxe@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 09:30:44AM +0200, Petr Mladek wrote:
> On Thu 2019-05-02 09:12:32, Greg Kroah-Hartman wrote:
> > On Thu, May 02, 2019 at 12:31:42PM +1000, Tobin C. Harding wrote:
> > > Currently we use custom logic to track kobject initialization.  Recently
> > > a predicate function was added to the kobject API so we now no longer
> > > need to do this.
> > > 
> > > Use kobject API to check for initialized state of kobjects instead of
> > > using custom logic to track state.
> > > 
> > > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > > ---
> > >  include/linux/livepatch.h |  6 ------
> > >  kernel/livepatch/core.c   | 18 +++++-------------
> > >  2 files changed, 5 insertions(+), 19 deletions(-)
> > > 
> > > @@ -626,7 +626,7 @@ static void __klp_free_objects(struct klp_patch *patch, bool nops_only)
> > >  		list_del(&obj->node);
> > >  
> > >  		/* Might be called from klp_init_patch() error path. */
> > > -		if (obj->kobj_added) {
> > > +		if (kobject_is_initialized(&obj->kobj)) {
> > >  			kobject_put(&obj->kobj);
> > >  		} else if (obj->dynamic) {
> > >  			klp_free_object_dynamic(obj);
> > 
> > Same here, let's not be lazy.
> > 
> > The code should "know" if the kobject has been initialized or not
> > because it is the entity that asked for it to be initialized.  Don't add
> > extra logic to the kobject core (like the patch before this did) just
> > because this one subsystem wanted to only write 1 "cleanup" function.
> 
> We use kobject for a mix of statically and dynamically defined
> structures[*]. And we misunderstood the behavior of kobject_init().

Eeek, no, a kobject should never be used for a static structure, that's
just wrong.

Well, almost wrong, ignore how the driver core itself does this in
places :)

thanks,

greg k-h
