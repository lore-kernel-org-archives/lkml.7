Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33BDC32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669782089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfHAGaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:30:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33119 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726783AbfHAGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:30:13 -0400
X-UUID: b7ea4ece14aa45f9a7c142b33136ffbd-20190801
X-UUID: b7ea4ece14aa45f9a7c142b33136ffbd-20190801
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 361796521; Thu, 01 Aug 2019 14:30:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 1 Aug 2019 14:30:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 1 Aug 2019 14:30:04 +0800
Message-ID: <1564641003.25219.7.camel@mtkswgap22>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Date:   Thu, 1 Aug 2019 14:30:03 +0800
In-Reply-To: <20190801061527.GB11627@dhcp22.suse.cz>
References: <20190731161151.26ef081e@canb.auug.org.au>
         <1564554484.28000.3.camel@mtkswgap22>
         <20190801155130.29a07b1b@canb.auug.org.au>
         <20190801061527.GB11627@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 08:15 +0200, Michal Hocko wrote:
> On Thu 01-08-19 15:51:30, Stephen Rothwell wrote:
> > Hi Miles,
> > 
> > On Wed, 31 Jul 2019 14:28:04 +0800 Miles Chen <miles.chen@mediatek.com> wrote:
> > >
> > > On Wed, 2019-07-31 at 16:11 +1000, Stephen Rothwell wrote:
> > > > 
> > > > After merging the akpm-current tree, today's linux-next build (powerpc
> > > > ppc64_defconfig) produced this warning:
> > > > 
> > > > mm/memcontrol.c: In function 'invalidate_reclaim_iterators':
> > > > mm/memcontrol.c:1160:11: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> > > >   } while (memcg = parent_mem_cgroup(memcg));
> > > >            ^~~~~
> > > >   
> > > 
> > > Hi Stephen,
> > > 
> > > Thanks for the telling me this. Sorry for the build warning. 
> > > Should I send patch v5 to the mailing list to fix this? 
> > 
> > You might as well (cc'ing Andrew, of course).
> > 
> > I would suggest finishing that loop like this:
> > 
> > 		memcg = parent_mem_cgroup(memcg);
> > 	} while (memcg);
> > 
> > rather than adding a set of parentheses.

thanks for the advise
> 
> Qian has already posted a patch http://lkml.kernel.org/r/1564580753-17531-1-git-send-email-cai@lca.pw

Thanks Qian's quick fix.

It's the first time that I receive a build warning after the patch has
been merged to -mm tree. The build warning had been fixed by Qian,
should I send another change for this?


