Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E584C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BD521925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCUNsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:48:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:49139 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfCUNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:48:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="153822859"
Received: from dilu-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 06:48:32 -0700
Date:   Thu, 21 Mar 2019 15:48:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     keyrings@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        David Howells <dhowells@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] security/keys/encrypted: Break module dependency
 chain
Message-ID: <20190321134831.GC4603@linux.intel.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
 <20190321134549.GB4603@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321134549.GB4603@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:45:49PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 19, 2019 at 02:01:44PM -0700, Dan Williams wrote:
> > On Mon, Mar 18, 2019 at 11:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > With v5.1-rc1 all the nvdimm sub-system regression tests started failing
> > > because the libnvdimm module failed to load in the qemu-kvm test
> > > environment.  Critically that environment does not have a TPM. Commit
> > > 240730437deb "KEYS: trusted: explicitly use tpm_chip structure..."
> > > started to require a TPM to be present for the trusted.ko module to load
> > > where there was no requirement for that before.
> > >
> > > Rather than undo the "fail if no hardware" behavior James points out
> > > that the module dependencies can be broken by looking up the key-type by
> > > name. Remove the dependencies on the "key_type_trusted" and
> > > "key_type_encrypted" symbol exports, and clean up other boilerplate that
> > > supported those exports in different configurations.
> > 
> > Any feedback? Was hoping to get at least patch1 in the queue for
> > v5.1-rc2 since this effectively disables the nvdimm driver on typical
> > configurations. Jarkko, would you be willing to merge it since the
> > regression came through your tree?
> 
> Yes, of course. The feedback has been extremely passive because I've
> been sick leave for the early week :-)
> 
> Before I'm merging this I'm just thinking that would it be better
> idea to merge a patch for trusted.c that reverts the old behavior
> with cc to stable and fixes tags as I said in my earlier response.
> 
> It would less intrusive for stable kernels. Lets quickly sort out
> the best strategy before merging.

I.e. the way I see the situation:

1. Reverting the old behavior in the sense that missing TPM does
   not prevent init of trusted.ko should be done right now.
2. Your patch could be definitely merged but not as a bug fix.
3. At some point we could consider failing the init of trusted.ko
   if TPM is missing because that is kind of senseful anyway with
   better testing now that we understand the dependency context
   better.
