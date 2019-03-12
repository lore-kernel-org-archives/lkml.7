Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C05A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="lKKKL1XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfCLST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:19:59 -0400
Received: from vern.gendns.com ([98.142.107.122]:52900 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfCLST7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=US/zEefkZtrxoiAf+jSw3DYCYvnbsFLLPAFVaq5fLG4=; b=lKKKL1XYFKKtyd8bCFIYeRJgLP
        99ONgK6+etYMLwllbgoKLtP1X9aiUNfaDcYJQKFzk4Eftb7KXaz6IfIgP5a98d68X1UE04WTCVHrG
        JuMO4ht09iuBWTC4gdnQtYe8Y7GjX00zl3wJ88jv495St5T81RQClb1ZC3GLMwAnrdDwcAdsDqyAT
        ZcyJ6uY4+PD1MKmML7IWsN9uxVJy+n6OtlxbRav+uXDaK2vorr919j9+ndQM9o3rUxe8ZbTAtVRAh
        /1rwLg6GLTqWBKmoW1VzJKSoSDzevyzTdt6q5RSgGMFm55WQsOURPKznRh0Up0dOwPVaUOSm0IHWx
        vAP3ZtBA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36902 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h3lzI-0002qL-VL; Tue, 12 Mar 2019 14:18:53 -0400
Subject: Re: [PATCH v3 02/11] ARM: davinci: enable the clocksource driver for
 DT mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190226120633.18200-1-brgl@bgdev.pl>
 <20190226120633.18200-3-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <4a8b2bec-b67d-e198-0df4-e2ed1f24926c@lechnology.com>
Date:   Tue, 12 Mar 2019 13:19:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226120633.18200-3-brgl@bgdev.pl>
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
> Switch all davinci boards supporting device tree to using the new
> clocksource driver: remove the previous OF_TIMER_DECLARE() from
> mach-davinci and select davinci-timer for ARCH_DAVINCI.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---


Reviewed-by: David Lechner <david@lechnology.com>

