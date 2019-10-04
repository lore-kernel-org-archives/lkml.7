Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6523FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ECE207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fZyGQE2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbfJDPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:52:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:36271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389954AbfJDPwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570204319;
        bh=tlXNezk2klm36a8BgtQ7aWv6+faM2dhbJvCXCdCOFZA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fZyGQE2WrjZW8em4J6qE/CMX+qaoDkrb4cfayYSFuSsC6XNDBbfJABOmngKV3z7bM
         Rjhi3KD+3Xk3kjAeigEITXt/JHUykRRXfsNPBQfG3CWFZxUNiKjhniJULcmVBJeold
         YWu7xOUqeX3JdNjf2KwccTcd5yZ4d/k8In2n3Xq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.214.220] ([80.208.214.220]) by web-mail.gmx.net
 (3c-app-gmx-bap10.server.lan [172.19.172.80]) (via HTTP); Fri, 4 Oct 2019
 17:51:59 +0200
MIME-Version: 1.0
Message-ID: <trinity-c33ab112-57a5-47d6-80e5-13c96442e302-1570204319219@3c-app-gmx-bap10>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Lee Jones" <lee.jones@linaro.org>,
        "Hsin-Hsiung Wang" <hsin-hsiung.wang@mediatek.com>
Cc:     "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 4 Oct 2019 17:51:59 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20191004152001.GS18429@dell>
References: <20191003185323.24646-1-frank-w@public-files.de>
 <20191004152001.GS18429@dell>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:SA0Gglr+Lfvr4Iz1kF2/P2ycdFCnYWrl8HCghLFJOGQq5gM3NRxGEevpstbEN1hpyf6vT
 gz5mldmbYfbpYp5LpYr9QI3wk1cMPPitFC1DNLKkBoO8tQtsFYq9xE/KlcvGlxJl7oEL4Q7JWYfW
 4CvIDXImNJfBcEtvO797AERoqtx98dg7+AG5jVr+T+bPFeeNZ5aRXEpypWUszXHF/Nq4JeQY+RqP
 qKkOZsZiI6DZrbfXZXQuTqV4WjRs03JliKYKhehpbkhSpfdyjpbz2/KnPCjTUOEHb8fhE9qLUKdH
 sQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:DUEgJZ4YN2A=:bc/n0OX5WsUSC0c2k100q8
 RE27yEX1VHwQKm6UTogrAHMF/rdsYW9bauE+46Z52liDodog/Rl/VO/+35Nh7DIXaRMy0KWJ7
 6eK1Mu1KpuKcCCN0tozF7AOJbzd6OHbwR8iHXs9KeuiBLW6+E83+AFY9pyyt4hIK70cU6r/m8
 /4Satde9MAiA03ExOtsqjd9lvrvWDYVKmtbqAAPFp+BO7+Ax/mTav0h5kfpxajq4nCIXSMPB7
 hEyAnXHdKv1b7hOOpBQm55zzaH0xwEk/vkjLfo4U3hiLXu9TceAOIHOxnLzLGym6jLedKTqAB
 ljkXEnCBsGUMEJgv1m/yCrFNC1OIKjZzcrXY672EthDNOGtwabqYIy3Jfcq+60Z/Qbra/tHrF
 fEA4XmuA/2o6Wx2FauqPRoO4KeWOMmYU738wsN6xLD1uD1TQIgVwN1lsfQYkp+IE0Pj2eUol3
 oK2K2qBcVWUhvs+lJuL6PudkSeCSXNvL1IeB/i0emE52jHNkVCbA1+44bqa/CVy++iDroL/NU
 Y9K3IiIuh3+/cbGMTaqiQA/Zmo9ThE0O2bcSAzz+NuVWY0Xofz3QNGogkCESzkRxmXRGPFMCI
 8o+YZ9xrnFevRPf3Hvzt3JXLuQXZzWxuYuZfzyZKNQzJJVZ72TV55+TYHtM+Rj9YUv6SUMpv0
 D25m6Yp9BMqijAMuruku/k4oEnWSc6OpAGwhhxhwxM7Al+xYHdK3+D+Xt5dQb5l5u7Ec=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Question goes to Hsin-Hsiung Wang ;)

i only took his code (and splitted the 3rd part) to get mt6323 working again without reverting the other 2 Patches

regards Frank


> Gesendet: Freitag, 04. Oktober 2019 um 17:20 Uhr
> Von: "Lee Jones" <lee.jones@linaro.org>

> Will there be other devices which have a !0 CID shift?

