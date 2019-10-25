Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40959CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ADC21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cQVFHky3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394573AbfJYNTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:19:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:42897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394561AbfJYNTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572009580;
        bh=KFRM/HuQYrBsmzUGAol+zTtrK8sFAfsaYLY7BYhLUSE=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=cQVFHky33nyI+63EU/Z0YFLvNd2hFP4hzV7/zX54U+EJosF7b6j/8OgoVERM2TQb9
         zU8KJufzEhc0V+hc9XE5EjW4PylZWIy4eUSX5QYnxyf6CCS79Ydc/kgfFaYj9xUDwE
         DQuVV1/2g076OrHPiHufi5ni86M3gTpjGemCP7cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1hfGob3qew-00ilro; Fri, 25
 Oct 2019 15:19:39 +0200
Message-ID: <3f6f8ac5dd3c3f053c682e8fc408c85d7b3e93e0.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     snazy@snazy.de, Michal Hocko <mhocko@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 15:19:37 +0200
In-Reply-To: <eab6798a6081fba94353be71681fcd8c7dcf8011.camel@gmx.de>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <20191025115038.GF17610@dhcp22.suse.cz>
         <eab6798a6081fba94353be71681fcd8c7dcf8011.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6llJXN/am3SGFo+oibZ1pCgXyV1XsvnsZFtNqUCawdAvCMcZdU
 xgqttSCpTyJuLIS+wt8q/75J0L/91em0rU4c7pMqEsNNQOvbNoWlknyPJbeplL5eANmRkjR
 fARCp5v0a8qIMGVYdhIGz8u40415NGBQKBQmKTUb7TrVF/c2oD2po3e4wzEfoKTNLV/PfsA
 LtJlJVwMDa5gNkaEnYpYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lk83J9fMnHY=:aKC97v3q4y6d5T1C3vLaP3
 buogJYs0jBkvbzCI8XmxnlLLVe5JDQQkf2SfpLP3CM96Obsg4nKWYBUB5bKMMwDf6ghCTFv1g
 GvY5PY0n5a6iJPAHdozhZKTg5CwEWIMHeoivCuzdczejU3yZNhfrKkgMgIuPPP2eJH2yZr8tI
 j6wdjMLv/h/SPSNxBgCp4UmHq7z/E3TJ9+j7tFjvvaTNOojgq/U49B+5mRWlH5RQKmIpoN2K6
 CeMPK4z1hyEoTgcS3cHGfjCCb7FutILyBqUf5LKtaWiRQDOXyjEDxK1ktB+JXZhzx64d01y2K
 MVgD3t36Q+dVV59PHqLx8J6zJmdmkA+uC0VXmD7klLy/57PyJwXcl5+pRTZtLSE/dCOVwSYG4
 6z6XsRPPa1pHfO1mq7TgKiND0trd/rVuWKvKysPXrS01EZOKP+iu8QufO3AYLnMwapPfUqbo2
 n0MLHeS3t+7nRGm+VH9cGggf42LlbnmzqifRhHSMju1sxAyG9OA81Cs86tPHfGL8iT/tt3G1d
 e0qeezUCOss4qOt7mORCOJ57aWvMD3+LnC3v4/wBc1ImL6I1b+05vWKLTJFk7RQLkuD2zEMrq
 3h2oTDnXo0nzHd3uwc3KMiu4t8NFAHbCdHhSJMXxKK4bP1ds0+m7vwH5PWP7DncDBjVxI1mQX
 8G/0JXYG41zN4rrY1/nc8icW70jouYw0kX0syAgJcOcR+SqYeVbdd/sabLxkCZfQ5rDecwNoE
 gK/GyIpZFmsoPmtpoZUWYo/Yza3h5zSPQkZxVmGhUiBH9umdMTPZC2xllYc+rORCETFqQKjWh
 fW2c4DkpN5wjtVkWBQj2QeS2FQJIi0WMz4IuyE/9jC2r4ay6dtrP3ezDIpaDq+tiO1G4QNDpL
 kd4ZiDvjntvdjZkB8Ejp/eG/jWScSZreotG3z0YLWiad9tDK6VpVESrQ6g/I3mLazZeWFpl3k
 eW7ujeY4NosaxJgrcjmNho5ucQ3GhxsfNCsKKzMHw5Guiuc4QlnIQweRyIAADRl5rA5ygb/CL
 +qnFnyPbl9bvHMcXu8C5CUpY6QYI/3iRee+QahIKxgPJ4KWcXWGTwowZPquCMu3QxIg87YIhC
 +oOXVR4brg0ackPyFxtsnUCdzNoecvtsyoqYKJdo+NJ7n3uwKe1b0uAQ558O7AfRoieKZCi7r
 3q38UzzN/6zmyniB1YiDMCUbl2WbWP3pb+BFCSs++BOUT/VUY0+5ZXwDyFzc198S8Glm14wAM
 f+BY8KQNEsHFTrPBIf9ABsTIB9Zz/BXU9uADT6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 13:59 +0200, Robert Stupp wrote:
> On Fri, 2019-10-25 at 13:50 +0200, Michal Hocko wrote:
> > On Fri 25-10-19 13:46:33, Michal Hocko wrote:
> > >
> I suspect, that it's something that's "special" on my machine. But
> I've
> got no clue what that might be. Do you think it makes sense to try
> with
> all the spectre/meltdown mitigations disabled? Or SMT disabled?
>

Bummer - booting the kernel with `mitigations=3Doff` didn't help.


