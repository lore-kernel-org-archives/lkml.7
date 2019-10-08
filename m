Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B0AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491B7206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfJHJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:18:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:9232 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfJHJSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:18:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 02:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206604806"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 02:18:04 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 12:18:04 +0300
Date:   Tue, 8 Oct 2019 12:18:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, acelan.kao@canonical.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com, mcgrof@kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191008091804.GB2819@lahna.fi.intel.com>
References: <20191007184231.13256-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007184231.13256-1-ztuowen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:42:31PM -0600, Tuowen Zhao wrote:
> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
> 
> This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> and with it overwrite the MTRR settings to force the use of strongly
> uncachable pages for intel-lpss.
> 
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
> 
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> 
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
