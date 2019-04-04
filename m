Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfDDStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:49:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52366 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfDDStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:49:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hC7Qm-0004IO-95; Thu, 04 Apr 2019 18:49:44 +0000
Date:   Thu, 4 Apr 2019 19:49:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
Message-ID: <20190404184944.GD2217@ZenIV.linux.org.uk>
References: <20190404105255.12189-1-amir73il@gmail.com>
 <20190404184448.GC2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404184448.GC2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:44:48PM +0100, Al Viro wrote:

> Huh?  sb_writers is taken when we *open* the new file.  Then we replace
> its ->path.mnt with a clone and transfer the write count from the original
> to new one.  And close the old file while we are at it.
> 
> >From sb_writers POV mainline has
> 	sb_start_write(new_sb)	// in open
> 	sb_start_write(new_sb)	// mnt_want_write() on clone
> 	last write to old_sb, then sb_end_write(old_sb) // acct_pin_kill()
> 	sb_end_write(new_sb)	// mnt_drop_write(mnt)
> and you flip the order of the last two lines.
> 
> Could you explain how exactly does your patch help whatever
> problem overlayfs has?

Ow...  Sorry, -ENOCOFFEE...

Let me wake up properly and look at that thing again.
