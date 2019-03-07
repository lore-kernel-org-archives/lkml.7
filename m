Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C201C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27DE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:48:27 -0500
Received: from foss.arm.com ([217.140.101.70]:43714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCGKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:48:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85ED3EBD;
        Thu,  7 Mar 2019 02:48:26 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518CA3F706;
        Thu,  7 Mar 2019 02:48:25 -0800 (PST)
Subject: Re: [PATCH] coresight: catu: fix clang build warning
To:     arnd@arndb.de, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     ndesaulniers@google.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190307103309.1574563-1-arnd@arndb.de>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b32ab22a-2513-29b9-c000-d698f4efcb90@arm.com>
Date:   Thu, 7 Mar 2019 10:48:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307103309.1574563-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 07/03/2019 10:32, Arnd Bergmann wrote:
> Clang points out a syntax error, as the etr_catu_buf_ops structure is
> declared 'static' before the type is known:
> 
> In file included from drivers/hwtracing/coresight/coresight-tmc-etr.c:12:
> drivers/hwtracing/coresight/coresight-catu.h:116:40: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct etr_buf_operations' [-Wtentative-definition-incomplete-type]
> static const struct etr_buf_operations etr_catu_buf_ops;
>                                         ^
> drivers/hwtracing/coresight/coresight-catu.h:116:21: note: forward declaration of 'struct etr_buf_operations'
> static const struct etr_buf_operations etr_catu_buf_ops;
> 
> This seems worth fixing in the code, so replace pointer to the empty
> constant structure with a NULL pointer. We need an extra NULL pointer
> check here, but the result should be better object code otherwise,
> avoiding the silly empty structure.
> 
> Fixes: 434d611cddef ("coresight: catu: Plug in CATU as a backend for ETR buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
