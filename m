Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284A220851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfCAOxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:53:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:11229 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfCAOxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:53:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 06:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,427,1544515200"; 
   d="scan'208";a="138262931"
Received: from mylly.fi.intel.com (HELO [10.237.72.68]) ([10.237.72.68])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2019 06:53:08 -0800
Subject: Re: [PATCH v5 2/2] i2c: designware: Add support for an interface
 clock
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <080b8edd-168e-d71a-b4c2-985460a51e53@linux.intel.com>
Date:   Fri, 1 Mar 2019 16:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 3:52 PM, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> The Synopsys I2C Controller has an interface clock, but most SoCs hide
> this away. However, on some SoCs you need to explicitly enable the
> interface clock in order to access the registers. Therefore, add
> support for an optional interface clock.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>   - Updated comments to reference "interface clock" instead of
>     "peripheral clock".
>   - Corrected spelling in commit message, changing "explicity" to
>     "explicitly".
> v4:
>   - Updated comments to reference "peripheral clock"
>     instead of "bus clock".
>   - Added Wolfram's Acked-by
> v3:
>   - busclk renamed to pclk.
>   - Added comment with dw_i2c_dev struct definition describing pclk.
>   - Added enable rollback of first clock if second fails to enable.
> v2:
>   - Use new devm_clk_get_optional() function as it simplifies handling when
>     the optional clock is not present.
> ---
>   drivers/i2c/busses/i2c-designware-common.c  | 18 ++++++++++++++++--
>   drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>   drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
Build & boot tested on linux-next that has the required commit
60b8f0ddf1a9 ("clk: Add (devm_)clk_get_optional() functions").

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
