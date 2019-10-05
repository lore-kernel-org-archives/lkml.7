Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE4C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F8222CB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570285995;
	bh=1E6FbiJ9RjkjVUjC0fOSMFfb/6RKb7Y9Sxoe+r1QIJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zIdXUlA/E8iqVdflFIVg6dK0HP1XBf3989IzvXmSRNuThz6KQTfxPpuQdOJDxHZ96
	 3K2kLg45+jNg24FKRoue6lg6UzlEoIYTtDGLwR7XLLBQ+BvmfNTb27VthowtltN6Ph
	 pwx1NGWH/xlG5Js6RJ0qtEs08tgtsuFw/PzQAfzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfJEOdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfJEOdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:33:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C353218AC;
        Sat,  5 Oct 2019 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570285993;
        bh=1E6FbiJ9RjkjVUjC0fOSMFfb/6RKb7Y9Sxoe+r1QIJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tYD3tKIXuCTMl4xJnOV6NiYaq2BoYVoY3VZIpxrDTB4BTY8BLBD5v4kfr/Dk2IQrh
         Ubb+jT6aE9eWjLM0XYtc+sWqGZ1gkcQZOsnjqeTcRpQ6oOiX3Uo6oEKW3cVlsnVX3G
         Kuhjep/UNYsWXqPhpUUqWKScghfav5Cy87ChbBmA=
Date:   Sat, 5 Oct 2019 15:33:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 0/2] Simplify count_read/count_write/signal_read
Message-ID: <20191005153255.4290ce81@archlinux>
In-Reply-To: <cover.1568816248.git.vilhelm.gray@gmail.com>
References: <cover.1568816248.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

This all makes sense to me.  Do you want to wait for some more reviews
or should I pick them up now through IIO?  We are really early in
the cycle so plenty of time, unless there are new drivers coming you
want to use these from the start.

Thanks,

Jonathan


On Wed, 18 Sep 2019 23:22:44 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v3:
>  - Squash code changes to single patch to avoid compilation error
> 
> The changes in this patchset will not affect the userspace interface.
> Rather, these changes are intended to simplify the kernelspace Counter
> callbacks for counter device driver authors.
> 
> The following main changes are proposed:
> 
> * Retire the opaque counter_count_read_value/counter_count_write_value
>   structures and simply represent count data as an unsigned integer.
> 
> * Retire the opaque counter_signal_read_value structure and represent
>   Signal data as a counter_signal_value enum.
> 
> These changes should reduce some complexity and code in the use and
> implementation of the count_read, count_write, and signal_read
> callbacks.
> 
> The opaque structures for Count data and Signal data were introduced
> originally in anticipation of supporting various representations of
> counter data (e.g. arbitrary-precision tallies, floating-point spherical
> coordinate positions, etc). However, with the counter device drivers
> that have appeared, it's become apparent that utilizing opaque
> structures in kernelspace is not the best approach to take.
> 
> I believe it is best to let userspace applications decide how to
> interpret the count data they receive. There are a couple of reasons why
> it would be good to do so:
> 
> * Users use their devices in unexpected ways.
> 
>   For example, a quadrature encoder counter device is typically used to
>   keep track of the position of a motor, but a user could set the device
>   in a pulse-direction mode and instead use it to count sporadic rising
>   edges from an arbitrary signal line unrelated to positioning. Users
>   should have the freedom to decide what their data represents.
> 
> * Most counter devices represent data as unsigned integers anyway.
> 
>   For example, whether the device is a tally counter or position
>   counter, the count data is represented to the user as an unsigned
>   integer value. So specifying that one device is representing tallies
>   while the other specifies positions does not provide much utility from
>   an interface perspective.
> 
> For these reasons, the count_read and count_write callbacks have been
> redefined to pass count data directly as unsigned long instead of passed
> via opaque structures:
> 
>         count_read(struct counter_device *counter,
>                    struct counter_count *count, unsigned long *val);
>         count_write(struct counter_device *counter,
>                     struct counter_count *count, unsigned long val);
> 
> Similarly, the signal_read is redefined to pass Signal data directly as
> a counter_signal_value enum instead of via an opaque structure:
> 
>         signal_read(struct counter_device *counter,
>                     struct counter_signal *signal,
>                     enum counter_signal_value *val);
> 
> The counter_signal_value enum is simply the counter_signal_level enum
> redefined to remove the references to the Signal data "level" data type.
> 
> William Breathitt Gray (2):
>   counter: Simplify the count_read and count_write callbacks
>   docs: driver-api: generic-counter: Update Count and Signal data types
> 
>  Documentation/driver-api/generic-counter.rst |  22 ++--
>  drivers/counter/104-quad-8.c                 |  33 ++----
>  drivers/counter/counter.c                    | 101 +++----------------
>  drivers/counter/ftm-quaddec.c                |  14 +--
>  drivers/counter/stm32-lptimer-cnt.c          |   5 +-
>  drivers/counter/stm32-timer-cnt.c            |  17 +---
>  include/linux/counter.h                      |  74 ++------------
>  7 files changed, 53 insertions(+), 213 deletions(-)
> 

