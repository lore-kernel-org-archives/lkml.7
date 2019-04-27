Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BAAC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCF8208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="Cb+V3lIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfD0I6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:58:47 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:18608
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfD0I6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=SY70ACJXMXfpTtZvJjcA3AX2iq9xy4ww6mICUG5zVGI=;
        b=Cb+V3lIjEo3WG7Phl9eQnCrF6JMqamqi/VIoey+L6RFjPI6gogyF/VYo2TUOJrBVvEJIW0jZw0TAj
         6tu96vZ2/Qqqh8Ytdse1h34Hsd9QO21HWzcrcjbD6J+EgGP5jnK9w0/1Cg0DsnjHs9bpM6eWTKhl/r
         Gtxp2R7CdePhmuOg=
X-HalOne-Cookie: 2997f6c37e5523611d894567f72f6c98584d969a
X-HalOne-ID: a871c8fa-68ca-11e9-a59f-d0431ea8bb10
Received: from localhost (unknown [87.49.45.205])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a871c8fa-68ca-11e9-a59f-d0431ea8bb10;
        Sat, 27 Apr 2019 08:58:43 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
Date:   Sat, 27 Apr 2019 10:58:42 +0200
In-Reply-To: <20190426215103.GD9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Sat, 27 Apr 2019 00:51:03 +0300")
Message-ID: <87tvejakot.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
>> >> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
>> >> is not possible to register a port without having
>> >> serial8250_request_std_resource() called.
>> >> 
>> >> For adding a 8250 port to an MFD device, this is problematic, as the
>> >> request_mem_region() call will fail, as the MFD device (and rightly  so)
>> >> has requested the region.  For this case, the 8250 port should accept
>> >> having passed mapbase and membase, and just use that.
>> >
>> > You need to simple set port type and use UPF_FIXED_TYPE.
>> > No need for this patch.
>> 
>> The reason for this patch is to be able to do exactly that (set port
>> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
>> 
>> In the current serial8250_register_8250_port() there is:
>> 
>>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> 
>> So, even though I set UPF_FIXED_TYPE, I get
>> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF. 
>
> Yes.
>
>> So I need this patch.
>
> Why? I don't see any problems to have these flags set.

The problem with having UPF_BOOT_AUTOCONF is the call to
serial8250_request_std_resource().  It calls request_mem_region(), which
fails if the MFD driver already have requested the memory region for the
MFD device.  And I believe that is a valid thing to do.

To workaround this, I first thought I could just avoid setting
port->mapbase, causing serial8250_request_std_resource() to be a no-op.
But this breaks with more than one UART port, as uart_match_port() will
match the same line for all such UART ports, causing all but the last
one to be removed.

That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to
request and map the register memory.  So when that is already done by
the parent MFD driver, I think it is silly to workaround problems caused
by UPF_BOOT_AUTOCONF being force setted, when it really shouldn't.

> Moreover, some drivers
> are used as MFD counterparts with exactly same bits set.
>
>> I think it is unfortunate that UPF_BOOT_AUTOCONF is or'ed to flags like
>> that, but changing that will surely break stuff.
>
> True.
