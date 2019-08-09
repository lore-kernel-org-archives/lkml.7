Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D809C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DE9214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406944AbfHITAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:00:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55398 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726358AbfHITAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:00:41 -0400
Received: (qmail 5162 invoked by uid 2102); 9 Aug 2019 15:00:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 15:00:40 -0400
Date:   Fri, 9 Aug 2019 15:00:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Prashant Malani <pmalani@chromium.org>
cc:     syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
In-Reply-To: <CACeCKafa5OkV=Mj0sBvr_oQeT5HBe9CRcT1g7BKqzECXv7ODvg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908091459450.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, Prashant Malani wrote:

> Hi,
> 
> I'm trying to get up to speed on USB kernel code. Sounds like
> dev->intf should have been set to NULL for the error path in
> ld_usb_probe() ?

Why should it?

After all, dev gets deallocated at the end of ld_usb_probe(), where 
ld_usb_delete() is called.  Who cares what value is stored in 
deallocated memory?

Alan Stern

