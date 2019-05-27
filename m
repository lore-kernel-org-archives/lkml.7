Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8833C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615A21734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558943899;
	bh=MncaZRtt9JGEJ+Fon5vYS9wti5aXh/woh1ldn90wtaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Do8+Cimxjtx3uFVE+L3Mh4EYsaYSej9/vtPWGsR4tQIA4mYaMmAvX8cSmBleJg4Wv
	 LEYLf/EUp3QJ90rpe+a4ThoBfplcmnZXIkghtBkfhgNn6swzvhVYeCgmolujS+M+f9
	 FMjeIEhWAD8CeqwpM12ay8KHparcupM4Ny0JZa2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfE0H6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:58:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0H6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:58:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so9114847pfn.7;
        Mon, 27 May 2019 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AtLyxtk9Dzb+m0497auHuXX2nLc0N/zfXlXDKG81NXE=;
        b=YddJ3EXGsxY4Mae6Yosu3sXkx8hcN2mk9wf03Iho6huUQyCPm36tLZN9XRHcwwl3Li
         VZaWwsKHHQZcGjze8MpJwBYvZOr4/JFoZqb2BPJXB4vYBfUDiYxmmmeOW3i5Nkxxl1sA
         P1fefUbWAjWl4KGzjTUuRKEIyJuI1s/2DqcJ3DorxbS8UENXyLrPmziVxPdpJ+rBCOF9
         YomHgrYFvLVxqilDv0CmZeyCuZyUeOhpTLmA4D3xEhFkTGRV8ptiiK2Ma+ENptkVk/mR
         m95QZTxEYEUNCpACv/zCSylIB2q9gUhh6hNzdZIxykp8t69jthBbipxfdll4UlP3zuWj
         kGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AtLyxtk9Dzb+m0497auHuXX2nLc0N/zfXlXDKG81NXE=;
        b=E9865puWIr3ZOA6rm/8yVUmQyyjx/Wz5HIRNHiJMZhKjW0WOfwF6JsYVXHDxJVHM4r
         6BaPJ8n82wUoIM5wNEuyQ6eXkNVFQK3asEd3vszmRICpHK7Id2BZ2O1HAaZb1X2Kp2U2
         QMt49vH1nOwKGCFM23hfmUsNR2CuJuvdzHGnp+0doMU2hYWxMi98GmGeTtkIet3NXKFH
         IPrBH3t70biO42QPoSJZHGCtqMLlU/UWppE6b7gaNdNw4nbqpns+zMI4yQMDjXneolpK
         1tPoEYVePYA4VRAW5/c5FhKZ/FJCSzVUNgPEIqna4VPqIiE4ol/9mDAEzPx4AxD0uVUP
         EVRQ==
X-Gm-Message-State: APjAAAXV9iqEoAudT2nMAB42a8la7Z9ah6EX9Np4NIBfVtokBxXqUm3a
        vkdXQSkUuNaBsjwX68zyv7I=
X-Google-Smtp-Source: APXvYqy7Ciw4BWJbHLqJmf1T3VmgXQeVxglXh68Qvk5eTkT4dj+InYqIzbs2GO1rQP7sg3r1fXpkAw==
X-Received: by 2002:a17:90a:b885:: with SMTP id o5mr28965553pjr.52.1558943897757;
        Mon, 27 May 2019 00:58:17 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id d9sm8833891pgl.20.2019.05.27.00.58.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 00:58:16 -0700 (PDT)
Date:   Mon, 27 May 2019 16:58:11 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190527075811.GC6879@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521062628.GE32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:26:28AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 11:55:33, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> > > [cc linux-api]
> > > 
> > > On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > > > System could have much faster swap device like zRAM. In that case, swapping
> > > > is extremely cheaper than file-IO on the low-end storage.
> > > > In this configuration, userspace could handle different strategy for each
> > > > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > > > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > > > file IO is more expensive in this case so want to keep them in memory
> > > > until memory pressure happens.
> > > > 
> > > > To support such strategy easier, this patch introduces
> > > > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > > > that /proc/<pid>/clear_refs already has supported same filters.
> > > > They are filters could be Ored with other existing hints using top two bits
> > > > of (int behavior).
> > > 
> > > madvise operates on top of ranges and it is quite trivial to do the
> > > filtering from the userspace so why do we need any additional filtering?
> > > 
> > > > Once either of them is set, the hint could affect only the interested vma
> > > > either anonymous or file-backed.
> > > > 
> > > > With that, user could call a process_madvise syscall simply with a entire
> > > > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > > > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > > 
> > > OK, so here is the reason you want that. The immediate question is why
> > > cannot the monitor do the filtering from the userspace. Slightly more
> > > work, all right, but less of an API to expose and that itself is a
> > > strong argument against.
> > 
> > What I should do if we don't have such filter option is to enumerate all of
> > vma via /proc/<pid>/maps and then parse every ranges and inode from string,
> > which would be painful for 2000+ vmas.
> 
> Painful is not an argument to add a new user API. If the existing API
> suits the purpose then it should be used. If it is not usable, we can
> think of a different way.

I measured 1568 vma parsing overhead of /proc/<pid>/maps in ARM64 modern
mobile CPU. It takes 60ms and 185ms on big cores depending on cpu governor.
It's never trivial.
