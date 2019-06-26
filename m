Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B552147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="V58GbM/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFZGbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:31:16 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:34928 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:31:16 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7D6B32DC68FE;
        Wed, 26 Jun 2019 02:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561530675;
        bh=UI2GCXuBlxHgc850F1IfwNc+nsesrzgc20uhDpnUNSA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V58GbM/IaY8yJHTevGM2YMXWyvjz94zsRDVbk87BElo745K17gBhdRcNgKLyMp0Yu
         rrw8xk+rDD4ywtCaqoDh1th9okWQJbDyeeAfJedEb6iEG9LcCd0Z/Oqu8e6g0zYszq
         jeeKBvDLHmjjwjclNcHZyNiGvGida3Vmdgu3v6K/ceJnScMvFHnI6OEdoAxXT7pKwO
         7HB30vulphiiJ4hzta0WhmAs8gk6cyi5VK6HXy1X4aVpHXbjdx/3AyUHola0fRGjDJ
         CiUnNQaaZwXn/gB/A+OlyuBWbLqnK5E1zTy9sYSPRBfPG81UiGiZPFBeie7g02QBFb
         pDjgk3iqHfG+pX86sLyYH83bBo9Tcx/2eqc252x+WoCBlpeNIMfMib9bS0KvkQ4kJU
         XSwpA7y0zzLE0Pg/lf6VxvRlfycnyivQGb6YYlqGp4qMvqm/JOu8B3mnj1/JUohSwz
         CsZuFjyNo6T7eMj2v3TqMdu8HcVnGDn5YjXg3WNXNLy/X8Dr5W91drGLRDIUlNqGTk
         vkB1zB+88tPhhHoAEQPhwRptORM4WyMZSaWTpyIERpvw6H5p1zxmi7Xpr55oBP1QzH
         +38aqqzjJ/D+OdzV9CM3bQEFg7PvAf3rddF5+52jA+kXDnYWZU0q5bHoiSAuI8LjvD
         hSehiItyqMXEbkOEOwvSTNTo=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5Q6UtdL031388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 16:31:11 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <edac179f0626a6e0bd91922d876934abf1b9bb19.camel@d-silva.org>
Subject: Re: [PATCH v2 2/3] mm: don't hide potentially null memmap pointer
 in sparse_remove_one_section
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 26 Jun 2019 16:30:55 +1000
In-Reply-To: <20190626062344.GG17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
         <20190626061124.16013-3-alastair@au1.ibm.com>
         <20190626062344.GG17798@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Wed, 26 Jun 2019 16:31:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 08:23 +0200, Michal Hocko wrote:
> On Wed 26-06-19 16:11:22, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > By adding offset to memmap before passing it in to
> > clear_hwpoisoned_pages,
> > we hide a potentially null memmap from the null check inside
> > clear_hwpoisoned_pages.
> > 
> > This patch passes the offset to clear_hwpoisoned_pages instead,
> > allowing
> > memmap to successfully peform it's null check.
> 
> Same issue with the changelog as the previous patch (missing WHY).
> 

The first paragraph explains what the problem is with the existing code
(same applies to 1/3 too).

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


