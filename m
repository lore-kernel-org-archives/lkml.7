Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564426134;
	bh=pIMNsYM0fVCuJc3GSaOexiSH6hgAFC4uyI+oZR7lEY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wlCuxrBuut5/UwzoiTkLBC1AIau84aAjZqD56pZ4gt9LoUldVn2eOa1E+MAXwBv18
	 Rdt8E4oGXxTqaey7OTXqYgrkCgklIVLRl/P/G5mvKeNQto89Uz4qaCCiPMwbRoAPkG
	 iT9TPTdqUh+GiR7+cvQgJ1YIY/AsqKOXm6+V8ZVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbfG2Ssx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:48:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfG2Ssx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB20FAEFD;
        Mon, 29 Jul 2019 18:48:51 +0000 (UTC)
Date:   Mon, 29 Jul 2019 20:48:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729184850.GH9330@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz>
 <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz>
 <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-07-19 10:28:43, Yang Shi wrote:
[...]
> I don't worry too much about scale since the scale issue is not unique
> to background reclaim, direct reclaim may run into the same problem.

Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
You can have thousands of memcgs and I do not think we really do want
to create one kswapd for each. Once we have a kswapd thread pool then we
get into a tricky land where a determinism/fairness would be non trivial
to achieve. Direct reclaim, on the other hand is bound by the workload
itself.
-- 
Michal Hocko
SUSE Labs
