Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19824C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C0520656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfDQPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:54:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729940AbfDQPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:54:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8BA5ADAA;
        Wed, 17 Apr 2019 15:54:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82B49DA871; Wed, 17 Apr 2019 17:55:20 +0200 (CEST)
Date:   Wed, 17 Apr 2019 17:55:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Message-ID: <20190417155520.GI20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416174900.GT2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:49:00PM +0100, Al Viro wrote:
> 	We have a lot of boilerplate in ->destroy_inode()
> instances, and several filesystems got the things wrong
> in that area.  The patchset below attempts to deal with that.
> 
> 	New method (void ->free_inode(inode)) is introduced,
> and RCU-delayed parts of ->destroy_inode() are moved there.
> The change is backwards-compatible - unmodified filesystem
> will behave as it used to.  Rules:
> 	->destroy_inode		->free_inode
> 	f			g		f(), rcu-delayed g()
> 	f			NULL		f()
> 	NULL			g		rcu-delayed g()
> 	NULL			NULL		rcu-delayed free_inode_nonrcu()
> IOW, NULL/NULL acts as NULL/free_inode_nonrcu.
> 
> 	For a lot of filesystems ->destroy_inode() used to consist
> only of call_rcu(foo_i_callback, &inode->i_rcu).  Those simply get
> rid of ->destroy_inode() and have the callback (with saner prototype)
> become their ->free_inode().

The simplified API looks good to me. For btrfs and affs bits:

Acked-by: David Sterba <dsterba@suse.com>
