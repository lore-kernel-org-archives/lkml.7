Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C052075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553561092;
	bh=8SUfUE5nuZ1q7O+shWBJjUmIu7S7n/I9P2djfmaQFt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=le+UOuqsZnUQkfJKalKUItgk9CUSQfL8hdGvI/cQH7hBK+tusH8ugBCWyo450QuYK
	 sTOlfAgFCQIJm1RzHfc2d7FCdrHDP525C1yDiEKlaebRvwKtIJsyUkqlR7xV70s/Ii
	 u77YNCVAYkvYDH2FK7wD7fu25b7sY7wU4lvGiUWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfCZAov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCZAov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:44:51 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AF62080F;
        Tue, 26 Mar 2019 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553561090;
        bh=8SUfUE5nuZ1q7O+shWBJjUmIu7S7n/I9P2djfmaQFt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgwcYj/MtOYsZSRSAQZJZmAOXrcAJWxN8DvslHezaJxGGppnUH9hg0WRn3OC3rd+5
         CIOEoiA2anJiXnkvhlqLHbwgOEBeE0v9dkEPNPK1g+exjlciJPASiI196sSYfbfeMa
         j1gLzdLm1hOYZFHXDyJli5H+H3Cii/Zz4DKCVJOY=
Date:   Tue, 26 Mar 2019 09:43:51 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 25/27] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20190326004351.GA26712@kroah.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-26-matthewgarrett@google.com>
 <20190326003137.GB5112@kroah.com>
 <CACdnJus6a_7VUR27K7dJE037b3TPwDNMh1AyAOptHepB18vjxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJus6a_7VUR27K7dJE037b3TPwDNMh1AyAOptHepB18vjxw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:38:09PM -0700, Matthew Garrett wrote:
> On Mon, Mar 25, 2019 at 5:35 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Mar 25, 2019 at 03:09:52PM -0700, Matthew Garrett wrote:
> > > Normal device interaction should be done through configfs, sysfs or a
> > > miscdev, not debugfs.
> >
> > Then why not just not allow debugfs at all if it is such a "big
> > problem"?
> 
> Previous attempts to do so have resulted in strong pushback from
> various maintainers. If you're happy just having any complaints
> reassigned to you then I'm more than happy to turn it off entirely.

Sure, send them my way :)
