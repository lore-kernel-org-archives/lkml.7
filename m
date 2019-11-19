Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22149C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1907222A0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfKSOzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:55:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:43779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfKSOzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:55:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 06:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="407774783"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2019 06:55:19 -0800
Subject: Re: [PATCH v3] usb: xhci: only set D3hot for pci device
To:     Henry Lin <henryl@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191113014927.11915-1-henryl@nvidia.com>
 <20191119081656.8746-1-henryl@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <a06cd930-01d4-da57-1606-69e78566abb3@linux.intel.com>
Date:   Tue, 19 Nov 2019 16:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119081656.8746-1-henryl@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2019 10.16, Henry Lin wrote:
> Xhci driver cannot call pci_set_power_state() on non-pci xhci host
> controllers. For example, NVIDIA Tegra XHCI host controller which acts
> as platform device with XHCI_SPURIOUS_WAKEUP quirk set in some platform
> hits this issue during shutdown.
> 
> Signed-off-by: Henry Lin <henryl@nvidia.com>

Thanks, looks great.

I like this solution.
Keeps original code sequence, removes pci specific calls from generic xhci code,
and at the same time it fixes the NVIDIA Tegra xHC shutdown issue.

Adding to queue

-Mathias
