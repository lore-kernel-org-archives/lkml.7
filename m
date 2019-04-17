Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A91C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187BD217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfDQOlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:41:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:55188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731743AbfDQOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:41:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0045AEEA;
        Wed, 17 Apr 2019 14:41:43 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:41:42 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Arun KS <arunks@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mateusz Guzik <mguzik@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190417144142.GF8962@blackbody.suse.cz>
References: <20190417120347.15397-1-mkoutny@suse.com>
 <20190417134152.GM5878@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417134152.GM5878@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:41:52PM +0200, Michal Hocko <mhocko@kernel.org> wrote:
> Don't we need to use the lock in prctl_set_mm as well then?

Correct. The patch alone just moves the race from
get_cmdline/prctl_set_mm_map to get_cmdline/prctl_set_mm.

arg_lock could be used in prctl_set_mm but the better idea (IMO) is
complete removal of that code in favor of prctl_set_mm_map [1].

Michal

[1] https://lore.kernel.org/lkml/20180405182651.GM15783@uranus.lan/
