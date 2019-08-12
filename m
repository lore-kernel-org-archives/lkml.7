Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7187C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1BD21721
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rM4BK921"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHLQJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:09:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46816 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id j15so9741209qtl.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnaZNj6OcIrJnBFWcRbWSkY4xvepDmg4dEtDDEvjaC0=;
        b=rM4BK921mK8jKTrz9MbRlgFiOPaChAQ15XigvY/jAwEMMmDjYs+frqzS9w0lCcBJ2y
         LGHmgem/txYDZlL6lL1NndLexe2xsTsATmLxsr1ZR6w/ArOF8I+GYdm5k4I4zt4w8d9m
         4B/bfXraf5DMKa6mheJn03H+NfDgHpFJEo4P7dUZ1UI81eKjI2XkWslh07PPm1Igq83k
         S4rnb5ZrF04v9S0JYjHJyPaZ/tsGcqfmski9/9jrIBiLvPgz24cpRvO9W2N3xQlgGKZB
         2sgoRt+hNct+yDOozBW3wK30nlZ3XJ1XyvHVscTMM4skUtmNFIOOphCzkMVN+2ykIxiW
         YP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnaZNj6OcIrJnBFWcRbWSkY4xvepDmg4dEtDDEvjaC0=;
        b=lkm25xLfJ1xDUePoMszca2AIBSa4eqEggjXPqYpE3VyA0qsFk8nKxkUXkNYBPz5wyE
         PtrFrm+TnAPp5lnGApfSw7QFkq5iyxX2X+WG0rpmWXWCRaFNBt0UQkMt3G9NKrB82WeA
         joM8CGxgfpjmnqUyLhf3yAz29ibFeWg7GldJA6EXJqkE/Zs/q0iJ09kbjE4MNISio2Uh
         8S7kPqP4YcMpFu1cJRrG59jDLX0CyjgGivpz9pP9fxq9AuFpQdduKEjvcPTbHMwqBANp
         YC016kUuEAXFyAvIpnjWrD8pN/eT+tu+sf7IBZFiTzw0GtTXyRHj3OTrldh3oaC809C1
         gj6w==
X-Gm-Message-State: APjAAAUeuIzpJ2pangg3F58XhNMzQHo+6c2h1SAtm/JS2mfqyVXGus86
        ybLVl09QEof0pTHm7JVbG4FymA==
X-Google-Smtp-Source: APXvYqw1JCAIgiCqB+pKXAs2o/kKQN4tbl59wY+nts7LpDjypCtYx4/rlvkaywOcvdN+2GK2rbwv4w==
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr15711217qvt.128.1565626151734;
        Mon, 12 Aug 2019 09:09:11 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o50sm19991310qtj.17.2019.08.12.09.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:09:11 -0700 (PDT)
Message-ID: <1565626149.8572.1.camel@lca.pw>
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
From:   Qian Cai <cai@lca.pw>
To:     Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Date:   Mon, 12 Aug 2019 12:09:09 -0400
In-Reply-To: <20190812153326.GB17747@sasha-vm>
References: <20190808074736.GJ11812@dhcp22.suse.cz>
         <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
         <20190808185313.GG18351@dhcp22.suse.cz>
         <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
         <20190809064633.GK18351@dhcp22.suse.cz>
         <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
         <20190811234614.GZ17747@sasha-vm> <20190812084524.GC5117@dhcp22.suse.cz>
         <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
         <20190812132226.GI5117@dhcp22.suse.cz> <20190812153326.GB17747@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 11:33 -0400, Sasha Levin wrote:
> On Mon, Aug 12, 2019 at 03:22:26PM +0200, Michal Hocko wrote:
> > On Mon 12-08-19 15:14:12, Vlastimil Babka wrote:
> > > On 8/12/19 10:45 AM, Michal Hocko wrote:
> > > > On Sun 11-08-19 19:46:14, Sasha Levin wrote:
> > > > > On Fri, Aug 09, 2019 at 03:17:18PM -0700, Andrew Morton wrote:
> > > > > > On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org>
> > > > > > wrote:
> > > > > > 
> > > > > > It should work if we ask stable trees maintainers not to backport
> > > > > > such patches.
> > > > > > 
> > > > > > Sasha, please don't backport patches which are marked Fixes-no-
> > > > > > stable:
> > > > > > and which lack a cc:stable tag.
> > > > > 
> > > > > I'll add it to my filter, thank you!
> > > > 
> > > > I would really prefer to stick with Fixes: tag and stable only picking
> > > > up cc: stable patches. I really hate to see workarounds for sensible
> > > > workflows (marking the Fixes) just because we are trying to hide
> > > > something from stable maintainers. Seriously, if stable maintainers have
> > > > a different idea about what should be backported, it is their call. They
> > > > are the ones to deal with regressions and the backporting effort in
> > > > those cases of disagreement.
> > > 
> > > +1 on not replacing Fixes: tag with some other name, as there might be
> > > automation (not just at SUSE) relying on it.
> > > As a compromise, we can use something else to convey the "maintainers
> > > really don't recommend a stable backport", that Sasha can add to his
> > > filter.
> > > Perhaps counter-intuitively, but it could even look like this:
> > > Cc: stable@vger.kernel.org # not recommended at all by maintainer
> > 
> > I thought that absence of the Cc is the indication :P. Anyway, I really
> > do not understand why should we bother, really. I have tried to explain
> > that stable maintainers should follow Cc: stable because we bother to
> > consider that part and we are quite good at not forgetting (Thanks
> > Andrew for persistence). Sasha has told me that MM will be blacklisted
> > from automagic selection procedure.
> 
> I'll add mm/ to the ignore list for AUTOSEL patches.
> 
> > I really do not know much more we can do and I really have strong doubts
> > we should care at all. What is the worst that can happen? A potentially
> > dangerous commit gets to the stable tree and that blows up? That is
> > something that is something inherent when relying on AI and
> > aplies-it-must-be-ok workflow.
> 
> The issue I see here is that there's no way to validate the patches that
> go in mm/. I'd happily run whatever test suite you use to validate these
> patches, but it doesn't exist.
> 
> I can run xfstests for fs/, I can run blktests for block/, I can run
> kselftests for quite a few other subsystems in the kernel. What can I
> run for mm?

I have been running this for linux-next daily.

https://github.com/cailca/linux-mm

"test.sh" will give you some ideas. All the .config has almost all the MM
debugging options turned on, but it might need some modifications to run on QEMU
 etc.

"compile.sh" will have some additional MM debugging command-line options, and
some keywords to catch compilation warnings for MM.

> 
> I'd be happy to run whatever validation/regression suite for mm/ you
> would suggest.
> 
> I've heard the "every patch is a snowflake" story quite a few times, and
> I understand that most mm/ patches are complex, but we agree that
> manually testing every patch isn't scalable, right? Even for patches
> that mm/ tags for stable, are they actually tested on every stable tree?
> How is it different from the "aplies-it-must-be-ok workflow"?
> 
> --
> Thanks,
> Sasha
> 
