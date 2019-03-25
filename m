Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DC82083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfCYVxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYVxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:53:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF13206DF;
        Mon, 25 Mar 2019 21:53:39 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:53:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] parport: daisy: do not try to load lowlevel driver
Message-ID: <20190325175338.2fa290cc@gandalf.local.home>
In-Reply-To: <20190325211325.21411-1-sudipm.mukherjee@gmail.com>
References: <20190325211325.21411-1-sudipm.mukherjee@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 21:13:25 +0000
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Some distros like Suse has an alias for "parport_lowlevel" and that
> alias points to "parport_pc". Now when the parport bus registers, it
> also initialises the daisy driver as the daisy driver is needed to
> check the port when the port is first found. Due to the new device
> model daisy driver will now try to find the parallel ports while trying
> to register its driver so that it can bind with them. Now, since daisy
> driver is loaded while parport bus is initialising the list of parport
> is still empty and it tries to load the lowlevel driver, which has an
> alias set to parport_pc, now causes a deadlock.
> 
> We do not need to search for ports and bind the initial list of ports
> to daisy driver as daisy driver is always the first driver to use the
> new found parport and we know when the parport bus is registering the
> list of parport will always be empty. So, proceed with the daisy_drv
> registration even if the list of parport is empty.
> 
> Fixes: 1aec4211204d ("parport: daisy: use new parport device model")
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Tested-by: Michal Kubecek <mkubecek@suse.cz>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
