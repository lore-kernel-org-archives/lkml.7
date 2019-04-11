Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C62C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555007573;
	bh=Xg14Ly0lpWt+vXYMejRnrWfm4sJ5tOCz3tfEScq3RRc=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=dCT8VE6bvECpSRHaWtvNwns/Tp4G47Nu1bn7CLWkQXU1qXzl83YPuIK/JJgiuZzN0
	 8yT9L/+PYVDn5I7Vw/9Y/jxv4fVWMc6ry/ibboXJxITDaoIw74+JfVQVdQXlFESQsU
	 ftxHFsKMj1z3b1KxX3k4WT/n0V+jjutkqOiNazDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDKScw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDKScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:32:51 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C754B2083E;
        Thu, 11 Apr 2019 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555007570;
        bh=Xg14Ly0lpWt+vXYMejRnrWfm4sJ5tOCz3tfEScq3RRc=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=FhJLmORsVupR9fYgt5CvMswkypZG5sg0avTKuvgwRlaBXjskNcwQsATgPrjLZq0eb
         N9sLM1l/UhBS8N5r6QgnY4e8vYvQObRY0Fl6Or72BNQZI1EFg4TxPvwI3GZBSVp+04
         9AQR0ocGYpIAw3DoS6gHAsHOC5V++d260/uxD7+o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
References: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] drivers: clk: Update clock driver to handle clock attribute
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, linux-clk@vger.kernel.org,
        michal.simek@xilinx.com, mturquette@baylibre.com,
        sboyd@codeaurora.org
Message-ID: <155500757006.20095.12680724036255288516@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 11:32:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2019-03-04 15:19:10)
> From: Rajan Vaja <rajan.vaja@xilinx.com>
>=20
> Versal EEMI APIs uses clock device ID which is combination of class,
> subclass, type and clock index (e.g. 0x8104006 in which 0-13 bits are
> for index(6 in given example), 14-19 bits are for clock type (i.e pll,
> out or ref, 1 in given example), 20-25 bits are for subclass which is
> nothing but clock type only), 26-32 bits are for device class, which
> is clock(0x2) for all clocks) while zynqmp firmware uses clock ID
> which is index only (e.g 0, 1, to n, where n is max_clock id).
>=20
> To use zynqmp clock driver for versal platform also, extend use
> of QueryAttribute API to fetch device class, subclass and clock type
> to create clock device ID. In case of zynqmp this attributes would be
> 0 only, so there won't be any effect on clock id as it would use
> clock index only.
>=20
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---

Applied to clk-next

