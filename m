Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED834C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26D3217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="cagSho4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfEUOb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:31:58 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:62765
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbfEUOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=68cjQ473bQLE5GiEYkgBg9Ezckcy73DieA8K3oH1vTo=;
        b=cagSho4Rp7gM8SguUEt1c9U03ECIPhqybra77u73djIpG35rXUtI7RU1vPDobYNCsaJe90uUV72NT
         nTvyzzuHNre1Lm9hQi5kwHkNi4t6+Y79bZVKuUXLT7M+LKzEcsLt99nks8aApvDzK3LPxCEcsJdYLX
         g29dfM5k1HIvxQOQ=
X-HalOne-Cookie: b50b45784449bfbea3f9694c168057a61f901524
X-HalOne-ID: 2d17b33d-7bd5-11e9-a0e1-d0431ea8bb03
Received: from localhost (unknown [193.163.1.7])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2d17b33d-7bd5-11e9-a0e1-d0431ea8bb03;
        Tue, 21 May 2019 14:31:52 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <87o94ejwrx.fsf@haabendal.dk> <20190507133844.GA6194@dell>
        <87bm05mpmx.fsf@haabendal.dk> <20190514104741.GO4319@dell>
        <20190514122618.GA18859@kroah.com> <87imudky2o.fsf@haabendal.dk>
        <20190521100904.GA13612@kroah.com> <87pnocm59v.fsf@haabendal.dk>
        <20190521111817.GA24911@kroah.com> <87lfz0m3ge.fsf@haabendal.dk>
        <20190521125651.GA6264@kroah.com>
Date:   Tue, 21 May 2019 16:31:52 +0200
In-Reply-To: <20190521125651.GA6264@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 21 May 2019 14:56:51 +0200")
Message-ID: <87h89nnajr.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, May 21, 2019 at 01:50:25PM +0200, Esben Haabendal wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, May 21, 2019 at 01:11:08PM +0200, Esben Haabendal wrote:
>> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> >> 
>> >> >> I will try ad hold back with this thread until you get back to it.
>> >> >
>> >> > Ok, I have no idea what is going on here, sorry.  This is a really long
>> >> > and meandering thread, and I can't even find the original patches in my
>> >> > queue.
>> >> >
>> >> > So can you resend things and we can start over?  :)
>> >> 
>> >> Will do.
>> >> 
>> >> > But note, using a mfd for a uart seems VERY odd to me...
>> >> 
>> >> Ok.  In my case, I have a pcie card with an fpga which includes 5 uart
>> >> ports, 3 ethernet interfaces and a number of custom IP blocks.
>> >> I believe that an mfd driver for that pcie card in that case.
>> >
>> > I believe you need to fix that fpga to expose individual pci devices
>> > such that you can properly bind the individual devices to the expected
>> > drivers :)
>> 
>> Well, that is really out-of-scope of what I am doing here.
>
> Not really, if you have control over the fpga firmware (and odds are you
> do), just fix that and instantly your device works with all kernels, no
> need to change anything.
>
> Why not do this?

Because I do not have control over fpga firmware.

>> > Seriously, who makes such a broken fpga device that goes against the PCI
>> > spec that way?  Well, not so much as "goes against it", as "ignores all
>> > of the proper ideas of the past 20 years for working with PCI devices".
>> 
>> Might be.  But that is the firmware I have to work with here, and I
>> still hope we can find a good solution for implementing a driver without
>> having to maintain out-of-tree patches.
>
> As this hardware will not work on any operating system as-is, why not
> fix the firmware to keep from having to support a one-off device that no
> one else would be crazy enough to create?  :)

Clearly, someone has been crazy enough.  Hopefully, we can be smart
enough to make Linux fit to it.

/Esben
