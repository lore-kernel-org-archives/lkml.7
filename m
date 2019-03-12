Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C333C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8BC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tj32NjeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfCLRwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:52:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCLRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=230SxmBFj0CarYJqxw8BlXT5FM8fCROKpq+2bHkGdlo=; b=Tj32NjePxjUsmkEjqkLxiHNw1
        Dq2MT3TJlBRfi3Y5NnjBDk0s0EweaLHROW2FkBIoagTnzjZwu+62Z2k4cmXZ6xvKO8tCqVCbwC89M
        O2TZMeFtNgncUjsUqA1sOGxk+SAcb02OrfpORBguPKFKQJ/hAusPAJWA6fW2vYc5q7UcQDbcEmG+S
        9JXb7vu5bfU6tS7C1pdEq2NV91qD7Kfb4ts7F82G3nJzFeoLZZnr4pJuMf9288awplKXHtCxo5dzu
        68dviPy441t94N5Oh+B+hxojBIzgjeJr2PJguSlyYWR8Zs61GC361dQWAHggIPssoaARwY7ZMqZpc
        aSxcGtrsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3kyr-0002MN-ID; Tue, 12 Mar 2019 17:14:21 +0000
Date:   Tue, 12 Mar 2019 10:14:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     osstest service owner <osstest-admin@xenproject.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, david@redhat.com,
        k.khlebnikov@samsung.com, Julien Freche <jfreche@vmware.com>,
        Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-mm@kvack.org
Subject: Re: xen: Can't insert balloon page into VM userspace (WAS Re:
 [Xen-devel] [linux-linus bisection] complete test-arm64-arm64-xl-xsm)
Message-ID: <20190312171421.GJ19508@bombadil.infradead.org>
References: <E1h3Uiq-0002L6-Ij@osstest.test-lab.xenproject.org>
 <80211e70-5f54-9421-8e8f-2a4fc758ce39@arm.com>
 <46118631-61d4-adb6-6ffc-4e7c62ea3da9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46118631-61d4-adb6-6ffc-4e7c62ea3da9@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 05:05:39PM +0000, Julien Grall wrote:
> On 3/12/19 3:59 PM, Julien Grall wrote:
> > It looks like all the arm test for linus [1] and next [2] tree
> > are now failing. x86 seems to be mostly ok.
> > 
> > The bisector fingered the following commit:
> > 
> > commit 0ee930e6cafa048c1925893d0ca89918b2814f2c
> > Author: Matthew Wilcox <willy@infradead.org>
> > Date:   Tue Mar 5 15:46:06 2019 -0800
> > 
> >      mm/memory.c: prevent mapping typed pages to userspace
> >      Pages which use page_type must never be mapped to userspace as it would
> >      destroy their page type.  Add an explicit check for this instead of
> >      assuming that kernel drivers always get this right.

Oh good, it found a real problem.

> It turns out the problem is because the balloon driver will call
> __SetPageOffline() on allocated page. Therefore the page has a type and
> vm_insert_pages will deny the insertion.
> 
> My knowledge is quite limited in this area. So I am not sure how we can
> solve the problem.
> 
> I would appreciate if someone could provide input of to fix the mapping.

I don't know the balloon driver, so I don't know why it was doing this,
but what it was doing was Wrong and has been since 2014 with:

commit d6d86c0a7f8ddc5b38cf089222cb1d9540762dc2
Author: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Date:   Thu Oct 9 15:29:27 2014 -0700

    mm/balloon_compaction: redesign ballooned pages management

If ballooned pages are supposed to be mapped into userspace, you can't mark
them as ballooned pages using the mapcount field.
