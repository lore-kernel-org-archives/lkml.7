Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DFF20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V1ZWuQQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDMLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 07:41:31 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33062 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfDMLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 07:41:31 -0400
Received: by mail-oi1-f169.google.com with SMTP id e5so10161283oii.0;
        Sat, 13 Apr 2019 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q13kuNkTBHkcWihycz+KK0I6eBNtjvR1vvA6Tk/zFZ4=;
        b=V1ZWuQQkDMT1//qpcFkGoC2aB0YLJrrRq+qF3dz7XUtNX1GQgFS56T7GJbuam2wqOK
         eMKjlsuRgTm3SXA195kuV9wJ7C7/a2V6FwFmcZtGPb48oCZcKXJfKZw7jjAA/VIsXW09
         50Df+q0L2AL/7CPOsl5nQofExF4JQAuB2nG/Wwss6yPO56a7yfdJVIznl0MR3EylBBIA
         Oi5GkzCUlvbxbMwBzkzXgSNaD/0HwhUupQ2E2xmixYvkYmfaJ+jEiMWZGTP/iD5jWml7
         l3FM4bxOYinnDfARhGRhHYP3OvHrMbv6yezxoNCWpQGF8g3/aa3/DsSF+xWpSXBrpwHa
         06HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q13kuNkTBHkcWihycz+KK0I6eBNtjvR1vvA6Tk/zFZ4=;
        b=CEKSLFamIF2DvCaZjG619rbxX5tGF+Oe6APtjCKSCcqvK3Ixv2PUgLWmzmArIj/M1l
         B10g4Ib7a6JSOXzLsoXXSolKBGVTOMHk+L+6r09sXOBTbRZf4txECYzvS25WAtN+a3B5
         KlDyphkTG/RvndXKq+cdk3C8BqNzuyNmDGhpw7095oNbHhHP/Hu+qgIjPtjPERJwAOvj
         AEGe8D1caFdVUqnSEF3X6WLlXWnupbwUY5yC/J8eaNBcqwqs6AnfbkhFUPz+WtAi6TXW
         4cqBthhxecS/G/NurV/V8m+mh+/Lh4bExXNUX/SYTjY3zPIRyNxivpvpA9pW6jRsPvYx
         baEg==
X-Gm-Message-State: APjAAAWSVWFtLjqF2RduM7vo/Gj1WOri766SCvVNx4YwCZReQfJZgHYy
        66T4F+p6qzgMuG5beIj3MvOMSM7Rp0mR2c2GPqepyg==
X-Google-Smtp-Source: APXvYqyvBEoNM+100tF5Ew7Nv2paa0mwftXH+HmOHRp7JUWfyGWsV/q0zfmDL3q7w43lw52wTnk4ivATNrJaLoyjewc=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr13298471oif.47.1555155690122;
 Sat, 13 Apr 2019 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100221.26740-1-glaroque@baylibre.com> <20190412100221.26740-2-glaroque@baylibre.com>
In-Reply-To: <20190412100221.26740-2-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 13 Apr 2019 13:41:19 +0200
Message-ID: <CAFBinCCd1EkvcwX0aiKxPXepyndu8_VhKq+RFVU7KxzYNftUJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clk: g12a-clkc: add Temperature
 Sensor clock ID
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

On Fri, Apr 12, 2019 at 12:02 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add clock id used by temperature sensor for G12A Socs
nit-pick if you have to re-send if for some reason: "used by the
temperature sensors for G12A SoCs" (because as far as I know the two
temperature sensors share this clock)

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
