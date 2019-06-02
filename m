Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9CC28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 02:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5CA2780F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 02:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFBCnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:43:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfFBCnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 22:43:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hXGSt-0001lc-Pr; Sun, 02 Jun 2019 02:43:23 +0000
Date:   Sun, 2 Jun 2019 03:43:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Yan, Zheng" <zyan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, idryomov@redhat.com,
        jlayton@redhat.com
Subject: Re: [PATCH] ceph: use ceph_evict_inode to cleanup inode's resource
Message-ID: <20190602024316.GT17978@ZenIV.linux.org.uk>
References: <20190602022546.16195-1-zyan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602022546.16195-1-zyan@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 10:25:46AM +0800, Yan, Zheng wrote:
> remove_session_caps() relies on __wait_on_freeing_inode(), to wait for
> freezing inode to remove its caps. But VFS wakes freeing inode waiters
> before calling destroy_inode().

*blink*

Which tree is that against?

> -static void ceph_i_callback(struct rcu_head *head)
> -{
> -	struct inode *inode = container_of(head, struct inode, i_rcu);
> -	struct ceph_inode_info *ci = ceph_inode(inode);
> -
> -	kfree(ci->i_symlink);
> -	kmem_cache_free(ceph_inode_cachep, ci);
> -}

... is gone from mainline, and AFAICS not reintroduced in ceph tree.
What am I missing here?
