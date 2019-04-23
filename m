Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75476217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfDWPQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:16:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36602 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfDWPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:16:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hIx9a-0004SB-Tv; Tue, 23 Apr 2019 15:16:15 +0000
Date:   Tue, 23 Apr 2019 16:16:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190423151614.GN2217@ZenIV.linux.org.uk>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
 <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
 <20190421170235.GI2217@ZenIV.linux.org.uk>
 <20190423145237.GA3609@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423145237.GA3609@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:22:37PM +0530, Bharath Vedartham wrote:

> > ISTR some discussions of reiserfs layout endianness problems, but
> > that had been many years ago and I could be wrong; I _think_
> > the conclusion had been "it sucks, but we can't do anything
> > without breaking existing filesystem images".  Not sure if that
> > was the same bug or something different, though.
> 
> Hi Al,
> 
> Thanks for your detailed explanation. I learnt quite a bit from it. 
> I agree we should not "supress" this bug.
> 
> I have noticed in the reiserfs code that, a checksum mismatch only
> causes a warning? Even if there is a checksum mismatch, data still is
> copied to the buffer? 
> 
> What is the point of the checksum over here? 

                reiserfs_warning(inode->i_sb, "jdm-20002",
                                 "Invalid hash for xattr (%s) associated "
                                 "with %k", name, INODE_PKEY(inode));
                err = -EIO;
IOW, reiserfs_xattr_get() fails on mismatch, not just whines into log.
