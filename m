Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE52C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A42087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="VYJEQOtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfD2G2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:28:01 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:43096
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbfD2G2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=XYOc3di3/FnOo+X1QJKgjdVsQJzM5OjhprwMMvJqZaI=;
        b=VYJEQOtc9+dJ6uCZe31Kujvkd9whUVy8H7qTaH9uEt3neZalOs7U0HGfgteWD5bguKLSwqlhD1fjk
         eVIEFw3qOuP/4QNUml4O6TpTOPeNaigwcE3IC25PzR8RfKrjKoYuLQf+gaAUnPhwn7kXZtfdYrL+uS
         d0z72zKCZsubdrqM=
X-HalOne-Cookie: 77fc30f33d2e37bcee46875632c6ff9310ff2e62
X-HalOne-ID: ed4dcbfe-6a47-11e9-9a3d-d0431ea8bb03
Received: from localhost (unknown [193.163.1.7])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id ed4dcbfe-6a47-11e9-9a3d-d0431ea8bb03;
        Mon, 29 Apr 2019 06:27:56 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list\:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
        <87tvejakot.fsf@haabendal.dk>
        <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
Date:   Mon, 29 Apr 2019 08:27:56 +0200
In-Reply-To: <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
        (Andy Shevchenko's message of "Sat, 27 Apr 2019 19:41:10 +0300")
Message-ID: <87y33tz5oz.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> The reason for this patch is to be able to do exactly that (set port
>> >> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
>> >>
>> >> In the current serial8250_register_8250_port() there is:
>> >>
>> >>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> >>
>> >> So, even though I set UPF_FIXED_TYPE, I get
>> >> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.
>> >
>> > Yes.
>> >
>> >> So I need this patch.
>> >
>> > Why? I don't see any problems to have these flags set.
>>
>> The problem with having UPF_BOOT_AUTOCONF is the call to
>> serial8250_request_std_resource().  It calls request_mem_region(), which
>> fails if the MFD driver already have requested the memory region for the
>> MFD device.
>
> If it's MFD, why it requested the region for its child?
> Isn't it a bug in MFD driver?

It is a PCI driver, which calls pci_request_regions().  The PCI device
carries a lot of different functions, which uses small slices of the PCI
memory region(s).  With the resources being a tree structure, I don't
think it is a bug when a parent driver requests the entire memory
region.

It would be nice if child drivers requesting memory would pass the
parent memory resource.  Maybe 8250 driver could be changed to accept a
struct resource pointer instead of a simple mapbase value, allowing to
setup the resource with parent pointing to the MFD memory resource.

/Esben
