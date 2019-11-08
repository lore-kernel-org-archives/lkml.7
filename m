Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6CFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7B2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573247337;
	bh=JHqRS3uSKLO7yNAzjFw7Q1nOi5AO9AvovI8DqhUNkqQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=ll9Pm9roQf1tOyiIAD1UDsYiBIDGmx1UB9twSbYYSUj7CcaRCDU9kfR1DrrdtBS6G
	 gE6/zN/N3bsIKL7sgLocCWqeTVjx32VW/UcOeim6PUtOLAVb5UiWLY2ApsfHtRow5H
	 FoEA0iNwYbVaGrHH66cWunHjEn/2wv3d8BFHEBVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfKHVI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbfKHVIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:08:55 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C8C20869;
        Fri,  8 Nov 2019 21:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573247334;
        bh=JHqRS3uSKLO7yNAzjFw7Q1nOi5AO9AvovI8DqhUNkqQ=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=LIEyKga2iyXN5fFNmksNgPPGuuAoe7udgxU7uuYQRwcthQLdQkQpEOx62ACht245V
         JR8r5BgmMHaeOU7WpybnQSm78GwxSrqBCcCTr29Rt3dE0g3+EswURrQH4vOgL9IE/M
         FEmOsrn0YtW1KaB+o607/aQRtq65Cixnwyb4LzXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191108071718.17985-1-alexandru.ardelean@analog.com>
References: <20191106113551.5557-1-alexandru.ardelean@analog.com> <20191108071718.17985-1-alexandru.ardelean@analog.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     mturquette@baylibre.com, jsarha@ti.com, ce3a@gmx.de,
        geert+renesas@glider.be, horms@verge.net.au, magnus.damm@gmail.com,
        wsa+renesas@sang-engineering.com,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3] clk: clk-gpio: propagate rate change to parent
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 13:08:53 -0800
Message-Id: <20191108210854.95C8C20869@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Ardelean (2019-11-07 23:17:18)
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> For an external clock source, which is gated via a GPIO, the
> rate change should typically be propagated to the parent clock.
>=20
> The situation where we are requiring this propagation, is when an
> external clock is connected to override an internal clock (which typically
> has a fixed rate). The external clock can have a different rate than the
> internal one, and may also be variable, thus requiring the rate
> propagation.
>=20
> This rate change wasn't propagated until now, and it's unclear about cases
> where this shouldn't be propagated. Thus, it's unclear whether this is
> fixing a bug, or extending the current driver behavior. Also, it's unsure
> about whether this may break any existing setups; in the case that it doe=
s,
> a device-tree property may be added to disable this flag.
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next

Next time please send as a new topic instead of a reply to the original
patch. Makes it easier for me to apply the patch.

