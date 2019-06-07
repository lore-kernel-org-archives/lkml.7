Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D523C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E2D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559917539;
	bh=pQE1N8ceBIikDupWmP1H4L2CLUPsxbXwuhohdGY2fyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lQxEhcOjx/Fx+N1/WAbo96rBGLWu7VtNhCN/nt4g+uFLNNvWEcaeldfZm51ScHYpK
	 qWBnmhp0ys9pjT9/sp3LzxupEbyU5oqiPzwGdFuDYwzFHVTQ4dd+4oQ52zjPnju7Mn
	 yRKm8WYWCtClyyhfYljfH0LJvnU0j/YqjG0M29Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfFGOZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:25:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728572AbfFGOZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94217AF05;
        Fri,  7 Jun 2019 14:25:36 +0000 (UTC)
Date:   Fri, 7 Jun 2019 16:25:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
Message-ID: <20190607142525.GH18435@dhcp22.suse.cz>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190423175252.GP25106@dhcp22.suse.cz>
 <5a571d64-bfce-aa04-312a-8e3547e0459a@linux.alibaba.com>
 <859fec1f-4b66-8c2c-98ee-2aee9358a81a@linux.alibaba.com>
 <20190507104709.GP31017@dhcp22.suse.cz>
 <ec8a65c7-9b0b-9342-4854-46c732c99390@linux.alibaba.com>
 <217fc290-5800-31de-7d46-aa5c0f7b1c75@linux.alibaba.com>
 <alpine.LSU.2.11.1906070314001.1938@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1906070314001.1938@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-06-19 03:57:18, Hugh Dickins wrote:
[...]
> The addition of "THPeligible" without an "Anon" in its name was
> unfortunate. I suppose we're two releases too late to change that.

Well, I do not really see any reason why THPeligible should be Anon
specific at all. Even if ...

> Applying process (PR_SET_THP_DISABLE) and mm (MADV_*HUGEPAGE)
> limitations to shared filesystem objects doesn't work all that well.

... this is what we are going with then it is really important to have a
single place to query the eligibility IMHO.

> I recommend that you continue to treat shmem objects separately from
> anon memory, and just make the smaps "THPeligible" more often accurate.

Agreed on this.

-- 
Michal Hocko
SUSE Labs
