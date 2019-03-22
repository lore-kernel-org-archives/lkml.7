Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553242959;
	bh=sO574eWAM1evrj0tgHHf0vM/YvuLjI2SRZoU3UauCl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YAeUHH4weuiY9/rKV+ABQ99Fs9lidjrddNG47gur0z+AdQ4MPms85Ytk2LJ8QU+Fv
	 sy84c5e8cH9ulwX0x+VhxYR9Hdq2XyBaCafDSMyovxHqudNgs6f2NkO5kfFjlPvBHU
	 gwONIwL4FdstavjD8GgaHSWBuBiPNlX2O3nTlB5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfCVIWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:22:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbfCVIWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:22:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8A59AEE5;
        Fri, 22 Mar 2019 08:22:35 +0000 (UTC)
Date:   Fri, 22 Mar 2019 09:22:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        osalvador@suse.de, anshuman.khandual@arm.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/hotplug: fix notification in offline error path
Message-ID: <20190322082235.GA32418@dhcp22.suse.cz>
References: <20190320204255.53571-1-cai@lca.pw>
 <CAFqt6zbHwvTgFfrjvDbETRYu05O1W=_e_GT8R6pMkDhFfzYFOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbHwvTgFfrjvDbETRYu05O1W=_e_GT8R6pMkDhFfzYFOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-03-19 12:20:12, Souptick Joarder wrote:
> On Thu, Mar 21, 2019 at 2:13 AM Qian Cai <cai@lca.pw> wrote:
> >
> > When start_isolate_page_range() returned -EBUSY in __offline_pages(), it
> > calls memory_notify(MEM_CANCEL_OFFLINE, &arg) with an uninitialized
> > "arg". As the result, it triggers warnings below. Also, it is only
> > necessary to notify MEM_CANCEL_OFFLINE after MEM_GOING_OFFLINE.
> 
> For my clarification, if test_pages_in_a_zone() failed in  __offline_pages(),
> we have the similar scenario as well. If yes, do we need to capture it
> in change log ?

Yes this is the same situation. We can add a note that the same applies
to test_pages_in_a_zone failure path but I do not think it is strictly
necessary. Thanks for the note anyway.
-- 
Michal Hocko
SUSE Labs
