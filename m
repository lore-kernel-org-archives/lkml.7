Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E326020828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kLp8KxAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCRTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:40:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42314 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:40:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so171418otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8hj4bj40boJqs14HMvyewd4IxHw+UYjCmIjnYphp68=;
        b=kLp8KxAqOHuve7Rfx0qQKCwS3CbQ3tpJ0EyJsKTwUAGnm6dSsxtJCUmTbm3HX0wf9p
         UTyTbiVc2ZIoHakxEWhnAAiLBFZuNSTTc0AUtV1aLXThEl9rMiE9pelA5egG6zjvDzoP
         jnfndxctSamqdrNJ8hSggOC8eDVM//HWhO8kjcNq7ZiQKBnAxFsPGyy3EDlHFVdqnmPN
         6S8YGfzkdamhG4OqG7YboLFvwM5DXlYaYLZwkbOrzdIkoe+WEebPscB7WkHvMRP+etwh
         4RBUctr80F06H26xJmmaJZAv/rCUfBbOLZDIkPMjGsBfdv4J3jgfuJinWtlRM4WDXzit
         soiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8hj4bj40boJqs14HMvyewd4IxHw+UYjCmIjnYphp68=;
        b=tpfTCc+X6DBcSMdJM5pbvl0pUFRyNUVERWOcAeW+/TwiK+GA4+edrXq5n/x8JQ4tJ3
         wdHZscwE7K83dame01YNo4EFjntrDPGzveNemydo1dGADBtpHp/ZrVi+WyXEYGmF8qAs
         8YkqC6LVasBP8oK+nuvCVfRpm92hwodnczrxcEPJQYdp+DbsM/y2fcQsKyN75f43vIF/
         5U8GFUYR9NbIr9ECpxDcgVXAU6mU1gh8Zxh0+a7fcszi4nHgKrp37Gku3t0VRkp8Q8oG
         dgtwOal8W5ZY0HaXxGwhcnb2prXr8QSCcJlD4t2hTxaTrCUIAvsUZ3wcoxotaC5nNKoc
         hCGg==
X-Gm-Message-State: APjAAAW6b1ZxX9d1Rp915WQMVBuJZNlurBvMN6FLuHCr4WN2CF78u4oE
        SWvwAqM4TZu3bwCiVF1ncZ6ClNgRYTBN+RjKdWWOFrf+
X-Google-Smtp-Source: APXvYqxSAGO82C4Ly8hXwsZ6CqbqlACNkc4W8O0yDurHNW/09H9fL6VSiz++oUrW7UUXe+OEoKo7M+QHAcf6Tqk5X34=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr11960181oth.308.1552938014643;
 Mon, 18 Mar 2019 12:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190318095851.4062-1-narmstrong@baylibre.com> <20190318095851.4062-8-narmstrong@baylibre.com>
In-Reply-To: <20190318095851.4062-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 20:40:03 +0100
Message-ID: <CAFBinCBiTJ6Z_9Y_58LdiebUSXAhAYE8xn5FvUdDd2MstpfrWQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: meson: g12a: Add G12A USB nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:00 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the nodes for the USB Complex found in the Amlogic
> G12A SoC.
>
> It includes the :
> - 2 USB2 PHYs
> - 1 USB3 + PCIE Combo PHY
> - the USB Glue with it's DWC2 and DWC3 sub-nodes
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
