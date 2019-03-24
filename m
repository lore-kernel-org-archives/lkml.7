Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB0C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF60421741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452178;
	bh=DWxGvLT9zvJxKdGgFotu0Nvf5Zh8JRDUifJTRLlRyNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QpOt0774JJx8v2vdCBtOQGx6BcDiFmCfS42Gw5a9v5YCsNSr/h/Yz+1DG6faIQ/uZ
	 1gU+/neuGsRw0ORHB8RGRUPQydFPCvRSVa9Az3tjEUFOg//VIwqN8ZEso1Zcn6338A
	 iXPdlMBWYX/wCiFREnfnU+HNvghXU8hTM4rBXruQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfCXS3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfCXS3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:29:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19342148D;
        Sun, 24 Mar 2019 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452175;
        bh=DWxGvLT9zvJxKdGgFotu0Nvf5Zh8JRDUifJTRLlRyNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HqS8KZGc3OZCnoG4FV9mcVxA5aAzgrsR10R9VKxiYFaTkD92q+1+tU07iZku6uxI+
         GLzFgUkDEgHbKBKb9T+KkH1JB+w5vF69R8f0jsOqdFgTUPmy2mUpAyOsPbFBXxIHjA
         HWv2nLKEaD2pYRB+I4QG5a+bK3KsycRV+r0HvHU8=
Date:   Sun, 24 Mar 2019 18:29:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC 0/4] iio-input-bridge so that accelerometers which only
 have an iio driver can still present evdev input events
Message-ID: <20190324182920.66242add@archlinux>
In-Reply-To: <cover.1552941573.git.hns@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 21:39:30 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

	
> Some user spaces (e.g. some Android) use /dev/input/event* for handling the 3D
> position of the device with respect to the center of gravity (earth). This can
> be used for gaming input, rotation of screens etc.
> 
> This should be the standard because this interface is an abstraction of how
> this data is acquired from sensor chips. Sensor chips may be connected through
> different interfaces and in different positions. They may also have different
> parameters. And, if a chip is replaced by a different one, the values reported
> by the device position interface should remain the same.
> 
> But nowadays, new accelerometer chips usually just get iio drivers and rarely
> an evdev input driver.
> 
> Therefore we need something like a protocol stack: input device vs. raw data.
> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or keyboard
> input events vs. raw gpio or raw USB access.
> 
> This patch set bridges the gap between raw iio data and the input device abstraction
> so that accelerometer measurements can also be presented as X/Y/Z accelerometer
> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> 
Hi,

I've kind of run out of time today and want to give this a detailed look.

In the meantime a few initial comments.

1. Resend the whole series cc'ing the linux-input list and maintainer.
2. In the vast majority of devices the interrupt pin is connected for an
   accelerometer. and they support data ready signals.  My gut feeling is
   that should be the preferred mode.  It was for that use case that we originally
   put all the demux and multiple buffer code in IIO. The original series for
   that actually had an input bridge.
https://lore.kernel.org/linux-iio/1351679431-7963-5-git-send-email-jic23@kernel.org/

3. It's going to be a hard sell to have it 'always' map an accelerometer in IIO
   to an input device when configured.  There are lots of other accelerometer use
   cases where this would be crazy.  In the repost, give some comentary perhaps on
   the following options:
   a) Explicit binding - like the iio-hwmon bridge.
   b) A userspace bridge (I even wrote one of those years ago using uevent)
   c) Some sort of userspace triggered way of creating these on demand.

4. Input has polled modes. Don't reinvent them.

5. The patch break up is very very random.  Just have one patch :)

Anyhow, I'll take a look in detail but may be a little while.

Thanks,

Jonathan


> 
> H. Nikolaus Schaller (4):
>   iio: input-bridge: optionally bridge iio acceleometers to create a
>     /dev/input
>   iio: input-bridge: add iio-input-bridge to Makefile
>   iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
>   iio: input-bridge: make the iio-input-bridge driver called by iio-core
> 
>  drivers/iio/Kconfig                    |   7 +
>  drivers/iio/Makefile                   |   1 +
>  drivers/iio/industrialio-core.c        |  12 +
>  drivers/iio/industrialio-inputbridge.c | 420 +++++++++++++++++++++++++
>  drivers/iio/industrialio-inputbridge.h |  28 ++
>  5 files changed, 468 insertions(+)
>  create mode 100644 drivers/iio/industrialio-inputbridge.c
>  create mode 100644 drivers/iio/industrialio-inputbridge.h
> 

