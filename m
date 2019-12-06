Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FADEC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2524E20659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575642266;
	bh=ZZT369kA6Po8rzHTdXYEw5LXvSzYqDbFmh48D/9ldN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VqN837a2WQTHSAc7DKu3gaLgYv2usie/xCQBBU5zA4BJQ0IPDb9ZWBS6kysK945he
	 +mcWFeOVK/J+DBaO77Ae9aS1jZ9mUDh2WxdqWrt4Mbua4bhEY3p/1TG+W2N5pBJ1T5
	 25dd5UJYfBuaPcvQPP8CaWrrp8ezvKdDfzwfLyVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:24:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:24:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so7917339wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vc6cQnfCxKN0uDPrk49B3m1HkxNISZTqI0Pp7rQHqII=;
        b=cGr7X6RF7ZcUqQsmj+Tx6kD94zVjwY7czhSIdCoTzdqJkhAcfNjeMCm0o3jK6YvgLU
         syhv7pP7bcR7KlJHDbPtY5Qt7H4QNW8gAW23AfgowOlmzA4abOI6UbrnmV5FyZcQwj2D
         MTJriYwtljz4NwzpKuVGQuAz+u/cTM5qcMynPAbospfZhyvdGoZ+gixmftRq+q+8TDGT
         H12mGNkSXG3vIfHJItdcK/XiMuAXz0xY1pa7BAQxXKfALgjmk0NchKiy53dd3sYU1bZR
         fkvpXmNXNWI4uQT2WteB3sb071v/Q1Ol5lN1Wm11uuTQcvHpnZAf8LMWAHaNJjSfUS6S
         SjwQ==
X-Gm-Message-State: APjAAAWPFkldamGlnIUc/es8chcg4pv3vSCtXpanDVGhiPvhMV1AocHK
        vWFUKvPi68nWeIPn2LbH8QE=
X-Google-Smtp-Source: APXvYqwwmMDnS2FZLfKG16pLce1tzYWbto9tStZ6peuTR2ohVxYhKW7GPLX8eCkxS/T2ph8KLjhUOw==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr16211867wrc.60.1575642260421;
        Fri, 06 Dec 2019 06:24:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z6sm17140998wrw.36.2019.12.06.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:24:19 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:24:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "thomas_os@shipmail.org" <thomas_os@shipmail.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH v3 2/2] mm, drm/ttm: Fix vm page protection handling
Message-ID: <20191206142418.GP28317@dhcp22.suse.cz>
References: <20191206082426.2958-1-thomas_os@shipmail.org>
 <20191206082426.2958-3-thomas_os@shipmail.org>
 <20191206103055.GO28317@dhcp22.suse.cz>
 <10c4835486275e87334058bc2f406609c55271eb.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10c4835486275e87334058bc2f406609c55271eb.camel@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-12-19 14:16:10, Thomas Hellstrom wrote:
> Hi Michal,
> 
> On Fri, 2019-12-06 at 11:30 +0100, Michal Hocko wrote:
> > On Fri 06-12-19 09:24:26, Thomas Hellström (VMware) wrote:
> > [...]
> > > @@ -283,11 +282,26 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct
> > > vm_fault *vmf,
> > >  			pfn = page_to_pfn(page);
> > >  		}
> > >  
> > > +		/*
> > > +		 * Note that the value of @prot at this point may
> > > differ from
> > > +		 * the value of @vma->vm_page_prot in the caching- and
> > > +		 * encryption bits. This is because the exact location
> > > of the
> > > +		 * data may not be known at mmap() time and may also
> > > change
> > > +		 * at arbitrary times while the data is mmap'ed.
> > > +		 * This is ok as long as @vma->vm_page_prot is not used
> > > by
> > > +		 * the core vm to set caching- and encryption bits.
> > > +		 * This is ensured by core vm using pte_modify() to
> > > modify
> > > +		 * page table entry protection bits (that function
> > > preserves
> > > +		 * old caching- and encryption bits), and the @fault
> > > +		 * callback being the only function that creates new
> > > +		 * page table entries.
> > > +		 */
> > 
> > While this is a very valuable piece of information I believe we need
> > to
> > document this in the generic code where everybody will find it.
> > vmf_insert_mixed_prot sounds like a good place to me. So being
> > explicit
> > about VM_MIXEDMAP. Also a reference from vm_page_prot to this
> > function
> > would be really helpeful.
> > 
> > Thanks!
> > 
> 
> Just to make sure I understand correctly. You'd prefer this (or
> similar) text to be present at the vmf_insert_mixed_prot() and
> vmf_insert_pfn_prot() definitions for MIXEDMAP and PFNMAP respectively,
> and a pointer from vm_page_prot to that text. Is that correct?

Yes. You can keep whatever is specific to TTM here but the rest should
be somewhere visible to users of the interface and a note at
vm_page_prot should help anybody touching the generic/core code to not
break those expectations.

Thanks!
-- 
Michal Hocko
SUSE Labs
