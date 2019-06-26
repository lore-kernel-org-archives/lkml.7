Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF0C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B242086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561532381;
	bh=p9jVfOcgOghwi4+WlcWkjNcm/swM7xVzspjPRuxNwGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEK0t5t4Kp0P66q0xEZRD7qPLJSZnMPTsa9Z6Kp0JooK1gUzb8wiVdybhoZ1JQzpZ
	 ymFgLLkv1LbCQzKESjqNKGBvt2dqnDmd9Gc+OW3eLsCNpzvZmXEvHuUxXFPSgJ4Miq
	 lMLgi9hSV6U3fm3/UqyaEwKZEVk0dyWjPLGkih8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFZG7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:59:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfFZG7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:59:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94530AC83;
        Wed, 26 Jun 2019 06:59:38 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:59:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm: don't hide potentially null memmap pointer in
 sparse_remove_one_section
Message-ID: <20190626065935.GL17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-3-alastair@au1.ibm.com>
 <20190626062344.GG17798@dhcp22.suse.cz>
 <edac179f0626a6e0bd91922d876934abf1b9bb19.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edac179f0626a6e0bd91922d876934abf1b9bb19.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 16:30:55, Alastair D'Silva wrote:
> On Wed, 2019-06-26 at 08:23 +0200, Michal Hocko wrote:
> > On Wed 26-06-19 16:11:22, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > By adding offset to memmap before passing it in to
> > > clear_hwpoisoned_pages,
> > > we hide a potentially null memmap from the null check inside
> > > clear_hwpoisoned_pages.
> > > 
> > > This patch passes the offset to clear_hwpoisoned_pages instead,
> > > allowing
> > > memmap to successfully peform it's null check.
> > 
> > Same issue with the changelog as the previous patch (missing WHY).
> > 
> 
> The first paragraph explains what the problem is with the existing code
> (same applies to 1/3 too).

Under what conditions that happens? Is this a theoretical problem or can
you hit this by a (buggy) code? Please be much more specific.

-- 
Michal Hocko
SUSE Labs
