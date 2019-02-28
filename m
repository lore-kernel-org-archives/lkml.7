Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B225218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551379356;
	bh=oLvNdA/M/UKLXZYqQYq+ZFgHkuM+Rc/ZO2DPIBogeu8=;
	h=In-Reply-To:To:Subject:References:From:Cc:Date:List-ID:From;
	b=m1kEE0+8FLfMdfXGHIaabzRpysdRwpeQL0/wUE+MU02cSplHEbbQn1CXFGczBrG0D
	 8AiRNFxaxl4B4PAvdkeLl3tV2OhpZKY2m5xJIVWD8jOlV6LYdpWvd4RS8v3GP9k+Pm
	 lV3VFQzmF4oRg/Nll8x64oPg1FNsIt1oExDptEqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfB1Smf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfB1Sme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:42:34 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E4D20863;
        Thu, 28 Feb 2019 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551379353;
        bh=oLvNdA/M/UKLXZYqQYq+ZFgHkuM+Rc/ZO2DPIBogeu8=;
        h=In-Reply-To:To:Subject:References:From:Cc:Date:From;
        b=NHhvjKfZ0S2SmY3fzFrEisgq9iBjLgtBixr81bonO7/cd74Bl0bXj7JRTKH0BPZOB
         gpvHNZiaGqy+E/OauSBFdEhVavO5AMwE8Z+JSeLwNjjzEbIn90ZvlqHJZpUw0SxYnw
         rCLAgD6VYA+TfR4L6Np3MB8QERrXRxY6H8PVtZtg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1550884678.20534.0@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>,
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock calculation
Message-ID: <155137935225.16805.10412318501940648799@swboyd.mtv.corp.google.com>
References: <20181227181319.31095-1-paul@crapouillou.net> <20181227181319.31095-15-paul@crapouillou.net> <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de> <1546722339.30174.0@crapouillou.net> <20190105212711.s765knwwerceytvk@pengutronix.de> <1547129096.16183.0@crapouillou.net> <1550884678.20534.0@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 10:42:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-02-22 17:17:58)
> Bump.
>=20
> What should I do here?
>=20

I thought I replied to the list but maybe it got rejected because my MUA
is currently failing hard at sending 8-bit mails without
using quoted printable. Let me remove all non-ascii characters from this
mail!

If someone has the mail please rebounce it to the list. Otherwise, I
think I basically said this is OK because clk_round_rate() semantics are
specifically vague here to allow the implementation to decide how rates
are rounded (up, down, closest, etc). As long as the whole rate space is
searched with a +1 or a -1 style of search it should be work. We're not
going to add round_up() or round_down() APIs as far as I'm concerned,
and you can look on the list to see previous proposals on that topic to
get some background on why they aren't liked.

