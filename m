Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23A8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65664206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564642276;
	bh=f7oq1H1zwPtiRiDAkgHRibopVd4IUb+QEnxna6oeIfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H9Kwb8cMvAuuURYxhxdcCw6t6yWv3eUSmDBMWt+XWe/BjDgkBYXPzjVbuQCBpXZXl
	 ZM9t1tNToBUGs23iSNJhMQKyMQKFEFu6ZGPUBN7o0AzK2WZnaEXlJGQG1CYWRQfCXi
	 UTroWbQb2gDcnQyKnvLtCJgtrsWHkl8j5E/tnnwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfHAGvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:51:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41143 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:51:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so31611054pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z+wSy2NIw56Ih4OG3All4gi2gj6xpW5h+aVJhlgDXzA=;
        b=r8pAoGTe3awW6RqIb2JqB64N65oxWNjwZpK9U+UXIWwcqb+ujBDnbvMeMHHEzzir9v
         d46oiI1XmFzexTj1Xu896UiMhyfqyE/kOe6/3stzVI7dx5oCND6SQ9PHDMkDB0pjvJav
         W6FZZ89AqXASzs4uf4LnPBsZgpf65bHmKu+IHifu2EmNIRiRfTxKaU2SvCmAPbNeK+4g
         Ha8hpTayyvBCWIgMwCCRN9Rg6EF6QjpCf89kkrQDr/hc8BzJxCZV1W1V9xZ3fDS78O/Z
         EuNKEJUyvd76Zd9TySZxqHM8Tpk6OXyL9ztVUtRvTzf7kPDte1n4bWVX73xC/4c1hLhb
         rmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Z+wSy2NIw56Ih4OG3All4gi2gj6xpW5h+aVJhlgDXzA=;
        b=F8NtnyxNJgLsHd0Rml3WQaxo2pf4c2W1XFi+owS9pmbujZYCr3YypzEdj7yqh8I0UL
         0dLkVoiV+rGo08S2An56IZkN4glY5+aObjqRv0eWxlWjLUi19xwK8pDLhzzeKPRNxixa
         4ShPRNaeMTvdqN1hSR2NVxXdHUvoTslScnVN2QM045Sghecw+X7xP6s7pIyaaPsxW+I3
         PKh04YNWj3rDvZ1Ob3FlyUswGj7+UkFlnEvF2cEGLwrhZYXj6hqmMIuW4XwB1gh/6Eph
         x6EmaXIQm+zFStIss9ekWGnM2AelS/BlSQt3JqRctl8xCu+rMvkL5Cy/7pB3bINrUv67
         3cTQ==
X-Gm-Message-State: APjAAAU3Y9BD5/rNAS3ebd5rYUIzYIcLubX2OaTgf3en/sPX4S/TKFUp
        R/hLqDpWVy3PtjanBH7hZvsUxqMX
X-Google-Smtp-Source: APXvYqy7MQ5OSx4BlyyKB0FvW0mnEEtl3nm0LuK11aKIVzBcR5piytGZo7Q6qT+E/6AfdFy4BVnfUA==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr125415539pls.267.1564642274050;
        Wed, 31 Jul 2019 23:51:14 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 33sm83795415pgy.22.2019.07.31.23.51.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 23:51:12 -0700 (PDT)
Date:   Thu, 1 Aug 2019 15:51:08 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: "mm: account nr_isolated_xxx in [isolate|putback]_lru_page"
 breaks OOM with swap
Message-ID: <20190801065108.GA179251@google.com>
References: <1564503928.11067.32.camel@lca.pw>
 <20190731053444.GA155569@google.com>
 <1564589346.11067.38.camel@lca.pw>
 <1564597080.11067.40.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564597080.11067.40.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:18:00PM -0400, Qian Cai wrote:
> On Wed, 2019-07-31 at 12:09 -0400, Qian Cai wrote:
> > On Wed, 2019-07-31 at 14:34 +0900, Minchan Kim wrote:
> > > On Tue, Jul 30, 2019 at 12:25:28PM -0400, Qian Cai wrote:
> > > > OOM workloads with swapping is unable to recover with linux-next since
> > > > next-
> > > > 20190729 due to the commit "mm: account nr_isolated_xxx in
> > > > [isolate|putback]_lru_page" breaks OOM with swap" [1]
> > > > 
> > > > [1] https://lore.kernel.org/linux-mm/20190726023435.214162-4-minchan@kerne
> > > > l.
> > > > org/
> > > > T/#mdcd03bcb4746f2f23e6f508c205943726aee8355
> > > > 
> > > > For example, LTP oom01 test case is stuck for hours, while it finishes in
> > > > a
> > > > few
> > > > minutes here after reverted the above commit. Sometimes, it prints those
> > > > message
> > > > while hanging.
> > > > 
> > > > [  509.983393][  T711] INFO: task oom01:5331 blocked for more than 122
> > > > seconds.
> > > > [  509.983431][  T711]       Not tainted 5.3.0-rc2-next-20190730 #7
> > > > [  509.983447][  T711] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > > disables this message.
> > > > [  509.983477][  T711] oom01           D24656  5331   5157 0x00040000
> > > > [  509.983513][  T711] Call Trace:
> > > > [  509.983538][  T711] [c00020037d00f880] [0000000000000008] 0x8
> > > > (unreliable)
> > > > [  509.983583][  T711] [c00020037d00fa60] [c000000000023724]
> > > > __switch_to+0x3a4/0x520
> > > > [  509.983615][  T711] [c00020037d00fad0] [c0000000008d17bc]
> > > > __schedule+0x2fc/0x950
> > > > [  509.983647][  T711] [c00020037d00fba0] [c0000000008d1e68]
> > > > schedule+0x58/0x150
> > > > [  509.983684][  T711] [c00020037d00fbd0] [c0000000008d7614]
> > > > rwsem_down_read_slowpath+0x4b4/0x630
> > > > [  509.983727][  T711] [c00020037d00fc90] [c0000000008d7dfc]
> > > > down_read+0x12c/0x240
> > > > [  509.983758][  T711] [c00020037d00fd20] [c00000000005fb28]
> > > > __do_page_fault+0x6f8/0xee0
> > > > [  509.983801][  T711] [c00020037d00fe20] [c00000000000a364]
> > > > handle_page_fault+0x18/0x38
> > > 
> > > Thanks for the testing! No surprise the patch make some bugs because
> > > it's rather tricky.
> > > 
> > > Could you test this patch?
> > 
> > It does help the situation a bit, but the recover speed is still way slower
> > than
> > just reverting the commit "mm: account nr_isolated_xxx in
> > [isolate|putback]_lru_page". For example, on this powerpc system, it used to
> > take 4-min to finish oom01 while now still take 13-min.
> > 
> > The oom02 (testing NUMA mempolicy) takes even longer and I gave up after 26-
> > min
> > with several hang tasks below.
> 
> Also, oom02 is stuck on an x86 machine.

Yeb, above my patch had a bug to test page type after page was freed.
However, after the review, I found other bugs but I don't think it's
related to your problem, either. Okay, then, let's revert the patch.

Andrew, could you revert the below patch?
"mm: account nr_isolated_xxx in [isolate|putback]_lru_page"

It's just clean up patch and isn't related to new madvise hint system call now.
Thus, it shouldn't be blocker.

Anyway, I want to fix the problem when I have available time.
Qian, What's the your config and system configuration on x86?
Is it possible to reproduce in qemu?
It would be really helpful if you tell me reproduce step on x86.

Thanks.

