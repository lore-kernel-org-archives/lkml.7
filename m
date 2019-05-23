Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21DEC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609602173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="oZUuIBmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfEWBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:40:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:40:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so4357961wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bv7sUG/HkMLXw1f3vdh+moGUnqf44UPafbBga8Tp8WE=;
        b=oZUuIBmhOgFo+cS25ouMk+nTbSA6/1n+RYUkfkSKhs8H2Y0b74Bl3GqyL5lBj31ZDX
         1KQjwuyBQTHMENC5TPbRSRP/PI/rwuCiwyLJgYk5F7LTVTtIwTt52iarUI4mnB+Sv/jj
         1vpQSvbFkRUF6/CrGkZk6ecOqVySYIF4Mj/INYQ/WR7UlPXWxtboBUTb9J47YG7SPjro
         yzA/4MoH48A9c/oTaleeETLSAeH3vVE83NqAewcnLtjUYxe5gzKHpCh/lJGUQdwczXsm
         aQnLNrMv9ncQXhql8IazIP+dM88ZuSlEJiVS80/jYaPshOorqzsNrWTlT8svMJEJi1Sv
         lVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bv7sUG/HkMLXw1f3vdh+moGUnqf44UPafbBga8Tp8WE=;
        b=jrj/ME2OY2+qrRBiws/zR/pbutWhvi6ti7+283c7GhrvuakhZx3FcQU4WGz7sar+ki
         TS1BN5l/Lphkjzb9KXyozElSgGQe9Pc2wy5lbHKVp/OH4Th6ZNa03DAeuDRb/kQ7TzIT
         QOsurq848AMcZRsE37X+XdmMjYU/TzcDPiT174LuqkfrSEpQG26NzFsfMEjTTU2VyfoI
         VIsmVmAWCMP3Rbf4RXjNxciJVgbfC0dqWaS2wngPnqWoAis48PHTGyHDrzFPSjqCq2RA
         g8tScbximbLbPho2NFK67V10TQkcEofdU2GWv9L9oO0cBI+ic1GhADIdxVQRJTW9/96R
         q4zQ==
X-Gm-Message-State: APjAAAWmcsWEZ1BBNNMIoq6Dwc9ERncVJBl/jXBcUq8WawU17AvCJRW4
        RUhE+f0x5VOfS/ObHJWz5mm06aZ0wCc3CFqrUWZFAw==
X-Google-Smtp-Source: APXvYqzRQyVk2ExeHJ1ZTElvYIoij8hzAusVhvBsxfWNNBpIMPozLFVymNPRFTgGIPZCPyX2Sw9KqWNA5WLdRsgp+lo=
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr29401825wrs.103.1558575628427;
 Wed, 22 May 2019 18:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190523012629.7707-1-natechancellor@gmail.com>
In-Reply-To: <20190523012629.7707-1-natechancellor@gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 23 May 2019 09:40:17 +0800
Message-ID: <CAFRkauD-nQn9D7Dp+=2iyWMFEc=E7-vMmncFMOqrHHWuMV0vKA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Move max77651_SBB1_desc's
 declaration down
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Clang warns:
>
> drivers/regulator/max77650-regulator.c:32:39: warning: tentative
> definition of variable with internal linkage has incomplete non-array
> type 'struct max77650_regulator_desc'
> [-Wtentative-definition-incomplete-type]
> static struct max77650_regulator_desc max77651_SBB1_desc;
>                                       ^
> drivers/regulator/max77650-regulator.c:32:15: note: forward declaration
> of 'struct max77650_regulator_desc'
> static struct max77650_regulator_desc max77651_SBB1_desc;
>               ^
> 1 warning generated.
>
> Move max77651_SBB1_desc's declaration below max77650_regulator_desc's
> definition so this warning does not happen.
>
> Fixes: 3df4235ac41c ("regulator: max77650: Convert MAX77651 SBB1 to picka=
ble linear range")
> Link: https://github.com/ClangBuiltLinux/linux/issues/491
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
