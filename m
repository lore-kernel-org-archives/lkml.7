Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0ADC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46121897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568802198;
	bh=/Zfr/QtjxEv0/rdG9JlMCZnPD4M+CijN9S/GYk/RM/s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pW/sE5nQzFTjpsx0jsWH5ZWK8NzAoTXrosbDbN5dFKDR0JFBBhFlJnIU8Qa6Pj6w1
	 RfkaUYvRVqhkm+KGVgyzu5xrzfWGqS3j1VKMd0giIgVnBAPJmLcJ9KlXnD1c6KWkId
	 m1cLQiTkcDJjt0dKvm4H9W0Pgoto746RMsqG8Pm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIRKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:23:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIRKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:23:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA0F337;
        Wed, 18 Sep 2019 03:23:16 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E209F3F59C;
        Wed, 18 Sep 2019 03:23:15 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: Fix GIC_LINE_NR accessor
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wanghaibin.wang@huawei.com
References: <1568789850-14080-1-git-send-email-yuzenghui@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <89645aea-70d4-8456-cb47-5a11846fa934@kernel.org>
Date:   Wed, 18 Sep 2019 11:23:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568789850-14080-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2019 07:57, Zenghui Yu wrote:
> As per GIC spec, ITLinesNumber indicates the maximum SPI INTID that
> the GIC implementation supports. And the maximum SPI INTID an
> implementation might support is 1019 (field value 11111).
> 
> max(GICD_TYPER_SPIS(...), 1020) is not what we actually want for
> GIC_LINE_NR. Fix it to min(GICD_TYPER_SPIS(...), 1020).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> Hi Marc,
> 
> I still see "GICv3: 992 SPIs implemented" on the host. I go back to
> https://patchwork.kernel.org/patch/11078623/ and it seems that we
> failed to make the GIC_LINE_NR correct at that time.

Ah, nice catch. Clearly, I didn't have my head screwed on properly when
I wrote this. I'll take this in for the next round of fixes.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
