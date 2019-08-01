Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49389C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EFE2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564694973;
	bh=IcCzMlX4dc3f9h8KtxcRej0L15KSfSfotNSXtyxh5Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iaiGGhrIVu3hfhiFpVkNYoBH9Awh2cqbatsMrP4QudGGxGhWJA1YeIk3Z/9cG17NM
	 w/WmVBqnG4lDAis2FwBpBDz1OcNJ6VQPyBMSTbsxrtM0fOo3KACJ0veGCoWzZHcfz5
	 2cUi+19ogA2kGH4NPlJQ1WkH3stUsp1D+hzPb9ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfHAV3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:29:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:46792 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfHAV3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:29:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 14:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="191711513"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 14:29:30 -0700
Date:   Thu, 1 Aug 2019 15:26:52 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH v4 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190801212651.GF15795@localhost.localdomain>
References: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <744998862eebecfae79afd23c42d518264231a22.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190801210929.GE15795@localhost.localdomain>
 <d825feec-f6ca-30b8-3c7f-fb94e2e13499@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d825feec-f6ca-30b8-3c7f-fb94e2e13499@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:21:07PM -0700, sathyanarayanan kuppuswamy wrote:
> On 8/1/19 2:09 PM, Keith Busch wrote:
> > Rather than surround the call to pci_pri_init() with the #ifdef, you
> > should provide an empty function implementation when CONFIG_PCI_PRI is
> > not defined. Same thing for the next patch adding PASID.
>
> This function is defined and used in the same file (ats.c). Is there any
> advantage in defining an empty function ? But if this is the recommended
> approach, I can make the necessary changes. Please confirm.

That way is just the existing convention, so it's recommended for
kernel style consistency. See the "Conditional Compilation" section in
Documentation/process/coding-style.rst (currently section 21).
