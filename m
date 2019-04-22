Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB16C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F162077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfDVPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:55:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfDVPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:55:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hIbHs-0000ae-93; Mon, 22 Apr 2019 15:55:20 +0000
Date:   Mon, 22 Apr 2019 16:55:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] dcache: ensure d_flags & d_inode are consistent in
 lookup_fast()
Message-ID: <20190422155520.GJ2217@ZenIV.linux.org.uk>
References: <20190419084810.63732-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419084810.63732-1-houtao1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:48:10PM +0800, Hou Tao wrote:

> The root cause is the inconsistency between d_flags & d_inode
> during the REF-walk in lookup_fast(): d_is_negative(dentry)
> returns false, but d_backing_inode() still returns a NULL pointer.
> 
> The RCU-walk path in lookup_fast() uses d_seq to ensure d_flags & d_inode
> are consistent, and lookup_slow() use inode lock to ensure that, so only
> the REF-walk path in lookup_fast() is problematic.
> 
> Fixing it by adding a paired smp_rmb/smp_wmb between the reading/writing
> of d_inode & d_flags to ensure the consistency.

The problem is real, but I'm not sure I like the proposed fix ;-/
We could simply use d_really_is_negative() there, avoiding all that
mess.  If and when we get around to whiteouts-in-dcache (i.e. if
unionfs series gets resurrected), we can revisit that...
