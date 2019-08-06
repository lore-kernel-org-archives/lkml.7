Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7740520818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfHFOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:19:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43046 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731893AbfHFOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:19:38 -0400
Received: (qmail 2562 invoked by uid 2102); 6 Aug 2019 10:19:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Aug 2019 10:19:37 -0400
Date:   Tue, 6 Aug 2019 10:19:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
In-Reply-To: <1565095011.8136.20.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019, Oliver Neukum wrote:

> Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> > 
> > I think this must be caused by an unbalanced refcount.  That is,
> > something must drop one more reference to the device than it takes.
> > That would explain why the invalid access occurs inside a single
> > bus_remove_device() call, between the klist_del() and
> > device_release_driver().
> > 
> > The kernel log indicates that the device was probed by rndis_wlan,
> > rndis_host, and cdc_acm, all of which got errors because of the
> > device's bogus descriptors.  Probably one of them is messing up the
> > refcount.
> 
> Hi,
> 
> you made me look at cdc-acm. I suspect
> 
> cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")
> 
> is buggy decrementing the refcount on the interface in destroy()
> even before the refcount is increased.
> 
> Unfortunately I cannot tell from the bug report how many and which
> interfaces the emulated test device has. Hence it is unclear to me,
> when exactly probe() would fail cdc-acm.

Only one interface (numbered 234!).

> If you agree. I am attaching a putative fix.

Your patch adds a line saying:

> +	usb_get_intf(acm->control); /* undone in destroy() */

but I don't see any destroy() function in that source file.  Did you 
mean acm_port_destruct()?

In any case, I don't know if this missing "get" would cause the 
problem, but it might well.

Alan Stern

