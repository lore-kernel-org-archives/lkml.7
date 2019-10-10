Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB74C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570693111;
	bh=NL/tEtpoIxvVymAAXR8kmQMbwXwYwo1MzSsxWl1R5mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=egkwHhzP78uNNdhJ+3BXmeoaARp0USzS1SgY7vUBJXqdVEbUftk2gxa8ptZ9PgFgP
	 JrfV60+AlUb2UxgMLUn8TEBru9YZo7lzpE1/N1cQp3FO5P5EtG4VOIC2OeCVmLWgW8
	 LmbH6kDc2I5FUve8k7rpYL8lDiVneYWK5iKf3RS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfJJHi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733073AbfJJHd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:33:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5BF1B169;
        Thu, 10 Oct 2019 07:33:54 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:19:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Subject: Re: Potential NULL pointer deference in mm/memcontrol.c
Message-ID: <20191010071937.GA18412@dhcp22.suse.cz>
References: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 21:56:04, Yizhuo Zhai wrote:
> Hi All:
> mm/memcontrol.c:
> The function mem_cgroup_from_css() could return NULL, but some callers

This is the case only when the memory cgroup controller is disabled
which is a boot time option.

> in this file
> checks the return value but directly dereference it, which seems
> potentially unsafe.
> Such callers include mem_cgroup_hierarchy_read(),
> mem_cgroup_hierarchy_write(), mem_cgroup_read_u64(),
> mem_cgroup_reset(), etc.

And none of those should be ever called under that condition AFAICS.

Thanks!
-- 
Michal Hocko
SUSE Labs
