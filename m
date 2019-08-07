Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A69821E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfHGNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:38:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388240AbfHGNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:38:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D56D9AEF3;
        Wed,  7 Aug 2019 13:38:53 +0000 (UTC)
Message-ID: <1565185131.15973.1.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   Oliver Neukum <oneukum@suse.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Wed, 07 Aug 2019 15:38:51 +0200
In-Reply-To: <CAAeHK+wyvJbi08ruuOn1qF0O1Jubz_BhZz5wXdNg4Vy5XeyQmw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
         <1565095011.8136.20.camel@suse.com>
         <CAAeHK+wyvJbi08ruuOn1qF0O1Jubz_BhZz5wXdNg4Vy5XeyQmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.08.2019, 14:50 +0200 schrieb Andrey Konovalov:
> On Tue, Aug 6, 2019 at 2:36 PM Oliver Neukum <oneukum@suse.com> wrote:
> > 
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
> > 
> > If you agree. I am attaching a putative fix.
> 
> Let's see if it fixes the issue.
> 
> #syz fix: https://github.com/google/kasan.git 6a3599ce

Hi,

did this ever produce a result? I saw none.

	Regards
		Oliver

