Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202EAC73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E766F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNA1e83g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGJFY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:24:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40216 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGJFY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:24:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so899551otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioMDB4xCRfyih9blEfQfFq/5H+9f5r/eOiGuXZsKTpM=;
        b=mNA1e83gi656UXPR8nqOQSjw8wH59lM6GanNHXNRGXbg3bq0gEGgsCw16oi+sZU9DJ
         eQZNOeldrdnuV/5hnGKQpKr1o2kQF/+U+p3TsmIt5rF6zYyIyCNLkjBN4/L5YKqKT399
         fjPfPjemWu2HGAWRYhrVRBy+683K0HsvchE32sejFHgVZACcqHIZ+f/pqMUocPt7Vl4L
         KWMDPgOhI1YaN2NTfaA9ps2KehruPFGrFg/YgM5cP42ecPkX2bSaw3Ozx3KQ593gVsOd
         gw5i9X/nIAPz3i1KLeKE3PdtZ5ohiIMDa+//oPJUWKzQddrhWXjk6v1O30WeFi5CPm/K
         /Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioMDB4xCRfyih9blEfQfFq/5H+9f5r/eOiGuXZsKTpM=;
        b=trz9ZFUoMmpYF2As7Hq3/v0oo12LDMbwpQNSZs8+aQ+oYf0thm/Z4VURIclTIlR7GN
         t4tJ1j2mQlN7Oe19zFpx/wlWqCMhvsykFtatFFCSZtD1xHzDTy2ba26jmHECZtXxohCK
         LskumLex6DG0ylLnl8TaUyfsBANSoRwtgrp5Syns9aswiRlJeFPmFe9+4IJaTCmGcWh2
         ElH4hcArYbQW9dPq820ps6W5dEF1ePRrWJiuLb52h787ugZ7r3ds9b9kze1HamDEXVjp
         Uu4d0VnEhRyZMX51Ba5PXCF44SU/K0t+/YiZbzO+rNNrkt5UifEDh9MCVIDoRj6l3HeH
         Qe6g==
X-Gm-Message-State: APjAAAUmRQc/VQTOWFiwfKzJFK4Sn5Uw1IytskYdVO3dFsR5tkM22zAW
        77fXkcJzuxKeNwel59om9WAQjqVSzKibZ2pLrl1JTg==
X-Google-Smtp-Source: APXvYqzNWCTp+PGnXinfRndYKaIVZTZf7jZeNiuotZqNqZys/IitGZeb1egfuAbp/LgydGLR3qx1qbqBFaufmhseWLw=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr9197123otp.344.1562736296734;
 Tue, 09 Jul 2019 22:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182543.GA6611@hari-Inspiron-1545>
In-Reply-To: <20190709182543.GA6611@hari-Inspiron-1545>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 10 Jul 2019 13:24:45 +0800
Message-ID: <CA+Px+wVMn-wZ_aoAV2OMEg4zE7aoYG__my2EJM_PP5ghaXjoFw@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: codecs: mt6358: change return type of mt6358_codec_init_reg
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 2:25 AM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> As mt6358_codec_init_reg function always returns 0 , change return type
> from int to void.
>
> fixes below issue reported by coccicheck
> sound/soc/codecs/mt6358.c:2260:5-8: Unneeded variable: "ret". Return "0"
> on line 2289
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>

Thanks for cleaning this up.
