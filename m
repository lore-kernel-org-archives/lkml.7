Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3924C2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="H4W1Gfzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfKFPOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:14:37 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41664 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfKFPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:14:36 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so1544647qvp.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MaiX8VRerzyev1ZArUoTJw696l2Gt83YXij8tyjJQbM=;
        b=H4W1GfzuYZ7DP0U0AybPzo8AboknGRb62bqzuQaXpMPd0WPSRuV572/5Fs/qVH/GOn
         lw3uqqU+HUwYTcVnrfYaLXinDqfO3AzL6wWm6yWXf5nGT3EEViJkb+hoLCIorOgQKlIl
         AD/yWfh5HrjZm06Gq9HAeKtg11KNLQO9VoVN7eAs0wi6hu8UX2TF14ELkTpJV0/u04V4
         lYqhhX6xaAdKoBneQRK4Xj4aDOo53fksK3cpIbHdeuW5VFJGrRq+jGVM7F9kOKvK5kFx
         3aVc7fth2qT7Zmlj84xPqI3DorZOd+qvsKl/u498TTdVDJvFG20OeOiSoYmn83m2JruN
         Q+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MaiX8VRerzyev1ZArUoTJw696l2Gt83YXij8tyjJQbM=;
        b=BQerg8peprjtnU+Xp+6zd1fli6WbzOAPN/LhQRjwXX81qtY+QxQ6dwle3/EtgYDgwG
         dqHaZ2A4yjOudsRrSGRSZbxdMbohNUCng5My0G0KrOhin9t/nx5VgPw9NFhEH4Cs/vrg
         x8bhH+h1FT40OiWlLC4bB6k67XTbNreelq8/3VRBmRwYXY4JsImkSeAXKikiTAnDSkyf
         IyPNRz8ijp/+06sznVScscsMPlXXy4cv3Z+cw6YauqRFqYlEF/6vY185M/yi+gknWwdy
         RrGyPCQ00JoAwpYOt0uii1R4XWBxMFG4vU/KwxKwxUq9HrwlNs2dTAFm3uoondHL8TiA
         T9dg==
X-Gm-Message-State: APjAAAVs8H/F1eCWcqiqv59knVuEn3PBg72znB2K+9o9aed1xfoszpDt
        SjlD+aJk8/GSZq488EEo5IMaHg==
X-Google-Smtp-Source: APXvYqzsVlFvlPYamFE6V1750HdcL+cbp5Vvqr3c7qxxcyeD2Ubns1CJiXub1aPqHB9M3Tkx4jkiug==
X-Received: by 2002:a0c:fa05:: with SMTP id q5mr2721824qvn.182.1573053273346;
        Wed, 06 Nov 2019 07:14:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::66e4])
        by smtp.gmail.com with ESMTPSA id u7sm12505786qkm.127.2019.11.06.07.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:14:32 -0800 (PST)
Date:   Wed, 6 Nov 2019 10:14:31 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, snazy@snazy.de,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
References: <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
 <20191106120315.GF16085@quack2.suse.cz>
 <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
 <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
 <20191106150524.GL16085@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106150524.GL16085@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:05:24PM +0100, Jan Kara wrote:
> On Wed 06-11-19 09:56:09, Josef Bacik wrote:
> > On Wed, Nov 06, 2019 at 02:45:43PM +0100, Robert Stupp wrote:
> > > On Wed, 2019-11-06 at 13:03 +0100, Jan Kara wrote:
> > > > On Tue 05-11-19 13:22:11, Johannes Weiner wrote:
> > > > > What I don't quite understand yet is why the fault path doesn't
> > > > > make
> > > > > progress eventually. We must drop the mmap_sem without changing the
> > > > > state in any way. How can we keep looping on the same page?
> > > >
> > > > That may be a slight suboptimality with Josef's patches. If the page
> > > > is marked as PageReadahead, we always drop mmap_sem if we can and
> > > > start
> > > > readahead without checking whether that makes sense or not in
> > > > do_async_mmap_readahead(). OTOH page_cache_async_readahead() then
> > > > clears
> > > > PageReadahead so the only way how I can see we could loop like this
> > > > is when
> > > > file->ra->ra_pages is 0. Not sure if that's what's happening through.
> > > > We'd
> > > > need to find which of the paths in filemap_fault() calls
> > > > maybe_unlock_mmap_for_io() to tell more.
> > > 
> > > Yes, ra_pages==0
> > > Attached the dmesg + smaps outputs
> > > 
> > > 
> > 
> > Ah ok I see what's happening, __get_user_pages() returns 0 if we get an EBUSY
> > from faultin_page, and then __mm_populate does nend = nstart + ret * PAGE_SIZE,
> > which just leaves us where we are.
> > 
> > We need to handle the non-blocking and the locking separately in __mm_populate
> > so we know what's going on.  Jan's fix for the readahead thing is definitely
> > valid as well, but this will keep us from looping forever in other retry cases.
> 
> I don't think this will work. AFAICS faultin_page() just checks whether
> 'nonblocking' is != NULL but doesn't ever look at its value... Honestly the
> whole interface is rather weird like lots of things around gup().
> 

Oh what the hell, yeah this is super bonkers.  The whole fault path probably
should be cleaned up to handle retry better.  This will do the trick I think?

Josef

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a335ae9..2468789298e6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -628,7 +628,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_WRITE;
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
-	if (nonblocking)
+	if (nonblocking && *nonblocking != 0)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
@@ -1237,6 +1237,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	unsigned long end, nstart, nend;
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
+	int nonblocking = 1;
 	long ret = 0;
 
 	end = start + len;
@@ -1268,7 +1269,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		ret = populate_vma_page_range(vma, nstart, nend, &nonblocking);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
@@ -1276,6 +1277,14 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 			}
 			break;
 		}
+
+		/*
+		 * We dropped the mmap_sem, so we need to re-lock, and the next
+		 * loop around we won't drop because nonblocking is now 0.
+		 */
+		if (!nonblocking)
+			locked = 0;
+
 		nend = nstart + ret * PAGE_SIZE;
 		ret = 0;
 	}
