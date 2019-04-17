Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB2C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B07F2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvOAB7yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfDQV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:57:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38277 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:57:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id d13so105808edr.5;
        Wed, 17 Apr 2019 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBpTCXhk2LilYeHlTZ3sbhr04hptB1DMCc+g6ITMMFk=;
        b=WvOAB7yp0DjrGk7XtpK+Eg3nRcid8g/E3xiHzSOhiM3mRCvK5eRRFosPpRH57vE5ji
         xedtLDefaNvxYJRu+PV5moJVt7WLEpOHF9E9vxaf7g1toqmcXeEtYX3r7/G2Yr6hCsTJ
         mWAamB+V/TGRgGbianHw5tY7hUCokegEEKhqoHV3mRrnpMkvSsAfvt+V3KBu1ifwi9vg
         OJdHGZ+S2bHs5DcmPAR3keOObdHwo3aQkZDkPkvGVhxBYMjB0rwyWsQ2JL1+6bzQlln4
         o8k1dfesvVNghv4Oi8jEr85OfwnGQuT2UuTECuG0TIgKnYY37c+Ml8XQ8Jty0AKBfvoS
         oxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBpTCXhk2LilYeHlTZ3sbhr04hptB1DMCc+g6ITMMFk=;
        b=Qnqx93mBQbd95/rZtEwZYMKuHBF6ZwqkVLKg2x/8lfRgSTVjWkNsyHxZiIbKBBESMu
         Sj48WdnczIKvlM8yJ0f567dTAIevLC6Nqwfdh9Qejid3r/6/e0xXbpK9xz/M19XD01Iw
         7+tqSR8J4xeYoK6bBWAOCH/jYvnpbKWkH/Q7XqERBfjxQD4nIksqTUPItgkwzAsN/hwX
         dJno7M3N1LPYj3mV29GGHAxhZcB9R8ENR7L0QEtgi9R5X1j2I9UH1uaA3Tr8+N0GHouC
         SWlHMs67K0C19ij5k/Jf+zhjRjs9jE+zdwZMhx+jkQYSSSFbQZ1DQKer+75oZbuL8Bhb
         KrMw==
X-Gm-Message-State: APjAAAUqX7m/iaOC8Cb8GmQKy2cmnjSRRPxZeS5CncwPEN2Y0uizDTvp
        0VzYRhyEAsICEKgDlTUhUoAg2lap6ylczL8Pu4A=
X-Google-Smtp-Source: APXvYqwI3NnUKUeOA/BBQSxy7VT4L/FG+couvBb+WgOg+NOG4hGAgFhyPD87nX9HtwNs+Dog5QulkMhsORP86V+tRos=
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr24053195ejb.202.1555538239455;
 Wed, 17 Apr 2019 14:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190417205404.1877560-1-arnd@arndb.de>
In-Reply-To: <20190417205404.1877560-1-arnd@arndb.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 17 Apr 2019 17:56:43 -0400
Message-ID: <CAF=yD-KkUveFFj_j721kML0rMJF=uDcVQv+RQO4N6xjorHCtZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> socket protocol handlers, and all of those end up calling the same
> sock_get_timestamp()/sock_get_timestampns() helper functions, which
> results in a lot of duplicate code.
>
> With the introduction of 64-bit time_t on 32-bit architectures, this
> gets worse, as we then need four different ioctl commands in each
> socket protocol implementation.
>
> To simplify that, let's add a new .gettstamp() operation in
> struct proto_ops, and move ioctl implementation into the common
> sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> through.
>
> We can reuse the sock_get_timestamp() implementation, but generalize
> it so it can deal with both native and compat mode, as well as
> timeval and timespec structures.
>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Willem de Bruijn <willemb@google.com>
