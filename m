Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6645C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428E20863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554568270;
	bh=jb6yy7bgxI0A4RvAzOVxk5WGblIUqABaej9Gn5NJcCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lhwjiG6ZdnupQUfiloWAfG/SMLf+UBTRo7729aGxuR1KN9gqdnMaHSyfXCqbcGB5R
	 XdQu04Lv1ZSdO1fbGnrVTzmFTqJ9MzOmp+eAuqNCK/zCLvVhGD2pHETp9OsM5UL5Rv
	 OE/xfXcfBzN0D7EPpNusW6xPs8xEaU2/mNGjAmFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDFQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:31:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46102 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 12:31:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so7713837ljk.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/qr5EbXZ6xio3j28Nfm8z9iejPNL/OkZ4onwLqY4AM=;
        b=f19wt0qjwtpCBho2I0CFFiOoNE/JyR5VkqTqpqYghNCndbnpMdf5+9OWsdPtjehljH
         XlwCutXV58SdsQig/9EzXFF4SXJTFyB3hHqKhZdvkKByRgoICZ5AK77/Sv2b2PU9IqrY
         TvRzSO7DRsggHmaH4VWEoaxuBrszeD9vUhMIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/qr5EbXZ6xio3j28Nfm8z9iejPNL/OkZ4onwLqY4AM=;
        b=TJfYurzK7PjgtUUHqzI8SEmbTw/1xk4oVBknuBUyBIdEkTCkS5k0ksYv47OEv1o+IC
         wr3IYJIBd5BhJvbFiWTvvrH1xI/PxBCznyr2CW+3QrSOrrFaDPfIBycMfISluH/CrK5L
         /jtUv2OyNO2DRCpSPeDtIJawFNM1kvxz4s6ZNhUSmH0N/xl4l5kV8NPi3pBh1G3j+D9h
         KBcqzQHxtKuLlUbpRdnEWfeAylG9dZWQ9tRpJjLkilNw53/CpKu1tGw9x5I4HHoxhxhI
         inz8wMDkgpk7eeLnoI5QFUXGMgm6QFrPlSFZvA+lLoZJKHUIwBmZcdeqT7d59eui7J1b
         2qkQ==
X-Gm-Message-State: APjAAAW+s1yD4IH/q6DgmRZYEbqEFxp0APNpSAwEJuX2BHgly+0CeZTU
        3hZjUIWyDoDNXA5bnlCJJaLuj5ypTi0=
X-Google-Smtp-Source: APXvYqw3ooWvRBH7O+Jqjc3BTHJom/e7gY9E8czcEU11XrOK4tGYl5gkZzlpSo6mhoUeSNE+xzGFKA==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr10414219ljk.78.1554568266693;
        Sat, 06 Apr 2019 09:31:06 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u11sm5075255lfi.5.2019.04.06.09.31.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t4so7760400ljc.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr4727540ljh.111.1554568265019;
 Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190405160859.5288-1-hch@lst.de>
In-Reply-To: <20190405160859.5288-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Apr 2019 06:30:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
Message-ID: <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
Subject: Re: [PATCH] block: remove CONFIG_LBDAF
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 6:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Dropping this option removes a somewhat weird non-default config that
> has cause various bugs or compiler warnings when actually used.

I'm ok with this, but let's queue it for 5.2, ok? Jens?

              Linus
