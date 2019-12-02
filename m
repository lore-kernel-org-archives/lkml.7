Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DED620718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLBWRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:17:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:59081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:17:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 14:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="410596616"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2019 14:17:07 -0800
Date:   Mon, 2 Dec 2019 14:29:02 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of
 unsigned long
Message-ID: <20191202222902.GB220960@romley-ivt3.sc.intel.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
 <e236e8fe-3a81-e17a-2286-228bfde9919a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e236e8fe-3a81-e17a-2286-228bfde9919a@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:02:13AM +0100, Jürgen Groß wrote:
> On 25.11.19 20:43, Fenghua Yu wrote:
> >The address of "flags" is passed to atomic bitops which require the 
> >address is aligned to size of unsigned long.
> >
> >Signed-off-by: Fenghua Yu <fenghua.yu@intel.com> ---
> >  include/xen/interface/io/pciif.h | 7 +++++-- 1 file changed, 5 
> >  insertions(+), 2 deletions(-)
> >
> >diff --git a/include/xen/interface/io/pciif.h 
> >b/include/xen/interface/io/pciif.h index d9922ae36eb5..639d5fb484a3 
> >100644 --- a/include/xen/interface/io/pciif.h +++ 
> >b/include/xen/interface/io/pciif.h @@ -103,8 +103,11 @@ struct 
> >xen_pcie_aer_op {
> >  	uint32_t devfn;
> >  };
> >  struct xen_pci_sharedinfo { - /* flags - XEN_PCIF_* */ - uint32_t 
> >flags; + /* flags - XEN_PCIF_*. Force alignment for atomic bit 
> >operations. */ + union { + uint32_t flags; + unsigned long 
> >flags_alignment; + };
> >  	struct xen_pci_op op; struct xen_pcie_aer_op aer_op;
> >  };
> >
> 
> NAK.
> 
> This is an interface definition for communication between Xen dom0 and 
> guests via shared memory. It can't be changed.
> 
> BTW: you should Cc: the maintainers for the files you are modifying.
> 
> 
> Juergen

After spending more time on the patch, actually I find this patch is not 
needed because there is no split lock issue on the "flags" field:

The bit offsets in all atomic bitops on the "flags" field are always 
constant values. On x86, an atomic bitop is optimized to use a locked byte
instruciton which only operates the byte containing the bit. So the
byte won't across cache line boundaries and there won't be split lock
issue in the atomic bitops

I will remove this patch in the next version of the patch set.

Thanks.

-Fenghua

