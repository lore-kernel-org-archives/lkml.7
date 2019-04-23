Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D3E21906
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556060430;
	bh=EeaQKmLG3fYyd+mnAdVPREDARRO/e4IXy7yRKjb9S9c=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=T4W0LOoDVoilZGIIAVKId/mVPjiZTNdwPXzsBAcwWVkjfkw/+tKlZgExL4z7Foix5
	 TQG0W+BKOxwPx/fCVOf6aJk/RkBARpy+YrfyRjoOTSwlKLcFjCGYZDg/jtbMr3Kpjg
	 Pf0TmiKOwD4Pko8Zd1Q/lxzbF3lBpNb/fVH6UyHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDWXA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfDWXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:00:28 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E126E206BA;
        Tue, 23 Apr 2019 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556060428;
        bh=EeaQKmLG3fYyd+mnAdVPREDARRO/e4IXy7yRKjb9S9c=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=HbJYB4UWA6xVCzovsop3aU4TaTD5kEaf48GD5lS4YXm+fS7ppTojKZWO+ZF/ljRzs
         eC5gKJVBPcg1JXgoYshnB3ineCahHqe+y7wxASBrD9ZX9ZNeITnC0jP7BD7mi2lwwB
         xfmAmkw4S/Ki30C0XDq4PCAiwZCQt145nX+vMhPs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1553954142-65515-1-git-send-email-nixiaoming@huawei.com>
References: <1553954142-65515-1-git-send-email-nixiaoming@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/2] clk:mmp: clk-mix.c fix divide-by-zero
To:     chao.xie@marvell.com, jbrunet@baylibre.com, mojha@codeaurora.org,
        mturquette@baylibre.com, nixiaoming@huawei.com,
        sboyd@codeaurora.org, soren.brinkmann@xilinx.com
Message-ID: <155606042712.15276.6873845293187802041@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 16:00:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nixiaoming (2019-03-30 06:55:42)
> The _get_div() function has a branch with a return value of 0
> Add a check on the return value of _get_div() to avoid divide-by-zero
>=20

Are you seeing this in practice? Or just trying to avoid a div-by-zero
case that you've found from inspection?=20

> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
