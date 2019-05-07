Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6329C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ACD206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251663;
	bh=wIdOeoWBqmWd4F+oemrD/NRxvbi8qBfaju2fXEsswHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YA175H4AlxHuKTk4F1O6Sz1TNtoJHpWvNrp3vEU8NJkSyYd+/0FCUDi5V2NO7za1g
	 0je9IETaJUmnLpYu/FFE3k8C0KufUy1B4TXCxUkUic0Ib4Mo0cwSHGta4t6tn/tVN2
	 VsT1+T1vRzLEXFJSk9TDQy78UI5wa4Rjt2OTARJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfEGRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbfEGRyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:54:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B223CAB91;
        Tue,  7 May 2019 17:54:20 +0000 (UTC)
Date:   Tue, 7 May 2019 19:54:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH AUTOSEL 4.14 62/95] mm, memory_hotplug: initialize struct
 pages for the full memory section
Message-ID: <20190507175419.GW31017@dhcp22.suse.cz>
References: <20190507053826.31622-1-sashal@kernel.org>
 <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
 <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
 <20190507170208.GF1747@sasha-vm>
 <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
 <20190507171806.GG1747@sasha-vm>
 <20190507173224.GS31017@dhcp22.suse.cz>
 <20190507173655.GA1403@bombadil.infradead.org>
 <20190507174514.GI1747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507174514.GI1747@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-05-19 13:45:14, Sasha Levin wrote:
[...]
> We're going to have (quite a) large amount of systems with "weird"
> memory layouts that do memory hotplug quite frequently in production, so
> this whole "tends to work usually" thing kinda scares me.

Memory hotplug is simply not production ready for those cases,
unfortunately. It tends to work just fine with properly section
aligned systems with memory being in the movable zones or for zone
device. Everything beyond that is kinda long way to get there...
-- 
Michal Hocko
SUSE Labs
