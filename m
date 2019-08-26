Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C111C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3F2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfHZUXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:23:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:37954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbfHZUXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:23:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 13:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="187703911"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2019 13:23:39 -0700
Date:   Mon, 26 Aug 2019 13:23:39 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190826202339.GA49895@otc-nc-03>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824085300.GB16813@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

Minor nit: Small commit log fixup below. 

On Sat, Aug 24, 2019 at 10:53:00AM +0200, Borislav Petkov wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> Date: Thu, 22 Aug 2019 23:43:47 +0300
> 
> Microcode update was changed to be serialized due to restrictions after
> Spectre days. Updating serially on a large multi-socket system can be
> painful since it is being done on one CPU at a time.
> 
> Cloud customers have expressed discontent as services disappear for a
> prolonged time. The restriction is that only one core goes through the
s/one core/one thread of a core/

> update while other cores are quiesced.
s/cores/other thread(s) of the core

> 
> Do the microcode update only on the first thread of each core while
> other siblings simply wait for this to complete.
> 
>  [ bp: Simplify, massage, cleanup comments. ]
> 

Cheers,
Ashok
