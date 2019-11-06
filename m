Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE6C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C6218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfKFRZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:25:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:50308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728466AbfKFRZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:25:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B3A0AC82;
        Wed,  6 Nov 2019 17:25:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 67D6D1E4353; Wed,  6 Nov 2019 18:25:20 +0100 (CET)
Date:   Wed, 6 Nov 2019 18:25:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     snazy@snazy.de
Cc:     Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106172520.GF12685@quack2.suse.cz>
References: <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
 <20191106120315.GF16085@quack2.suse.cz>
 <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
 <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
 <20191106150524.GL16085@quack2.suse.cz>
 <20191106151429.swqtq2dt4uelhjzn@macbook-pro-91.dhcp.thefacebook.com>
 <9f6b707c69ceb34e3916b1d47f2e2fa6a4f025ab.camel@gmx.de>
 <94c71621a0245db763db9e289286b79056cc9bc5.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c71621a0245db763db9e289286b79056cc9bc5.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 18:03:10, Robert Stupp wrote:
> Oh, and I just realized, that I have two custom settings in my
> /etc/rc.local - guess, I configured that when I installed that machine
> years ago. Sorry, that I haven't mentioned that earlier.
> 
> echo 0 > /sys/block/nvme0n1/queue/read_ahead_kb
> echo never >
> /sys/kernel/mm/transparent_hugepage/defrag
> 
> That setting is probably not quite standard, but I assume there are
> some database server setups out there, that set RA=0 as well.

Ok, yes, that explains ra_pages == 0. Thanks for the details.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
