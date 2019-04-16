Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C697520693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="acbgphUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfDPOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:34:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55091 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:34:23 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so16597871ite.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbG+Yvzexu4hHn4Fx5cx1WYQVSrW+dfyN8M54lq9RqM=;
        b=acbgphUpeVrHhIS6tCjFaHUIEtEEzPGX9y2+9IUITop0VWtUofZjHESIOLfKJW+RlQ
         cmzpL5ZWoPfhN+TzUQ+GcWRT9tbcxhBXziOfFo/4QFclrnNlAkhvAAKp+B136SzghN5k
         UBKiX15TCnBsz1UFWRk7tAzhXKkzK4oQARe/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbG+Yvzexu4hHn4Fx5cx1WYQVSrW+dfyN8M54lq9RqM=;
        b=dfcZX6po2hHtn5jlgIMep3lr4XfWBB3k/XkydYhtvcWDh54arTxrzzk15pGo9hbzsR
         n0HXubIPiwN0pXDH971WWCKB4Ed2GILEGw4Xs8VILtd2DfKhzE6iU+T7Dv/hJimmNZBR
         +bFgq8MqvQB3U1Zh9yNI0yG+qyJwGoxls3aLbUottCnhIlV42MposLIDhdLLw8rYuQVW
         Y9r12n81OdnyLiLaoVzmT4crgm7i/woMBl6YQM/Yqf51TVvQFFPTNlI1E+qWA1E3gI8n
         lY3Ect+cisssK4K6Oje0fu1p4+Ue5Px22hCYBWmETmx7rWNOovx9UNLkgknyTNu5C+uj
         HZJg==
X-Gm-Message-State: APjAAAXzH6NZH/+1T47mhBpl4QJOueAE1YaLcqcx+7Kp2keXJ11jKH3Q
        7nxTfMdRjDYJPwu4B5qAg+9NLZ7nkeBF66n3xqUjUQ==
X-Google-Smtp-Source: APXvYqzOzXgdeSQVgSf9kLzt0i4X7zq/IAui/xbA19dL2mqaDyMKXqlZxSWIOxqGgWPIu98YV+rApuKUS0h7iLhMs2E=
X-Received: by 2002:a24:cd01:: with SMTP id l1mr27414897itg.150.1555425262124;
 Tue, 16 Apr 2019 07:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org> <1555065186-8154-5-git-send-email-pgreco@centosproject.org>
In-Reply-To: <1555065186-8154-5-git-send-email-pgreco@centosproject.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 16 Apr 2019 20:04:11 +0530
Message-ID: <CAMty3ZCQiSgRMhxEpykcA-6RnDgBdjMVtXEw0XLYM2cqgtU=bQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 4/6] ARM: dts: sun8i: v40:
 bananapi-m2-berry: Enable AHCI
To:     =?UTF-8?Q?Pablo_Sebasti=C3=A1n_Greco?= <pgreco@centosproject.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 4:03 PM Pablo Greco <pgreco@centosproject.org> wrote:
>
> Just like the Bananapi M2 Ultra, enable the ahci controller and
> the two regulators needed to activate it.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
