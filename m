Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8016F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555512952;
	bh=lHJwBPEvzbMMpcjx2itlEjB2S/EToOyAQG5s6hW08PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x0LVkANvg22WGp5bB/usCMvLqHXkLNQwa8zc0ELNNVSaGItT/xWhfLm34k5Bsifol
	 exNLtaf37tUSQE0y+XoBLDjPC3m46moRAD7m83FT0Zs0U99p2JsxeDtwlx5TgY6qlg
	 dC93UQ3m+RkZsl0KRjZWdRBHCE5Pvwt7LeFB/PTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfDQOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:55:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfDQOzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:55:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78B5FAE0F;
        Wed, 17 Apr 2019 14:55:49 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:55:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Arun KS <arunks@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mateusz Guzik <mguzik@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190417145548.GN5878@dhcp22.suse.cz>
References: <20190417120347.15397-1-mkoutny@suse.com>
 <20190417134152.GM5878@dhcp22.suse.cz>
 <20190417144142.GF8962@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417144142.GF8962@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 16:41:42, Michal Koutny wrote:
> On Wed, Apr 17, 2019 at 03:41:52PM +0200, Michal Hocko <mhocko@kernel.org> wrote:
> > Don't we need to use the lock in prctl_set_mm as well then?
> 
> Correct. The patch alone just moves the race from
> get_cmdline/prctl_set_mm_map to get_cmdline/prctl_set_mm.
> 
> arg_lock could be used in prctl_set_mm but the better idea (IMO) is
> complete removal of that code in favor of prctl_set_mm_map [1].

Ohh, I have missed that patch. As long as both are merged together then
no objections from me and you can add

Acked-by: Michal Hocko <mhocko@suse.com>

> Michal
> 
> [1] https://lore.kernel.org/lkml/20180405182651.GM15783@uranus.lan/

-- 
Michal Hocko
SUSE Labs
