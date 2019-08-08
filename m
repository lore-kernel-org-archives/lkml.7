Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB948217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm5BPoTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbfHHSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:04:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36177 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:04:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so13506972lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaZ/BuHyNlaApD40wywwaA3ZttcsEmS6y79BUPzlwkQ=;
        b=Wm5BPoTvKbdJUFMXngUMXUpH1apuKAaIpjtolUyDPjiI2xdxGU7Nkp/du0h06ROJMx
         +fVjNNkwfG53IX6Y69QPnbKY8sxd9g+MeR8YygYAEjYysaXxo6givcWhhE7Tk6uiHIth
         yVwMP16KxJg0ypz5HAptvoKv5bgwRYe/qKcny+u7pi7upZ+GlbOr1EEQrDKWNzAj+L70
         4xBVpdLG3TDpJXAoJpRtuyq4C8jH5PxjqDcnNGfS+ZRqjkfcE21iWzgMQlqAXXVsV4WQ
         VwGdgQ4ehFH8sONF2ymM6hjWzXQZDHeuJ+iCpNkhjcXghR9wJpiOq15DasObTIdlQoD4
         sdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaZ/BuHyNlaApD40wywwaA3ZttcsEmS6y79BUPzlwkQ=;
        b=WJ4m9w3viZfIMhnw5gpAS+M5BMWtCvDmWy7PQWb0KeuMmTESdwzkoQxHC8bJp0b9O8
         UWwNjsNj4LHdIoVwmPNc/FpvPQ8fkdInAE9YzRux5KMSUBpe2wQhct6WXugo+RtOlwlA
         8QBUFYLIa95P4YyGY+PgeJYgUnIGgWA64SVYNU4y6qJqayGjE0UiI6iLSszVeerRnAlq
         FlQIVW1UKkoa8J1QOCPACDmmvv5OMwVc2+Hw8zUay2lt1F2xuWBVV2ZIOOK2uz0voItM
         tGvQadvSNvLmIl5GDx667sUQ2QGw8fbA7wfEO0vfUwKwyJxXu8Yw1fgPRTaQVUkwxmlp
         Z0qQ==
X-Gm-Message-State: APjAAAUlKzimpzklWBB8g9M5wgKjOXpRDAI1crE2egm1Y7GjFlvdqGGe
        GIQe8UAG62f0DOOIOUyjLe2AGHmOezRQ1XDJE/o=
X-Google-Smtp-Source: APXvYqwHb9L622Jo+Y+SC1d0wOhWUahviZL4eCn3QF+yjEDmzEp2+ye680T142EtZdaz4eiey5ye6QRKL9f3a3OrcIE=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr9873208lfi.173.1565287485224;
 Thu, 08 Aug 2019 11:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190806142328.5847-1-standby24x7@gmail.com>
In-Reply-To: <20190806142328.5847-1-standby24x7@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Aug 2019 20:04:34 +0200
Message-ID: <CANiq72mhEXJsSSyGLYtp3Zb_YSG2PKnHyu5sMN5bCeP_TYMHpg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Fix a typo in cfag12864b-example.c
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 4:25 PM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fix a spelling typo in cfag12864b-example.c
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Picked it up, thanks!

Cheers,
Miguel
