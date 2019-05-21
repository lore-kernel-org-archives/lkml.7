Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E66C18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45EF217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfEUUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:42:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:18009 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEUUmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:42:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 13:42:40 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2019 13:42:40 -0700
Date:   Tue, 21 May 2019 13:42:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190521204239.GA11029@agluck-desk>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
 <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190521202902.GC7793@cz.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521202902.GC7793@cz.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:29:02PM +0200, Borislav Petkov wrote:
> 
> Can we do instead:
> 
> -static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks_array);
> +static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank, mce_banks_array[MAX_NR_BANKS]);
> 
> which should be something like 9*32 = 288 bytes per CPU.
> 

Where did you get the "9" from?  struct mce_bank looks to
be over 50 bytes.

Still only 1.5K per cpu though.

-Tony
