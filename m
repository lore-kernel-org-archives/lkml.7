Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A635D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="nwqFvBDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfEULu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:50:29 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:48214
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727743AbfEULu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=eEuX7iutFvi1HOGEPs3UIDtx4qkK8OvCvI0OJsFeod4=;
        b=nwqFvBDK3fqszHkd0uNt2gYOdVmI4rKnl55oFSOB004/238Qo9tuSBi76k5fzsXp0ooR0KTAp1OPF
         9FDwdQ67qmf9DKj+wceYctN0d/y+GxYqAEojl1RRAm79+cCxsbHTgMyeucBMcBC61BgTMl/bQ5P3c9
         15Iz2cMv3JgJCNqo=
X-HalOne-Cookie: 9767e542c6c60036e2d58a9f057583b96d4064d7
X-HalOne-ID: 9efd9c0d-7bbe-11e9-bc27-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 9efd9c0d-7bbe-11e9-bc27-d0431ea8a283;
        Tue, 21 May 2019 11:50:25 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <20190426084038.6377-3-esben@geanix.com>
        <20190507114905.GB29524@dell> <87o94ejwrx.fsf@haabendal.dk>
        <20190507133844.GA6194@dell> <87bm05mpmx.fsf@haabendal.dk>
        <20190514104741.GO4319@dell> <20190514122618.GA18859@kroah.com>
        <87imudky2o.fsf@haabendal.dk> <20190521100904.GA13612@kroah.com>
        <87pnocm59v.fsf@haabendal.dk> <20190521111817.GA24911@kroah.com>
Date:   Tue, 21 May 2019 13:50:25 +0200
In-Reply-To: <20190521111817.GA24911@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 21 May 2019 13:18:17 +0200")
Message-ID: <87lfz0m3ge.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, May 21, 2019 at 01:11:08PM +0200, Esben Haabendal wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> >> I will try ad hold back with this thread until you get back to it.
>> >
>> > Ok, I have no idea what is going on here, sorry.  This is a really long
>> > and meandering thread, and I can't even find the original patches in my
>> > queue.
>> >
>> > So can you resend things and we can start over?  :)
>> 
>> Will do.
>> 
>> > But note, using a mfd for a uart seems VERY odd to me...
>> 
>> Ok.  In my case, I have a pcie card with an fpga which includes 5 uart
>> ports, 3 ethernet interfaces and a number of custom IP blocks.
>> I believe that an mfd driver for that pcie card in that case.
>
> I believe you need to fix that fpga to expose individual pci devices
> such that you can properly bind the individual devices to the expected
> drivers :)

Well, that is really out-of-scope of what I am doing here.

> Seriously, who makes such a broken fpga device that goes against the PCI
> spec that way?  Well, not so much as "goes against it", as "ignores all
> of the proper ideas of the past 20 years for working with PCI devices".

Might be.  But that is the firmware I have to work with here, and I
still hope we can find a good solution for implementing a driver without
having to maintain out-of-tree patches.

/Esben
