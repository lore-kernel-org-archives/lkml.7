Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3DAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A8620811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555980753;
	bh=eI6owgygkTQD8tW+dNal57mFXd7qEDYjEBGmV7V1WK8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=yCPGIjivc4cee63Jf4R4W7Skv2K++Lp8g5sg8F9dTPhZiYvq9c95RS+XmfQUUv6ER
	 FLLmfzS5V8OaRCu31dpg8DWsWzXY8nqa8RIu+O4o0xoad/u5yjsSunGM/5t4dypm6c
	 V++jiYHarPx4+XtZt80/FIIChWiAzXTODb7avIvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfDWAwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfDWAwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:52:31 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A2320811;
        Tue, 23 Apr 2019 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555980750;
        bh=eI6owgygkTQD8tW+dNal57mFXd7qEDYjEBGmV7V1WK8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Q2eUR2eKYraYBZ/WUkcSPgk9KRCFjkrNSQglmCJ83lzKBQz2dch1EWiLUQkSWRYrg
         tkfAF8XG6o1aRSeso+SztcdTw0Z15Ry5k9borm21rd4vUDaNH145aEkuTFJbUJ4H7u
         DYTl4PmlsiFpa7GiXAC3tP/smPKzTAosewcXsO00=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
References: <1549911467-2465-1-git-send-email-jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1] clk: Probe defer clk_get() on orphans
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mturquette@baylibre.com
Message-ID: <155598074927.15276.327474594450313045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 22 Apr 2019 17:52:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-02-11 10:57:47)
> If a parent to a clock comes from outside that clock's provider, the pare=
nt
> may not be present at the time the clock is registered (ie the parent com=
es
> from another driver that has not yet probed).  The clock can still be
> registered, and a reference to it obtained, however that clock may not be
> fully functional - ie get_rate might return an invalid value.
>=20
> This has been a problem that has resulted in the UART console breaking on
> some Qualcomm SoCs, as the UART baud rate is based on a clock that is the
> child of XO.  Due to the large chain of dependencies, its possible that t=
he
> RPM has not provided XO by the time that the UART driver probes, gets the
> baud rate clock, and calls get_rate - which returns 0 and results in a bad
> configuration.
>=20
> An orphan clock is a clock that is missing a parent or some other ancesto=
r.
> Since the parent is defined, we can assume that it is expected to appear =
at
> some point in a properly configured system (all bets are off if a required
> driver is not compiled, etc), and it is unlikely that the clock can be
> properly consumed during the time the clock is an orphan.  Therefore,
> return EPROBE_DEFER for orphan clocks so that consumers wait until the
> parent chain is established, and proper clock operation can occur.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>=20
> This is based upon the "Rewrite clk parent handling" series at [1], and a=
ssumes
> that the suspected missing line commented on at [2] is added.
>=20
> The idea for this solution came from [3] and [4].
>=20
> [1] https://lore.kernel.org/lkml/20190129061021.94775-1-sboyd@kernel.org/=
T/#u
> [2] https://lkml.org/lkml/2019/2/11/1634
> [3] https://lkml.org/lkml/2019/2/6/382
> [4] https://lkml.org/lkml/2015/12/27/209

There have been multiple attempts over the years to support probe defer
for clks that don't have parents. If you search the kernel mailing list
archives I'm sure you'll come across them (for example
https://patchwork.kernel.org/patch/6313051/). That's why we have the
first part of the code to indicate if a clk is an orphan or not, i.e.
commit e6500344edbb ("clk: track the orphan status of clocks and their
children"), but not this patch that you've sent.

There are a couple requirements that we need to make sure we don't break
first.

 1. clk_get() should work for clks on the orphan list if that clk is
 parented to something that will never be registered with the framework

 2. We need a way for drivers to express that the parent of a clk
 won't exist

 3. Critical clks need to turn clks on even if they'll never get
 parents registered

We've had problems in the past
(http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343007.html)
where bootloaders configure clks in certain ways that the kernel doesn't
care to even consider as possible. In these cases we either need to let
clk_set_rate() reparent them when consumers are ready or we need to
convert drivers that are forcing on clks early to use the
CLK_IS_CRITICAL flag to turn on clks even if they're never going to find
their parents.

Last time we tried to do this in 2015 (wow so many years ago!) we were
blocked on not having the critical clks infrastructure and the legacy
sunxi clk driver needed to convert to DT and critical clks flag to keep
working. I think we could have done it a year or two ago, because sunxi
moved to a new design, but then we got more use-cases where clks may
never get the parent they're currently configured for in the bootloader
and then the kernel would never hand out the clk to consumers and the
clk_set_rate() case would fail.

To fix that last part, I'm proposing we introduce the .get_parent_hw()
op and then rely on drivers to tell the framework that the parent is
there either with a direct pointer reference or by knowing that the
DT/firmware is telling us the parent is valid. If we just rely on string
names and a u8 to indicate parents then we don't have enough information
to figure out how the parent is provided and if it will ever appear at
some point in the future. Once we have a way to describe this through
DT/firmware then we're able to indicate the clk is an orphan when that's
actually the case vs. when the clk is configured in hardware for
something that we won't know about. You can see this work in the
clk-parent-rewrite series in clk.git.

There's also one more problem, which is what we do with clks that we've
handed out to consumers and then the driver for the parent of that clk
is removed and the parent is unregistered. Right now, we move these clks
to the orphan list and set the clk_nodrv_ops on the parent that's
unregistered. We probably need to set clk_nodrv_ops on all the children
that get orphaned, and remove the cached clk_core pointer in all the
clk_core::parents members (even ones that aren't currently using it!),
and stash away the original clk_ops so we can restore them later when
the clk is properly reparented if the parent comes back. It's a lot of
book keeping to remove the dangling references and let it come back
later. I haven't started on this part, but it's on my radar.

