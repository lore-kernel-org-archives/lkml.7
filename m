Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ACAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407A022DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfHTLtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:49:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:42261 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbfHTLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:49:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E2887C009; Tue, 20 Aug 2019 13:49:42 +0200 (CEST)
Date:   Tue, 20 Aug 2019 13:49:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: avoid attaching writeback_fid on mmap with type
 PRIVATE
Message-ID: <20190820114927.GA12715@nautica>
References: <20190820100325.10313-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820100325.10313-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengguang Xu wrote on Tue, Aug 20, 2019:
> Currently on mmap cache policy, we always attach writeback_fid
> whether mmap type is SHARED or PRIVATE. However, in the use case
> of kata-container which combines 9p(Guest OS) with overlayfs(Host OS),
> this behavior will trigger overlayfs' copy-up when excute command
> inside container.

hmm, I guess this just works for non-ovl cases because sync_inode()
realizes there is nothing to sync, but the fsync at the end still
triggers the copy-up ?

Well, I guess there really is no need to flush for private mappings,
so might as well go for this; sparing an extra useless clone walk cannot
hurt.

I'll queue this up after tests, no promise on delay sorry :/
-- 
Dominique
