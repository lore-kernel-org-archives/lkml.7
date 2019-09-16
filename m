Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7CC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252912067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfIPF0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:26:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:29724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIPF0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:26:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 22:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="190970096"
Received: from abonnier-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.54.54])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2019 22:26:18 -0700
Date:   Mon, 16 Sep 2019 08:26:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190916052616.GB4556@linux.intel.com>
References: <20190914171743.22786-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914171743.22786-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 08:17:44PM +0300, ivan.lazeev@gmail.com wrote:
> From: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> cmd/rsp buffers are expected to be in the same ACPI region.
> For Zen+ CPUs BIOS's might report two different regions, some of
> them also report region sizes inconsistent with values from TPM
> registers.
> 
> Memory configuration on ASRock x470 ITX:
> 
> db0a0000-dc59efff : Reserved
> 	dc57e000-dc57efff : MSFT0101:00
> 	dc582000-dc582fff : MSFT0101:00

This is interesting and great thing for us because we can test fully
the tpm_crb part without requiring NVS tweaks. And NVS tweak can then
be built on top of working code.

So far I've seen only AMD fTPM's that report NVS regions. This is
important thing to have in the commit message.

I'll give a detailed review later on.

/Jarkko
