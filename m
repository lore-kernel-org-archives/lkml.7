Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE98C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98C214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbfHFO0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:26:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbfHFO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:26:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B89FCAC1C;
        Tue,  6 Aug 2019 14:26:04 +0000 (UTC)
Message-ID: <1565101558.8136.30.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 06 Aug 2019 16:25:58 +0200
In-Reply-To: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.08.2019, 10:19 -0400 schrieb Alan Stern:
> On Tue, 6 Aug 2019, Oliver Neukum wrote:
> 
> > Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> > > 
> > > I think this must be caused by an unbalanced refcount.  That is,
> > > something must drop one more reference to the device than it takes.
> > > That would explain why the invalid access occurs inside a single
> > > bus_remove_device() call, between the klist_del() and
> > > device_release_driver().
> > > 
> > > The kernel log indicates that the device was probed by rndis_wlan,
> > > rndis_host, and cdc_acm, all of which got errors because of the
> > > device's bogus descriptors.  Probably one of them is messing up the
> > > refcount.
> > 
> > Hi,
> > 
> > you made me look at cdc-acm. I suspect
> > 
> > cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")
> > 
> > is buggy decrementing the refcount on the interface in destroy()
> > even before the refcount is increased.
> > 
> > Unfortunately I cannot tell from the bug report how many and which
> > interfaces the emulated test device has. Hence it is unclear to me,
> > when exactly probe() would fail cdc-acm.
> 
> Only one interface (numbered 234!).

Yes. cdc-acm went into the look_for_collapsed_interface code path.
But I cannot tell whether it proceeded to made_compressed_probe

(Yes, I know the code makes extensive use of "goto")

> > If you agree. I am attaching a putative fix.
> 
> Your patch adds a line saying:
> 
> > +	usb_get_intf(acm->control); /* undone in destroy() */
> 
> but I don't see any destroy() function in that source file.  Did you 
> mean acm_port_destruct()?

Yes, sorry

> In any case, I don't know if this missing "get" would cause the 
> problem, but it might well.

Then let's wait for the result.

	Regards
		Oliver

