Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B336222C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfJDO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:27:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46354 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbfJDO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:27:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGOYe-0003DA-Ff; Fri, 04 Oct 2019 14:27:48 +0000
Date:   Fri, 4 Oct 2019 15:27:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Varad Gautam <vrd@amazon.de>, stable@vger.kernel.org,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH] devpts: Fix NULL pointer dereference in dcache_readdir()
Message-ID: <20191004142748.GG26530@ZenIV.linux.org.uk>
References: <20191004140503.9817-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004140503.9817-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 04:05:03PM +0200, Christian Brauner wrote:
> From: Will Deacon <will@kernel.org>
> 
> Closing /dev/pts/ptmx removes the corresponding pty under /dev/pts/
> without synchronizing against concurrent path walkers. This can lead to
> 'dcache_readdir()' tripping over a 'struct dentry' with a NULL 'd_inode'
> field:

FWIW, vfs.git#fixes (or #next.dcache) ought to deal with that one.
