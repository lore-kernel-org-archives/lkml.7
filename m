Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B101C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CC2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfIROXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:23:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53206 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729911AbfIROXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:23:15 -0400
Received: (qmail 2743 invoked by uid 2102); 18 Sep 2019 10:23:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2019 10:23:14 -0400
Date:   Wed, 18 Sep 2019 10:23:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
cc:     linux-bluetooth@vger.kernel.org, <linux-usb@vger.kernel.org>,
        <dianders@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hui Peng <benquike@gmail.com>, <linux-pm@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 0/2] Reset realtek bluetooth devices during user suspend
In-Reply-To: <20190917212702.35747-1-abhishekpandit@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1909181017300.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Abhishek Pandit-Subedi wrote:

> On a Realtek USB bluetooth device, I wanted a simple and consistent way
> to put the device in reset during suspend (2 reasons: to save power and
> disable BT as a wakeup source). Resetting it in the suspend callback
> causes a detach and the resume callback is not called. Hence the changes
> in this series to do the reset in suspend_noirq.

What about people who _want_ BT to be a wakeup source?

Why does putting the device in reset save power?  That is, a suspended
device is very strictly limited in the amount of current it's allowed
to draw from the USB bus; why should it draw significantly less when it
is reset?

> I looked into using PERSIST and reset on resume but those seem mainly
> for misbehaving devices that reset themselves.

They are, but that doesn't mean you can't use them for other things 
too.

> This patch series has been tested with Realtek BT hardware as well as
> Intel BT (test procedure = disable as wake source, user suspend and
> observe a detach + reattach on resume).

This series really seems like overkill for a single kind of device.

Is there any way to turn off the device's BT radio during suspend (if
wakeup is disabled) and then turn it back on during resume?  Wouldn't 
that accomplish what you want just as well?

Alan Stern

