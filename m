Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54FD208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561346247;
	bh=uXZHOHUtLcEMnM5mBVcj3Apcs/iHOElmyoO1V8O2rCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w/WYWbNh5aFap+CPKD9SlPPDYDXfMPG3CsyjfvAib6/ANjbEt/g2weOKX3jgZsN4L
	 l/qJVJyCSAo0Djp8mkoUiqOIITSO+Z6zG+WqvNGePYoC3GOEE/NNiXKV0E5ISNuljO
	 H7AnkSMKLBla6ZRvZ0Blm+vPp6z1h0KlxGBdQ+R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfFXDR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXDR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:17:26 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7579120663;
        Mon, 24 Jun 2019 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561346245;
        bh=uXZHOHUtLcEMnM5mBVcj3Apcs/iHOElmyoO1V8O2rCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0w6mnKDtsQiP5FItZQgTYOishkH95cwlStBEtx5KZOA4/uDidjWfkJMW1945J2Nt
         1ox1/OCeZEt6EsF+QVIvzNvR1my6libK0c4uYDqBEGiG83TNzluBT1+EQdPerwVZDT
         KbBqIvGO8bBw2uct1DGJiBLB8yqO9+3KgHmuHCkg=
Date:   Mon, 24 Jun 2019 11:16:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     mark.rutland@arm.com, kstewart@linuxfoundation.org,
        songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org,
        nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com,
        netdev@vger.kernel.org, gerg@uclinux.org,
        lorenzo.pieralisi@arm.com, will@kernel.org,
        linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net,
        festevam@gmail.com, gregory.clement@bootlin.com,
        allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org,
        haojian.zhuang@gmail.com, bgolaszewski@baylibre.com,
        tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com,
        sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com,
        jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de,
        acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr,
        dmg@turingmachine.org, swinslow@gmail.com, namhyung@kernel.org,
        tglx@linutronix.de, linux-omap@vger.kernel.org,
        alexander.sverdlin@gmail.com, linux-arm-kernel@lists.infradead.org,
        info@metux.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        hsweeten@visionengravers.com, kgene@kernel.org,
        kernel@pengutronix.de, sudeep.holla@arm.com, bpf@vger.kernel.org,
        kafai@fb.com, daniel@zonque.org
Subject: Re: [PATCH 06/15] ARM: imx: cleanup cppcheck shifting errors
Message-ID: <20190624031651.GA16146@dragon>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190623151313.970-7-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623151313.970-7-tranmanphong@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 10:13:04PM +0700, Phong Tran wrote:
> [arch/arm/mach-imx/iomux-mx3.h:93]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Applied, thanks.
