Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECBC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176F42084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X3w8IXwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDMLnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 07:43:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38134 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfDMLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 07:43:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so10135097oie.5;
        Sat, 13 Apr 2019 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PhNdP0asdVObS6Xc/5QPUT8gFKo5WEOH+jVFHzdyF0=;
        b=X3w8IXwa+SzR5FfzM9rOMzxd4hw8y+kSdy6o78ko467+SvDzG1kvjZP9lrs1c2Dhnw
         Iv6GYbYxl32ta2f+S90yzujPiPggs4XH2TZLFcaQ6EHV09gN/tJBnYi17bqBIubR2Fzm
         +5OEDDkZuZairFfga1GZpwZaxvULbunu0gtGJMgLDu2DDJidU42NyU92ptmh+z/2HdoN
         f00KlPIpQS8G6NJbL6e1BUihId4CxNNGQMpaEpbrBdAvh/M0g4JcFqM9e1KbD2ipdtpD
         h9j4ZBx19cCWBvyi3/1OW1rCUMALF90fAAuzDWiVwy62ATAgTKHAbUsZ6Y/ThNKqEQCk
         XgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PhNdP0asdVObS6Xc/5QPUT8gFKo5WEOH+jVFHzdyF0=;
        b=s3JVDaQwGO0tII92pULp/fYKdvxVwUJz2iEWI9X+3Q5YM/rVi/gXBJVJmzDpjX1KGR
         pBOqlHLXg4loNc75aESo6xvVpnwgKdb9xLSh1pGcDWN1oloOvBhDp6Z0SBLmgozEG4Kc
         wAqGZODqnHepjIesxi5KbQ91RNrCeQV38z4pIXiKixNlMGSmNT0B6rtFxg5pMnfL/K6o
         7RK7junNRX94uNvjrVsHXngYj12h8Lnc0WNqMSTiqg2XnLaCLcQGgSLJxldP4fPX+fdW
         FiPUb+7uFQbdSG1GJv1Ocl481mFeS2553b2AhfbC01PjkKkuRZ7MFVPAZYsSCyA7otNN
         MJHg==
X-Gm-Message-State: APjAAAXjnS7ppwFmqXjEtqpBZ4HdODj4m/73m3oWXhIM/5UF4eGLJBgn
        dW4HElgjb8ytEx27FbdvA/nQrGieCSOlozWv9G0=
X-Google-Smtp-Source: APXvYqxqXFZDeb3MD3FPgVmZ4ZsFdh+cixd6uEq+e7w+qpemMnK54guuTIMepO8ZQ/3ObliIu7U2Wb6CvLTe+yJydVg=
X-Received: by 2002:aca:d487:: with SMTP id l129mr14029433oig.129.1555155802759;
 Sat, 13 Apr 2019 04:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100221.26740-1-glaroque@baylibre.com> <20190412100221.26740-3-glaroque@baylibre.com>
In-Reply-To: <20190412100221.26740-3-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 13:43:12 +0200
Message-ID: <CAFBinCAhf0EpnvUnYFEvAHo44a7OBoD-Hasx60Aow6ZfvWWEpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clk: meson-g12a: Add Temperature Sensor clock
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:03 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add TS clock used by two temperature sensor
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
