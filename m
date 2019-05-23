Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B386C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="aLZjpXIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfEWJby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:31:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfEWJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:31:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so1569758wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ozW29rNk7jqBzsqPwmK5fiFVlAdGSbYVAGL0ITKgSdM=;
        b=aLZjpXIGYDHmv/ws2VbtEe2RblTPaIJxvjNl4LutzOg6NqTRYnE1IWtllwsXC1N6Hl
         SGsx/tYWWQGkzt3dPwTAhFPc8JX0vtqaDWHfEfngYbPKD2urZVV3nmCKXF3Clz8J4s+j
         aSrOk4KfdDOmlAUQ2TUCMCDpU4OgImCG9wxrTkuxDsd0WrwFyvg6hKpKSPCFQCuYEx4a
         RpG0ismUy5mI+Lv8BIjzWbfq/+q26Gcxq+6LHeqNCgzhFKHJKzsj1Oy+pp2hBbpDBrOL
         u/4gV18XE4FHn6J/0znioN/LFLPI9misaH9wNj+j8IjRkOMSrJhEECo2pMA71wP53qhd
         p3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozW29rNk7jqBzsqPwmK5fiFVlAdGSbYVAGL0ITKgSdM=;
        b=KuCcRMxKt50QVpaz/qeqip6VyRgyF3+/Kfz9Nrj6LDjFE5PvUAgMLpX2cfWP4ijERD
         jWUr0ji60QZ39VjyI0qtve1K3hl1XNQ3h3x9PksFJmNf58l+/zw8YuKnJFnzV/isEaOn
         vFpofr3oECVSPuUVNdwhI+RMvFm5/ikKdduOtyGSmNnDzVPvaCGbcTDreWQO/xBi9sNJ
         RpdzDmlhCF4cJbULJcXm3Wl/1U0LyRfIYRh8MpvfiNQ7z5vjn8yjCvo6pl3JE40l9umX
         est2XwUqimirMs63T8KVGgxXBAZ6JeX0belFrw0RcvPYyMFI4sCUNl6FjM1JAm+e4gP2
         gofQ==
X-Gm-Message-State: APjAAAVdiKAWoesLKVMpk/O71OlheTBlnbJOQnTSfScYzPSVUQq09cmC
        fYhHW3pYVvfBx0XsqR/F3qDBz8/KB2QDLATQMQYHrg==
X-Google-Smtp-Source: APXvYqzj1kwHy+TkUXT3LQpMPBCHNOOQ8zMgJk0apJ5xCjGxYGg5xEimWzmLzWeGi+jeI7HLTcYBjtT830ObqAP7VRo=
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr30926927wrs.103.1558603912553;
 Thu, 23 May 2019 02:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJWDJiLZA7NQ12VkxqV9nKV-9idn3JsZGdXhz0e19NX54w@mail.gmail.com>
In-Reply-To: <CAMpxmJWDJiLZA7NQ12VkxqV9nKV-9idn3JsZGdXhz0e19NX54w@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 23 May 2019 17:31:41 +0800
Message-ID: <CAFRkauBu511Mf7jgLMuX0M_C_KjmBrxSG_d4OEh6ChHfSYK80w@mail.gmail.com>
Subject: Re: regulator: NULL-pointer dereference in tps6507x
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> =E6=96=BC 2019=E5=B9=B45=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Hi Axel,
>
> commit f979c08f7624 ("regulator: tps6507x: Convert to regulator core's
> simplified DT parsing code") causes the following crash on da850-evm
> board with linux v5.2-rc1:

The fix is already in regulator tree and linux-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/regulator?id=3D7d293f56456120efa97c4e18250d86d2a05ad0bd

Regards,
Axel
