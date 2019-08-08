Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE41C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DEF21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565307572;
	bh=DkAAejaivtf5zjkmcresyTQ54IwUXOKSGkqOhqPx9q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sLUqw/u9wsLC/w1hsmA4zm8+wWxNdruzs2L9VnbNOIl3UzqDj7+dYtQiGdyffWDOt
	 JF3qbUl0AMNN2itAuETJ6jbZhBnkoHQXXuGN3lsXhJVm6NW/xijGqA6IBcqi3jvVXL
	 C2oxs+Z9yVLvkzSD8xxF5YQlJqqDlzMC64g7dwX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbfHHXja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390130AbfHHXja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:39:30 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555262173E;
        Thu,  8 Aug 2019 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565307569;
        bh=DkAAejaivtf5zjkmcresyTQ54IwUXOKSGkqOhqPx9q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5T+9+7pTiq+M8+tRJnzWxAdk5YAAoix4royPR9zIimI3fX2zFgoXWpW/NMtliOdE
         HiW9bJP2T3sY3hkPDdPCAiM0fDFC70VcHJa0tzJi7i4wi5fW6XgFKvPqJNQ4Rpij5r
         Vj8g+vFbWO3xkgW88RwCDFXw9p4DZOq4QsHt+1PU=
Date:   Thu, 8 Aug 2019 16:39:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
Message-Id: <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
In-Reply-To: <20190808185313.GG18351@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
        <20190808074607.GI11812@dhcp22.suse.cz>
        <20190808074736.GJ11812@dhcp22.suse.cz>
        <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
        <20190808185313.GG18351@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 20:53:13 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > https://lkml.org/lkml/2019/6/1/165
> > 
> > Ironic to find that commit message in a stable backport.
> > 
> > I'm happy to drop the Fixes tag.
> 
> No, please do not drop the Fixes tag. That is a very _useful_
> information. If the stable tree maintainers want to abuse it so be it.
> They are responsible for their tree. If you do not think this is a
> stable material then fine with me. I tend to agree but that doesn't mean
> that we should obfuscate Fixes.

Well, we're responsible for stable trees too.  And yes, I find it
irksome.  I/we evaluate *every* fix for -stable inclusion and if I/we
decide "no" then dangit, it should be backported.

Maybe we should introduce the Fixes-no-stable: tag.  That should get
their attention.
