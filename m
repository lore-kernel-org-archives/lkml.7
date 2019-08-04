Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF3C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F82F2075C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e5thmEDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfHDJXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 05:23:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:42269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfHDJXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564910600;
        bh=Oi0qBKpS1zpZHZDbRB9bx40ZA2YAz8/lccg36x6bvPc=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=e5thmEDfpO8kWK7Jmax/X65Tb4o2QvDHjGjVo9n7n4AQsFI8e2KZQKKlfbS6q2ORG
         XVFPXY0dTX4k5C/eUtlxGmQWfO2ero51Qu1nPz1SYAc4t3nqg1PimdeFqcU2rRv9nh
         CnsSkwgwNFZaTaHNahIdjxlMAQYz86/8dj0UPdcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.94.10.6] ([196.52.84.45]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MWwp6-1hokiJ3xhs-00Vuv9 for
 <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 11:23:20 +0200
To:     linux-kernel@vger.kernel.org
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
Date:   Sun, 4 Aug 2019 09:23:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U4wRXzSlCtkm8rZ0+8o5Wpc4SJsu0+V9HYAcEx9jEZqrapstOM2
 8OCTO4n2U/XRawDtcDPZ5zSFFGWqTsJKNynqXYjVU6M0Kcd0AxEFNF19m3o6DlC4IFAvXDJ
 iRgqbER8qi3vWRgL/V+3wd2Bg1t4pAvT7XBqjmPQ0ccPPHyzixpowsD/LRwEOc1df2TFrXs
 dsJwYx9xNHUdnFiHm2dMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpzRUryDTmw=:05lDcR6Xen2/KZkcJgskV2
 D5ccfdiahpB1VbMzJ283uIsd97R8QxGtne33NBGtEhZEwo9FU7UsYZTLvIj+afbEUs6xaWvZ+
 4wjLzJ7OdgFsqCRGj13sJjzSvzM0sK8MDrBp8a9/QvsQAvKdRi6gilhM/ZQPrDXfEhCIUe8ix
 nmVG0XUoYgM7SA/pJjTVjwXH+kZLQ32IWYXusL96eaQ3oOYdoDsF6pe+aBedXwlyBuOoRjjgU
 Yfag8V6MHaOvk16L1m2HATk834cBm71HnjPKlPDskqjkXDHkZfOQDGbpX8rnMb/ZAeCdqc74n
 c9E2COHxKN4Ry9idtvvvGOyCLQvNR+D2j/ZiMAd4J86QWpQjuv92LQ/lUAcHRrc/oCwo0F9Rn
 y/K9wO4IIlUrnn40YTjYaLLbMsqivuA07NVT5K6JiPe6+CFviH+qoILo8ZRSFwO8P+ZlJTCFS
 iQykh4n6wN9abmh3LBpLK7J+WPa4JERQZn4H/MRfnbys+rG7T6EKNf3xqgu3neGAVqbAqAzq9
 jUam1HxBRO/k2dpufDnUHTtrdInsHNPiLuPRg0+sx/O3CE9hCnBlKHEbsw+C9v7JQwXh77pd1
 Rdaisd+BKoH+4HxntrvGxXZ+Au4E+VACCO32suTgG4/ygjpK4A1bu2HilmYzpY+TLCP39Y14f
 6Mnbq5xJJFJjOBO3roh/bmtu/ZA+SKKtJ5+6BO0IA03sbqKDi+hgdh9F04w+qQDARM0C+oWAH
 hBt2GxZpv39Ea6Beaxip99sQBK8vhsgSis0J9dRaZugEQeLVfncpD42h+IhJ5gPzXi9vr1Uwv
 xseYP9zjzLRkxOVVwba3wTBvdx1R8WyGHEhpaPiNvPrWnpmyWhxxv9PYRX6+HmGBfxMgD1Ks8
 lRAw60yN5wldQqvvVbihdsw4cg6A79TpB94vfhY6RznT8zHlihkMgopVrVp+Nx4Puu/iUBoo6
 PFd9Yijh3C83/zq744WQN2+wKr6OGqCkZgCh49ce9wat/NZZR/eNnVpj3PgzBf4PRwYpaGZlV
 1XveWyYEeWpNw0kp4Itp1sSIFEZbl6WfsBKdQKVYtmUtswLKxPEuNMilVZl39/HDvwBHdPHO/
 ySs/G0cR7M1EOTFpfe0k3xJ7HWAyQW62y+EwJ+RfTw8tBdz453IedNDqGNwm4NxxJc4rszMvi
 aFbes=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There's this bug which has been bugging many people for many years
already and which is reproducible in less than a few minutes under the
latest and greatest kernel, 5.2.6. All the kernel parameters are set to
defaults.

Steps to reproduce:

1) Boot with mem=3D4G
2) Disable swap to make everything faster (sudo swapoff -a)
3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
4) Start opening tabs in either of them and watch your free RAM decrease

Once you hit a situation when opening a new tab requires more RAM than
is currently available, the system will stall hard. You will barely  be
able to move the mouse pointer. Your disk LED will be flashing
incessantly (I'm not entirely sure why). You will not be able to run new
applications or close currently running ones.

This little crisis may continue for minutes or even longer. I think
that's not how the system should behave in this situation. I believe
something must be done about that to avoid this stall.

I'm almost sure some sysctl parameters could be changed to avoid this
situation but something tells me this could be done for everyone and
made default because some non tech-savvy users will just give up on
Linux if they ever get in a situation like this and they won't be keen
or even be able to Google for solutions.


Best regards,
Artem
