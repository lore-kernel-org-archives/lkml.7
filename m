Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7562082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfUGXorS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfC1QiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:38:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44091 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfC1QiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:38:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so13772488ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rqi6tVc28O6Pn3Hdb1FJNM2EnhUMeHMWDyOPTJWIc4=;
        b=GfUGXorS2wGNUIm6FTOUXfiNan6LFH3in17f5azB5ecQs7LeHsikjP8sQk/5HrZWO+
         ZcykMVny3rR8BKEVtkIUoX4mopseCTzGnkCEFTXlBE7oNFj1ohh6VnIBjf3MHX9oAv0B
         fAg95ysge301stFhci7vpQ8j0RVmrz6vIX4glFYPw6PrfHj6rvNfZ4jUqjA6vYAnn4Or
         3u6KHQ2OhfkG/AJSQsx4rqtA3AtPuCFPizeKap9vezI+FnEB4QfH+JujO0I6QfzAERG0
         XdIRoOlRd2L48nHKlhy4/TFTgdrivVg8xsFXp3clKExNNJU4u/cBwJTmRMK9sPuby15t
         YVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rqi6tVc28O6Pn3Hdb1FJNM2EnhUMeHMWDyOPTJWIc4=;
        b=Xza6/bZvsUXhKG8wKRjiL2BdHvjmaWCRZlCbeXAf7y67ZnnhDHPHE8AyQIxdrWNzO1
         2nyIg7ptjOzw22SVgFO8ff7cbPbySiXUIi4y0sxQU0c7EWEt5lzHdVKJyciRfCzMkcaF
         gtogInkO38YNf4JiwrWW4//mMuKc6IQM45l+N6fwyIQvb/Vq7CCWAfNVeIcJjUtdLjN8
         EB/pdvz1qtyXZuN2GQQKeVN29vw04EpHnJBnR7ABxNcs4ItvVxEmbshTLbWRncubZJO4
         +Ga831VsnYKq+dNhPQs6f4XmjBr4mWbHkPebNsV0B0/G0I0KvAsGQvzXRo4JWi/zz1LG
         iw7Q==
X-Gm-Message-State: APjAAAXvivgUzHd9gf3ku6fedCDMxGQW8Pp0wX/onlz70ZuvRyGzTf2p
        GZNDD/M7VPBEtmLryZqLVIbZL3caf/6Zao7D1pY+0w==
X-Google-Smtp-Source: APXvYqzHXpgetN9759nShtPoP7zUixXNg61bL0q4Y8AGhQ4fULR6J6jdlItYKFcxhmHP1mwzJX+bs575yh1Q18/E1no=
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr1498402lja.107.1553791082299;
 Thu, 28 Mar 2019 09:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190322173052.23763-1-brgl@bgdev.pl>
In-Reply-To: <20190322173052.23763-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:37:50 +0100
Message-ID: <CACRpkdbw7zvYx1s742HmYj8E=J0=SygEgBHVDyQ5c84N70V3fA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix debugfs read
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 6:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The debugfs read callback must advance ppos or users using read() on
> the file descriptor will never get the EOL. This wasn't spotted before
> as I was using busybox cat for testing which uses sendfile() internally
> and only noticed it now when switched to cat from coreutils.
>
> Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied for fixes.
Sorry for slow application, I was in no-wifi-land for some days.

Yours,
Linus Walleij
