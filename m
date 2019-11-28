Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A7C21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfK1Rdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:33:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:57873 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726610AbfK1Rdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:33:43 -0500
Received: (qmail 20969 invoked by uid 500); 28 Nov 2019 12:33:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2019 12:33:42 -0500
Date:   Thu, 28 Nov 2019 12:33:42 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <hverkuil@xs4all.nl>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mchehab@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
In-Reply-To: <1574938260.21204.5.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1911281225340.19734-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Oliver Neukum wrote:

> Hi,
> 
> it is a bit awkward to complain here, as your patch tests as correct
> while mine didn't, but this is a race condition.
> You can't guarantee that urb->status != 0.
> The kill may happen while the completion handler is running for
> a successful transfer.
> 
> I really appreciate your help, but I must understand what is going
> wrong here. You are stopping the resubmit, but how could the resubmit
> ever have not failed?

You probably have figured all this out already, but I'll answer anyway.

The code I changed doesn't race with the error condition you were 
concerned about.  The two are independent, and it doesn't matter if the 
kill happens while the completion handler is running.

In the case my patch addresses, the resubmit does not fail.  Rather, it
succeeds but then the URB completes with a -EPROTO error.  The problem
is that the completion handler then resubmits the URB again, and it
completes again with the same error, right away, in a tight loop --
which prevents the CPU from executing any other code.  The way to fix
the problem is to break the loop by not resubmitting, which is what the
patch does.

Alan Stern

