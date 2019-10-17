Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69835ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461EF2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407240AbfJQChm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:37:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfJQChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:37:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKvfT-0001pf-6k; Thu, 17 Oct 2019 02:37:35 +0000
Date:   Thu, 17 Oct 2019 03:37:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no
Subject: Re: KASAN: use-after-free Read in mnt_warn_timestamp_expiry
Message-ID: <20191017023735.GS26530@ZenIV.linux.org.uk>
References: <0000000000007f489b0595115374@google.com>
 <20191017014755.GA1552@sol.localdomain>
 <20191017015853.GR26530@ZenIV.linux.org.uk>
 <20191017022705.GB1552@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017022705.GB1552@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:27:05PM -0700, Eric Biggers wrote:

> How about the following?
> 
> 	pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
> 		sb->s_type->name,
> 		is_mounted(mnt) ? "remounted" : "mounted",
> 		mntpath,
> 		tm.tm_year+1900, (unsigned long long)sb->s_time_max);
> 
> I think more people would understand "remounted" than "reconfigured".  Also,
> is_mounted(mnt) seems like a better choice than mnt_has_parent(real_mount(mnt)).

Works for me(tm).  Care to fold that into your patch and resend?
