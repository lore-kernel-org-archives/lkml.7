Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BF6C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C100A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557931916;
	bh=z41i8/DGYgyRAFj/Ci74jDn2figXcF5FiHIzhZ88OF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ql8dPlzH3WACzcUzR3+7QkrATLpJVh2cfn6zatubjqnD7RkIBdtJXPG29q4Bl7/17
	 NfJ4BU++Y9vUvAWkrVWa/xAbqCH28miJbX0On7/eTYjjfd4gCkwpg/13hRLxWJa2+q
	 NsyQzyKrkDSQg9kLg05i3v9FvkbzX9EsIPLTrG80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfEOOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:51:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:51410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbfEOOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:51:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 281DAAFDD;
        Wed, 15 May 2019 14:51:53 +0000 (UTC)
Date:   Wed, 15 May 2019 16:51:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515145151.GG16651@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515065311.GB16651@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Suren and Minchan - the email thread starts here 20190514131654.25463-1-oleksandr@redhat.com]

On Wed 15-05-19 08:53:11, Michal Hocko wrote:
[...]
> I will try to comment on the interface itself later. But I have to say
> that I am not impressed. Abusing sysfs for per process features is quite
> gross to be honest.

I have already commented on this in other email. I consider sysfs an
unsuitable interface for per-process API. Not to mention this particular
one is very KSM specific while the question about setting different
hints on memory of a remote process is a more generic question. As
already mentioned there are usecases where people would like to say
that a certain memory is cold from outside of the process context (e.g.
monitor application). So essentially a form of a user space memory
management. And this usecase sounds a bit similar to me and having a
common api sounds more sensible to me.

One thing we were discussing at LSFMM this year was a way to either
provide madvise_remote(pid, addr, length, advice) or a fadvise
alternative over /proc/<pid>/map_vmas/<range> file descriptors
(essentially resembling the existing map_files api) to achieve such a
functionality. This is still a very rough idea but the api would sound
much more generic to me and it would allow much wider range of usecases.

But maybe I am completely wrong and this is just opens a can of worms
that we do not want.
-- 
Michal Hocko
SUSE Labs
