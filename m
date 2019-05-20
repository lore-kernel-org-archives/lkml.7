Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A67C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B583520851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HueEfz4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfETGOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:14:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43675 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfETGOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:14:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so9092947oie.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 23:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CV65XuoVfWbORLC3QwcYmvS9+lxjCJ2sZGYpo27bAno=;
        b=HueEfz4Z/zw++PW9pR3nsrU/CWPyaFlVR6fCdgfSxL5+jcK7lO95ZWKdm/C4QVxD6v
         EJue1bc7GmXSymsaCMYnpK1tCUeYboF6ZLhqGFkCJZBFTroUWnBy3p5CWA33wDjOOmx5
         6KlUrmx80lOh+8cToVCypfVoWu4CK6Yuz5zC/CNhedkRNAQBAgHEefETQ9EuKml6dKgA
         mB9k7zFhXgCgstTbbkOS5iZgu4HZ9zTune/mPZ1jMBoNFafEzOLHMfUL10uzQgDdniFi
         ZsOgtE6VHc84rjwzkj5z5G0vbnmxxARGKthtWQf4Iveb46/QShcHDVloXo54eqIF+9fh
         XLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CV65XuoVfWbORLC3QwcYmvS9+lxjCJ2sZGYpo27bAno=;
        b=rjuX1ryuRJLuJnzzYmQAIK22RXfc0hxD/k+EOQGAq6LgefDrwAyC7kprqnlUmgc+UY
         8G+1ajWggkr2qojoiPcuhb5Elg2uQ+NeOutr1WN0wumEyN1Vo+Zjr00Ivi7KM3st3Znm
         VtVczLqFjtzz4LN4B3hWFEEpIP626JMxXDvyY4WjJ9uFUnZqLa6iygHzznUxhN26h7CW
         dfCQK0HEQaD4+TQ9m6dgQQIsAunw0TZWcT90wWblj+v0fffU6OJaklFvqrx7vH8rM7kq
         MiwwvKlZelwNYr7cLGVbRjvk8Oy+u5nhk7yEZpIkSPSdeYu8dwQF/aKhQXGwirrJYUay
         TuFQ==
X-Gm-Message-State: APjAAAXwNDIsS1RWO+8LU5Guri4YtUiJgeEWQ6rd1lpDOYMqj3KNRSaj
        R2RSI/5Kdmg33CEZcPepNmng1iXdndbRTyY5c4UtWI5g
X-Google-Smtp-Source: APXvYqxbOWPOYc25RZ36r6MymGsjn39y3QN/YIPqJ/vvjkpawijs2NHIawt73y9OXcjn81v92e3BJacv4Ascn8W1fUA=
X-Received: by 2002:aca:5704:: with SMTP id l4mr21921526oib.21.1558332873902;
 Sun, 19 May 2019 23:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190519204012.31861-1-brgl@bgdev.pl> <20190519204012.31861-2-brgl@bgdev.pl>
 <20190519205235.GA19630@kunai>
In-Reply-To: <20190519205235.GA19630@kunai>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 20 May 2019 08:14:23 +0200
Message-ID: <CAMpxmJW=T_hZAkyhsE+Wi7qhJBE2bviNfaGCJJta0s8g85+9Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 19 maj 2019 o 22:52 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a=
):
>
>
> > Now that it's upstream, use the resource managed version
> > of i2c_new_dummy().
>
> That was fast :)
>
> > -     dummy_client =3D i2c_new_dummy(base_client->adapter,
> > -                                  base_client->addr + index);
> > +     dummy_client =3D devm_i2c_new_dummy_device(dev, base_client->adap=
ter,
> > +                                              base_client->addr + inde=
x);
> >       if (!dummy_client) {
>
> Oh well, the confusion starts already :/ devm_i2c_new_dummy_device()
> returns an ERR_PTR.
>

Ugh, sorry for that, especially since I followed the discussion on
that series. :(

I should not be sending out patches late on Sundays I guess.

Bart
