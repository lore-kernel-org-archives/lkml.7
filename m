Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56041C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AC2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976710;
	bh=TkuDPGpcaz9V3TCFafNZva2EkKV3wli6koFG9q5cghE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xS3MBB+EuuiFtcf8M/uFokK8TdayZSDbXG61d6bxxvS4pJSoDfdjLFUJW7RdueSxK
	 RfhkwuRmyOmDwYEvtVAbDcKZN04SyoQVfZ5DzYk4YFTk3JrXGAwSaFZvKNGqhmJXZ4
	 sMigPfDfqDfboptn9j9fsrUHp+4dfuWws/4SgXG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfHPRbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfHPRbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:31:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6022086C;
        Fri, 16 Aug 2019 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976708;
        bh=TkuDPGpcaz9V3TCFafNZva2EkKV3wli6koFG9q5cghE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IbJQDF+M60CpxSWWfFxbJldVOU254xLnYDUJYNlSZnGUjjsP5jU8N4k8bJdJVtEMm
         r0zuiph/HEhroZv2olfyQPYZfr7PTyd7AZqpFJPtbZtHNLlMyLwTQUiOQWLqI/5bdZ
         iRY9zd6DWAqebbBCbfzmU8RvYADgN5P7dxEdQn5s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCA1i=4Lu1xMVyASoFEDhCEn6phDb4h1s15h0ZfGRQX1kw@mail.gmail.com>
References: <20190815223155.21384-1-martin.blumenstingl@googlemail.com> <20190815232951.AA402206C2@mail.kernel.org> <CAFBinCA1i=4Lu1xMVyASoFEDhCEn6phDb4h1s15h0ZfGRQX1kw@mail.gmail.com>
Subject: Re: [PATCH RFC v1] clk: Fix potential NULL dereference in clk_fetch_parent_index()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:31:47 -0700
Message-Id: <20190816173147.ED6022086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-08-15 23:48:08)
> > > I have seen the original crash when I was testing an MMC driver which
> > > is not upstream yet on v5.3-rc4. I'm not sure whether this fix is
> > > "correct" (it fixes the crash for me) or where to point the Fixes tag
> > > to, it may be one of:
> > > - fc0c209c147f ("clk: Allow parents to be specified without string na=
mes")
> > > - 1a079560b145 ("clk: Cache core in clk_fetch_parent_index() without =
names")
> > >
> > > This is meant to be applied on top of v5.3-rc4.
> > >
> >
> > Ah ok. I thought that strcmp() would ignore NULL arguments, but
> > apparently not. I can apply this to clk-fixes.
> at least ARM [0] and the generic [1] implementations don't
>=20
> I did not bisect this so do you have any suggestion for a Fixes tag? I
> mentioned two candidates above, but I'm not sure which one to use
> just let me know, then I'll resend with the fixes tag so you can take
> it through clk-fixes
>=20
>=20

I added the fixes tag for the first one, where it was broken, i.e.
fc0c209c147f. Thanks.
