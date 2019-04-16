Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F420684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450697;
	bh=QSmnmybCrs+M+2b86CttsHRBMTgBmbZ5SySYSft3z8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SLtrHYoTvd3NRWrv3K/EkbLe5f9ENyaqtqPBBWR/Ru91TrnqP7miAM18HHN7C2Ycj
	 nuegbGhR5Q2QHFltyUPCeP6XL2rxd/b61FqIt9YJZKEZg+93haUwSPgfxUqv/2HADE
	 X6lsCyphmyqYQvIFETKiVc3/DusuOl3EJui96GLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfDPViQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:38:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfDPViP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:38:15 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2030E21;
        Tue, 16 Apr 2019 21:38:14 +0000 (UTC)
Date:   Tue, 16 Apr 2019 14:38:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tri Vo <trong@android.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>, willy@infradead.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v2] module: add stubs for within_module functions
Message-Id: <20190416143813.4bac4f106930f6686164c11b@linux-foundation.org>
In-Reply-To: <CANA+-vAvLUFPhfXj_CxkV8Fgv+zmqvu=MxwtwFTbr5Nrn68E9g@mail.gmail.com>
References: <20190415142229.GA14330@linux-8ccs>
        <20190415181833.101222-1-trong@android.com>
        <20190416152144.GA1419@linux-8ccs>
        <CANA+-vDxLy7A7aEDsHS4y7ujwN5atzkGrVwSvDs-U3Oa_5oLFg@mail.gmail.com>
        <CANA+-vAvLUFPhfXj_CxkV8Fgv+zmqvu=MxwtwFTbr5Nrn68E9g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 11:56:21 -0700 Tri Vo <trong@android.com> wrote:

> On Tue, Apr 16, 2019 at 10:55 AM Tri Vo <trong@android.com> wrote:
> >
> > On Tue, Apr 16, 2019 at 8:21 AM Jessica Yu <jeyu@kernel.org> wrote:
> > >
> > > +++ Tri Vo [15/04/19 11:18 -0700]:
> > > >Provide stubs for within_module_core(), within_module_init(), and
> > > >within_module() to prevent build errors when !CONFIG_MODULES.
> > > >
> > > >v2:
> > > >- Generalized commit message, as per Jessica.
> > > >- Stubs for within_module_core() and within_module_init(), as per Nick.
> > > >
> > > >Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > >Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > >Reported-by: kbuild test robot <lkp@intel.com>
> > > >Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> > > >Signed-off-by: Tri Vo <trong@android.com>
> > >
> > > Applied, thanks!
> >
> > Thank you!
> 
> Andrew,
> this patch fixes 8c3d220cb6b5 ("gcov: clang support"). Could you
> re-apply the gcov patch? Sorry, if it's a dumb question. I'm not
> familiar with how cross-tree patches are handled in Linux.

hm, I wonder what Jessica applied this patch to?

Please resend a new version of "gcov: clang support".
