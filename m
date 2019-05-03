Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86473C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5897D2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556901128;
	bh=wQFeqtk0b9+Acg78B6JbyuJJJmhtUePDvdDbBS6/xGI=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=GX5TAXjbHFlgTa9y5ydxFvfIeV174oebcE8A3xoXGC3MkxVoWpWI6kJAqgYFkwhSH
	 na2XbcCIVcmhEY8/MkuQFo78j0kXG/AfMe7x66u8WZ8Dj3c5qwVdFvIObg+yMcK1U8
	 yH2krca+eZ911mhPl3giGSnPsUwwEMZfYTrS96O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfECQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfECQcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:32:06 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E9420651;
        Fri,  3 May 2019 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556901126;
        bh=wQFeqtk0b9+Acg78B6JbyuJJJmhtUePDvdDbBS6/xGI=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=h4PYxc9P1Ie5o284Z8zsDfHtKG9GDmLEOeEsJjwej4HBoKUNKMNdN1ncb5lBseNjL
         QmlwzGHRBl+800lmeWXaPBd+IuQXIZukP8Y8HSFqe2l7u3rGGzvvAoLkizMWBKQum9
         qHrjr8LotBalA0mWxps+/UDVn/o6+AMxCF2xg808=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556261303-6360-1-git-send-email-Anson.Huang@nxp.com>
References: <1556261303-6360-1-git-send-email-Anson.Huang@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: correct pfdv2 gate_bit/vld_bit operations
Message-ID: <155690112534.200842.9362435431679500492@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 09:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-04-25 23:53:14)
> The operations of pfdv2 gate_bit/valid_bit are incorrect,
> they are defined as u8 for bit offset, but gate_bit is
> actually assigned as mask which could be 32 bit long and
> it causes overflow, and vld_bit is assigned as bit offset
> based on incorrect gate_bit value, it causes incorrect
> pfd clock gate status in clock tree, this patch fixes the
> issue by assigning them as correct bit offset.
>=20
> Fixes: 9fcb6be3b6c9 ("clk: imx: add pfdv2 support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

