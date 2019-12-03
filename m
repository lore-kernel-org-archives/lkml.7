Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A6C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239C0206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLCLQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:16:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:45216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfLCLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:16:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 03:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="242354818"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.95]) ([10.237.72.95])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2019 03:16:54 -0800
Subject: Re: fsl,p2020-esdhc sdhci quirks
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8afd0f53-eba8-e000-d8cc-b464e65850c3@rasmusvillemoes.dk>
 <53c77b5b-627e-424c-234b-05f73b44863e@rasmusvillemoes.dk>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ec06a3c3-93dd-3d3f-e436-5d7cc3714531@intel.com>
Date:   Tue, 3 Dec 2019 13:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <53c77b5b-627e-424c-234b-05f73b44863e@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/19 12:49 pm, Rasmus Villemoes wrote:
> On 03/12/2019 11.15, Rasmus Villemoes wrote:
>> Hi
>>
>> Commits
>>
>> 05cb6b2a66fa - mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358
>> support
>> a46e42712596 - mmc: sdhci-of-esdhc: add erratum eSDHC5 support
>>
>> seem a bit odd, in that they set bits from the SDHCI_* namespace in the
>> ->quirks2 member:
>>
>>                 host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>>                 host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> FWIW, with something like the patch below, sparse (make C=1) would complain
> 
> drivers/mmc/host/sdhci-of-esdhc.c:1306:31: warning: invalid assignment: |=
> drivers/mmc/host/sdhci-of-esdhc.c:1306:31:    left side has type
> restricted sdhci_quirk2_t
> drivers/mmc/host/sdhci-of-esdhc.c:1306:31:    right side has type
> restricted sdhci_quirk_t
> drivers/mmc/host/sdhci-of-esdhc.c:1307:31: warning: invalid assignment: |=
> drivers/mmc/host/sdhci-of-esdhc.c:1307:31:    left side has type
> restricted sdhci_quirk2_t
> drivers/mmc/host/sdhci-of-esdhc.c:1307:31:    right side has type
> restricted sdhci_quirk_t
> 
> But maybe that's too much churn, dunno.

Presumably testing would have caught this, so I think it would be better if
people tested their patches.
