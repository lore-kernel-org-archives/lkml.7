Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81552C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579F62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iweD1MXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406677AbfIWIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:35:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405465AbfIWIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:35:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so12841058wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DonLaU+ALkUO4XcKRBTGh6tkB6YDwuQS1LIpYKsRKI0=;
        b=iweD1MXsqfvUS94mRK6CuoKUGcj8JkfPP+1CofV6Ctqi9Zgrez1OViiWsNU4+5c9b3
         1v+Wlc6urwR5u48jExvDWPNV+b3xTmp577z0x9kdXFBVyFQUebSuMf8E1et5vWygC0wh
         BGMI+Q+gK2RunsyXNXM/I2ECIP6ap5PQQ7tlDaI6PWhk+9y+/59I2ld9Hl5Ce53t0s5n
         WMnZyjd6MyeGecXc+z8N8DfSowIX3WoHhi+euxfLNBkWSNJdv+aX7jtMW49/86y3zCOg
         XrPPRlfpPeHWL/GRo/wLm827Cc9vJJJ0CxfzJN1eBxB8tUI1uGbW6TfE5JcNWgejWrbv
         JIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DonLaU+ALkUO4XcKRBTGh6tkB6YDwuQS1LIpYKsRKI0=;
        b=aIJ9Pd/n1mg3M7B+2gbXoXc9hquem52CrdIPUIeSQr4SY+QkGqG4Pu8g45mFZ0dH53
         YOLAq0DHB/iQ9x/CUU0UKcazsk1jEBNvtnRBsHGHMxUJkSjwA/f+2clvUcxBH3ASp8JG
         8lTzblkGtLHXFqaiAGbBlj47U8mqZ3r8qnnuSHXNbQ0/L4jkjesrXoTb+nqUnW5DJyo2
         AdRNt3s52P77+fJ5gK7vQoc2IJwPozcon+WoWu4CmOKn5ZVzy64y3CvHcKYnWfVF65M7
         ubtRfbngC6RbWxe2qndzPLo7EpvTnUZ1Oq+PxTY3ej2wTq9kHV2IjgUwv3aV94AwwQ0g
         yq/g==
X-Gm-Message-State: APjAAAWHJGDs/jp5QWBFy+NUJvMvJ9LcE9ai+GEq0DBTZx7aKblVC66W
        HUv47HN6WvpkYxI6jBnSfezUDw==
X-Google-Smtp-Source: APXvYqxJcD4Iva8LjauXdRv7MdXdwAKMDkOV0VwKKJWiJJiS8vUfgnWZhmg47YeFRhHeSnOuDhR7JQ==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr20173795wrs.24.1569227737278;
        Mon, 23 Sep 2019 01:35:37 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r6sm9279229wmh.38.2019.09.23.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:35:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.3 034/203] ASoC: meson: g12a-tohdmitx: override codec2codec params
In-Reply-To: <20190922184350.30563-34-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org> <20190922184350.30563-34-sashal@kernel.org>
Date:   Mon, 23 Sep 2019 10:35:35 +0200
Message-ID: <1j7e5ztnoo.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22 Sep 2019 at 14:41, Sasha Levin <sashal@kernel.org> wrote:

> From: Jerome Brunet <jbrunet@baylibre.com>
>
> [ Upstream commit 2c4956bc1e9062e5e3c5ea7612294f24e6d4fbdd ]
>
> So far, forwarding the hw_params of the input to output relied on the
> .hw_params() callback of the cpu side of the codec2codec link to be called
> first. This is a bit weak.
>
> Instead, override the stream params of the codec2codec to link to set it up
> correctly.

Hi Sasha

This change depends on the following series in ASoC:
https://lore.kernel.org/r/20190725165949.29699-1-jbrunet@baylibre.com
which has also been merged in this merge window.

With this change, things are done (IMO) in a better way but there was no
known issue before that.

I don't think it is worth backporting the mentioned ASoC series to
5.3. I would suggest to just drop this change from stable.

Regards
Jerome

>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Link: https://lore.kernel.org/r/20190729080139.32068-1-jbrunet@baylibre.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
