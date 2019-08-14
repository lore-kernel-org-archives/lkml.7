Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808069;
	bh=rhwHtgh2/fDbYktm6AuNEWakyqGXppoxtIRS7xf4wlM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=v56UvQ0B5WUhaXdEOFRuchubMNSNkqmvmwXjrxd9vGF2hHrnMIhNEyaNioJrRJOX1
	 B+IZJNIpz4MaHxDvf4+ZLRfcgxhnvtmYiws/YUomksOVdIweXsRQnHrOd/yAChto8Q
	 fHnOeq194mtRQg3CVvvJzP4rGclKBUfcFUe1377c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfHNSlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:41:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE372084F;
        Wed, 14 Aug 2019 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808066;
        bh=rhwHtgh2/fDbYktm6AuNEWakyqGXppoxtIRS7xf4wlM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DbTh5ns5su7SAOgV6S1k6SuCGatax5uiRRfnXs0DQX+RUFVqVGBiG3STZG8Cv20CT
         Rnh+ijJhh+kpujLqWowUCnZF8msKVM0ofvSSU4FN3Y3n05Zav38fpHOsVhC7I1/7fy
         5e+XsoDb0nOAv+nfCvw2zPPjlcN6KvlJLJ4B/3LY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190727105330.44cc7f2f@xps13>
References: <20190108161940.4814-1-miquel.raynal@bootlin.com> <155502565678.20095.10517989462650657961@swboyd.mtv.corp.google.com> <20190521114644.7000a751@xps13> <20190617115703.642d9967@xps13> <20190727105330.44cc7f2f@xps13>
Subject: Re: [PATCH v4 0/4] Add device links to clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:41:05 -0700
Message-Id: <20190814184106.9BE372084F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2019-07-27 01:53:30)
>=20
> I know this series might have side effects despite the consequent
> amount of time spent to write and test it, but I also think the
> clk subsystem would really benefit from such change and handling
> suspend to RAM support would be greatly enhanced. You seemed
> interested at first and now not anymore, could I know why? I got
> inspired by the regulators subsystem. It is not an idea of mine
> that device links should be bring to clocks. Regulators are almost
> as used as clocks so I really understand your fears but why not
> applying this to -next very early during the -rc cycles and see
> what happens? You'll have plenty of time to ask me to fix things
> or even drop it off.
>=20

Ok, I'm back on this topic. Let me look at the latest code and see how
it works on a qcom platform I have in hand. If the device links look OK
then it should be good. I also want to make sure we're not holding a
nested pile of locks when we're adding the device links so that we don't
get some weird lockdep problems.

