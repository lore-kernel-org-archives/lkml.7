Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDA020650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572521174;
	bh=4sAehePpj6xZ6iopTBgUkIAGWEP5mxLV4kz/agNymUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wLKa9jnPKC1efJSIKjBxu6FHJbur3tHbJgdr2bVKhns1TflNDQbwWGhBUljYphyyP
	 s2TKmPaf4jMatJNvddtPNeJhOqVsauVLKOaXLfykXPMk2E2F+4RhTt4/W/AS4UtBWx
	 JOOZJvroEvTNDEpeYsYnk14vl3ipyagRfVnqPy7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJaL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:45560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbfJaL0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:26:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C7B6B5F1;
        Thu, 31 Oct 2019 11:26:10 +0000 (UTC)
Date:   Thu, 31 Oct 2019 12:26:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Xinhai <lixinhai.lxh@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        API <linux-api@vger.kernel.org>, Dickins <hughd@google.com>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix checking unmapped holes for mbind
Message-ID: <20191031112609.GG13102@dhcp22.suse.cz>
References: <201910291756045288126@gmail.com>
 <20191030210836.a17c0649354b59961903d1a8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191030210836.a17c0649354b59961903d1a8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-10-19 21:08:36, Andrew Morton wrote:
> (cc linux-man@vger.kernel.org)
> 
> On Tue, 29 Oct 2019 17:56:06 +0800 "Li Xinhai" <lixinhai.lxh@gmail.com> wrote:
> 
> > queue_pages_range() will check for unmapped holes besides queue pages for
> > migration. The rules for checking unmapped holes are:
> > 1 Unmapped holes at any part of the specified range should be reported as
> >   EFAULT if mbind() for none MPOL_DEFAULT cases;
> > 2 Unmapped holes at any part of the specified range should be ignored if
> >   mbind() for MPOL_DEFAULT case;
> > Note that the second rule is the current implementation, but it seems
> > conflicts the Linux API definition.
> 
> Can you quote the part of the API definition which you're looking at?
> 
> My mbind(2) manpage says
> 
> ERRORS
>        EFAULT Part or all of the memory range specified by nodemask and maxn-
>               ode points outside your accessible address space.  Or, there was
>               an unmapped hole in the specified memory range specified by addr
>               and len.
> 
> (I assume the first sentence meant to say "specified by addr and len")

My understanding is that this really refers to area pointed to by nodemask.
Btw. why there is any special casing around the unmapped holes with the
address space range? This looks like an antipattern to other address
space operations to me. E.g. munmap simply unmaps all existing vmas in
the given range, mprotect, madvise etc. behave the same.

So my question is, do we want to remove that weird restriction and
simply act on all existing VMAs in the range? The only situation this
could regress would be if somebody used mbind to probe for existing VMAs
and that sounds a more than sensible to me. Or am I missing anything?
-- 
Michal Hocko
SUSE Labs
