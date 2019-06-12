Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D01C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E046B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyjaHPUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408759AbfFLNzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:55:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39216 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407368AbfFLNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:55:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so8981654pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JuCNsBgKz2kjwwU2iDU7wV4lSMUa82jMKbRvCjaKNYk=;
        b=DyjaHPUeflN5ZsbtMGDS9Y5nT5fm3yy+sEHGvi6P//QVMQd2DHb7JAQZ1QAUpVOzvJ
         N+KZ9PwASzybi0SO1U8b+EDTeErIAqt7oZT6ojvJ5s9QMF+iex62ERsVrm8o8++vfvYF
         6VIib32cQ8JALMkAgDNWQCE8e241NVPKstnWeQ2+mGDa7iuxpNCsYDcTDmmSc7BWe0jg
         XvsfjxgQKxKqyhdeezlhXKq113Cv2BhnB7TVMXccoGCXQ37WlMG42T5+DCr0X7DLsQHw
         znEQuw8W69ywX1XQ5aVKeL7n1nqWdZLqmHcAvIkalngQAuijXjBjEd8XJaWH3wKRJYE9
         2Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuCNsBgKz2kjwwU2iDU7wV4lSMUa82jMKbRvCjaKNYk=;
        b=rcdR7l+KsQ7/KNKZ7S8vpTsnHEgdP9Y9SfkF403yGZdRpYAxOdE73q0BGUC/6zgL34
         le0sQeXpVTGWrhzheqkcJjytuKL5lC350hL4NPm/1aCbtZsdUeP9U2tXEiTq1i1ongcL
         Hr72CSDDYSkMIsqvCNa1lc8hkFKmrlkSOGvkN7JNgFgJcZPoUUCjvhwwo1bPiMdpg6JI
         oLIn3Xz6y4/wpe4vJFRq+f42gVumTpyQkUcIY3RpbWcZHk8HNQm+UZN+mSU/q7E52f7k
         LGW+zLRGc9SbZwiz0iOIOyXrSB5JJ0FD0R+qKpzVDSA9gdAT5QXvOrHUXIQCBZPo8a+u
         RICg==
X-Gm-Message-State: APjAAAWcUULu2MqxiHgoNJGqmlHOS3fASO41fs1O/OoAjv4fGfjXFdwi
        XhH24meGRjQjX/I6SXT2Ig==
X-Google-Smtp-Source: APXvYqxlJ7e75DsWX7egMpEWIh17YRS2EgGe1PzB66KsEeNy0SS0S0WCNWEmTNn2GsRLsUzGK7fXXQ==
X-Received: by 2002:a63:574b:: with SMTP id h11mr5323558pgm.25.1560347710137;
        Wed, 12 Jun 2019 06:55:10 -0700 (PDT)
Received: from dhcp-128-55.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j11sm2865040pfa.2.2019.06.12.06.55.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:55:09 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:54:58 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190612135458.GA19916@dhcp-128-55.nay.redhat.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <87tvcwhzdo.fsf@linux.ibm.com>
 <2807E5FD2F6FDA4886F6618EAC48510E79D8D79B@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79D8D79B@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:29:11PM +0000, Weiny, Ira wrote:
> > Pingfan Liu <kernelfans@gmail.com> writes:
> > 
> > > As for FOLL_LONGTERM, it is checked in the slow path
> > > __gup_longterm_unlocked(). But it is not checked in the fast path,
> > > which means a possible leak of CMA page to longterm pinned requirement
> > > through this crack.
> > 
> > Shouldn't we disallow FOLL_LONGTERM with get_user_pages fastpath? W.r.t
> > dax check we need vma to ensure whether a long term pin is allowed or not.
> > If FOLL_LONGTERM is specified we should fallback to slow path.
> 
> Yes, the fastpath bails to the slowpath if FOLL_LONGTERM _and_ DAX.  But it does this while walking the page tables.  I missed the CMA case and Pingfan's patch fixes this.  We could check for CMA pages while walking the page tables but most agreed that it was not worth it.  For DAX we already had checks for *_devmap() so it was easier to put the FOLL_LONGTERM checks there.
> 
Then for CMA pages, are you suggesting something like:
diff --git a/mm/gup.c b/mm/gup.c
index 42a47c0..8bf3cc3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2251,6 +2251,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
        if (unlikely(!access_ok((void __user *)start, len)))
                return -EFAULT;

+       if (unlikely(gup_flags & FOLL_LONGTERM))
+               goto slow;
        if (gup_fast_permitted(start, nr_pages)) {
                local_irq_disable();
                gup_pgd_range(addr, end, gup_flags, pages, &nr);
@@ -2258,6 +2260,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
                ret = nr;
        }

+slow:
        if (nr < nr_pages) {
                /* Try to get the remaining pages with get_user_pages */
                start += nr << PAGE_SHIFT;

Thanks,
  Pingfan
