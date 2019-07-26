Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC78C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B9520449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149687;
	bh=FVYNxjJLl/W5Dert07lPwnlV/q5+htxqU2YZhMN4tVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QW5c0THwadYf1xaOWZZWZQIgbr8qwTUu6V5KEUMUgGF9NJxF5iKcbm7u/sHkW+XEV
	 p6AqE8zvY2p3Wg5bVp/10AKJDDUomn0+ErMXpkYKaZHTSWb8b7CxTotVsTDIdBUz/n
	 yCBJ1cAqM09CmVvX2I9D2IfvKuA+Rk5z/nK9LZtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbfGZOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388797AbfGZOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:01:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5712420659;
        Fri, 26 Jul 2019 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564149681;
        bh=FVYNxjJLl/W5Dert07lPwnlV/q5+htxqU2YZhMN4tVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOFvSAqxJtYLjDKCpiywPR/Hj9HyVEoup//WBMEY/mfHLkp6x8koAmiOwLlmv5j9g
         d7eEUcC+sk7AlJo5/EO6o57O26KLm1D/D101VmY6rnW5jBO60Mh5FdXduz7Lu320y9
         0eMqTheDx3jighRHdszCAdnWVz/haxkmtwIMqmMA=
Date:   Fri, 26 Jul 2019 16:01:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Chang, Junxiao" <junxiao.chang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Li, Lili" <lili.li@intel.com>
Subject: Re: [PATCH] platform: release resource itself instead of resource
 tree
Message-ID: <20190726140118.GA23143@kroah.com>
References: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
 <20190725133850.GB11115@kroah.com>
 <840F6BCBBBA89F46BAD0D7D6EF39E6E350F5072A@SHSMSX107.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840F6BCBBBA89F46BAD0D7D6EF39E6E350F5072A@SHSMSX107.ccr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Jul 26, 2019 at 10:24:22AM +0000, Chang, Junxiao wrote:
> Hi Greg,
> 
> Thank you for looking at it.
> 
> Below example is simplified description. Our detail problem is:
> 1. ACPI driver registers a MEM resource during bootup;
> 2. Our PUNIT(Intel CPU power management module) platform device reads ACPI driver's resource, and registers same MEM resource;
> 3. According to current resource management logic, if two resources are same, later registered resource will be parent. That is, PUNIT platform device's resource will be ACPI driver resource's parent.
> 4. PUNIT kernel module is removed, its resource will be removed. If we use original API "release_resource", ACPI driver's resource will be released as well because it is PUNIT device's child;

Why did you remove this module?  That never happens unless you do it "by
hand", and as root.  Just don't do this if it causes problems in your
system, right?

Anyway, if you create a child reference you should always clean up all
of your children before removing yourself from memory.  So try fixing
that up first.

> 5. Next time PUNIT platform device kernel module is inserted, it might read wrong ACPI MEM resource because it has been released in step 4.
> 
> How should we handle this case? :) 

Don't unload kernel modules unless you know what you are doing :)

Seriously, you are creating a dependancy here that you are not
expressing in your module reference count, and you are not properly
cleaning up after yourself when removing your devices.  Just delete your
child devices when unloading yourself and you should be fine, right?

> We should not register same MEM resource in step 2? Or, make change in
> resource management logic, if two resources are same, later registered
> resource should be child instead of parent?

I don't know how your resource management logic works, try working with
the developers who wrote that.  But as you describe it, it is not
correct at least when you try to clean things up.

thanks,

greg k-h
