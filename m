Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE092C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B442205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="Grhq43zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEGLgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:36:01 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:21954
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfEGLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=Uh3f7qnRbSQQXQkMm0s19BuoSqf0wRLQse1bOkuUKK4=;
        b=Grhq43zgaue0On9gftW7qUtepFq7wFqh+NFFWeBHc70giS3ymHNBOEJ5rauaVsT3JU3s3ZhXnDAlw
         XwHNudsR3VU4yi8ZHoTTHDy4yld5B+unu8JLqMbDkewSaSZOOsD/6sRglaAJRGElsGQH/0Xg+AwXcQ
         9W1PiOX7GOxXNSH4=
X-HalOne-Cookie: fac621c1e4a6af216c8d436403609853b7145ede
X-HalOne-ID: 486930ec-70bc-11e9-a343-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 486930ec-70bc-11e9-a343-d0431ea8bb10;
        Tue, 07 May 2019 11:35:58 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
Date:   Tue, 07 May 2019 13:35:58 +0200
In-Reply-To: <20190507093239.GB4529@dell> (Lee Jones's message of "Tue, 7 May
        2019 10:32:39 +0100")
Message-ID: <87sgtqjy3l.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:
> On Thu, 02 May 2019, Esben Haabendal wrote:
>
>> Could you help clarify whether or not this patch is trying to do
>> something odd/wrong?
>> 
>> I might be misunderstanding Andy (probably is), but the discussion
>> revolves around the changes I propose where I change the serial8250
>> driver to use platform_get_resource() in favour of
>> request_mem_region()/release_mem_region().
>
> Since 'serial8250' is registered as a platform device, I don't see any
> reason why it shouldn't have the capability to obtain its memory
> regions from the platform_get_*() helpers.

Good to hear.  That is exactly what I am trying do with this patch.

@Andy: If you still don't like my approach, could you please advice an
acceptable method for improving the serial8250 driver to allow the use
of platform_get_*() helpers?

/Esben
