Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC0CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437E206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jfk4z3rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfD0TyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:54:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39282 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:54:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id o39so5496933ota.6;
        Sat, 27 Apr 2019 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2TEYGqM2eqA95oCN6AjNEUtVj0QAPeCnR422YmBgJY=;
        b=jfk4z3rTOiPIraD+0HZ3/hSMfVejWs8MzSVFJn9E5gilPR6WcUFc/FXsl2MTYqyJD1
         iL67C+m7ZHL/hK+8+F74+26i81yr0ny10pc6k4M2Y91y9WYBAEEvU1worHDygXzb/XN7
         6xem1RVIVApib8NZjeIgg8ghxkv2CwbewiazLkIm1lgR5KIc/PZDxuMGTJatd/Bg6m2/
         +4zudfoYEA8ah9Fnr53btvar35ir7pPc7L86i7dBhby6MWzKTtjFe4n0OBllatQb1e8r
         MANZ8oBiEAjsYaGzutCKSh2s+Ty0BVZuQHoXHnOTPvJuHPpfvyozGSCylO3fXqdKjy9H
         FtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2TEYGqM2eqA95oCN6AjNEUtVj0QAPeCnR422YmBgJY=;
        b=U3GZvcteGdpapCFrb7YPzOYCzRYUjJbRID2nuCPKAVZ+ygTMwaqU7pPS/xo7UEEa6f
         yIeE2DUwnlzHvFXbWHbbACv4WmYQjYz6ZC5DELcNrEFnbtvgu8NBfHcGVAe3lpZPxUgi
         CO7zCEnjR1ODb379LN7o9UoOuvWaLFURLQhvw5j/RhudiMhd4STkkcUTTKBxNdD2JpEx
         J+e1RCmkVUVt3VfWV7aURA6GHkEtRRmhfpiObdJQFfzEfZeKB1xDNOffgaIOWsvZnBvl
         C7/I7krYgx6+bEf9X5lHPmQcRYxnMe6Vnh64hRAO0maQqFJe5mbe5ttl1fXwBB1n79bA
         KUqg==
X-Gm-Message-State: APjAAAXlTEdwo9ZKWOiSqAy0mhyDh+IXvQG8m+FSM9hYZVuYD01OlkCq
        1ELPwTjMjs5S9yJHK6NtfD3uitno2ho8C1jszCU=
X-Google-Smtp-Source: APXvYqxdQGav6cTTyWMwHZFjSG0R6IVWWZ5ejvCPNbCrS9afVnS9yepb3YW82Va6BKB9w/HRTy3DynT9wiCFCwXa9QE=
X-Received: by 2002:a9d:7443:: with SMTP id p3mr11829327otk.148.1556394847785;
 Sat, 27 Apr 2019 12:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-3-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 21:53:57 +0200
Message-ID: <CAFBinCDb8H74=awtuu2Z0MDF47gXbi2AVPAHNXfz=S8xVT0J8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mmc: meson-gx: ack only raised irq
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

On Tue, Apr 23, 2019 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> This is merely a clean up. It makes sense to only ack raised irqs
> instead of acking everything all the time.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
based on reading (and understanding) the code and a test on my Khadas
VIM this seems fine so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
