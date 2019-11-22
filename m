Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3369C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9087A20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKVQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:20:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46602 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:20:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYBfV-0008SH-BH; Fri, 22 Nov 2019 16:20:25 +0000
Date:   Fri, 22 Nov 2019 16:20:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191122162025.GC26530@ZenIV.linux.org.uk>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:20:21PM +0900, Kusanagi Kouichi wrote:
> If DEBUG_FS=n, compile fails with the following error:
> 
> kernel/trace/trace.c: In function 'tracing_init_dentry':
> kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  8658 |         trace_automount, NULL);
>       |         ^~~~~~~~~~~~~~~
>       |         |
>       |         struct vfsmount * (*)(struct dentry *, void *)
> In file included from kernel/trace/trace.c:24:
> ./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
>   206 |      struct vfsmount *(*f)(void *),
>       |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

ACK.  I'd probably add something along the lines of "the stub for
debugfs_create_automount() used in !DEBUG_FS configs is misdeclared -
its callback argument (unused by the stub) has the wrong type.
Get the stub in sync with the real debugfs_create_automount()."
to commit message.
