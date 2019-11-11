Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B83CC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418FE206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573467172;
	bh=SRfM3HwNAqHUpU2dSiyP5wz3MY0B5WMhMN0EKMk0BCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ceQSVVH7SELMR5XUM6+NKhDjeijvWJIJvK7EaU6S6YWU6slXORiQm7M0G/5pEZW5z
	 IswqmlYClWWY5mvtTXAabyDc+wDyQW4MPeZIlOiAgbAYLM8hlq7wmp36V6P522/ujI
	 DNS1ueHFXvCj3YGJn1McxqGutKYd+GGo+bsTgdPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKKKMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:12:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKKMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:12:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 853F2B29C;
        Mon, 11 Nov 2019 10:12:49 +0000 (UTC)
Date:   Mon, 11 Nov 2019 11:12:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, guro@fb.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111101248.GF1396@dhcp22.suse.cz>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-11-19 16:26:52, Qian Cai wrote:
> 
> 
> > On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > -    for (zid = 0; zid <= zone_idx; zid++) {
> > +    for (zid = 0; zid < zone_idx; zid++) {
> >        struct zone *zone =
> 
> Oops, I think here needs to be,
> 
> for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {
> 
> to deal with this MAX_NR_ZONES special case.

Yep this looks correct.

Thanks!

-- 
Michal Hocko
SUSE Labs
