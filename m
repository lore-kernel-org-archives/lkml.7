Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B5C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBA42064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e6NtxAT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfD0UDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:03:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37240 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD0UDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:03:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so4373958otg.4;
        Sat, 27 Apr 2019 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0/Zgu3L8TA8JK/4HG1qsga/lPfJom6e1Yx53R0kCIg=;
        b=e6NtxAT3R+topwkq+nRkflN1XdZogALF2AtNFHcQL5l/dJTdUEQgnoWAFRSKBkQDCd
         oiK+9a73TYQA0PPsTD+aK1jTKTLTgXcutF4KGssniKWyDUCkgFf+7FgZnmd0aqiFxbtf
         uy1bNZ0Zn0hkI0cm+mvB1qTM1eNytBhcTQ1BB/D00rhTe1j84FmmM5IySABP3cp78dus
         w4v0zemhq6Jilb5f/8ilt6Hb7lEchoUOp7/4XObOeLbQwfB2WVl9fRFyah6l4et3Sydl
         245QSOH13m7Bm3LVezX/qKUlW0Gi6Xixg0EiwmrlsRvhTkfWazybKmVJMPC2ogXjsxLE
         MzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0/Zgu3L8TA8JK/4HG1qsga/lPfJom6e1Yx53R0kCIg=;
        b=jGDLOHPC+WzMRKFub9GKSVMHk8UgzT1Z0f/cvKI3R2qkYbEqKiFROn2WbhB40cOvAT
         RkVhdaqDQBa/tuTeZuJ1M3nSeLuFndZcZxt6AmMpqXeYZ19llzOceAVjh7S4TmitRMvZ
         loclKlZChtUjAhyO8XghyCeZHSVaXIJ+I/iMhJiS3SSc2B9HV3SqGhdhBlSwr8Nf/fSE
         K4qjiy700ww6MKGAfSqoV9sjr93WHPuGLOWRv31dx8HYvVK9P7tNRxsWqIjHjpJmgf0s
         +iZbg7smcfvK/YFI0FEh5HGPYRTa+btMnAULDTyRau1JVx03TNQosXhxKMSmajJrtZ8i
         Qhxw==
X-Gm-Message-State: APjAAAVHMZLvebCZHh0aKBevNbTIaTxCMhM0R9eSydytfVWXLKUM3FLh
        wo3XBl9ky5n3mLYD2ZpVfWxrqgxUHw/YQ2nA6sQ=
X-Google-Smtp-Source: APXvYqy3+2AXgUMpVHVF2NbQMGNZphYDQ54egxc+cmd5oJLEzzVPK8/UTuUZMgSWjGJyIpgeZz35BlDJVuqxTSIfkDQ=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr31038186otl.86.1556395419137;
 Sat, 27 Apr 2019 13:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-6-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-6-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:03:28 +0200
Message-ID: <CAFBinCAoXx2H14GEth9HkDPjbdB=XEkL8KNcFY6vUwH+YV9Aiw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mmc: meson-gx: avoid clock glitch when switching
 to DDR modes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Activating DDR in the Amlogic mmc controller, among other things, will
> divide the output clock by 2. So by activating it with clock on, we are
> creating a glitch on the output.
>
> Instead, let's deal with DDR when the clock output is off, when setting
> the clock.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[boot-tested on Khadas VIM and no obvious regressions could be seen]
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for fixing this issue from v1!
