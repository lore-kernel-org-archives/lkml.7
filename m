Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88DDC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313B20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDAXwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:52:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:16849 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDAXwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:52:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 16:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="145740064"
Received: from unknown (HELO localhost) ([10.249.254.142])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2019 16:52:47 -0700
Date:   Tue, 2 Apr 2019 02:52:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        tomas.winkler@intel.com
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Subject: Re: Add support for TCG2 log format on UEFI systems
Message-ID: <20190401235245.GA29282@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227202658.197113-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:26:54PM -0800, Matthew Garrett wrote:
> Identical to V4, but based on tpmdd-next

OK, so on my GLK NUC I get valid final log and invalid event log
after adding some extra klogs.

I.e.

-       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
+       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
+               pr_err("No event log\n");
                return -ENODEV;
+       }

will result

[    2.654392] No event log 

but still

[    0.000000] efi:  ACPI 2.0=0x69ca2000  ACPI=0x69ca2000  TPMFinalLog=0x69ce4000  SMBIOS=0x69f63000  SMBIOS 3.0=0x69f62000  ESRT=0x69f3e818  MEMATTR=0x63475118

Tomas, I wonder if you are able to get the log out with some machine?

/Jarkko
