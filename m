Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D482AC00454
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D0B214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLNOol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 09:44:41 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 09:44:41 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLRgp-1iPISi3R3r-00IWSQ; Sat, 14 Dec 2019 15:44:40 +0100
Received: by mail-qt1-f178.google.com with SMTP id e12so1303927qto.2;
        Sat, 14 Dec 2019 06:44:39 -0800 (PST)
X-Gm-Message-State: APjAAAVPsgQHhdhqTY+tobWbByMAOqF1Gyr4idkvD9hOVlPfvoSNNBeV
        WU/2+eCAHuBxSUcbf+0WqXirrob7AsIS/j8odKc=
X-Google-Smtp-Source: APXvYqzGh5bFPG98ALm1rwS+1oBWlB0rdxMwfuMdc0Z+WDAdOTm5wzrRksxa1T6t4KX6ZZtoY3ya4gCQPdB2/t83nQQ=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr16755745qte.204.1576334678661;
 Sat, 14 Dec 2019 06:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-15-arnd@arndb.de>
 <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
In-Reply-To: <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 14 Dec 2019 15:44:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Tuv766qK0RX+ZkNiqDqiOOHPeawFXT0V-Zsj5ZKAAQg@mail.gmail.com>
Message-ID: <CAK8P3a1Tuv766qK0RX+ZkNiqDqiOOHPeawFXT0V-Zsj5ZKAAQg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v2 24/24] y2038: sparc: remove use of struct timex
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:476WpjpbtZIZ4Qe480wQKSas3sZ10yCunJfDY4jCNnoTNI+ikUb
 9uOtr4EUHeaBdfBm7oXZk8q83a8qeNcVI39F1aGWYP1ogCqe7DU4QkJdZZQ23T3ZoYBkheM
 6chfglxG9GQ0SnXjpo5um76fVGHoHtM83Wv7fPPGbo2TB0heKoj+4DofNDx6cTf+4bkQLer
 a9QSTPLhGGg/noSAprycQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3tsXHoCWadY=:r4R6+yIaJ/tkW2GZg4umBz
 oXu1bttiPp2BlXHf5pQAH7rJyQxm3V4aEhQazpLphkAVVlz3ugOO2pARB+8AONoOEcWqr876p
 SyEJQjVq6skp+g6YTPkCY5d8ZzsouSY/BnZTOto3Ub+04R8upmYL5zdg86kPopLpH3iWNN+Zz
 lc3y1aVcmwSuAf7AC7rO12RYOCyE/6X27nIeFNSNK+XEo8l6+VVQ/5oYv1DlVGt/O6GvmAsU7
 fbIUsUtJIq1HOpvBUZxsv5vkR9XkrTetv9pwpo3qHvkVWvprqLtq1/d5JzGvuzwGZk9N3TG9e
 NbilQjzffC5Y0ZG7Wl7m5Yf2ZW4vrxAeKmeBoPdqjqN9hJSRNerDIY3MjfDfiuZgD/4DqZuax
 tQELsBWy6VSjcI9rsMeXQEqEcsVI1Em4FxfH2tLOLQZtsm752VBLYjrtD1fyMbXd8+s0k1Nmx
 Ty8g+KsPEYR4XExtZl4n8LcZysk3dqUzOo6AloKyrY+hr3pwNlUHpMjrDNxqAUt+/OaTlnKaO
 hrQ0IBU4bs3/iMsVB4eZZO7ENrxg09Ned3B29uFr2zpMmBMV680Q7riQ3wl3ujm/uCzLRFTj+
 +niboY8YipMgzO1qyAajUIaK39D9V9f7buvQ/RbLvo6fBy+LwQP/V7RYTWFCoOy4lI/gc81wn
 Waxc2RHuJX/CS/728x3hL9U11oBQ7xYmbwA2rR22umZo+iKacu84jgYvCuWdJXJz3dD1uP9I0
 Vquarupo7reM0NtXyqmHwyQ3E9YPowxyJLSgPdgYW+YMSjq68/gBCGKtRt27wzw5EHgdQnhzu
 XGqmpr18/yE9wZibcnoz+mM3vAxvYCKT+cGr4w/pQMSa/mmCu76W/JhzYO+i4PKZu2YxdyiaI
 PKerVjkz5voU4fXdpgwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 2:38 AM Julian Calaby <julian.calaby@gmail.com> wrote:
> On Sat, Dec 14, 2019 at 7:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Am I mis-reading the patch, or is "kt" not defined?

You are right, and there are other problems in this patch that I should have
found in a trivial compile-test. Please disregard this patch, it should not have
been part of this set before I had gotten around to at least some testing.

When I collected stuff from my backlog, I only made sure that this one had
no dependencies on other work, but failed to realize that sparc64 was not
part of my build test matrix and that the 0day bot had not seen it either.

       Arnd
