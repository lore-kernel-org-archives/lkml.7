Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193EC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A117722CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfIEAVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:21:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:9577 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfIEAVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:21:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 17:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="212590875"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 17:21:32 -0700
Date:   Wed, 4 Sep 2019 17:21:32 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Boris Petkov <bp@alien8.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190905002132.GA26568@otc-nc-03>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
 <20190829060942.GA1312@zn.tnic>
 <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:12:29AM +0200, Boris Petkov wrote:
> On September 5, 2019 12:06:54 AM GMT+02:00, Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:
> >Why do we need to taint kernel here? We are not making any changes.
> 
> Because this is not a normal operation we want users to do. This is only for testing microcode quicker.
> 
> >This won't allow people to load from new microcode blob which I thought
> >was one of the objectives behind this new feature.
> 
> You load a new blob the usual way: echo 1 > ...
> 
> This is the "unusual" way where you reload an already loaded revision only.

But echo 2 > reload would allow reading a microcode file from 
/lib/firmware/intel-ucode/ even if the revision hasn't changed right?

#echo 1 > reload wouldn't load if the revision on disk is same as what's loaded,
and we want to permit that with the echo 2 option.
