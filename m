Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A02C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143721537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zrrtFvrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFUNgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:36:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45330 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:36:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so10102723edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cnC3suzlgwD62Q8O7FoLN2Bc0yj3F9CWcR6TgaR1LLc=;
        b=zrrtFvrl4p7uTqycYUBHGqaztc91HANl9u9PpKLY7U7rcWsCOOeWiEDqlASL4SSEuY
         ZqqicXW/nV5z+021k5EusmejEXXNNfgLn3AvyKy6M71xezPYdXaG0rCj9wTdkWiMDHkG
         /Cl3PE8EUukQhj0s9A9WX3zqTgEwNaIZaXQQnVAE/2/gc7JSt8hB0gS4w2ympIr1Yrxy
         mmZzOvlxL/7bfRgFnthfff+zVrJS39UskfbFNPwu7sXRX8oj+Ufgl3BNlkqQMt6o9YAN
         jqRYeFjPL/z3fsImc5/ifslgFZuK7s81erlgqIukiir0X2pl9WFKyjdvldE9MDFxGJ+Y
         EpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cnC3suzlgwD62Q8O7FoLN2Bc0yj3F9CWcR6TgaR1LLc=;
        b=npYilcgpruJ7CZ7VYGVJHpTd0AtHcTaUTCEIPRJuzDY8+CkPm+3Z2Vw9Dt7+SW+mb7
         bsTaQ/w0JwXA3D3VubN+fgoWiu9KdgKRtyj3SPfIXPbkgQueomM0wNRBvluwJXrxUdYO
         uPfvLsM25LXrRrQOYhbAFT1M9sBW0GvL+rKnwc8k0QbR91uVkis9qtJuXi4XvV99Vxuj
         ltDrfXqvDqAogjIBhpiRVcfnFbjSQL4VgjlvQGIehVBRRdoAYCVqjkIIzAjl4SpNPAO1
         9Y9LQ4xOqthHdPsCNrw3nE0WTSPp027a0vUZTZ4OCWtY61nufc/+XXQjJurVlnYULT+g
         b+7g==
X-Gm-Message-State: APjAAAW5w40GMbaRd/ePXPwtLCyQep+zrVAQfvrZu/knq0ZG2GiiLjAY
        nt401DF/fUbeydi1/3T+K0+Vyw1dOo4=
X-Google-Smtp-Source: APXvYqylF/ZGnoajREjtqJ3qd8ZnbSjXbf2NB4U/xNXjWS/QwEe58V6Y8Ny7PU80e6ICaU6cNuj7qg==
X-Received: by 2002:a17:906:5008:: with SMTP id s8mr80542081ejj.308.1561124171736;
        Fri, 21 Jun 2019 06:36:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e1sm432826ejl.2.2019.06.21.06.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:36:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 39A5410289C; Fri, 21 Jun 2019 16:36:13 +0300 (+03)
Date:   Fri, 21 Jun 2019 16:36:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Message-ID: <20190621133613.xnzpdlicqvjklrze@box>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-6-songliubraving@fb.com>
 <20190621124823.ziyyx3aagnkobs2n@box>
 <B72B62C9-78EE-4440-86CA-590D3977BDB1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B72B62C9-78EE-4440-86CA-590D3977BDB1@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:17:05PM +0000, Song Liu wrote:
> 
> 
> > On Jun 21, 2019, at 5:48 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Thu, Jun 13, 2019 at 10:57:47AM -0700, Song Liu wrote:
> >> After all uprobes are removed from the huge page (with PTE pgtable), it
> >> is possible to collapse the pmd and benefit from THP again. This patch
> >> does the collapse.
> >> 
> >> An issue on earlier version was discovered by kbuild test robot.
> >> 
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> include/linux/huge_mm.h |  7 +++++
> >> kernel/events/uprobes.c |  5 ++-
> >> mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++++++
> > 
> > I still sync it's duplication of khugepaged functinallity. We need to fix
> > khugepaged to handle SCAN_PAGE_COMPOUND and probably refactor the code to
> > be able to call for collapse of particular range if we have all locks
> > taken (as we do in uprobe case).
> > 
> 
> I see the point now. I misunderstood it for a while. 
> 
> If we add this to khugepaged, it will have some conflicts with my other 
> patchset. How about we move the functionality to khugepaged after these
> two sets get in? 

Is the last patch of the patchset essential? I think this part can be done
a bit later in a proper way, no?

-- 
 Kirill A. Shutemov
