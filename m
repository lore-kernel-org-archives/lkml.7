Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9084CC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670992053B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fppg3bEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF1I3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:29:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1I3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:29:21 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so10758028ioc.8;
        Fri, 28 Jun 2019 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=29qZLe/ycWIjMlCCTOUGo9VV3OPNk26MXL4ayhclDzE=;
        b=fppg3bEMvomKBqCuu5MbgltOVZzicIWbxIszalTiKpOukfh7yDamu9UIkwW90t5yrr
         KS+nKl6mCjVB07ZezU5u2R1gYh1NYMouU26Gh67JgkcxT2PowQSnTGJEztYu4pq9BGlA
         smau2cMrN1CwZoZ/Peqc5lToGcK03YawLY9dFD4q+eK5Ut9N4f32shmgft706Raaoonq
         l787F12baTCgYT/V5AhQGFUPjFgqWeLxWLO/MOPR3Ps9UE3NKfW0/aq76sJ4Iw9eH1FY
         o72fOltKv0iIw9tYxri03T6NVwfU2eQEqAK2o4GydeFNBzbx6xYwpuDpMXaNv7F9nQGx
         c+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=29qZLe/ycWIjMlCCTOUGo9VV3OPNk26MXL4ayhclDzE=;
        b=VTFD265SzXkg7Y+Pnyui/Vh1nsX3onTILYkDRPQ33qd4CYI/MjawJG9Fm1dsErgHQr
         YOeeHQfZl6NQHyqLrhH/N/gqG6Qqf5MAudeS2ZRU6+brLYV83X4Qe0eL0W6mGiQE4WQ8
         1Yn26Q5vQtH4/hOwLcV1lWhTJJ2wRLTxLy+SD24qapfJslpAwYp4I4SDG2kYpFt9TC4y
         EckOHokjS+415Vng9KRM6DmcPRCjTij82nQgg+/a+crMblZ/cOJsHRxaTjDkj1a18Fkk
         TKW6cjUVYMwmA+k9vmWPnHHFh5egi61BB6AfYeaj3eATA5JkZUVeGLKW7HlNuQQ1+lRV
         8eYw==
X-Gm-Message-State: APjAAAVrykBMme0q9/r/BZCUVLr/W5dwK52iU033jv5FHOG/fn2pbPFY
        nd4mKOrwVgOhQzKeRxnR6Pj+GRKzSwutgw==
X-Google-Smtp-Source: APXvYqx397DfWi2rMOTvGEWYF2Dd1fSUebqX4QPfLoCsJxTRziJQHrYp+57KFN6LOx2O0EVy4qFzuQ==
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr9577840iol.22.1561710561112;
        Fri, 28 Jun 2019 01:29:21 -0700 (PDT)
Received: from [192.168.1.8] (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b3sm1313370iot.23.2019.06.28.01.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 01:29:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4.4 0/1] 4.4.184-stable review
From:   Kelsey <skunberg.kelsey@gmail.com>
In-Reply-To: <20190626083604.894288021@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 02:26:40 -0600
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <28E380A7-7D7D-49DC-B100-459F43C0FC01@gmail.com>
References: <20190626083604.894288021@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled, booted, and no dmesg regressions on my system.=20

Cheers,=20
Kelsey

> On Jun 26, 2019, at 2:45 AM, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> This is the start of the stable review cycle for the 4.4.184 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, =
please
> let me know.
>=20
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	=
https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.184-r=
c1.gz
> or in the git tree and branch at:
> 	=
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git =
linux-4.4.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h
>=20
> -------------
> Pseudo-Shortlog of commits:
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    Linux 4.4.184-rc1
>=20
> Eric Dumazet <edumazet@google.com>
>    tcp: refine memory limit test in tcp_fragment()
>=20
>=20
> -------------
>=20
> Diffstat:
>=20
> Makefile              | 4 ++--
> net/ipv4/tcp_output.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
>=20

