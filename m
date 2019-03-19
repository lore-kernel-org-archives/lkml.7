Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9145FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCSMxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:53:03 -0400
Received: from foss.arm.com ([217.140.101.70]:51108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfCSMxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7707D1596;
        Tue, 19 Mar 2019 05:53:02 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204D33F59C;
        Tue, 19 Mar 2019 05:53:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:52:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>,
        "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be applied
 on A64FX v1r0
Message-ID: <20190319125258.GD59586@arrakis.emea.arm.com>
References: <5FA513F682BE7F4EAAB8EE035D5B08E44E9363CC@G01JPEXMBKW02>
 <20190315151241.GC48314@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A35627D@G01JPEXMBKW03>
 <20190318120454.GA3697@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318120454.GA3697@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:06:06PM +0000, Mark Rutland wrote:
> From 6439e9c0b1525e9d4c7be65552e6f2b1f9d1dbe0 Mon Sep 17 00:00:00 2001
> From: "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>
> Date: Fri, 15 Mar 2019 12:22:36 +0000
> Subject: [PATCH] arm64: apply workaround on A64FX v1r0
> 
> Fujitsu erratum 010001 applies to A64FX v0r0 and v1r0, and we try to
> handle either by masking MIDR with MIDR_FUJITSU_ERRATUM_010001_MASK
> before comparing it to MIDR_FUJITSU_ERRATUM_010001.
> 
> Unfortunately, MIDR_FUJITSU_ERRATUM_010001 is constructed incorrectly
> using MIDR_VARIANT(), which is intended to extract the variant field
> from MIDR_EL1, rather than generate the field in-place. This results in
> MIDR_FUJITSU_ERRATUM_010001 being all-ones, and we only match A64FX
> v0r0.
> 
> This patch uses MIDR_CPU_VAR_REV() to generate an in-place mask for the
> variant field, ensuring the we match both v0r0 and v1r0.
> 
> Fixes: 3e32131abc311a5c ("arm64: Add workaround for Fujitsu A64FX erratum 010001")
> Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
> [Mark: use MIDR_CPU_VAR_REV(), reword commit message]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Thanks. Mark's variant queued for 5.1-rc2.

-- 
Catalin
