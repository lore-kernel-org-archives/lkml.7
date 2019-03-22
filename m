Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45412218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfCVKMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:12:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:49211 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfCVKMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:12:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 03:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="124918269"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.199])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2019 03:12:29 -0700
Date:   Fri, 22 Mar 2019 12:12:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware
 TPM
Message-ID: <20190322101227.GB3122@linux.intel.com>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com>
 <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
 <CAPcyv4gc_KWedC12bTcX24KwjKiBCF=yvouRNzCbJKaLrgJdDg@mail.gmail.com>
 <d0434a90-4010-8c76-c02e-bb1a6ec831ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0434a90-4010-8c76-c02e-bb1a6ec831ef@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:45:47PM +0100, Roberto Sassu wrote:
> On 3/21/2019 5:30 PM, Dan Williams wrote:
> > On Thu, Mar 21, 2019 at 7:27 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> > > 
> > > On 3/21/2019 2:54 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Mar 18, 2019 at 04:45:13PM -0700, Dan Williams wrote:
> > > > > Rather than fail initialization of the trusted.ko module, arrange for
> > > > > the module to load, but rely on trusted_instantiate() to fail
> > > > > trusted-key operations.
> > > > > 
> > > > > Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> > > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: James Bottomley <jejb@linux.ibm.com>
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > 
> > > > It should check for chip in each function that uses TPM now that
> > > > the code does not rely on default chip. Otherwise, the semantics
> > > > are kind of inconsistent.
> > > 
> > > If no other TPM function can be used before a successful key
> > > instantiate, checking for a chip only in trusted_instantiate() seems
> > > sufficient. Then, the same chip will be used by all TPM functions until
> > > module unloading, since we incremented the reference count.
> > > 
> > > I would suggest to move the tpm_default_chip() and init_digests() calls
> > > to trusted_instantiate() to restore the old behavior of init_trusted().
> > > 
> > > trusted_instantiate() should look like:
> > > ---
> > > if (!chip) {
> > >          chip = tpm_default_chip();
> > >          if (!chip)
> > >                  return -ENODEV;
> > > }
> > > 
> > > if (!digests) {
> > >          ret = init_digests();
> > >          if (ret < 0)
> > >                  return ret;
> > > }
> > 
> > This patch already achieves that because tpm_find_get_ops() will fail
> > and cause tpm_is_tpm2() to return NULL.
> 
> In addition, the changes I proposed would allow users to create trusted
> keys if a TPM is added later. CONFIG_TRUSTED_KEYS=y and
> CONFIG_TCG_TPM=m is a valid configuration.
> 
> Jarkko, Dan's patch seems sufficient to fix the issue. He could include
> the changes I proposed in his patch. What is your opinion?

Agreed.

/Jarkko
