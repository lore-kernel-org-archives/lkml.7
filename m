Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80923C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554A9208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561128319;
	bh=rsCDn3qBb6zALp8DkCiY9VjakZ7sbnF4v1lpfSmqIgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=duIWGxZ/u3Cdb6CNVMj32OPjRPaT8qITkWQi8iXTF2qz9+KbMPN+R2hXpyzvhKj0H
	 6AYj4hNr1aFq8MmDl94q0lT8RdrcJ5+DZ7e2HXgeQFj9KbmJLsid7Odg3UhS5jbslJ
	 9ZXIXDx+9wueWd1A0o+3HFwQUGSUAtRoCKIcbQSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFUOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFUOpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:45:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E23C2089E;
        Fri, 21 Jun 2019 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561128316;
        bh=rsCDn3qBb6zALp8DkCiY9VjakZ7sbnF4v1lpfSmqIgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pt1qnHiaVa94ao+grRWkTuG10JTHcF/bDa+54km7+h6lxQKR/RJXV2B/ayzRPSOl6
         gHvKhTBmlif7HvDupZb7a95DkOd45YJxEaqIiqIjBJczzcRmN8Ps8F6qVl4aFKvS59
         GMcApy5WNnDO6/3Up2lEoumpYwg+J9v59sZKmz2M=
Date:   Fri, 21 Jun 2019 16:45:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI/AER sysfs files violate the rules of how sysfs works
Message-ID: <20190621144514.GB6493@kroah.com>
References: <20190621072911.GA21600@kroah.com>
 <CACK8Z6GeAheLfmPcYXNnrTn1Rg7C-rndi_YCxiLsePapGCMmzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GeAheLfmPcYXNnrTn1Rg7C-rndi_YCxiLsePapGCMmzw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 07:08:38AM -0700, Rajat Jain wrote:
> On Fri, Jun 21, 2019, 12:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > Hi,
> >
> > When working on some documentation scripts to show the
> > Documentation/ABI/ files in an automated way, I ran across this "gem" of
> > a sysfs file: Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> >
> > In it you describe how the files
> > /sys/bus/pci/devices/<dev>/aer_dev_correctable and
> > /sys/bus/pci/devices/<dev>/aer_dev_fatal and
> > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > all display a bunch of text on multiple lines.
> >
> > This violates the "one value per sysfs file" rule, and should never have
> > been merged as-is :(
> >
> > Please fix it up to be a lot of individual files if your really need all
> > of those different values.
> >
> > Remember, sysfs files should never have to have a parser to read them
> > other than a simple "what is this single value", and you should NEVER
> > have fun macros like:
> >
> >         for (i = 0; i < ARRAY_SIZE(strings_array); i++) {               \
> >                 if (strings_array[i])                                   \
> >                         str += sprintf(str, "%s %llu\n",                \
> >                                        strings_array[i], stats[i]);     \
> >                 else if (stats[i])                                      \
> >                         str += sprintf(str, #stats_array "_bit[%d]
> > %llu\n",\
> >                                        i, stats[i]);                    \
> >         }                                                               \
> >         str += sprintf(str, "TOTAL_%s %llu\n", total_string,            \
> >                        pdev->aer_stats->total_field);                   \
> >
> > spit out sysfs information.
> >
> > Note, I am all for not properly checking the length of the sysfs file
> > when writing to it, but that is ONLY because you "know" that a single
> > integer will never overflow anything.  Here you are writing a ton of
> > different values, with no error checking at all.  So just when I thought
> > it couldn't be any worse...
> >
> > Please fix.
> >
> 
> My apologies. I will discuss with Bjorn and fix this.

thank you.  I'll be glad to review patches for this.

thanks,

greg k-h
