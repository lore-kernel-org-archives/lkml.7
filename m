Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7925E21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565389042;
	bh=sBCc7FSNFhlnRsGYMaaCt24naPV+9JGWf4SdSDBpZSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C6+A/UqK9h2rIOVe2kh3S50tAOfvLRuvvskPa0+HgvnvXZShBEezcENtVTF1gZJN+
	 NhqbWng0PoLKjLTYuerZISk3oR0IE36Ai4nv9bx5CtZloRZLFi00zqBWuF9x1Jz1yY
	 Z9q1Dery3C0tm1/tcZHd750pjTHzl19j5DQkX9Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfHIWRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfHIWRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:17:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8646B20C01;
        Fri,  9 Aug 2019 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565389039;
        bh=sBCc7FSNFhlnRsGYMaaCt24naPV+9JGWf4SdSDBpZSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M0Yq6MHAY53t1ncV64OxCpQqedn+WGq7kUdkHQs/u4ha4+lqiISH5b3bRrmIog8Wt
         o8ciIYK8TbwhCQwuiXofvHPxI9UqaGaq0sdOWGr5Xetzut3rRRFlbp/2r5gMkvzC1m
         KsxqJdOSCt+CD15CCLeCix6toLaH2Y6YVAvmk3DQ=
Date:   Fri, 9 Aug 2019 15:17:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
Message-Id: <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
In-Reply-To: <20190809064633.GK18351@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
        <20190808074607.GI11812@dhcp22.suse.cz>
        <20190808074736.GJ11812@dhcp22.suse.cz>
        <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
        <20190808185313.GG18351@dhcp22.suse.cz>
        <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
        <20190809064633.GK18351@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > Maybe we should introduce the Fixes-no-stable: tag.  That should get
> > their attention.
> 
> No please, Fixes shouldn't be really tight to any stable tree rules. It
> is a very useful indication of which commit has introduced bug/problem
> or whatever that the patch follows up to. We in Suse are using this tag
> to evaluate potential fixes as the stable is not reliable. We could live
> with Fixes-no-stable or whatever other name but does it really makes
> sense to complicate the existing state when stable maintainers are doing
> whatever they want anyway? Does a tag like that force AI from selecting
> a patch? I am not really convinced.

It should work if we ask stable trees maintainers not to backport
such patches.

Sasha, please don't backport patches which are marked Fixes-no-stable:
and which lack a cc:stable tag.
