Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C32C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A225E01
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfE3RKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:10:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:64258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3RKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:10:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 10:10:45 -0700
X-ExtLoop1: 1
Received: from araj-mobl1.jf.intel.com ([10.251.6.93])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2019 10:10:44 -0700
Date:   Thu, 30 May 2019 10:10:44 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tipbot@zytor.com" <tipbot@zytor.com>, "bp@suse.de" <bp@suse.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        David Wang <DavidWang@zhaoxin.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW3RpcDp4ODYv?=
 =?utf-8?Q?urgent=5D_x86=2Fmce=3A_Ensur?= =?utf-8?Q?e?= offline CPUs don' t
 participate in rendezvous process
Message-ID: <20190530171044.GA18559@araj-mobl1.jf.intel.com>
References: <985acf114ab245fbab52caabf03bd280@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985acf114ab245fbab52caabf03bd280@zhaoxin.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 09:13:39AM +0000, Tony W Wang-oc wrote:
> On Thu, May 30, 2019, Tony W Wang-oc wrote:
> > Hi Ashok,
> > I have two questions about this patch, could you help to check:
> > 
> > 1, for broadcast #MC exceptions, this patch seems require #MC exception
> > errors
> > set MCG_STATUS_RIPV = 1.
> > But for Intel CPU, some #MC exception errors set MCG_STATUS_RIPV = 0
> > (like "Recoverable-not-continuable SRAR Type" Errors), for these errors
> > the patch doesn't seem to work, is that okay?
> > 
> > 2, for LMCE exceptions, this patch seems require #MC exception errors
> > set MCG_STATUS_RIPV = 0 to make sure LMCE be handled normally even
> > on offline CPU.
> > For LMCE errors set MCG_STAUS_RIPV = 1, the patch prevents offline CPU
> > handle these LMCE errors, is that okay?
> > 
> 
> More specifically, this patch seems require #MC exceptions meet the condition
> "MCG_STATUS_RIPV ^ MCG_STATUS_LMCES == 1"; But on a Xeon X5650 machine (SMP), 

The offline CPU will never get a LMCE=1, since those only happen on the CPU 
that's doing active work. Offline CPUs just sitting in idle.

The specific error here is a PCC=1, so irrespective of what happens
We do capture the errors in the per-cpu log, and kernel would panic. 

What specifically this patch tries to achieve is to leave an error
sitting with MCG-STATUS.MCIP=1 and another recoverable error would shut the 
system dowm. 

I don't see anything wrong with what this patch does.. 

> "Data CACHE Level-2 Generic Error" does not meet this condition.
> 
> I got below message from: https://www.centos.org/forums/viewtopic.php?p=292742
> 
> Hardware event. This is not a software error.
> MCE 0
> CPU 4 BANK 6 TSC b7065eeaa18b0 
> TIME 1545643603 Mon Dec 24 10:26:43 2018
> MCG status:MCIP 
> MCi status:
> Uncorrected error
> Error enabled
> Processor context corrupt
> MCA: Data CACHE Level-2 Generic Error
> STATUS b200000080000106 MCGSTATUS 4
> MCGCAP 1c09 APICID 4 SOCKETID 0 
> CPUID Vendor Intel Family 6 Model 44
> 
> > Thanks
> > Tony W Wang-oc
