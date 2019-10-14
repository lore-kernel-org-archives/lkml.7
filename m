Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CEECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FD020854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dJLj5RVT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S+kstYHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfJNJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:30:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfJNJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:30:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8E71602F7; Mon, 14 Oct 2019 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045405;
        bh=4tXM//LUyG5g+XUIx5WMarfDzddVaiDxZSiBVoU808Q=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=dJLj5RVT+r1fs4hjroGiAWsYiYN8JtVuTdpYGS9MlCkDc50Dsen+1Nl/V02UIxOqE
         uBcLsmL5qTGncl33fGlZL1H9BlBzWEG49rodTg6T5EZbikM5NCxNr/9/0EvoF1TcOv
         IXUbMh/dgMbOnRNxmnywYiwuAKBIO1FOVvcYowfo=
Received: from Sgrover (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sgrover@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0F9B60159;
        Mon, 14 Oct 2019 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045404;
        bh=4tXM//LUyG5g+XUIx5WMarfDzddVaiDxZSiBVoU808Q=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=S+kstYHv86rJD5p3d/0AHl5JulbKyn9ICV5ThvP+ttOFb/MElr3uZmXiRRemfMsey
         2UvtV/zEq9J4p3aNYEXfEPQZSFBE/9JIYgZuXLf4lozDGjASHFHW/Yr9D01Yf65yn1
         h/zym3wBtEzLpVF1w/FLFZUdDAXpTdREHvwtr8VU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0F9B60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgrover@codeaurora.org
From:   <sgrover@codeaurora.org>
To:     "'Marco Elver'" <elver@google.com>,
        "'Dmitry Vyukov'" <dvyukov@google.com>
Cc:     "'kasan-dev'" <kasan-dev@googlegroups.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Paul E. McKenney'" <paulmck@linux.ibm.com>,
        "'Will Deacon'" <willdeacon@google.com>,
        "'Andrea Parri'" <parri.andrea@gmail.com>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Mark Rutland'" <mark.rutland@arm.com>
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org> <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com> <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
In-Reply-To: <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
Subject: RE: KCSAN Support on ARM64 Kernel
Date:   Mon, 14 Oct 2019 14:59:58 +0530
Message-ID: <002801d58271$f5d01db0$e1705910$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkPOdSLH2Qcxx8ygFmLWl3/QxVtgJ871EyAngelYemlMA6UA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

When can we expect upstream of KCSAN on kernel mainline. Any timeline?

Regards,
Sachin Grover

-----Original Message-----
From: Marco Elver <elver@google.com>=20
Sent: Monday, 14 October, 2019 2:40 PM
To: Dmitry Vyukov <dvyukov@google.com>
Cc: sgrover@codeaurora.org; kasan-dev <kasan-dev@googlegroups.com>; LKML =
<linux-kernel@vger.kernel.org>; Paul E. McKenney =
<paulmck@linux.ibm.com>; Will Deacon <willdeacon@google.com>; Andrea =
Parri <parri.andrea@gmail.com>; Alan Stern <stern@rowland.harvard.edu>; =
Mark Rutland <mark.rutland@arm.com>
Subject: Re: KCSAN Support on ARM64 Kernel

On Mon, 14 Oct 2019 at 10:40, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
> >
> > Hi Dmitry,
> >
> > I am from Qualcomm Linux Security Team, just going through KCSAN and =
found that there was a thread for arm64 support =
(https://lkml.org/lkml/2019/9/20/804).
> >
> > Can you please tell me if KCSAN is supported on ARM64 now? Can I =
just rebase the KCSAN branch on top of our let=E2=80=99s say android =
mainline kernel, enable the config and run syzkaller on that for finding =
race conditions?
> >
> > It would be very helpful if you reply, we want to setup this for =
finding issues on our proprietary modules that are not part of kernel =
mainline.
> >
> > Regards,
> >
> > Sachin Grover
>
> +more people re KCSAN on ARM64

KCSAN does not yet have ARM64 support. Once it's upstream, I would =
expect that Mark's patches (from repo linked in LKML thread) will just =
cleanly apply to enable ARM64 support.

Thanks,
-- Marco

