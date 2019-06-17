Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886842086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfFQPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:06:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44387 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfFQPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:06:43 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hctDP-0004mS-V4; Mon, 17 Jun 2019 17:06:36 +0200
Date:   Mon, 17 Jun 2019 17:06:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     =?GB2312?B?zqy/tcqv?= <swkhack@gmail.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, swkhack@qq.com
Subject: Re: [PATCH] time: fix a assignment error in ntp module
In-Reply-To: <20190617132133.GA7851@localhost>
Message-ID: <alpine.DEB.2.21.1906171705280.1854@nanos.tec.linutronix.de>
References: <20190422093421.47896-1-swkhack@gmail.com> <alpine.DEB.2.21.1906170814590.1760@nanos.tec.linutronix.de> <CAObeVcdBDbSiyQCX7C_G3p6TpB9yjRyrWwsvPgh11V8v+BNaqQ@mail.gmail.com> <alpine.DEB.2.21.1906171409250.1854@nanos.tec.linutronix.de>
 <20190617132133.GA7851@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-54536811-1560783995=:1854"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-54536811-1560783995=:1854
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Miroslav,

On Mon, 17 Jun 2019, Miroslav Lichvar wrote:

> On Mon, Jun 17, 2019 at 02:14:57PM +0200, Thomas Gleixner wrote:
> > On Mon, 17 Jun 2019, 维康石 wrote:
> > > Yes,the  >UINT_MAX value can be passed by
> > > syscall adjtimex->do_adjtimex->__do_adjtimex->process_adjtimex_modes by the
> > > proper arugments.
> > 
> > So there is clearly some sanity check missing, but surely not that
> > type cast.
> 
> As the offset is saved in an int (and returned via adjtimex() in the
> tai field), should be the maximum INT_MAX?

Right.

> We probably also want to avoid overflow in the offset on a leap second
> and the CLOCK_TAI clock itself, so maybe it would make sense to
> specify a much smaller maximum like 1000000?
> 
> Even 1000 should be good enough for near future. Negative values are
> not allowed anyway. If the Earth's rotation changed significantly
> (e.g. hitting a very large asteroid), there probably wouldn't be
> anyone left to care about TAI. 

Hehehe. I leave it to you to find a sane limit taking all the possible
events into account :)

Thanks,

	tglx
--8323329-54536811-1560783995=:1854--
