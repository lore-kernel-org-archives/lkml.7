Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C210C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C17E208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfKTSSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:18:08 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34910 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727671AbfKTSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:18:08 -0500
Received: (qmail 4222 invoked by uid 2102); 20 Nov 2019 13:18:07 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2019 13:18:07 -0500
Date:   Wed, 20 Nov 2019 13:18:07 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>
cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <20191120113314.761fce32@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.1911201313480.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Pete Zaitcev wrote:

> On Wed, 20 Nov 2019 11:14:05 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > As it happens, I spent a little time investigating this bug report just
> > yesterday.  It seems to me that the easiest fix would be to disallow
> > resizing the buffer while it is mapped by any users.  (Besides,
> > allowing that seems like a bad idea in any case.)
> > 
> > Pete, does that seem reasonable to you?
> 
> Actually, please hold on a little, I think to think more about this.
> The deadlock is between mon_bin_read and mon_bin_vma_fault.
> To disallow resizing isn't going to fix _that_.

As I understand it (and my understanding is pretty limited, since I
only started to look seriously at the code one day ago), the reason why
mon_bin_vma_fault acquires fetch_lock is to prevent a resize from
happening while the fault is being handled.  Is there another reason?

If you disallow resizing while the buffer is mapped then 
mon_bin_vma_fault won't need to hold fetch_lock at all.  That would fix 
the deadlock, right?

Alan Stern

