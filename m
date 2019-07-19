Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7EC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D37321852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGSNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:00:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfGSNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C496EAF7A;
        Fri, 19 Jul 2019 13:00:32 +0000 (UTC)
Date:   Fri, 19 Jul 2019 15:00:31 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Message-ID: <20190719130031.GE19068@suse.de>
References: <20190717071439.14261-1-joro@8bytes.org>
 <20190717071439.14261-4-joro@8bytes.org>
 <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
 <20190718091745.GG13091@suse.de>
 <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
 <20190719122111.GD19068@suse.de>
 <CALCETrUjATNr97ZWX41Tt3QyiMM+GSqG92Nn=qZTTG6XrvL8GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUjATNr97ZWX41Tt3QyiMM+GSqG92Nn=qZTTG6XrvL8GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:24:03AM -0700, Andy Lutomirski wrote:
> Could you move the vmalloc_sync_all() call to the lazy purge path,
> though?  If nothing else, it will cause it to be called fewer times
> under any given workload, and it looks like it could be rather slow on
> x86_32.

Okay, I move it to __purge_vmap_area_lazy(). That looks like the right
place.


Thanks,

	Joerg
