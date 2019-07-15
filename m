Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89153C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B71E2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwOKluNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbfGOPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:02:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43696 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389254AbfGOPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:02:03 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so34528369ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kIXA8GU85p3Yokp73M6SuuvQd6PpNvvlT7z0N2F4io=;
        b=uwOKluNFh794Wb7BC3FTX0afdBMT1OJ6kZ7FACFrFkihCtoLPhrfNIgoArARcCPDoC
         B7SsB+3pXOpcJNCX5VZFyh7ssMJLqdrKjI4z/4SL/JNj4id4zVwuQA0/OPDFcXc+SVC6
         CcXxEqZce5f7qQkJnzx4Z4rxuJ1phGq1YbxhwUPnIrO3PfJlF9iaPS7dgpegpkJZ6+Sn
         U2nrDtUxdhBMhUX7ejnCMJRIbEefmz8JIfWoMbxZzEusfuYZNCLygcBGtVCeFwqZhg2Y
         yI+NHqRKLMZBLE6Isp5g8Eh0PrCBT01MCHMONSs+p/5ECGqihpPOenvXW6wYUIlU7xen
         +BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kIXA8GU85p3Yokp73M6SuuvQd6PpNvvlT7z0N2F4io=;
        b=CsTReTCkLtJH1tYKD6ORYPv/U8gFuY1bRhR9F6r1la/15nRX0AjTY79bnitSePU0bV
         7rgspOKXgGKuRLfT7NRMNlXqQxQSqw83rBCkC/1biYrclALr32e2falGWda/zbzAWL5T
         QNRCJJuqERZnICx4U4pfQueHRRLYDNynyCV2AqtykLR8g/J05Y5lNx++M3snmL6rxET4
         KDz6gP3gjZJCz68blTrRw4ZoIPg2wDfQHKVlpPjkaYPy/B2Zc9CmdERdU28CKYSgrk9i
         0I8c3weMnRuQNXJhK7lFErX/zaOq/CGBt7zc2M2fdP41QN2f8ifZE62D3g2r//CCCL8+
         As0Q==
X-Gm-Message-State: APjAAAXvHiETZExde9UhumDRGJUDFEn1uTUYpoheH9NbWis4RzcSESMm
        gjG2lZSyCILppGhCb8WZYovFrWeVXxqKW7xV3A==
X-Google-Smtp-Source: APXvYqyMX9ckVpVhNYM/AuXYFCF+2UwsWazz6PKm86ZZd+MuqhjC0agMegN0ch2fUPa5Yx29/GiwkCPyBstMZuWFB2M=
X-Received: by 2002:a6b:b756:: with SMTP id h83mr25547012iof.147.1563202922237;
 Mon, 15 Jul 2019 08:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
 <alpine.DEB.2.21.1907151435080.1722@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907151435080.1722@nanos.tec.linutronix.de>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 18:01:15 +0300
Message-ID: <CAKKbWA4jBMG8v4unqWEpGWgRm9CH+EJvojsOwMWTvnQH15HWdQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks,
Avi

On Mon, Jul 15, 2019 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Avi,
>
> On Mon, 15 Jul 2019, Avi Fishman wrote:
>
> > NPCM7XX_Tx_OPER GENMASK was wrong,
>
> That part is already fixed upstream:
>
>   9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK macro")

The automatic fix changed from
GENMASK(3, 27) to
GENMASK(27, 3)
I reviewd again the code to check how it worked so far and saw that it
should have been
GENMASK(28, 27) - this is a different value than 9bdd7bb3a844
For our fortune this wrong value didn't effect the our final write to
the register.
But still this should be fixed.

>
> > npcm7xx_timer_oneshot() did wrong calculation
>
> That changelog is pretty unspecific. It does not tell what is wrong and
> which consequences that has. Please be a bit more specific.

OK I will fix

>
> Thanks,
>
>         tglx



-- 
Regards,
Avi
