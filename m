Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48648C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148AF20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SaNMUR8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403956AbfFMQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:34:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47195 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbfFMQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:34:39 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 09586188
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=c/eyrUJezLRYTiw4Eryys2G0hdk=; b=SaNMUR
        8dxlSg05aOsn1QKtKkBKUdMdK8gMYebNjFybPIi9hVW6rLxPXtwpxXdDgvF0uGQ0
        aJlUjaG35jvcOako3xdi97qgtanV58Gj9fj8prqPR3+UnwKIt2kL/V1X4owm9CEY
        HHSXu/rARuLQh9TqMhnZvZWzoe7w0LprPNpkO1IEBH59T0uIsyEkBfccT11nxbxw
        KteiZv8aBWp6nPSDeyDwflusxC6jtZqMDmaP3KTuR5Dl7VvTZx4pJw7q0IU1SRvv
        goFWitoOyIpHobevfIe+QpLbH9J/La46dbRSQUc93R9cKZCLlRgsCbJGbbnZb6xM
        AjOTdILpFHY+Z+YQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d8c7f97c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:02:13 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id t76so14908051oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:34:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWkJAl13bX2XDv9UZeIIGB2DimcQ80wRknoalna6u1weNPPU9Oc
        JpVJySJhykDVl4p8gMneCtD3lXt6E/qFuOP3BVg=
X-Google-Smtp-Source: APXvYqwC+nqFzkn2Q40sbQCLZoiY0VYjrSoazuOA0QTmo/6ZcGWAyjlwk8rP2gYJSz4p8qVbezASwWK+9BVIOL/mHBE=
X-Received: by 2002:aca:ac4d:: with SMTP id v74mr3473955oie.66.1560443675408;
 Thu, 13 Jun 2019 09:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
 <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
 <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
 <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com> <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Jun 2019 18:34:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
Message-ID: <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> That does not make sense. The coarse time getters use
> tk->tkr_mono.base. base is updated every tick (or if the machine is
> completely idle right when the first CPU wakes up again).

Sense or not, it seems to be happening, at least on 5.2-rc4:

int __init mod_init(void)
{
      for (;;) {
              pr_err("%llu %llu %llu\n", get_jiffies_64(),
ktime_get_coarse_boottime(), local_clock());
              msleep(200);
      }
      return 0;
}

[    0.308166] wireguard: 4294892358 270211253 308165785
[    0.512931] wireguard: 4294892410 270211253 512926052
[    0.720930] wireguard: 4294892462 270211253 720925707
[    0.928995] wireguard: 4294892514 270211253 928990019
[    1.137011] wireguard: 4294892566 270211253 1137005585
[    1.344948] wireguard: 4294892618 1270211253 1344943311
[    1.552942] wireguard: 4294892670 1270211253 1552937363
[    1.760963] wireguard: 4294892722 1270211253 1760957241
[    1.969092] wireguard: 4294892774 1270211253 1969087174
[    2.176951] wireguard: 4294892826 1270211253 2176946130
[    2.385073] wireguard: 4294892878 2270211253 2385068075
[    2.593033] wireguard: 4294892930 2270211253 2593025847
[    2.801071] wireguard: 4294892982 2270211253 2801066369
[    3.008895] wireguard: 4294893034 2270211253 3008892169
[    3.216956] wireguard: 4294893086 2270211253 3216951160
[    3.424965] wireguard: 4294893138 3270211253 3424960158
[    3.632942] wireguard: 4294893190 3270211253 3632937133
[    3.840947] wireguard: 4294893242 3270211253 3840942470
[    4.048950] wireguard: 4294893294 3270211253 4048945319
[    4.257078] wireguard: 4294893346 3270211253 4257072850
[    4.464943] wireguard: 4294893398 4270211253 4464938724
[    4.672934] wireguard: 4294893450 4270211253 4672929572
[    4.880939] wireguard: 4294893502 4270211253 4880933901
[    5.089015] wireguard: 4294893554 4270211253 5089010190
[    5.297072] wireguard: 4294893606 4270211253 5297067556
[    5.504935] wireguard: 4294893658 5270211253 5504929920
[    5.712963] wireguard: 4294893710 5270211253 5712957452
[    5.920949] wireguard: 4294893762 5270211253 5920944292
[    6.128959] wireguard: 4294893814 5270211253 6128954684
[    6.336968] wireguard: 4294893866 6270211253 6336962979
[    6.544945] wireguard: 4294893918 6270211253 6544931514
[    6.752963] wireguard: 4294893970 6270211253 6752958001
[    6.961008] wireguard: 4294894022 6270211253 6961003309
[    7.169073] wireguard: 4294894074 6270211253 7169068202
[    7.376936] wireguard: 4294894126 7270211253 7376931429
[    7.585022] wireguard: 4294894178 7270211253 7585016996
[    7.793004] wireguard: 4294894230 7270211253 7792999324
[    8.000953] wireguard: 4294894282 7270211253 8000947668
[    8.208949] wireguard: 4294894334 7270211253 8208943630
[    8.417090] wireguard: 4294894386 8270211253 8417085802
[    8.625071] wireguard: 4294894438 8270211253 8625066012
[    8.833086] wireguard: 4294894490 8270211253 8833081441
[    9.041032] wireguard: 4294894542 8270211253 9041027362
[    9.248948] wireguard: 4294894594 8270211253 9248943016
[    9.456968] wireguard: 4294894646 9270211253 9456963019
[    9.664955] wireguard: 4294894698 9270211253 9664950178
[    9.872935] wireguard: 4294894750 9270211253 9872929704
