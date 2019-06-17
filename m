Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40FC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157520861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfFQMPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:15:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43568 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:15:03 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcqXK-0006f3-C3; Mon, 17 Jun 2019 14:14:58 +0200
Date:   Mon, 17 Jun 2019 14:14:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?GB2312?B?zqy/tcqv?= <swkhack@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, swkhack@qq.com,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH] time: fix a assignment error in ntp module
In-Reply-To: <CAObeVcdBDbSiyQCX7C_G3p6TpB9yjRyrWwsvPgh11V8v+BNaqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906171409250.1854@nanos.tec.linutronix.de>
References: <20190422093421.47896-1-swkhack@gmail.com> <alpine.DEB.2.21.1906170814590.1760@nanos.tec.linutronix.de> <CAObeVcdBDbSiyQCX7C_G3p6TpB9yjRyrWwsvPgh11V8v+BNaqQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-426885459-1560773698=:1854"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-426885459-1560773698=:1854
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 17 Jun 2019, 维康石 wrote:

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?
  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?

  http://daringfireball.net/2007/07/on_top

> Yes,the  >UINT_MAX value can be passed by
> syscall adjtimex->do_adjtimex->__do_adjtimex->process_adjtimex_modes by the
> proper arugments.

So there is clearly some sanity check missing, but surely not that
type cast.

> > > -     if (txc->modes & ADJ_TAI && txc->constant > 0)
> > > +     if (txc->modes & ADJ_TAI && (int)txc->constant > 0)
> > >               *time_tai = txc->constant;
> >
> > The way more interesting question is whether txc->constant can be >
> > UINT_MAX. In that case the txc->constant would be truncated.
> >
> > Miroslav?

Thanks,

         tglx
--8323329-426885459-1560773698=:1854--
