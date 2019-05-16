Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56928C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336842070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfEPU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:59:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:5975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfEPU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:59:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 13:59:43 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2019 13:59:43 -0700
Date:   Thu, 16 May 2019 13:59:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516205943.GA3299@agluck-desk>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516203456.GD21857@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:34:56PM +0200, Borislav Petkov wrote:
> On Thu, May 16, 2019 at 08:20:58PM +0000, Ghannam, Yazen wrote:
> > We don't actually know if there are bits set in hardware until we read
> > it back. So I don't think this is adding anything new.
> 
> Bah, of course. We need to read it first (pasting the whole function).
> Now, __mcheck_cpu_init_clear_banks() gets called when we change
> configuration too, in mce_cpu_restart() and if we do it this way, we'll
> be rereading MCi_CTL each time but I don't see anything wrong with that.

Intel doesn't "set any bits in hardware" ... so I think you'll just
get a 0x0 and disable everything.

> 
> Hmmm?
> 
> static void __mcheck_cpu_init_clear_banks(void)
> {
>         struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
>         int i;
> 
>         for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>                 struct mce_bank *b = &mce_banks[i];
> 
>                 rdmsrl(msr_ops.ctl(i), b->ctl);
> 
>                 /* Bank is initialized if bits are set in hardware. */
>                 b->init = !!b->ctl;
>                 if (b->init) {
>                         wrmsrl(msr_ops.ctl(i), b->ctl);
>                         wrmsrl(msr_ops.status(i), 0);
>                 }
> 
>         }
> }


I think the intent of the original patch was to find out
which bits are "implemented in hardware". I.e. throw all
1's at the register and see if any of them stick.

I don't object to the idea behind the patch. But if you want
to do this you just should not modify b->ctl.

So something like:
	

static void __mcheck_cpu_init_clear_banks(void)
{
        struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
	u64 tmp;
        int i;

        for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
                struct mce_bank *b = &mce_banks[i];

                if (b->init) {
                        wrmsrl(msr_ops.ctl(i), b->ctl);
                        wrmsrl(msr_ops.status(i), 0);
			rdmsrl(msr_ops.ctl(i), tmp);

			/* Check if any bits implemented in h/w */
			b->init = !!tmp;
                }

        }
}

-Tony

-Tony
