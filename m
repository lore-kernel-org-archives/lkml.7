Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD688C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A684D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AbQa4d1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfETRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:52:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39780 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfETRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:52:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id v2so10670077oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLlY3qA7vJB5pB/85supzcun/5fE7fwwy8teM59jstk=;
        b=AbQa4d1keqd/BDD7x+wNAp7tmtUjC9bTqCW4WRudeyF15W9elUiBJ4chChiuhZE/Rw
         LRGi5hAY3QteLppe2OwPYbtx8KEulzBqeVNhlxiJ2dozNJg8Wo95y/q37wWHGQhfASfV
         qb3Yg+46JYqq2oTHtt08qKjFz0PyHjG4iWux11r4C32ER0+tRazSJp2FKBtAePl6h+c9
         ObHWWXcoPFPUpu57FHOacEYoGA71+Q0Jd0dSvNP5HeWyLjmsXHdCqqdA6zZ7xb2SmBm0
         gTz9ZDbUYAbJrvtqCoqg4TKnOgzjTqIQHgtNYakEPVgEl6iF6hyPus2gO45bDO9jSBsa
         lbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLlY3qA7vJB5pB/85supzcun/5fE7fwwy8teM59jstk=;
        b=pXsZ+tJbOvowZtHLamJi1TWR8f5WsE5w1q4nRL5Pt5mAeew5xuuOncJ33F7ZcXSvhl
         j15dRonOy3RkORqCwKg3hcfNp18SATRmcttKcqdSeXKRt0mGK4rlcVAD+4se2pvN+nYJ
         iL7G9GjMIO1gCUcsMysDqrDoa+f1EYsAp3Rj4qL6mp2/sNSR+zBo7B92Oxv9AiLQAl76
         spDlAa2RnHmYIW7jVthNriPJkRW8YCEw2gKMP0wXBZf651+phE98TmHnDVofo7R2bFRD
         ZFBbHTWecRngx822h2woxOHqbnPrxluxrPlIb4CTRuTQfW1za7Hrraxd4Rx7UGc8uDzF
         2S3g==
X-Gm-Message-State: APjAAAU7Va8iLmWz5mHzNt8Srxlp5MWcUtnKnmbzVhBmM1lK6AsCc2RR
        tV5npRFS4RRV6+4oMbjuB+NXo4UVJ0yCoMaMS40=
X-Google-Smtp-Source: APXvYqxiFXL690TZO93hoIiMXPwRHNWOJXmMa25xFpK2VvQFxaqq4LCf1V6YJFp9f3Jq88uc83lFjBYQHfTH/0m7wVY=
X-Received: by 2002:aca:4341:: with SMTP id q62mr304351oia.140.1558374720213;
 Mon, 20 May 2019 10:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-2-narmstrong@baylibre.com>
In-Reply-To: <20190520134817.25435-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:51:49 +0200
Message-ID: <CAFBinCA+G6f8pq8zPwzq6rkNmyS6U=7fL5HWnObvWDWCB893iQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: meson: g12a: add drive-strength hdmi ddc pins
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> With the default boot settings, the DDC drive strength is too weak,
> set the driver-strengh to 4mA to avoid errors on the DDC line.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Amlogic's vendor kernel (from buildroot-openlinux-A113-201901) does the same so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
