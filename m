Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440F3218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKS+5XM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:18:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32938 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:18:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id h24so2668101qto.0;
        Wed, 03 Jul 2019 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IjB7eIx91cGzvCzJPmHdtVCISw8X3L0amGAAfmCgnb8=;
        b=SKS+5XM1x7Q2aAlwFM+0FFl021AbmFPeJWur5gPnzvrcDlOWGesHuHrReXgapS7D6H
         HvB6jEeOyjTk69U4MugVZAZ8AV3wrWLMTe8QiShPEh1k1RRfV2y74vHiugcdfMyAqKF+
         69BTwqfDfPbks2mtGThiF7QkN+hKJgAPGzkJfou7gPMSxYS8gdpkGRFTO2xrDwSs81iq
         1BTfM0VeiE0d4m6JDguO0zhMzQn5pxDsVAIgx+rbaExD/NMkQWTTk7xrCU+Q12X8Q8l+
         Fm0SVIHSvRXCNZa3zu4QQzPy5pMV9iwjndzM2FYse1EmZlxDkYcWLguuq2vBWtd4OMa0
         QRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IjB7eIx91cGzvCzJPmHdtVCISw8X3L0amGAAfmCgnb8=;
        b=sJLZVxxnWuRyigVAdx36T5tFJqoZi7MD7KFOVcOTpa9zAv7LOW4WtzwsdgyrKnh6mU
         GixrbcOY+Il2GMXqBJaB5jlFAUonsqyTfBje8yuMQsRLkZB+tI1hJXy/3UVclNDqEr4k
         dL/E7ed403wgGNDL/Qd7D2dOIfx6fsjX+1sDcvASEpRNW4jxdOhChLbetsCM4zkj9qXS
         PotcZhtnJZTXCbRNfdTdZRekyQad9yc29VSg7lIYUe3D2/swXmiL+ARcA+eoz/o5S4Ic
         GX4vokak33dCINvfOhgrIqaQuSAl5MwinDlIJDUgL5lUUWBeErDJiJAQqeyyfpQEWwSU
         vGaw==
X-Gm-Message-State: APjAAAU/tc8PYB4/EbpF7HABTyjWqBCAUVGtafvTqH/287F14ZaU/vYV
        kk/sO4D1qUD6gHZ6njS0Z5Prfd6if3tAgR8pfOnvnlVD
X-Google-Smtp-Source: APXvYqwGgM5Phb3RLVd4Z4Ax+sqyMgVnOmoG73XQaHgqBxim7OM82B4e7D+F3YtEkaU8KgLKnUOB4WnOnJ6qFelDqsE=
X-Received: by 2002:aed:38c2:: with SMTP id k60mr28886147qte.83.1562156286006;
 Wed, 03 Jul 2019 05:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <ad2e4b58-268e-c9e5-8a66-8cb5dee8d91e@web.de>
In-Reply-To: <ad2e4b58-268e-c9e5-8a66-8cb5dee8d91e@web.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 3 Jul 2019 05:17:54 -0700
Message-ID: <CAPhsuW7CAfu07Y319eHUUi3Ln422-jMmpTHmy0rT+MxZnO8BBA@mail.gmail.com>
Subject: Re: [PATCH] md-multipath: Replace a seq_printf() call by seq_putc()
 in multipath_status()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Shaohua Li <shli@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 5:25 AM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 Jul 2019 13:07:55 +0200
>
> A single character (depending on a condition check) should be put
> into a sequence. Thus use the corresponding function =E2=80=9Cseq_putc=E2=
=80=9D.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Can you explain why this is necessary?

Thanks,
Song
