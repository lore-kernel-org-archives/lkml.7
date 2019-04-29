Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4F92075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="WyvSl9iI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfD2GiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:38:04 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:50348
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfD2GiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=9wnic545AsxZHcx/2hqOCpwUOjyBhfbZc3ntdYwABvA=;
        b=WyvSl9iIFOcmGZ6eUlAGplycj4yNUwKW6vEWXfYXuDswldGuLYjCDaZoYrbkedvb95qs5WMMaolLm
         6KIMIUP+3hfwvdAuWVCEk+W1dRystMzgAu7bdCChne8+gGuMzY8SQp2eKZkSfPzR7RfyYtglJxi1nN
         S7mveu2smMn6jhqU=
X-HalOne-Cookie: 365ca68957aadfd74324080bb8210c56c9d88814
X-HalOne-ID: 54aea3d4-6a49-11e9-b614-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 54aea3d4-6a49-11e9-b614-d0431ea8a283;
        Mon, 29 Apr 2019 06:37:59 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
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
        <87tvejakot.fsf@haabendal.dk>
        <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net>
Date:   Mon, 29 Apr 2019 08:37:59 +0200
In-Reply-To: <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net> (Enrico
        Weigelt's message of "Sat, 27 Apr 2019 13:57:57 +0200")
Message-ID: <87tvehz588.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 27.04.19 10:58, Esben Haabendal wrote:
>
> Hi folks,
>
>> That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to
>> request and map the register memory.  So when that is already done by
>> the parent MFD driver, I think it is silly to workaround problems
>> caused by UPF_BOOT_AUTOCONF being force setted, when it really
>> shouldn't.
> I tend to agree. Maybe we should give serial8250_register_8250_port()
> some flags for controlling this, or add another function for those
> cases.

Changing serial8250_register_8250_port() would break existing drivers,
as I have seen that some explicitly rely on the automtic addition of
UPF_BOOT_AUTOCONF.

> A minimal-invasive approach could be introducing an
> serial8250_register_8250_port_ext() with extra parameters, and let
> serial8250_register_8250_port() just call it.

So basically a rename of __serial8250_register_8250_port() in my patch
to serial8250_register_8250_port_ext()?  Fine with me.  Should we give
it an EXPORT_SYMBOL() also, as it is just as valid to use in modules as
the current serial8250_register_8250_port()?

/Esben
