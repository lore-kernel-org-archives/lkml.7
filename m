Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F602C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1912020740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKYRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:53364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKYRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:43:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52EDC31B;
        Mon, 25 Nov 2019 09:43:38 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DED83F68E;
        Mon, 25 Nov 2019 09:43:37 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:43:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm64: dts: arm: juno: Fix UART frequency
Message-ID: <20191125174329.GA10102@bogus>
References: <20191119120331.28243-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119120331.28243-1-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:03:31PM +0000, Andre Przywara wrote:
> Older versions of the Juno *SoC* TRM [1] recommended that the UART clock
> source should be 7.2738 MHz, whereas the *system* TRM [2] stated a more
> correct value of 7.3728 MHz. Somehow the wrong value managed to end up in
> our DT.
> Doing a prime factorisation, a modulo divide by 115200 and trying
> to buy a 7.2738 MHz crystal at your favourite electronics dealer suggest
> that the old value was actually a typo. The actual UART clock is driven
> by a PLL, configured via a parameter in some board.txt file in the
> firmware, which reads 7.37 MHz (sic!).
> 
> Fix this to correct the baud rate divisor calculation on the Juno board.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 

Do we need fixes tag here ? Unless someone objects I will add and apply
this patch:

Fixes: 71f867ec130e ("arm64: Add Juno board device tree.")

--
Regards,
Sudeep
