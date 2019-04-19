Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7467BC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F3D217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711959;
	bh=MbUM7pw5gySPXkJ5iVOomuVdu0De1BFYsetF9+/c+mw=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=jt+bEUXQ/mtafizLX+QHqBGRznPwUF/z5W2V54Bueu4NgqMZiIm9ZiEvCpeh0gH2n
	 e64tzKH+4ut7LvVo0kYvC6m1jYgmrW+Dbxn0xl5jneZ8pjcRQNFj/+fPRRaB7/cjxN
	 2gv4iSubhN/sjhMEJn9Rbzm0X3Tn409LYxLwsqbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfDSWMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:12:38 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF3521736;
        Fri, 19 Apr 2019 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711957;
        bh=MbUM7pw5gySPXkJ5iVOomuVdu0De1BFYsetF9+/c+mw=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=MwHJCEGg+uedEEcfT/u9BgVx09OdQIxnAiZvCokZAwoENcPbae2UmBZBwKURqnENO
         IVdIyLdIpSXRp6PJNOeECXivQveVmHA+szH0nkchkSpe48WZHgGftLmjdpb5RDS8sX
         /vJelX34Bzun6r9qLbiyhUHMx/fbdYGtxZwQVCIo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-3-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-3-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/9] clkdev: Move clk creation outside of 'clocks_mutex'
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571195672.15276.10172483262833785539@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:12:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:43)
> We don't need to hold the 'clocks_mutex' here when we're creating a clk
> pointer from a clk_lookup structure. Instead, we just need to make sure
> that the lookup doesn't go away while we dereference the lookup pointer
> to extract the clk_hw pointer out of it. Let's move things around
> slightly so that we have a new function to get the clk_hw out of the
> lookup with the right locking and then chain the two together for what
> used to be __clk_get_sys().
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

