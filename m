Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37004C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EEE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="eBB53R5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCUP30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:29:26 -0400
Received: from vern.gendns.com ([98.142.107.122]:38118 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCUP30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A8p4nxElyglENvQ/zIhBQOkcpf/VYcLYfAVsGGcl504=; b=eBB53R5cyaxtRsH2RFt5qb1qtd
        7YDwSFLP3j7WTheKzygebPgSVcRH8s2xZ/USmxuTP6xxFMFV/HBiRliZsKNZmPvqpHP5F0Z0b5AvX
        /EbXMmHmeBMAGdu0m78xUqUErXSiSZhFS/fWg4z+Olz2DGaJ1aM8aiJbvcyncUyuIF2cTL5nhggnz
        heB/DnZcGeSXV8PG+7Nh3GGr3qPUypQjDSWYk6X2QCnF6P0not3HT2rLQEDjRM/nUKc2oFo8JlC2G
        sPhTPewYXjgaHA/ZphNV/d3Esg62F0tt1TTabs7TVPFAK6q/ZAQE2NJi/mtMUc9ggLd0Cp8NhYtcA
        wiZ3lYkg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42432 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h6zbq-0003kS-T4; Thu, 21 Mar 2019 11:27:58 -0400
Subject: Re: [PATCH 0/4] ARM: da850: enable cpufreq in DT mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190321141010.19612-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <e4d51b63-bc07-c595-9d73-c4b09eb11341@lechnology.com>
Date:   Thu, 21 Mar 2019 10:29:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321141010.19612-1-brgl@bgdev.pl>
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

On 3/21/19 9:10 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series adds cpufreq-dt operating points for da850 boards supported
> with device tree (da850-lcdk, da850-lego-ev3, da850-evm) and also
> includes a fix for the da850-evm boardfile which checks an unset variable
> to determine the highest available frequency for cpufreq.


I can't find any old threads about this, but I recall that there was a
problem with the USB OHCI controller breaking when switching frequencies.
It didn't happen all of the time, but often enough that it made using
cpufreq unusable for me. Is this still a problem?

Also, a big-picture question. On boards with fixed regulators, what is
the benefit of enabling frequency scaling? The power savings aspect
seems negligible (< 1% in my tests) since the voltage cannot be changed.
