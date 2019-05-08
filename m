Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD78C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8937420644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBELBBhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEHHzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEHHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:55:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so1928117wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0Gr0Qy8GhHQL5FDN6Sb65QrZiaFId6NzqBnXh3CcKJw=;
        b=sBELBBhLVs7gRIbzZOArljmnDmVyCYZOrbVTmb6+H+zDz3EI8ApUbljXjh/Q+/4SEd
         dH9nXvnWtB3Xhih2sDlwyRHIVT3Lnq5D8NcwbD/KuGmz/ZEFEbjUTbiBtq/8xB9MSOD5
         CSiZuYIrWu1pzT/4RC2lzphjcF5bBZMFD+fv+YGCArfdziG3iOfbxLPjuACu78tg6MWV
         ZGS7Iz+mYFYYXwOv9dgDUjXHk7Fink4Pg2IjroIrjf+RlY2U4HRMEmuR0USQ9Sgt828f
         4gfQcQotWiZYTgWCWSX402U30CZ41iA4a0dAn6EmRAy3kjHdbBvmHo8EJX6m5ArbGq2r
         tZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0Gr0Qy8GhHQL5FDN6Sb65QrZiaFId6NzqBnXh3CcKJw=;
        b=IwUT5fVDKE+PjHkci5NbjOIxNS0mPBi8pTkldb9tmrZDkOOP+mKyir+XzJXxqhlaVH
         xaKRg8lNqu2aeDCTJLFpOfGz75WgocXvo0hNwH33Gt6u/mhqRzf+hWN93RcA27CQ6jpH
         ossO9OdKUuLdA+1FNtyFK9LKJgjRkChTtENVh5B0SgQwxmHpSMhDwkBE6FLnErWkePZu
         Az+eNEdd8YhW4K7/trqDCfRBitc2VZwRKTrFaE1AVfK0CdskCE5EJB52NhMKN0Eb4swV
         9ejCBE4lZyp1+7iGNSE/j9sARyBleUEXGyfOeRWsOSOANwWu1H5eRL6GnUnRjQcK8QZQ
         UzWQ==
X-Gm-Message-State: APjAAAWZtwLexVDVqNsE/yBXve1MR1mgeuV3vdp8PoRUzrM+Us44Z4YA
        B+yZ4nJOVh7VfPIJHPMO7eq4Uw==
X-Google-Smtp-Source: APXvYqzzmCqA4/VUYubcXHP6qXo6VDxF15/Tsx0HAz5ycflpFzihsH4TO+R9oY3ivo6jDPtIAHMWxg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr1864181wmc.137.1557302142489;
        Wed, 08 May 2019 00:55:42 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g12sm2739646wmh.17.2019.05.08.00.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:55:41 -0700 (PDT)
Date:   Wed, 8 May 2019 08:55:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec_dev: Add a poll handler to receive MKBP
 events
Message-ID: <20190508075540.GA3995@dell>
References: <20190308123659.16101-1-enric.balletbo@collabora.com>
 <20190402040647.GM4187@dell>
 <c6cd7740-c3aa-6420-a789-735179ba59b4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6cd7740-c3aa-6420-a789-735179ba59b4@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> On 2/4/19 6:06, Lee Jones wrote:
> > On Fri, 08 Mar 2019, Enric Balletbo i Serra wrote:
> > 
> >> From: Vincent Palatin <vpalatin@chromium.org>
> >>
> >> Allow to poll on the cros_ec device to receive the MKBP events.
> >>
> >> The /dev/cros_[ec|fp|..] file operations now implements the poll
> >> operation. The userspace can now receive specific MKBP events by doing the
> >> following:
> >> - Open the /dev/cros_XX file.
> >> - Call the CROS_EC_DEV_IOCEVENTMASK ioctl with the bitmap of the MKBP
> >>   events it wishes to receive as argument.
> >> - Poll on the file descriptor.
> >> - When it gets POLLIN, do a read on the file descriptor, the first
> >>   queued event will be returned (using the struct
> >>   ec_response_get_next_event format: one byte of event type, then
> >>   the payload).
> >>
> >> The read() operation returns at most one event even if there are several
> >> queued, and it might be truncated if the buffer is smaller than the
> >> event (but the caller should know the maximum size of the events it is
> >> reading).
> >>
> >> read() used to return the EC version string, it still does it when no
> >> event mask or an empty event is set for backward compatibility (despite
> >> nobody really using this feature).
> >>
> >> This will be used, for example, by the userspace daemon to receive and
> >> treat the EC_MKBP_EVENT_FINGERPRINT sent by the FP MCU.
> > 
> > MFD does not seem like the correct place for this.  Maybe this is a
> > good candidate for drivers/platform/chrome/* where the rest of your
> > platform empire now resides.
> > 
> 
> The patch itself can't be moved without moving other parts, this would imply
> move all the file_operations and the chardev, those already resides in MFD, and
> some event handling. Is this what you're suggesting?

That would make the most sense, yes.

This whole Embedded Controller thing far extends the bounds of what
MFD was designed to do.  Hence why a great deal of it has already been
moved out to drivers/platform.

> If that's the case I need to look in more detail.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
