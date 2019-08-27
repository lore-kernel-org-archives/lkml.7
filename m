Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8CCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8070206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566890566;
	bh=nprqqVbPMYSXVpEwvT/1mwqjJtdnL1EABf/ZQ88SKfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KU2WjBzuExvfx3RvB92RYklrFtaxx/QT55+ZaqhCEK6qxvgSLtO3kirwFmV45+eJa
	 ZprxVeYtAfn7G+ouL7xM+xbKSB1svQNMwVAwmnuu/ACYfeFlQbGTFxhp1+uMmRyNfx
	 tk+qPmI1OA6F78MlE1HNr16iey6ZqH5i0o2plRHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfH0HWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:22:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0HWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:22:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0F24B087;
        Tue, 27 Aug 2019 07:22:43 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:22:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: don't hide potentially null memmap pointer in
 sparse_remove_section
Message-ID: <20190827072242.GT7538@dhcp22.suse.cz>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
 <20190827053656.32191-3-alastair@au1.ibm.com>
 <20190827062445.GO7538@dhcp22.suse.cz>
 <befab2a0a9f160f8af8c1a412068060636a7a64c.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befab2a0a9f160f8af8c1a412068060636a7a64c.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 17:00:16, Alastair D'Silva wrote:
[...]
> The NULL check was added in commit:
> 95a4774d055c ("memory-hotplug: update mce_bad_pages when removing the
> memory")
> where memmap was originally inited to NULL, and only conditionally
> given a value.
> 
> With this in mind, since that situation is no longer true, I think we
> could instead drop the NULL check.

This would be much more preferable to the original patch.

-- 
Michal Hocko
SUSE Labs
