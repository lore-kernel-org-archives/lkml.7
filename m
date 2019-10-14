Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05FAECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C8920663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbfJNQpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:45:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:64923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbfJNQpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:45:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="220152156"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2019 09:45:12 -0700
Date:   Mon, 14 Oct 2019 09:45:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be
 "flags"
Message-ID: <20191014164513.GA6839@iweiny-DESK2.sc.intel.com>
References: <20191013221155.382378-3-jhubbard@nvidia.com>
 <201910141316.DHpeevy3%lkp@intel.com>
 <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
 <20191014135234.7ak32pfir6du3xae@box>
 <acc39afa-ae6f-0eb9-fa31-1b63f8f86b2e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc39afa-ae6f-0eb9-fa31-1b63f8f86b2e@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:14:04PM +0530, Aneesh Kumar K.V wrote:
> On 10/14/19 7:22 PM, Kirill A. Shutemov wrote:
> > On Sun, Oct 13, 2019 at 11:43:10PM -0700, John Hubbard wrote:
> > > On 10/13/19 11:12 PM, kbuild test robot wrote:
> > > > Hi John,
> > > > 
> > > > Thank you for the patch! Yet something to improve:
> > > > 
> > > > [auto build test ERROR on linus/master]
> > > > [cannot apply to v5.4-rc3 next-20191011]
> > > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > 
> > > > url:    https://github.com/0day-ci/linux/commits/John-Hubbard/gup-c-gup_benchmark-c-trivial-fixes-before-the-storm/20191014-114158
> > > > config: powerpc-defconfig (attached as .config)
> > > > compiler: powerpc64-linux-gcc (GCC) 7.4.0
> > > > reproduce:
> > > >           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >           chmod +x ~/bin/make.cross
> > > >           # save the attached .config to linux build tree
> > > >           GCC_VERSION=7.4.0 make.cross ARCH=powerpc
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >      mm/gup.c: In function 'gup_hugepte':
> > > > > > mm/gup.c:1990:33: error: 'write' undeclared (first use in this function); did you mean 'writeq'?
> > > >        if (!pte_access_permitted(pte, write))
> > > >                                       ^~~~~
> > > >                                       writeq
> > > >      mm/gup.c:1990:33: note: each undeclared identifier is reported only once for each function it appears in
> > > > 
> > > 
> > > OK, so this shows that my cross-compiler test scripts are faulty lately,
> > > sorry I missed this.
> > > 
> > > But more importantly, the above missed case is an example of when "write" really
> > > means "write", as opposed to meaning flags.
> > > 
> > > Please put this patch on hold or drop it, until we hear from the authors as to how
> > > they would like to resolve this. I suspect it will end up as something like:
> > > 
> > > 	bool write = (flags & FOLL_WRITE);
> > > 
> > > ...perhaps?
> > 
> > Just use
> > 
> > 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> > 
> > as we have in gup_pte_range().
> > 
> > And add:
> > 
> > Fixes: cbd34da7dc9a ("mm: move the powerpc hugepd code to mm/gup.c")
> > 
> 
> b798bec4741bdd80224214fdd004c8e52698e42 isn't this the commit that need to
> be mentioned in the Fixes: tag?

Yes, and while we are at it the type should probably be changed to unsigned
int.

Ira

> 
> -aneesh
