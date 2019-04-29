Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C02075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfD2FVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:21:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbfD2FVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E4EFAD3E;
        Mon, 29 Apr 2019 05:21:37 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id A3466E0117; Mon, 29 Apr 2019 07:21:36 +0200 (CEST)
Date:   Mon, 29 Apr 2019 07:21:36 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: v5.1-rc7 fails to build on s390x (Re: Linux 5.1-rc7)
Message-ID: <20190429052136.GA21672@unicorn.suse.cz>
References: <CAHk-=whvWQbP20g77U4QRXQDS5w+kf=V-P2QjMkgA-OwJJjHtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvWQbP20g77U4QRXQDS5w+kf=V-P2QjMkgA-OwJJjHtg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5.1-rc7 fails to build on s390x due to

		vmf->page = ZERO_PAGE(vmf->vm_start);

from commit 67f269b37f9b ("RDMA/ucontext: Fix regression with
disassociate"). This is not a problem on x86_64 where ZERO_PAGE()
doesn't use its argument but s390 version does.

I suppose the line should rather read

		vmf->page = ZERO_PAGE(vmf->vma->vm_start);

but I'm just guessing.

Michal Kubecek
