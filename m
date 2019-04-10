Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62BFC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E672082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDJWAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:00:54 -0400
Received: from namei.org ([65.99.196.166]:33568 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:00:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AM0hDW005829;
        Wed, 10 Apr 2019 22:00:43 GMT
Date:   Thu, 11 Apr 2019 08:00:43 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: inode: fix a missing check for
 securityfs_create_file
In-Reply-To: <20190410180156.GZ2217@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.21.1904110800260.5714@namei.org>
References: <alpine.LRH.2.21.1903160608080.2905@namei.org> <20190315210025.17832-1-kjlu@umn.edu> <alpine.LRH.2.21.1904110334380.25754@namei.org> <20190410180156.GZ2217@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019, Al Viro wrote:

> Rather bad way to do it - generally, register_filesystem() should be
> the last thing done by initialization.  Any modular code that
> does unregister_filesystem() on failure exit is flat-out broken;
> here it's not instantly FUBAR, but it's a bloody bad example.
> 
> What's more, why not let simple_fill_super() do it?  Just
> static int fill_super(struct super_block *sb, void *data, int silent)
> {
>         static const struct tree_descr files[] = {
> #ifdef CONFIG_SECURITY
> 		{"lsm", &lsm_ops, 0444},
> #endif
> 		{""}
> 	};
> 
> and to hell with that call of securityfs_create_file() and all its
> failure handling...

Thanks for the review.  Reverted.

-- 
James Morris
<jmorris@namei.org>

