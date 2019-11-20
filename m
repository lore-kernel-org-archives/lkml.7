Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4434920709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSmjMhQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfKTPqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbfKTPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y+r4uRt0HfEzC6FA94CrzjLBOB4pZm30/6RDjRbTH2g=; b=tSmjMhQWEB6+CN5nvKQYwrE4j
        KN9lA3Wy9FdbarML5HFOnBe/e5P+FIJNuzW/qZfMiWe8AAYY+17KukZlabN24ozKEMqVR6yr/CgUN
        V5RxLT241bf/rr2fd7497JpuAT5hQ0Tvl5dzLOvhVpsbu543my2G37XYlFxxR737pWXCLKiJeCnNw
        UPmEIM/qcuFPEOtrNXLHssgN5YfiEmEq/0ILBivrDgxVDqspH26C3K70zyBx6dxc6j5NGVl8olIwF
        3Je8ZTgYWEvDuYtIg469g95Cyue9Mvu2MnRgBKJ6jrz4SvlO/zPwgwlnsF7Aqm3uriAzfK3z88Acv
        01CiO8UcA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXSAy-0003As-3v; Wed, 20 Nov 2019 15:45:52 +0000
Date:   Wed, 20 Nov 2019 07:45:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     viro@zeniv.linux.org.uk, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] tmpfs: use ida to get inode number
Message-ID: <20191120154552.GS20752@bombadil.infradead.org>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:23:18PM +0800, zhengbin wrote:
> I have tried to change last_ino type to unsigned long, while this was
> rejected, see details on https://patchwork.kernel.org/patch/11023915.

Did you end up trying sbitmap?

What I think is fundamentally wrong with this patch is that you've found a
problem in get_next_ino() and decided to use a different scheme for this
one filesystem, leaving every other filesystem which uses get_next_ino()
facing the same problem.

That could be acceptable if you explained why tmpfs is fundamentally
different from all the other filesystems that use get_next_ino(), but
you haven't (and I don't think there is such a difference.  eg pipes,
autofs and ipc mqueue could all have the same problem.

There are some other problems I noticed, but they're not worth bringing
up until this fundamental design choice is justified.
