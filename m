Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfI0OVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:21:02 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32962 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726926AbfI0OVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:21:01 -0400
Received: (qmail 2579 invoked by uid 2102); 27 Sep 2019 10:21:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 2019 10:21:00 -0400
Date:   Fri, 27 Sep 2019 10:21:00 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Andrey Konovalov <andreyknvl@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in pvr2_i2c_core_done
In-Reply-To: <20190927051042.GA1767219@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1909271015510.1698-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019, Greg Kroah-Hartman wrote:

> > It turns out the reason for this error is simple: The driver 
> > unregisters its subdevices in the release handler instead of in the 
> > disconnect handler.  There probably is documentation about this 
> > somewhere, but I don't know exactly where -- maybe Greg remembers.
> 
> Nope, I don't remember.  It should happen in the disconnect handler, odd
> of it to be in release, but maybe that's the "easiest" way for v4l to
> handle this?

This isn't a question of "easiest".  Unregistering child devices in a
release handler is just _wrong_, plain and simple.  That's what gives
rise to the

"sysfs group 'power' not found for kobject 'i2c-0'"

warning in the kernel log.  The group can't be found because it has 
already been removed; it gets destroyed when the parent USB interface 
device is unregistered, because unregistering a device also removes 
from sysfs everything below that device.

Alan Stern

