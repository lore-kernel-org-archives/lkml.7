Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95EE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="P2yAFZ6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfCLSYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:24:05 -0400
Received: from vern.gendns.com ([98.142.107.122]:54074 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfCLSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Dim6/40E2Hjvx3FhIEiWeBys0jmjuVF0jCckfeUK1g8=; b=P2yAFZ6G0+7Y9lb6MLwyON9OD/
        NyRdJORau+55jbAtouZX75P6LbSk07qkA6l+MuR4pMJS3GPioom+EabPUknjGIvu2Bk24TRPoH/Na
        WanFpVvod6nx+ahH6M249WbJ4BJ14IvG1HVai8zcZk7Rck94hIViaEQzvrMg7Osv1KwxgkmqMrbZq
        9qoafv3ep3TcIyhm0+6xNc97IHIzevCiTQ/NuMfzYXAoxuRpvek5SNqefwtGTM3JdatiS/hkMytQR
        gUEppGEnZxTyzBmuRI3KFNWEGhcPCZ47+/TC0vDJn3eD6QvgxlbqEq+5+xKvh5AXRcWh8Y+hgKXi/
        SxnXCX7Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36998 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h3m3E-0003Zn-6t; Tue, 12 Mar 2019 14:22:56 -0400
Subject: Re: [PATCH v3 03/11] ARM: davinci: WARN_ON() if clk_get() fails
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190226120633.18200-1-brgl@bgdev.pl>
 <20190226120633.18200-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <4292798d-444c-9eb1-2ea3-434909bce9b0@lechnology.com>
Date:   Tue, 12 Mar 2019 13:23:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226120633.18200-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 6:06 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the timer code checks if the clock pointer passed to it is
> good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> be functional and doesn't perform any checks so emit a warning if
> clk_get() fails. Apply this to all davinci platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


