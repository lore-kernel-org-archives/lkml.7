Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBDFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFFB21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F7rY2woN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393065AbfISVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:42:54 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35268 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbfISVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:42:53 -0400
Received: by mail-ed1-f54.google.com with SMTP id v8so4558445eds.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPXt1oW5DrO8Oz/+ZgQWbhpdLKiDcFjVs0zf8G0Ey+0=;
        b=F7rY2woNh5IcAn5OYZoXJ8RCbJxd2yqyiH4M8f85UZWHRWoLW8sjxdFct2ymo6ZVkB
         dVMXB2tC3uNyvgUUwJpyEiyqOMCXqRWH+hjIvcN+KTmU8ILI1vlk47akitpXVlldhj5e
         orWDGJNZiJu9frflXNbP/9bBuZWkaRCZZLtD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPXt1oW5DrO8Oz/+ZgQWbhpdLKiDcFjVs0zf8G0Ey+0=;
        b=HhwO8+JFqu5sVNjbLQE5crWRmJP9QrztQSP23B3WolooPLLSQ+WCD6Z9sJGkHus15m
         gL/LyQMa0ykw++9z2do2cBNY1tP7K1cJ4YVfrgwJB2thqtcQTV9WXQ3q+tsLjL65+p+G
         Bd9Adds2nFNNWsN5JXtLeGstyqoJ6etH1TVRrbl8XHoXoQR+IWGb9fLgCRo1hs/0sZ8D
         a4/yJf73mGKizOAVxvMl+TedHGYJUNHvXwa98ZGj6g/KRLACSGvidKayCTKEqBUSCtnI
         6h2Np2L0Mw6h+zZL3a5wF6mItmGuVVbSM357beHHY0bF9OQiUqpF8sQ1FyUcC8mubI2+
         b7hw==
X-Gm-Message-State: APjAAAUkZLBncLJYd3lcVb5qNAdiigr97+1Kyab3jaunRfaLgEG0S8BH
        JiKDGK17k9zSSR+f+ah80d9eW4HOGm8=
X-Google-Smtp-Source: APXvYqy6EQAjNuGX+iZsGLBbcJBK563/50zH26MkBKyS1k5Jriv0s5whNKkRkVQr7Yp4aRfQ4Bse/Q==
X-Received: by 2002:a17:906:244a:: with SMTP id a10mr8847873ejb.137.1568929371638;
        Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id n12sm1827836edi.1.2019.09.19.14.42.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q17so4646227wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
X-Received: by 2002:a5d:4689:: with SMTP id u9mr8650228wrq.78.1568929370634;
 Thu, 19 Sep 2019 14:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164625.236978-1-rrangel@chromium.org>
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 19 Sep 2019 15:42:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DjvU8iqG=-UTjQgb7m-ayBhoAtRP_mXY4WmjWs_kqZKQ@mail.gmail.com>
Message-ID: <CAHQZ30DjvU8iqG=-UTjQgb7m-ayBhoAtRP_mXY4WmjWs_kqZKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinging the patch set to make sure it's not forgotten :)

Thanks
