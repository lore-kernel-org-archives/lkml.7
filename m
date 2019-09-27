Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F15C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B189F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569543267;
	bh=ouc/ZGlpophw+opTwcJn7DhMFr0Pb1HOOZEWpUUYSk0=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=c0lzSGBQ2GIfixpz/EjfJlbwk6IPcx5meAVqyc317A0/D9nurSBMZLhACVoRHjIY3
	 R0HLnqn9teyoJnmI3Vve33P7ILUdcqXAZ+DjEras9npiCNUCUMjIG35AeF5XVgKpXx
	 PBVKequ+LVKzonbUWL6D+UeeQJFmX49FvsBaxpaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfI0AO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfI0AO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 20:14:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFDC7207FF;
        Fri, 27 Sep 2019 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569543266;
        bh=ouc/ZGlpophw+opTwcJn7DhMFr0Pb1HOOZEWpUUYSk0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=DRdMZW5AJXatJs4G1JlQTfOfltYGKHwfQVF23ynDzZJFds1pYvAYEyx/JxesVC+dt
         gxTeolLgLZudoqnLbTi5VsZObkLPTtiZuRqz6glzq0r8YrmSg+SB3xzeUcyj+Io4oN
         pqH6gowGJ0wJFBxhDSeWYNE4X7xhF2Ev/zt3+X18=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190919102518.25126-2-narmstrong@baylibre.com>
References: <20190919102518.25126-1-narmstrong@baylibre.com> <20190919102518.25126-2-narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RFC 1/2] clk: introduce clk_invalidate_rate()
User-Agent: alot/0.8.1
Date:   Thu, 26 Sep 2019 17:14:25 -0700
Message-Id: <20190927001425.DFDC7207FF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-09-19 03:25:17)
> This introduces the clk_invalidate_rate() call used to recalculate the
> rate and parent tree of a particular clock if it's known that the
> underlying registers set has been altered by the firmware, like from
> a suspend/resume handler running in trusted cpu mode.
>=20
> The call refreshes the actual parent and when changed, instructs CCF
> the parent has changed. Finally the call will recalculate the rate of
> each part of the tree to make sure the CCF cached tree is in sync with
> the hardware.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

The knee-jerk reaction to these patches is that it shouldn't be a
consumer API (i.e. taking a struct clk) but a provider API (i.e. taking
a struct clk_hw). I haven't looked in any more detail but just know that
it's a non-starter to be a consumer based API because we don't want
random consumers out there to be telling the CCF or provider drivers
that some clk has lost state and needs to be "refreshed".

