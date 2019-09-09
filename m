Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80621C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D4020828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQAA0ZH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfIINsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:48:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39255 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfIINsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:48:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so354081pfa.6;
        Mon, 09 Sep 2019 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBNE2kx800LnETQB7T7a8ghmuVEs85XpfEEauS23rlY=;
        b=jQAA0ZH9kX4X+OGD7x+3SiChxzRIQn06JGYz0297S06/HeZ16A7V952T640b1zHLYC
         dC+qIf9BX6BOec0wTNP1SOGWwMin06sZ1cyQxKpmepGYxP7MtEe+h/VB2qHjbB8FXrvR
         No8q9oHoQvxRVpx7v4uRIJwbrOLZTWqLwn/n9CfMJSOjDd7kPBQIJvzylxa3lCJ9djJs
         v0dvRBsPT3bcpeUdZqhjE7emE9AouOkiS94Nmhi9QKbeob7FAxIpBDGIFB1vcqODRRq6
         QxDLuiAT4N4ZOtfciImM86tLCrmSvH6LJGAtZ6PfTwSFAbvwSMo673lqn296N9wqAETG
         2pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBNE2kx800LnETQB7T7a8ghmuVEs85XpfEEauS23rlY=;
        b=I29BKjGYWMOzrMcIIUQtcBiqz+p7NseWkOJ5r1bYb3ZZctwynTnDALiDrr1oo/Sizn
         WhP0gAn/MsV1g8iF52qeYEAl+XaPBkGn91tM8IbuPTEyymgp50w4mbnjg7dZ5v0jnAwm
         tTfQe6ySt9vQLf3uxWaJpujAH/tHuhMqn2j17X/vbUWUiX9cPKD6FIbUbx2cN6WCXQ30
         lrh5xhb92/t/ukt6R3ztnKGT8HIxxRLkgFAhEpJz1cgG3yB5t+VHGtv1Xy0qY7uiECD7
         ZcBtRiGnwgIRhven9XY2YnQf6Xk8+jzkf4eg9q8z6o0JOONF5uRDCEM0knKLc0xizs5S
         hz0A==
X-Gm-Message-State: APjAAAV0Z2IfU7tqf7bjBv9Bk4kGC0QuCJmvZw4wlCUFgrHfOC7HbHLY
        Y5lexYK0OI19SrDbFyJirG8=
X-Google-Smtp-Source: APXvYqzT4ME55beiaYQljF+iK2ZoRRbGqON0nCabcct/0ML/fYvT51eiNy/0gBeFxCmd9yF4WS1xXQ==
X-Received: by 2002:a65:610a:: with SMTP id z10mr21998447pgu.178.1568036890314;
        Mon, 09 Sep 2019 06:48:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w26sm16575769pfi.140.2019.09.09.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 06:48:09 -0700 (PDT)
Date:   Mon, 9 Sep 2019 06:48:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 03/13] software node: get rid of property_set_pointer()
Message-ID: <20190909134807.GD145199@dtor-ws>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
 <20190909081557.93766-4-dmitry.torokhov@gmail.com>
 <20190909095505.GQ2680@smile.fi.intel.com>
 <20190909101555.GC145199@dtor-ws>
 <20190909113652.GX2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909113652.GX2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:36:52PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 09, 2019 at 03:15:55AM -0700, Dmitry Torokhov wrote:
> > On Mon, Sep 09, 2019 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 09, 2019 at 01:15:47AM -0700, Dmitry Torokhov wrote:
> > > > Instead of explicitly setting values of integer types when copying property
> > > > entries lets just copy entire value union when processing non-array values.
> > > > 
> > > > When handling array values assign the pointer there using the newly introduced
> > > > "raw" pointer union member. This allows us to remove property_set_pointer().
> > > 
> > > Is this reincarnation of 318a19718261?
> > > Have you read 63dcc7090137?
> > 
> > Okay, I think if I squash this and the followup patch to
> > property_get_data() then we'll only go through the "raw" pointer to get
> > to the non-inline data and therefore we will not have the union aliasing
> > issue.
> > 
> > The in-line values never change their type when storing/accessing.
> 
> It might work, though it prevents to do type checking at compile time. So,
> basically something like
> 
> 	struct obscure_things {
> 		u8 *prop_array_val;
> 		bla bla bla
> 	};
> 
> 	struct property_entry entry;
> 	struct obscure_things things;
> 	...
> 	entry.pointer.raw = &things;
> 
> which shouldn't be possible.

I think type checking is a red herring as we still can't validate the
type. I believe the answer here is to not allow external users to poke
in property_entry and use PROPERTY_ENTRY_XXX macros to construct
entires, as I have done for the Apple EFI driver.

> 
> I dunno what others think about your proposal.


Thanks.

-- 
Dmitry
