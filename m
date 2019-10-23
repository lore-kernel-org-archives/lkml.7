Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA66F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icuzZkfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfJWBbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:31:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbfJWBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:31:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id u20so9251120plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U+vdvB09PkcmP9LOSiC0ehQS4Gt1iKc8AAE0Dv+6kRA=;
        b=icuzZkfsf6ZSelPljNgPbP4csFqQFl2Ak5zwtLrdaLzvtkDGqlGgHiI5ub/qNRiYTQ
         apk71bTqumsbDb7iSBkXZkY6/OKbTlASf7av5e31sVfx88j1rni0PhG7iMpdyhYmM3Bq
         S7+HsNCX6tXaG571Wv7zg2f2pLhe1sYoMKHukdQ1zSiRKeja3NPf/JrKf9efFnsBVaNy
         +//ppc/74V7hoIpZ+5Bxp9cC0faI8PSbJjxKwB0dJhx/FQZBK9acMIuBtw/qXSaOEn9B
         VFFmbeX102i95ofIX9FtrFPXLWGBY6UqP3xft51SwN7QCAlzxjlHvKZQObOL1Shk63c8
         E7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U+vdvB09PkcmP9LOSiC0ehQS4Gt1iKc8AAE0Dv+6kRA=;
        b=DnUNB9pVJfXvrfJ6H9IWmxb8AUx4ScFOlJwDx0wW/2vNSlXDO2cpHbPrbmyN2uHkpZ
         OxjDtUf2IjyrIqo77IMi0zrwUyp3eNTwlpuTzUAP1KxTIuARtcbnV4zXoX9Gt4bkzJE7
         wBgytjOVRvmDUVU1+pn5BDm2lVH+WdWrJ1Z7uSfLrCCfb4c4B5GFgtKiwpU1RPhr5srX
         wsDWEyCdzcAUu1Y2rZXv+2Vs9bLNE/kuNXogg5oz/HAC1LZwzVcCAbco6YuEJm/Jlj/m
         hFnFh/pO6IaIf9QALGE6HPmClykHLXWVSl5Hj0I6wNPnPrLCz3ce/68tGf96wAOApE8u
         n0zA==
X-Gm-Message-State: APjAAAUTSSb+qCc2Y3H6tVBtok2aUVWXNjb9tZFRB7BavfHCn3CkaAtk
        ruV4H/0lLi7iqK/Eulu3+13Mig==
X-Google-Smtp-Source: APXvYqxE8RiHT/nJrFWc4+VZpi4jlH8YH8RQGdcO2b3ip3wceSVMGwRPpH13x8KxC3Mfvmi0sr0OYQ==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr6876407plb.244.1571794307043;
        Tue, 22 Oct 2019 18:31:47 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id g20sm20806561pfo.73.2019.10.22.18.31.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 18:31:46 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:31:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
In-Reply-To: <4ea5d015-19cb-d5d9-42f7-d1319d8de7c4@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1910221802270.2748@eggly.anvils>
References: <1571769577-89735-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1910221454060.2077@eggly.anvils> <4ea5d015-19cb-d5d9-42f7-d1319d8de7c4@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Yang Shi wrote:
> On 10/22/19 3:27 PM, Hugh Dickins wrote:
> > 
> > I completely agree that the current PageTransCompoundMap() is wrong.
> > 
> > A fix for that is one of many patches I've not yet got to upstreaming.
> > Comparing yours and mine, I'm worried by your use of PageDoubleMap(),
> > because really that's a flag for anon THP, and not properly supported
> > on shmem (or now I suppose file) THP - I forget the details, is it
> > that it sometimes gets set, but never cleared?  Generally, we just
> > don't refer to PageDoubleMap() on shmem THPs (but there may be
> > exceptions: sorting out the THP mapcount maze, and eliminating
> > PageDoubleMap(), is one of my long-held ambitions, not yet reached).
> > 
> > Here's the patch I've been carrying, but it's from earlier, so I
> > should warn that I've done no more than build-testing it on 5.4,
> > and I'm too far away from these issues at the moment to be able to
> > make a good judgement or argue for it - I hope you and others can
> > decide which patch is the better.  I should also add that we're
> > barely using PageTransCompoundMap() at all: at best it can only
> > give a heuristic guess as to whether the page is pmd-mapped in
> > any particular case, and we preferred to take forward the KVM
> > patches we posted back in April 2016, plumbing hva down to where
> > it's needed - though of course those are somewhat different now.
> 
> Thanks for catching this. I was definitely thinking about using
> compount_mapcount instead of DoubleMap flag when I was working the patch. I
> just simply thought it would change less file by using DoubleMap flag but I
> didn't notice it was kind of unbalanced for file THP.
> 
> With the unbalanced DoubleMap flag, it sounds better to use
> compound_mapcount.

Yes: no doubt PageDoubleMap could be fixed on shmem+file, but I have no
interest in doing that, because it's just unnecessary overhead for them.
(They have their own overhead, of subpage mapcounting for pmd: which is
something to eliminate and unify with anon when I get around to it.)

> 
> Thanks for sharing your patch, I'm going to rework v2 by using
> compound_mapcount. Do you mind I might steal your patch?

Please do! One less for me to worry about, thanks.

> 
> I'm supposed we'd better fix this bug regardless of whether you would like to
> move forward your KVM patches.

Absolutely. There remain a few other uses of PageTransCompoundMap
anyway, and I really wanted this outright mm fix to go in before
re-submitting AndresLC's KVM patch (I'll ask a KVM-savvy colleague
to take that over, Cc'ing you, once the mm end is correct).

Hugh
