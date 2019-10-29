Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E7ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A851D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572341585;
	bh=ESgihE2mJ4D11bv8ffgzhtfjRAPEzR6CfHa6NOhpS28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c8F1HjGG1TYiKu05yvJ6wQfQD3mEXq2OdVtLvlC+n1YvoRM3IRUrElUv4nopXkrB9
	 GlSsMvb04jfNz30XSFGGHUiALq7XWxMF5ikZ8wjHorWfklLUH8RRO54jgXYPRZIoGy
	 gZIbX8FZFGvnWp0vH68MCMrOhF0TDGLXrB5pDdOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfJ2JdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbfJ2JdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:33:04 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B280420659;
        Tue, 29 Oct 2019 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572341583;
        bh=ESgihE2mJ4D11bv8ffgzhtfjRAPEzR6CfHa6NOhpS28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b76gBopGQtasuYSgygtwkzaQ/4y91+5mDJkP7lN2pFY2n6fz9mc9YFalNKWYcRl2C
         WFKNMuLjHFlOk1UesDi1bFfh6LiIOp+zEI/cwbSJOHuCVbiEaKTjUfTLO2jMo+HXwn
         0gx/OPrRM6GrjhsxjLqLrlCKVB4dW71GENjTlkYs=
Date:   Tue, 29 Oct 2019 10:32:55 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029093254.GE18773@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:44:23PM -0600, Andy Lutomirski wrote:
> 
> > On Oct 27, 2019, at 4:17 AM, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > ﻿From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > The patch below aims to allow applications to create mappins that have
> > pages visible only to the owning process. Such mappings could be used to
> > store secrets so that these secrets are not visible neither to other
> > processes nor to the kernel.
> > 
> > I've only tested the basic functionality, the changes should be verified
> > against THP/migration/compaction. Yet, I'd appreciate early feedback.
> 
> I’ve contemplated the concept a fair amount, and I think you should
> consider a change to the API. In particular, rather than having it be a
> MAP_ flag, make it a chardev.  You can, at least at first, allow only
> MAP_SHARED, and admins can decide who gets to use it.  It might also play
> better with the VM overall, and you won’t need a VM_ flag for it — you
> can just wire up .fault to do the right thing.

I think mmap()/mprotect()/madvise() are the natural APIs for such
interface. Switching to a chardev doesn't solve the major problem of direct
map fragmentation and defeats the ability to use exclusive memory mappings
with the existing allocators, while mprotect() and madvise() do not.

-- 
Sincerely yours,
Mike.
