Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2BD2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfIEW1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:27:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:53141 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732714AbfIEW1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:27:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 15:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="267161496"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2019 15:27:06 -0700
Date:   Thu, 5 Sep 2019 15:27:06 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190905222706.GA4422@otc-nc-03>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
 <20190829060942.GA1312@zn.tnic>
 <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


On Thu, Sep 05, 2019 at 11:22:31PM +0200, Thomas Gleixner wrote:
> Raj,
> 
> On Thu, 5 Sep 2019, Raj, Ashok wrote:
> > On Thu, Sep 05, 2019 at 09:20:29AM +0200, Borislav Petkov wrote:
> > > On Wed, Sep 04, 2019 at 05:21:32PM -0700, Raj, Ashok wrote:
> > > > But echo 2 > reload would allow reading a microcode file from 
> > > > /lib/firmware/intel-ucode/ even if the revision hasn't changed right?
> > > > 
> > > > #echo 1 > reload wouldn't load if the revision on disk is same as what's loaded,
> > > > and we want to permit that with the echo 2 option.
> > > 
> > > Then before we continue with this, please specify what the exact
> > > requirements are. Talk to your microcoders or whoever is going to use
> > > this and give the exact use cases which should be supported and describe
> > > them in detail.
> > 
> > https://lore.kernel.org/lkml/1567056803-6640-1-git-send-email-ashok.raj@intel.com/
> > 
> > The original description said to load a new microcode file, the content
> > could have changed, but revision in the header hasn't increased. 
> > 
> > The other rules are same, i.e we can't go backwards. There is another
> > SVN (Security version number) embedded in the microcode which won't allow
> > going backwards anyway. 
> > 
> > I'll get back to you if there are additional uses, but allowing the facility to 
> > actually read the file achieves the same purpose as using the in-kernel copy.
> > 
> > I have used it multiple times during development :-)
> 
> That's all nice, but what it the general use case for this outside of Intel's
> microcode development and testing?
> 
> We all know that late microcode loading has severe limitations and we
> really don't want to proliferate that further if not absolutely required

Several customers have asked this to check the safety of late loads. They want
to validate in production setup prior to rolling late-load to all production systems.

Thanks
Ashok
