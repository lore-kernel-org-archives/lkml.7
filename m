Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8DC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E4C20842
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pPjHIsHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfJCXvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 19:51:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfJCXvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 19:51:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so2755723pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=SM0jbJ92pewaO2UyUMQGBudBI+n7lpF8N9PzdJ80Ddw=;
        b=pPjHIsHxI5U6qsDZ98f27ZX0jQhbAVXW4OmhAl4I75g7dVFAVlqNRyMe2Klv/pjH/5
         Eebo39ovpjedvBzVIH1EXWF5ADHAGDLwFWnulDD4UnbFLWrpCmXMZbrz5yJVocXENIaD
         PKI4c8gFYSy+aDQfCxxtfDvd8goG5gMUlTftarPohCJndwfvLBu+md+gjd+aD0F/Wsz4
         fiS1l2rv6DziNkAQQiqZ66g5J3QMJdbN9Aw4idY6lCd/Hi2SxTm6OHLd+PE6LdtIaM+A
         pGtZ1e/GhPkSK9HWx8Fb46xUnJ1Ftl/LqyiVgBvIlTubzICX/f8hV1RDjzCuqpRgnR+S
         8H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SM0jbJ92pewaO2UyUMQGBudBI+n7lpF8N9PzdJ80Ddw=;
        b=RTmInD8thszYE5Mlpg2h+8rKv3WSAUFurzAC9GRIyax5pX1UvpqRGXNZH5x9XQiobW
         wNSrtA5rOdfz4H+RjAm8j2UfmvqJqVGcHbHmhXLfMp/Z3T+r30372Lpspoul9fEVnyD6
         kxkE+7d7U/0aq88bDyAzPnlymspUFHX7hrSA3wpIzpipfrlI9VYQcJ/w5mh0fy+j1Vb0
         b+pH2pxgSnLCQsEcbE4/lfCjSFJHxurvEr+XYjx/x1UXVaFkK83ZQyseAktTQ91HfUBM
         nEsc/Xup4tcGBfwhmhz4u9MndWOwq0fZuypuint6vgSPcn8ysSQXfyE75AuJSuL3+o+X
         fbmg==
X-Gm-Message-State: APjAAAUGRuwEfIdCvZ4/98cMR2e734jqtP8QNcZPH1Fif5M+AYvi9sXh
        THWJmJp4VVktZDDdKMHGSr9P0Q==
X-Google-Smtp-Source: APXvYqwS+Kwy84pyUOoYC9yXYxngxdEt1wEwq/m4oP/itFien8ixsHy3bhJH7Qz1NFMB3aHSJ+OOmg==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr13278880pjn.10.1570146695643;
        Thu, 03 Oct 2019 16:51:35 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:6c63:e3e5:f440:92c9])
        by smtp.gmail.com with ESMTPSA id w2sm3738261pfn.57.2019.10.03.16.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 16:51:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/313] 5.2.19-stable review
In-Reply-To: <5d967daa.1c69fb81.174c7.399f@mx.google.com>
References: <20191003154533.590915454@linuxfoundation.org> <5d967daa.1c69fb81.174c7.399f@mx.google.com>
Date:   Thu, 03 Oct 2019 16:51:34 -0700
Message-ID: <7htv8pgzg9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> stable-rc/linux-5.2.y boot: 136 boots: 1 failed, 126 passed with 9 offline (v5.2.18-314-g2c8369f13ff8)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-5.2.y/kernel/v5.2.18-314-g2c8369f13ff8/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y/kernel/v5.2.18-314-g2c8369f13ff8/
>
> Tree: stable-rc
> Branch: linux-5.2.y
> Git Describe: v5.2.18-314-g2c8369f13ff8
> Git Commit: 2c8369f13ff8c1375690964c79ffdc0e41ab4f97
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 80 unique boards, 27 SoC families, 16 builds out of 209

TL;DR; all is well.

> Boot Failure Detected:
>
> arm64:
>     defconfig:
>         gcc-8:
>             rk3399-firefly: 1 failed lab

There's a known issue on this board I've been trying to debug with the
mediatek maintainers, and we're not sure yet if it's a kernel issue or
a hardware issue on my board, but for now, nothing to worry about for
stable.

Kevin

