Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEAC41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C2C22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564185150;
	bh=duPWZXNISArr/kR1w6uKGNRe0QFiHR2VTP/jsAi4jII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fQ7HZrTbuOsVk0nnAx/Sa3unyhu7IUkGz122qA/FIDKNlbYhGPNisR8Ou/DxsGKWv
	 5ulw/413oiEg0Lf2tRe3C7RhTg4GokhjpKuUh9IjBKvf1fKvLCgrVlyJtxTcxGzCf+
	 KCmekUYos20pFwNQ46uoafdcJroO5j6kxj80Sj80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfGZXw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfGZXw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:52:28 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264F522BE8;
        Fri, 26 Jul 2019 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564185147;
        bh=duPWZXNISArr/kR1w6uKGNRe0QFiHR2VTP/jsAi4jII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hYhyEKJ6315SFImWkhrogq8opXyZESo6nvCUXeRvILhK2r0LDuZ31t9nxJ78gRdGN
         Boll48yRo/jNq8My/PXPvGMfEI5pMZ/ex+PKcSDBlDuUVLG11jX/b/2+vzX5u6/Njg
         8aMojsLEWqYzzwbDPg2vBs86CNLrnsOgPnS+Y30M=
Date:   Fri, 26 Jul 2019 16:52:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Message-Id: <20190726165226.7068704eb54a0104aaead703@linux-foundation.org>
In-Reply-To: <509AB060-6E17-40AB-A773-DF3FB8EBDB62@fb.com>
References: <20190726054654.1623433-1-songliubraving@fb.com>
        <20190726054654.1623433-5-songliubraving@fb.com>
        <20190726160239.68f538a79913df343308b473@linux-foundation.org>
        <509AB060-6E17-40AB-A773-DF3FB8EBDB62@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 23:44:34 +0000 Song Liu <songliubraving@fb.com> wrote:

> 
> 
> > On Jul 26, 2019, at 4:02 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > On Thu, 25 Jul 2019 22:46:54 -0700 Song Liu <songliubraving@fb.com> wrote:
> > 
> >> This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables easy
> >> regroup of huge pmd after the uprobe is disabled (in next patch).
> > 
> > Confused.  There is no "next patch".
> 
> That was the patch 5, which was in earlier versions. I am working on 
> addressing Kirill's feedback for it. 
> 
> Do I need to resubmit 4/4 with modified change log? 

Please just send new changelog text now.  I assume this [4/4] patch is
useful without patch #5, but a description of why it is useful is
appropriate.

I trust the fifth patch is to be sent soon?
