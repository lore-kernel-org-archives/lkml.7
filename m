Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188DC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8552A24683
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFSUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:20:00 -0500
Received: from gentwo.org ([3.19.106.255]:47162 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfLFSUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:20:00 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id F0F143EE4A; Fri,  6 Dec 2019 18:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id F00093EE48;
        Fri,  6 Dec 2019 18:19:58 +0000 (UTC)
Date:   Fri, 6 Dec 2019 18:19:58 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qian Cai <cai@lca.pw>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
In-Reply-To: <BE1B9B9B-17C2-4093-A332-183DF3B6F2A3@lca.pw>
Message-ID: <alpine.DEB.2.21.1912061815160.17787@www.lameter.com>
References: <5384814f-c937-9622-adbe-c03e199e0267@linux.alibaba.com> <BE1B9B9B-17C2-4093-A332-183DF3B6F2A3@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-481738838-1575656398=:17787"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-481738838-1575656398=:17787
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 6 Dec 2019, Qian Cai wrote:

> > On Dec 6, 2019, at 12:31 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >
> > It looks since commit e78bbfa82624 ("mm: stop returning -ENOENT from sys_move_pages() if nothing got migrated") too, which reset err to 0 unconditionally. It seems it is on purpose by that commit the syscall caller should check status for the details according to the commit log.
>
> I don’t read it on purpose. “There is no point in returning -ENOENT from
> sys_move_pages() if all pages were already on the right node”, so this
> is only taking about the pages in the desired node. Anyway, but now it
> is probably the best time to think outside the box redesigning this
> syscalls and nuke this whole mess.

The nature of the beast is that moving pages is not a deterministic
process. The ability to move depends on pages being pinned and locked
by other kernel subsystem. Other system components may also move the page
independently.

If the user calls this system call and wants to move some pages then he
has presumably figured out somehow that pages are misplaced. If no pages
can be moved then the system call did nothing which could indicate that
some other process is interfering with the desire to move pages to certain
nodes.

This could be important to know (maybe the other system components already
moved the page indepently or another user is also migrating pages).
--531401748-481738838-1575656398=:17787--
