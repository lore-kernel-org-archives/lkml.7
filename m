Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20E0C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B199520748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574645594;
	bh=aHpsAgdjSsrOg3rfp8+01pOTc2dY01+7ldqLq4i00CE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gwruI1/VsnBtYN34onkn58kxObdFx42l7JZxs9QVlzrGWhONcnWeI6L/H4zd8r0VY
	 V9xcD5a7SuRQE6oil/BXCHBiLSMxZ69d1G7imeerOGpzl+aB3FcDpz8qVXNhchtwGI
	 Wp/YN8gOdBfuPWvfWf6ItBDIpZiim/GKLZbG7tTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKYBdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbfKYBdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 20:33:13 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC2E2071A;
        Mon, 25 Nov 2019 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574645592;
        bh=aHpsAgdjSsrOg3rfp8+01pOTc2dY01+7ldqLq4i00CE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D8PBOxbCRzzQhyZbLmVoTvPRZ7rw8j+3TLcwyseOPwsesl4rL6dOwuJT+FAdTYbqe
         jwMiElG4yu5Dho9tcm01+RCWozxPy45if3LATu3fdRZR6Z9F7andgjD750MThY+Fy8
         IDmVsaMVkzBLzbSjyaJbQQ1qV+LaiDgkY63NqcYs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-twxx4PyERHXuYcoehPoNYiVaOS4hZEK0KndoM2sL_5gQ@mail.gmail.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com> <20191025111338.27324-6-chunyan.zhang@unisoc.com> <20191113221952.AD925206E3@mail.kernel.org> <CAAfSe-twxx4PyERHXuYcoehPoNYiVaOS4hZEK0KndoM2sL_5gQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: sprd: add clocks support for SC9863A
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
User-Agent: alot/0.8.1
Date:   Sun, 24 Nov 2019 17:33:11 -0800
Message-Id: <20191125013312.ACC2E2071A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-11-17 03:27:15)
>=20
> Not sure if I understand correctly - do you mean that switch to use a
> reference to clk_parent_data.hw in the driver instead?
> like:
> https://elixir.bootlin.com/linux/v5.4-rc7/source/drivers/clk/qcom/gcc-sm8=
150.c#L136
>=20

Yes something like that.

> Since if I have to define many clk_parent_data.fw_name strings
> instead, it seems not able to reduce the code size, right?

Ideally there are some internal only clks that can be linked to their
parent with a single clk_hw pointer. That will hopefully keep the size
down somewhat. And if there are any external clks, they can be described
in DT and then only the .fw_name field can be used and the fallback
field .name can be left assigned to NULL.

