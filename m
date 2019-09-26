Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF500C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58FA222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569483499;
	bh=fvMaG7c6ziT5mjJObFGHSE6HA7R03z59F8NNiOvwKJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m92qQKN4g+ETHOp2idvsIoQzpo9B0BhZ8I1JjM1yhadtnV6MelsqDzRT/FVlRqmoM
	 supFMDVNwP9XI77MHZghlSb4vTEVruNVDhBnAYuJFbej8GDyd9csa2hjCDnQDv6yf8
	 a1iVQYBFOQ70aEIwr1yvIyIoDsNCVgNFOixRN7ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfIZHiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbfIZHiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C65DEAFE8;
        Thu, 26 Sep 2019 07:38:16 +0000 (UTC)
Date:   Thu, 26 Sep 2019 09:38:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190926073816.GC20255@dhcp22.suse.cz>
References: <1569337401.5576.217.camel@lca.pw>
 <20190924151147.GB23050@dhcp22.suse.cz>
 <1569351244.5576.219.camel@lca.pw>
 <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
 <1569427262.5576.225.camel@lca.pw>
 <20190925174809.GM23050@dhcp22.suse.cz>
 <1569435659.5576.227.camel@lca.pw>
 <92bce3d4-0a3e-e157-529d-35aafbc30f3b@redhat.com>
 <1569443568.5576.231.camel@lca.pw>
 <17ba6fc6-72ce-992b-7cc4-812acbdedbeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ba6fc6-72ce-992b-7cc4-812acbdedbeb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 09:26:13, David Hildenbrand wrote:
[...]
> I'd like to hear what Michal thinks. If we do want the cpu hotplug lock,
> we can at least restrict it to the call paths (e.g., online_pages())
> where the lock is really needed and document that.

Completely agreed. Conflating cpu and memory hotplug locks was a bad
decision. If there are places which need both they should better use
both lock explicitly.

Now, the reality might turn out more complicated due to locks nesting
but hiding the cpu lock into the mem hotplug is just not fixing that.
-- 
Michal Hocko
SUSE Labs
