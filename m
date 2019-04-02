Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD4C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED1420856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfDBNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:07:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:61872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbfDBNHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:07:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 06:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="288022998"
Received: from vsimsek-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.239])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2019 06:07:06 -0700
Date:   Tue, 2 Apr 2019 16:07:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     tomas.winkler@intel.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
Message-ID: <20190402130704.GA3916@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190401235245.GA29282@linux.intel.com>
 <CACdnJutCC7n++Nz5qy1YzmsSchEApDUvMH9-qpxYXckh-Dzf-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutCC7n++Nz5qy1YzmsSchEApDUvMH9-qpxYXckh-Dzf-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:32:26PM -0700, Matthew Garrett wrote:
> On Mon, Apr 1, 2019 at 4:52 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Feb 27, 2019 at 12:26:54PM -0800, Matthew Garrett wrote:
> > > Identical to V4, but based on tpmdd-next
> >
> > OK, so on my GLK NUC I get valid final log and invalid event log
> > after adding some extra klogs.
> >
> > I.e.
> >
> > -       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
> > +       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
> 
> Just to make sure - are you booting via the EFI boot stub? We need to
> obtain the boot log before ExitBootServices() is called, so if you're
> booting directly into the 32-bit entry point (eg, by using the "linux"
> command in grub) then you won't get a log.

... and I was wondering why it used to work when I tested the first
flush of patches. Ugh, sorry. The only excuse is too much multitasking
lately.

Anyway:

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I'll apply all patches soonish and include them to the next PR.

/Jarkko
