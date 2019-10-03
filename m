Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080EC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA6A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfJCLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:35:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:44399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfJCLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:35:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 04:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="198505323"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.161])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2019 04:35:06 -0700
Date:   Thu, 3 Oct 2019 14:35:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20191003113506.GE8933@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
 <1569420226.3642.24.camel@HansenPartnership.com>
 <20190927130657.GA5556@linux.intel.com>
 <1570020105.4999.106.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570020105.4999.106.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:41:45AM -0400, Mimi Zohar wrote:
> On Fri, 2019-09-27 at 16:06 +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 25, 2019 at 10:03:46AM -0400, James Bottomley wrote:
> > > On Wed, 2019-09-25 at 16:48 +0300, Jarkko Sakkinen wrote:
> > > [...]
> > > > +	data_page = alloc_page(GFP_HIGHUSER);
> > > > +	if (!data_page)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	data_ptr = kmap(data_page);
> > > 
> > > I don't think this is such a good idea.  On 64 bit it's no different
> > > from GFP_KERNEL and on 32 bit where we do have highmem, kmap space is
> > > at a premium, so doing a highmem allocation + kmap is more wasteful of
> > > resources than simply doing GFP_KERNEL.  In general, you should only do
> > > GFP_HIGHMEM if the page is going to be mostly used by userspace, which
> > > really isn't the case here.
> > 
> > Changing that in this commit would be wrong even if you are right.
> > After this commit has been applied it is somewhat easier to make
> > best choices for allocation in each call site (probably most will
> > end up using stack).
> 
> Agreed, but it could be a separate patch, prior to this one.  Why
> duplicate the problem all over only to change it later?

What problem exactly it is duplicating? The existing allocation
scheme here works correctly.

/Jarkko
