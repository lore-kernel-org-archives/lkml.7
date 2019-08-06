Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFEA2089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565104288;
	bh=aX7OaxDyIXCYVzhN6BLBIQYD7oD/7QrGiAZXFyWSNzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0t1SB74E2OIkDF57xptU+UvaktA59yX683m7j0ZLatXQu1KNzdhwbITGzqiwCpEst
	 FVuoTRXRdEkcIF5GbvTDnuHciZLUWizZRvq/XN4zhbOg4eC67vjmPDhXpfpMgfPJRe
	 YQi7a/Vlweho42v6gcNoxcdqJIofsdsv835JYuw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfHFPL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfHFPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BEFFAE65;
        Tue,  6 Aug 2019 15:11:25 +0000 (UTC)
Date:   Tue, 6 Aug 2019 17:11:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pankaj.suryawanshi@einfochips.com
Subject: Re: oom-killer
Message-ID: <20190806151123.GI11812@dhcp22.suse.cz>
References: <CACDBo54Jbueeq1XbtbrFOeOEyF-Q4ipZJab8mB7+0cyK1Foqyw@mail.gmail.com>
 <20190805112437.GF7597@dhcp22.suse.cz>
 <0821a17d-1703-1b82-d850-30455e19e0c1@suse.cz>
 <20190805120525.GL7597@dhcp22.suse.cz>
 <CACDBo562xHy6McF5KRq3yngKqAm4a15FFKgbWkCTGQZ0pnJWgw@mail.gmail.com>
 <df820f66-cf82-b43f-97b6-c92a116fa1a6@suse.cz>
 <CACDBo57Yjuc69GX+V7w_efSHPkpeU3D9RUr0TEd64oUTi4o8Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo57Yjuc69GX+V7w_efSHPkpeU3D9RUr0TEd64oUTi4o8Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 20:25:51, Pankaj Suryawanshi wrote:
[...]
> lowmem reserve ? it is min_free_kbytes or something else.

Nope. Lowmem rezerve is a measure to protect from allocations targetting
higher zones (have a look at setup_per_zone_lowmem_reserve). The value
for each zone depends on the amount of memory managed by the zone
and the ratio which can be tuned from the userspace. min_free_kbytes
controls reclaim watermarks.

-- 
Michal Hocko
SUSE Labs
