Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D684FC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65962187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mDltV6jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGCQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:28:45 -0400
Received: from mout.web.de ([217.72.192.78]:44355 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562171321;
        bh=whAN3DmjeN7ZXZnbvExTVzLYvO1SV43mh+ZZAM+G78g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mDltV6jxLAB1MnRNJw0cHhU1FYvHbQSRDJhAwD49Vc7maRIwY5hGkH7zDcLOMkd6Q
         164KA8ewsRt0fotzv2jqY33iDa+hzoYhy1ipUxK93gVxFmeEfafl+9eG/Qp5Aq8rCv
         NuKKhuY5PRs3qQ+vnu1gIJTHkcIiysq256rP3rPw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1jI-1hrXoH0JaS-008pxj; Wed, 03
 Jul 2019 18:28:41 +0200
Subject: Re: md-multipath: Replace a seq_printf() call by seq_putc() in
 multipath_status()
To:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Shaohua Li <shli@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <ad2e4b58-268e-c9e5-8a66-8cb5dee8d91e@web.de>
 <CAPhsuW7CAfu07Y319eHUUi3Ln422-jMmpTHmy0rT+MxZnO8BBA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3ae39471-e1d2-2e2a-984a-888340e84447@web.de>
Date:   Wed, 3 Jul 2019 18:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7CAfu07Y319eHUUi3Ln422-jMmpTHmy0rT+MxZnO8BBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3brbGjVY6q3V24KGWSjRQdXsXm5+PvtUBsHGAHvqVSIgDtOGXsS
 5p+VE6sOGl27nBDACgQcEiWSr0RYxYcY3uELUcXfemfFANd3ZajrEK80KbmlqfsGL3hY/Fd
 +jxdwq4sAW+jhHUOaAEIsRts0hR3KDlmOmOkmPnOvZKb4yuvSKgeirJKmXlIlx/gQv1zvAr
 gshf70HX7luzCWmdyssnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rrf00+A05yk=:QOu0I6XSoirsHTSbKL7cX9
 HkGZDEWBydTEtZkaGQeAX39OHH39fQQnBsH9OBeEpN8JPmGL1DevTQPe5yy3dLsU+pOeQTqMB
 OEQf8d39/5F7cFN7rcCGdofy88jd43CQajoTFaBrXtGBuk4TvHeEAVNmbT7j0fHqFTt5ftX+Q
 7qg3ocbMA/NvHyutfEn2m8dY4hNbRY9kDHDkbqMQG628mjpNrvu8NHdNHSHWKV29jXQW2P7wS
 nCKsBTZSz0Y+uRwd+QBmAq2vn9tubAjtblUXGLzXbkj123mTU0DmJhZ5AvE6BynT+FOupcrwa
 W96saLdykEbrzQxJNGZZwx/F8RjLMdZ4L2r9Kku9x4swZBPC3K1M0l/WDa7NmRISDPPqq1/uF
 B5Lp8BV7JOu1J/6N+UVq19fQRKVqzw0uolVSHKOJSvlY7GGSRFtFyhT+iULlG6Fa8ncppNNBd
 3jwzpYbWnODEJM+unLZynyCu2i+mIIytJC1sOaX452kw81vhb4TzCwqvT/EKoklqgh6FLFdFC
 9y5dbXsGTV83ITbGJ7H0IIfJhS2NU/j6JJoFrOD6/4LCUP2FbAMaMbGXkGW+wS+lGhS7QPbGK
 pZiiJZT/lu74UohG0JVEOHxRTdxsTwgHSFItiyhhzUMy5XzcJ7Wrs/2BaBx87in5aFbADS19c
 cGHz+iK4YD1Zc8P4KfjMI71IMV2td08kdxhE8nhiotmtxkk8Zb45FVlwznMZz3eBTZBSIwTJk
 CeIRyoyn+bVFwYxUY03KH3S4jbiIDvI51jURoMddl0zGV+jlhy0xcMyb45bcOfOreX3mFGfGx
 +x3wZB9IOMlSILq8Xo9wrj7ge/1Wj4VmEzLw/R++0EORclTw3SzBl5zr9psi1YowNNr40EHt8
 J7jIzF5UO9bUjbAJb+fKRbOd4bl9KK8ogIMELNLYxIMiH7YjVVBVBARGNtoLmaeBWNVlGSARY
 3a68/1xGAzAS+uDMhFP3hcXngUnrBrX/cO9oIAKZ/FCn8pnhEzOSp9xSkr1fMu51CaIv7xQgh
 YbU7hFE0+pxD4KnmgHo69WAUrlsSADrsN8L+TiSEfxdX1/9qa4dFBEziZ9UqZTFZ23u3Vftyl
 dyyfxu7MLBiFdUNagRLNyVj9tV0xYO+3wsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> A single character (depending on a condition check) should be put
>> into a sequence. Thus use the corresponding function =E2=80=9Cseq_putc=
=E2=80=9D.
=E2=80=A6
> Can you explain why this is necessary?

I suggest another bit of software fine-tuning.

* Pass only a relevant character instead of a string.

* Omit the format string for a function parameter.

Regards,
Markus
