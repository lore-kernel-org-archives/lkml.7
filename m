Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C3C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61402067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbfKHT5d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:57:33 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbfKHT5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:57:33 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N7zJj-1hpgym2s8x-0151yp; Fri, 08 Nov 2019 20:57:31 +0100
Received: by mail-qk1-f169.google.com with SMTP id h15so6339492qka.13;
        Fri, 08 Nov 2019 11:57:31 -0800 (PST)
X-Gm-Message-State: APjAAAVmtIn+xsVYCTCzLtPfK6bfCyoI+heb1Ny+7/sidNHAzVRIbLNu
        wTxoflQFzvlPZWpjJmCEEOr+4R8zUcG6EZByXok=
X-Google-Smtp-Source: APXvYqwbEOv9N5n3ZVSMCaT2AayZZFizNM7xZNN/vq5TItdY6JMB/hXbfpzfEILBcvqaJNvSbipOgEpXoOH0B2jqyjk=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr10475357qkb.138.1573243050314;
 Fri, 08 Nov 2019 11:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20191108170120.22331-1-will@kernel.org> <20191108170120.22331-2-will@kernel.org>
In-Reply-To: <20191108170120.22331-2-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Nov 2019 20:57:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
Message-ID: <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ,WRITE}_ONCE definitions out
 into rwonce.h
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:WN2iI+qyF2aSt8E8GeKGmxpYo3P2QxddmHwDuUf+2xOBmvCiXN1
 kfo03Y5w0Ed4/W8YtsfC67k8nnzv9O2z9711Ijn03wGaGTixokJJiaw8tAHBJ9cYCbCssiz
 Y2PsFV9C1+nQzCzb82xfQ06UlKQRgwLbbTKvxd2E7K8Gy5O38Glw7sMriEYvgOHRMSuO3q1
 GaxO+KieHHsxR9s9J7o2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bYkMvnYhV+E=:5i3VTKBS0g9a2FZ+pwIr/h
 YGXwH9EYPtpdpROfWmYRD8/qsvV5WJtT9N4XydZgBoxBTkEKg4CUMYzn/GpaQjz5kMOXfnF1f
 MppuGBcAI5xDJpx7/bOD4Cjt2zvLYJIaCzH8cU5MHM01uUndyxLEcA5KoAzUzexHN34ly4Di6
 3K9cuWzfla586x0lmwdxYkBLCbwApbKUc29p5d4sx2jS28pTqqGYovQdriPQ2INaUIjitX68x
 yHQYLiEv4gTceKnDvGfN85XlUEH2xH9/2l2uHpaHXPp7raydECobeYgohHlLS+g59JjHzdFQX
 Bc3ah8+euWPyRK+Etayp9cnuiqm/UmdNIcPdoKbsDEugcMW9BAQ2qDSurObGnIH15EnnZvfEF
 4LheLtq4DWgU72V2Rr2vPTZco1DXkJ4w7kAcxDs3Ts36ZJpjjaTxzoUvrmkWFKu3o1NsSSdtz
 6diG03KThrYLE4Aza5PiV3jt6QL1NvcR6M9nARqhQFzOG6ObZm9QZI0TrTvADlKe1LFVJ3s6m
 RGkpxNSrGt/7D/zBz3UDeBXB3tANmBEZnLr5smBbJE7mKI12z0vVNmX6rU4Bva5fg2YdqGNWN
 k48lfUG2+PJqzcbKozpHvqN52rswG2476rp2jPCIlPr0KZY8MT3DwUm4zkIUnzivZRPRtGaUS
 5YWKXSsJ09jptgYVHmIMccRcFrauU+PmsavJHTP1hXeXeRUrrM56JrFtOlm5G5ZsEKxftZrnh
 6aYlRvZkotFNPVdZ+jZRQ4V+hPXC+AWwMExucHXDN+2dQl0g0TJvKPOqJwnvu/oLxHjf6cGDz
 MGDr1slo0ciqEUpnP5XOlbKcNg127ZJTOUv1v9gMGYx8HUrai2US24TbwHYvbYPFl9siebGd4
 pM58UcjGFKWFvwd3Z9Dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 6:01 PM Will Deacon <will@kernel.org> wrote:
>
> In preparation for allowing architectures to define their own
> implementation of the 'READ_ONCE()' macro, move the generic
> '{READ,WRITE}_ONCE()' definitions out of the unwieldy 'linux/compiler.h'
> and into a new 'rwonce.h' header under 'asm-generic'.

Adding Christian Bornträger to Cc, he originally added the
READ_ONCE()/WRITE_ONCE()
code.

I wonder if it would be appropriate now to revert back to a much simpler version
of these helpers for any modern compiler. As I understand, only gcc-4.6 and
gcc4.7 actually need the song-and-dance version with the union and switch/case,
while for others, we can might be able back to a macro doing a volatile access.

     Arnd
