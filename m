Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B212087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558014788;
	bh=M/c+yYRX+0rot4S6x7CSSsHxUC8TWuladOOIMr9/RgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wi3SkWwi4QlgzMvynrq9DHPSA9FoTiCAidrPya7Ux8tRsTd8fWXoFXaFT6AM6hsXA
	 Gewlijl2UjNgyrQREmjB8T/XBTFhHtO9ufSDPBJyyv/+NZnlXsK56a3bAyhVvE0lYo
	 3Ta3PjnPD72mlM5xeb7S3bsKRMdbTrMdK/tEkIMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfEPNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:53:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEPNxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:53:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06CCAAED7;
        Thu, 16 May 2019 13:53:05 +0000 (UTC)
Date:   Thu, 16 May 2019 15:52:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        keith.busch@intel.com, kirill.shutemov@linux.intel.com,
        pasha.tatashin@oracle.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190516135259.GU16651@dhcp22.suse.cz>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
 <20190516133034.GT16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516133034.GT16651@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-05-19 15:30:34, Michal Hocko wrote:
> [You are defining a new user visible API, please always add linux-api
>  mailing list - now done]
> 
> On Wed 15-05-19 18:11:15, Kirill Tkhai wrote:
[...]
> > The proposed syscall aims to introduce an interface, which
> > supplements currently existing process_vm_writev() and
> > process_vm_readv(), and allows to solve the problem with
> > anonymous memory transfer. The above example may be rewritten as:
> > 
> > 	void *buf;
> > 
> > 	buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
> > 		   MAP_PRIVATE|MAP_ANONYMOUS, ...);
> > 	recv(sock, buf, n * PAGE_SIZE, 0);
> > 
> > 	/* Sign of @pid is direction: "from @pid task to current" or vice versa. */
> > 	process_vm_mmap(-pid, buf, n * PAGE_SIZE, remote_addr, PVMMAP_FIXED);
> > 	munmap(buf, n * PAGE_SIZE);

AFAIU this means that you actually want to do an mmap of an anonymous
memory with a COW semantic to the remote process right? How does the
remote process find out where and what has been mmaped? What if the
range collides? This sounds quite scary to me TBH. Why cannot you simply
use shared memory for that?
-- 
Michal Hocko
SUSE Labs
