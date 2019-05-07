Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E820825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="H/VtEJDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEGMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:04:37 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:44846
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfEGMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=c2VlK3MM/wgPOjvoDCLj1og4pjEnPybpBDaxjchOxpE=;
        b=H/VtEJDAcgCLvhq48Kp5YfMM8XwcJvQ7PdURzx7A7qDlg5fuiwSrykpzCJ72NPSUsaKenNEYSGAmf
         eqfzULm/WvNyD91pOl+iQ48hraRQxX+zP68Zjo+lXCi90RffXgLrFexURbl1OiOSbA72hqhhYuCPPc
         IancKGmZ39YCTSnE=
X-HalOne-Cookie: 28a63f102c7a92420db1d78ee04f8d6f20dc165c
X-HalOne-ID: 47378af4-70c0-11e9-a343-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 47378af4-70c0-11e9-a343-d0431ea8bb10;
        Tue, 07 May 2019 12:04:34 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-3-esben@geanix.com> <20190507114905.GB29524@dell>
Date:   Tue, 07 May 2019 14:04:34 +0200
In-Reply-To: <20190507114905.GB29524@dell> (Lee Jones's message of "Tue, 7 May
        2019 12:49:05 +0100")
Message-ID: <87o94ejwrx.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Fri, 26 Apr 2019, Esben Haabendal wrote:
>
>> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
>> to an MFD driver.
>> 
>> When calling mfd_add_device(), platform_data should be a pointer to a
>> struct plat_serial8250_port, with proper settings like .flags, .type,
>> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
>> passed as cell resources.
>
> What?  No, please!
>
> If you *must* create a whole driver just to be able to use
> platform_*() helpers (which I don't think you should), then please
> call it something else.  This doesn't have anything to do with MFD.

True.

I really don't think it is a good idea to create a whole driver just to
be able to use platform_get_*() helpers.  And if I am forced to do this,
because I am unable to convince Andy to improve the standard serial8250
driver to support that, it should be called MFD.  The driver would be
generally usable for all usecases where platform_get_*() works.

I don't have any idea what to call such a driver.  It really would just
be a fork of the current serial8250 driver, just allowing use of
platform_get_*(), supporting exactly the same hardware.

I am still hoping that we can find a way to improve serial8250 to be
usable in these cases.

/Esben
