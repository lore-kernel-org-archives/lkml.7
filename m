Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A734CC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A321743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aPBwkLHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGQQme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:42:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:42:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so11113687pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=1AorsIxKukv4QHmBEQpBYg3oWB5yXI20Vjy+qfW9lkc=;
        b=aPBwkLHRyP3zBfKz3S3KZH+l1+ZuRHEihIf2pUKXtkCweo+Ivk/jGG+X/fvdZIAoSM
         ZVu2DoZFhluTMuDDK3FJB7NZs0E5xyrn51mWlvLtQgjKe6f7kE46St5/G8CznBdRPtnz
         2XTizW1TMIpWX99cp06TCUJwuHnGHkuegzNLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=1AorsIxKukv4QHmBEQpBYg3oWB5yXI20Vjy+qfW9lkc=;
        b=N+2om2oaJLpc6bgSjXkJPMe1TEuFB3fJ+eaqcTGRLQX5N7mINj8lj6rM/+oIVhnR0I
         Lit8zYZbcqFjQ0e+y9NN8h0zBl5kqOzpekMqR6h2Hl8zjlfyFCmGirPsT4/WEWc78oxa
         QLFsqiNSDWrZKE3Y28RWlvvMqmcYpN9qvMgr0GbkjZclhishMaqkm+CBPLS6f4EYewXw
         n48bS3l1PJd1h0ZylDRXPeglR+FHchDqdN/71zJRa0CeHnA0rFdky7nwC4qUCUHaKL03
         YMOOsyGw7xKwjxQqrly0nUBD5rLyar0M4S2b/YMl7i1WYg/YRexHDp7CdK36eH0PIYyd
         5CzQ==
X-Gm-Message-State: APjAAAU9aeqrcI9L73Xj8tKUMP3y/+FVWIiwNNIJOVBaKMq+lQFVRrCA
        BMtrRele9CtIRp9EVNw8ckcIuA==
X-Google-Smtp-Source: APXvYqxZuX+kytE+ZiGzvIKhMhXtYWj9yk9FEuNeG1kHCHbkJhLViY62UlNKE2ks3nGqJgwjpLalwQ==
X-Received: by 2002:a63:d950:: with SMTP id e16mr44043545pgj.271.1563381753703;
        Wed, 17 Jul 2019 09:42:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a20sm20571581pjo.0.2019.07.17.09.42.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:42:33 -0700 (PDT)
Message-ID: <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717113956.GA12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190717113956.GA12119@ziepe.ca>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 09:42:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 04:39:56)
> On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > The hwrng_fill() function can run while devices are suspending and
> > resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> > is suspended, the hwrng may hang the bus while attempting to add some
> > randomness. It's been observed on ChromeOS devices with suspend-to-idle
> > (s2idle) and an i2c based hwrng that this kthread may run and ask the
> > hwrng device for randomness before the i2c bus has been resumed.
>=20
> You mean the TPM here right?

In my case yes, but in general it isn't the TPM.

>=20
> Should we be more careful in the TPM code to check if the TPM is
> suspended before trying to use it, rather than muck up callers?
>=20

Given that it's not just a TPM issue I don't see how checking in the TPM
is going to fix this problem. It's better to not try to get random bytes
from the hwrng when the device could be suspended.

