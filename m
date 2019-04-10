Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785D820854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554914971;
	bh=7V+bH6UyqInzIrPCYj+uVJgo/SA0OEKcOvlOhP4Kr4s=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=S8ZejnK/ZwATlKNwWiRXQdGOTRy1O7rvhOGIDfMMvEiaVolWyF8SS+kGf/hSlzizS
	 g3BROYA7ZKdbHdMt8qXYwbYkJMY8VE4UigKqtay6ELjI6zdbp2URllgzRjf9xJBFv2
	 VZCd+IylKVEquy5Izij9Q21PorBkfd704yTsGGw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfDJQta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbfDJQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:49:29 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0222E20818;
        Wed, 10 Apr 2019 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554914969;
        bh=7V+bH6UyqInzIrPCYj+uVJgo/SA0OEKcOvlOhP4Kr4s=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=kkZGz6OgRWG1Ak0KZH1KZEp//lzIEU6ApNOKDMXyLTXhcx5Z79F3jrlH+wRkhZUJS
         5bNZ3KFW+VWPhbIe0JDq8rnSnXHXkGVgc1/VHWumA0dVbKBY9YOQcPqC3QF/TdQNy5
         I5o9fZBLHVpqcHZCGsNYL02FnC/DYTOTHp2dJBUw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-4-sboyd@kernel.org> <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk drivers
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155491496818.20095.15093722814125773505@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 09:49:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-04-08 14:46:11)
> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
> > In some circumstances drivers register clks early and don't have access
> > to a struct device because the device model isn't initialized yet. Add
> > an API to let drivers register clks associated with a struct device_node
> > so that these drivers can participate in getting parent clks through DT.
>=20
> NACK.  This patch broke boot for me.  I had to pull the below from JTAG. =


No early printk support on this board? Sadness.

>   What do you need to debug this?
>=20

Hopefully nothing.

> [    0.000000] Unable to handle kernel read from unreadable memory at=20
> virtual address 0000000000000280

I guess you pass NULL as dev to clk_hw_register(). Will fix! Thanks for
testing.

> [    0.000000] Mem abort info:
