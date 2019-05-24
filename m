Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC6C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81A821841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558660820;
	bh=jGRjDILJOvXUNHEN2N5hoLhQcSop67WBg+udUpe3wfI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=IyMYOgkcOCgZMRZxl2oGbxCNy8oYm+I8MdAG6/vcUCzmrQa0XgQKSWt91kDNtL/A8
	 ZwTYfmjVGmcOwD945P5LNwkGpONGyk7ystQH2aG89vmEh9GQYi0Vw0HlPe5sd/yt9X
	 o9IafPm4vmVd2CirhtqYAOSylZ4O3VJ/Yp/7MTDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfEXBUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387626AbfEXBUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:20:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D61B217F9;
        Fri, 24 May 2019 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558660818;
        bh=jGRjDILJOvXUNHEN2N5hoLhQcSop67WBg+udUpe3wfI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mEHbGsYAhtlofg7+Ln41XrllgEKxGhnybCzuPbDwpB/smV7jbMXgfrpedW8UVDV50
         Twqu376XAoBO/vYd6nMhkBq8ZEzQYb854jPR8EbZahHxlZQm8pQgmGNdhSOTbU9MUK
         1dwFa+dq0/9+flICrIOGbSmV5gQ9jKQQCSfijkx8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190522082348.GA15793@basecamp>
References: <20190516085018.2207-1-masneyb@onstation.org> <20190520142149.D56DA214AE@mail.kernel.org> <20190522082348.GA15793@basecamp>
Subject: Re: [PATCH RESEND] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for vibrator
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>
User-Agent: alot/0.8.1
Date:   Thu, 23 May 2019 18:20:17 -0700
Message-Id: <20190524012018.1D61B217F9@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-05-22 01:23:48)
> On Mon, May 20, 2019 at 07:21:49AM -0700, Stephen Boyd wrote:
> >=20
> > This is inside the multimedia clk controller. The resource reservation
> > mechanism should be complaining loudly here. Is the driver writing
> > directly into clk controller registers to adjust a duty cycle of the
> > camera's general purpose clk?
> >=20
> > Can you add support for duty cycle to the qcom clk driver's RCGs and
> > then write a generic clk duty cycle vibrator driver that adjusts the
> > duty cycle of the clk? That would be better than reaching into the clk
> > controller registers to do this.
>=20
> I don't see any complaints in dmesg about this, however I'll work on a
> new clk duty cycle vibrator driver.
>=20

Ok. Probably no warning because the vibrator driver just creates the io
mapping without trying to reserve it with the io requesting APIs.

