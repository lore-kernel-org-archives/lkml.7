Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78064C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB520881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T11Vup/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfENXH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 19:07:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40876 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:07:57 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so1527061ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpPu6Srd12TWDsvx6xpShWyEQ5HvPxAwKNMasqNHAbk=;
        b=T11Vup/cYbfwY6YzAWV/mGwGD1gQDYyQC6G2BxXK4PPC718ZLMCye+aG74WCj5fos9
         09wYZgeFb/k3+WuqEj2zLbyGm+bkK2/fb3EhCCyuqqbpOLLYRADkdR71j6umz8fgOctZ
         oqF99nuKSPFnPGmRSiq5LQk19GqyNEeW44WFHIe5sd7P733SpJ5y5USvprGUccgWM81n
         nGOhxOhJ7X/f4vqn4W7KFFCnNxOOifuIbvXltdYt19gYBbkBHc5QoQjg7VswpWrjrFuw
         ecnaOdC9+M3e21yFG1yAo7HXSJsQE+PZ29OeX51tStLm2xS3s+V9hEk1Af9GkrlUK6et
         GgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpPu6Srd12TWDsvx6xpShWyEQ5HvPxAwKNMasqNHAbk=;
        b=JgakVNbJKWvIy6di1Nw0EniozDLX6LUvYOPn9igpIDYQyPxqOZZcMB33KoPy+im9FH
         PH6CdY6Qfgx5VynsgSLZEbPTRi7ixcQdlYTihEq2uuIOBw+Fs3Z6rPQAlU6RpiYeHWQN
         CWgUPMtAMAQwoJeUbzNlRMZMYhk5pHLNlxI9zJaD0zDQQMdAYEia0PaSAuFRIAINXxB8
         FvIFffOhU0GP8/VMnRWJK0N5EhL9WS85aMrsN2rAnKQaSsZeIB2BrCp3vKY+PQKCOUDY
         ylfLFf2aT0j9veK8ArbqKc2FKLgm3US3BElAj89c0sVg0lm+SPMXLCzqduVjZDd8OD+f
         rqcg==
X-Gm-Message-State: APjAAAUBX+65INsq9Chz7mCM2LFVMu66uMTUKMg2ylMA8wpST8UOU0FV
        BgRqQnJbGkrEEqWhkf4Bel0ITg==
X-Google-Smtp-Source: APXvYqxzoN7tuegV3gbfgvvbtn2Q1L1KZkn1XCuidG9PwFMOYDrpY9iAjhpTh23QbBLY6Tw5nU3lYw==
X-Received: by 2002:a24:8b07:: with SMTP id g7mr5386727ite.129.1557875276553;
        Tue, 14 May 2019 16:07:56 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id m142sm199408itb.31.2019.05.14.16.07.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 16:07:55 -0700 (PDT)
Date:   Tue, 14 May 2019 17:07:51 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't expose page to fast gup before it's ready
Message-ID: <20190514230751.GA70050@google.com>
Reply-To: Andrew Morton <akpm@linux-foundation.org>,
          Michal Hocko <mhocko@kernel.org>
References: <20180108225632.16332-1-yuzhao@google.com>
 <20180109084622.GF1732@dhcp22.suse.cz>
 <20180109101050.GA83229@google.com>
 <20190514142527.356cb071155cd1077536f3da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514142527.356cb071155cd1077536f3da@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:25:27PM -0700, Andrew Morton wrote:
> On Tue, 9 Jan 2018 02:10:50 -0800 Yu Zhao <yuzhao@google.com> wrote:
> 
> > > Also what prevents reordering here? There do not seem to be any barriers
> > > to prevent __SetPageSwapBacked leak after set_pte_at with your patch.
> > 
> > I assumed mem_cgroup_commit_charge() acted as full barrier. Since you
> > explicitly asked the question, I realized my assumption doesn't hold
> > when memcg is disabled. So we do need something to prevent reordering
> > in my patch. And it brings up the question whether we want to add more
> > barrier to other places that call page_add_new_anon_rmap() and
> > set_pte_at().
> 
> Is a new version of this patch planned?

Sorry for the late reply. The last time I tried, I didn't come up
with a better fix because:
  1) as Michal pointed out, we need to make sure the fast gup sees
  all changes made before set_pte_at();
  2) pairing smp_wmb() in set_pte/pmd_at() with smp_rmb() in gup
  seems the best way to prevent any potential ordering related
  problems in the future;
  3) but this slows down the paths that don't require the smp_mwb()
  unnecessarily.

I didn't give it further thought because the problem doesn't seem
fatal at the time. Now the fast gup has changed and the problem is
serious:

	CPU 1				CPU 1
set_pte_at			get_user_pages_fast
page_add_new_anon_rmap		gup_pte_range
__SetPageSwapBacked (fetch)
				try_get_compound_head
				page_ref_add_unless
__SetPageSwapBacked (store)

Or the similar problem could happen to __do_huge_pmd_anonymous_page(),
for the reason of missing smp_wmb() between the non-atomic bit op
and set_pmd_at().

We could simply replace __SetPageSwapBacked() with its atomic
version. But 2) seems more preferable to me because it addresses
my original problem:

> > I didn't observe the race directly. But I did get few crashes when
> > trying to access mem_cgroup of pages returned by get_user_pages_fast().
> > Those page were charged and they showed valid mem_cgroup in kdumps.
> > So this led me to think the problem came from premature set_pte_at().

Thoughts? Thanks.
