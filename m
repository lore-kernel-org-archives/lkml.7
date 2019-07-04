Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F9C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7621882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562218863;
	bh=e8TNcyelEwd3uBfOzE7u6HsVzn4zKxUqsTBHoLp6L4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nmk6rTlemCui3Q58QzlbGEH1AIn1YZaxkTgujAWs9WKBTFfu9M7FkGGU58M3w9dyV
	 VCLbLXbDlBzbbHku1An3aH6ExtoYzaDexGAxpluSBzXntHXjL4L3RGHXmwnb8HINLK
	 /o3QpDFeOu+0JjNV8BPiOuGMEP5Ok80Q7abdvTCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfGDFlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDFlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:41:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9560221882;
        Thu,  4 Jul 2019 05:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562218861;
        bh=e8TNcyelEwd3uBfOzE7u6HsVzn4zKxUqsTBHoLp6L4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku0Y7hpoqBS6APNaFuh3irUgN47JKJr78lnWKhlsZ/VI6RkaVk4gAxP9dRYX+4n5k
         a80+L+oQbzZGypfwGACLFiIEHBXubXt5nBmKXobQHaZTmIOG4ioBNK4mXYKmYotUcF
         1Z9Mes4ZtNuHFHgEFGePG5+XzLuNJH0Wd/Ba2onk=
Date:   Thu, 4 Jul 2019 07:40:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Muchun Song <smuchun@gmail.com>, rafael@kernel.org,
        prsood@codeaurora.org, mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 OPT2] driver core: Fix use-after-free and double free
 on glue directory
Message-ID: <20190704054058.GC347@kroah.com>
References: <20190626144021.7249-1-smuchun@gmail.com>
 <20190703193606.GA8452@kroah.com>
 <319ae04497cf1982076bf801cfdf565046096fd4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319ae04497cf1982076bf801cfdf565046096fd4.camel@kernel.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:57:13AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2019-07-03 at 21:36 +0200, Greg KH wrote:
> > 
> > > -static struct kobject *get_device_parent(struct device *dev,
> > > -					 struct device *parent)
> > > +/**
> > > + * __get_device_parent() - Get the parent device kobject.
> > > + * @dev: Pointer to the device structure.
> > > + * @parent: Pointer to the parent device structure.
> > > + * @lock: When we live in a glue directory, should we hold the
> > > + *        gdp_mutex lock when this function returns? If @lock
> > > + *        is true, this function returns with the gdp_mutex
> > > + *        holed. Otherwise it will not.
> > 
> > Ugh, if you are trying to get me to hate one version of these patches,
> > this is how you do it :)
> > 
> > A function should not "sometimes takes a lock, sometimes does not,
> > depending on a parameter passed into it"  That way lies madness...
> 
> Yes, I prefer this approach to the fix but I dont like the patch either
> for the same reason...
> 
>  ...
> 
> > Anyway, this is a mess.
> > 
> > Ugh I hate glue dirs...
> 
> Amen...

Well, can we just remove them?  Who relies on them anymore?

thanks,

greg k-h
