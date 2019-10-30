Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F40CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2320856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfJ3OCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:02:24 -0400
Received: from smtp2.axis.com ([195.60.68.18]:26087 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJ3OCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:02:23 -0400
IronPort-SDR: A6r/sRAgNcgUX6PPp549V7VnqRa+RPsV8Fgd5Ru+gJt5wm1+/Sadm+GxmQVl2XjiGjx+G3z7YQ
 XTVBPDQVArlEmWjORPnItJ6Lae0eZOWyNcIg1u5SF2X7bETQvczeZ/LzWt02wZ3DXAK3+tG9Ti
 dLDTINRcTZjDYjo76olwlpc8ZIKyxMkbc6m37TnfYz/ZIO5Ai0GClfE9RElV/B6zjTCAlUkKoZ
 3M+ungPUzRNzzcmBJgVdCqPpATxq6sZ9436l2dLaNlfn+Fza0GiP+L8HKNtz+u7aUcy0cTcnqa
 nNI=
X-IronPort-AV: E=Sophos;i="5.68,247,1569276000"; 
   d="scan'208";a="1925617"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Date:   Wed, 30 Oct 2019 15:02:16 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030140216.i26n22asgafckfxy@axis.com>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030132958.GD31513@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> >  first [and only] section is allocated from the zeroing path while with
> >  2 GiB of memory the first 1 GiB section is allocated from the
> >  non-zeroing path.)
> 
> Do I get it right that sparse_buffer_init couldn't allocate memmap for
> the full node for some reason and so sparse_init_nid would have to
> allocate one for each memory section?

Not quite.  The sparsemap_buf is successfully allocated with the correct
size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
allocate the same size from it.

The reason it fails is that sparse_buffer_alloc() for some reason wants
to return a pointer which is aligned to the allocation size.  But the
sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
enough space to align it.

I don't understand the reason for this alignment requirement since the
fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?
