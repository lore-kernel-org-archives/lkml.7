Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A6DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C862067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216548;
	bh=8FwAZHmi9UHXsQc/fK2P+f7BQai0va4r7Z/zs/ULFsc=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=aIZfkPoOq0dLju3ZSu6eEo+cWBJAxyII8cB5/zgz2RxN/U/I6HTrjHGS7/mQUexqg
	 wqTVkNfRGXbfbjH9xcUnKAcsn4GSfCdt7Ddxdl3KxKJ3v7CI5J1inISpMCPdpdECk2
	 gRyWfaifA7W+9hoIpsQatmxFP0rSBtuYU8f8Jzg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfDYSW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYSWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:22:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF08B20656;
        Thu, 25 Apr 2019 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556216544;
        bh=8FwAZHmi9UHXsQc/fK2P+f7BQai0va4r7Z/zs/ULFsc=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=U6BiAeMhAxc4gsPpYf+jfcZlkBDn70cguLWZHUqiXfFNMgqvr9hF+p8eyRWBV5+oo
         3R86GSUHUW0yhYTL2zEMHAj6ARZDGo4FLV/5QB5h8//uTtX6o+no2g1k1kVQeHwpC2
         IAR53Ot9UwqSvD/zjVpA7SiMXYLXpbpIP2azCgX0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
References: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: qoriq: add support for lx2160a
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Message-ID: <155621654326.15276.741983919838675194@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:22:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2019-04-25 06:57:05)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Add clockgen support and configuration for NXP SoC lx2160a in qoriq
> clock driver with compatible property as "fsl,lx2160a-clockgen".
>=20
> qoriq-cpufreq driver is based on qoriq clock driver, enable support
> of NXP SoC lx2160a in qoriq cpufreq driver to handle the lx2160a SoC.
>=20
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v3:
> - Incorporated review comments of Rafael J. Wysocki
> - Updated commit message

If you can split it into clk and cpufreq that would be preferred. Then I
can take the clk part and PM tree can take the cpufreq part. Otherwise,
you have sent other patches to drivers/clk/clk-qoriq.c and I'm worried
there will be cross tree conflicts if I take those other patches this
cycle.

