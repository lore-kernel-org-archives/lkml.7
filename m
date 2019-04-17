Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE202173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odKzzrxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbfDQOqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:46:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33007 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbfDQOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:46:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so20438332ede.0;
        Wed, 17 Apr 2019 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf4zNrzh2HkCHcZSsf9zz0Z1oL3V3Ad5eDuXP2p14ic=;
        b=odKzzrxnQ9EYWq6uD+DQnFOpPcurA3nck/SXHUSMYUJez3Y0KpPhsx2XNKlAaUEJYL
         WJwIHMBIq7GmzNs6cIHEfQUR4Zx97jNe9f5NgaGEBD0PoeLF4FeHbWyafZOvU/t5wkEv
         h0O/UosinViUOzAFrA3zPyaQokySQhmDoy5e8tmAWF3/xa17HddL2nD7x6uXIXnnO+J9
         PDtWhmHKD0Yo3Og7BZytiFzMHkwkfs6qzjgrHWUM+K8REQOUOejNa2/4SM0MGbKGqKfO
         sqorVInZJnSv/IEpkZ+xVPOrB6gm0RJPULyS5eoxNAaQs9A81xBcKlVCH7Vc/K2BK4G5
         DzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf4zNrzh2HkCHcZSsf9zz0Z1oL3V3Ad5eDuXP2p14ic=;
        b=ktheEa3RdqCHYuaiy4pxLqKY5Pkk17kNOSBecv1BZXuf0Ly+ZcyGgsq3We3ttF4zAp
         QGj6B9YBVd3VymrU64y4RTPHmDu7Pi7j9/dBlvLyoWHm6hOjLdL8ROkJ55xgAKLL03V1
         kp2iNHTpb49cgxrnPT8ELiwetW77YJEvB0lVC9F7Mm2R7xnq22zniQdyOVW4kYZ0MNxZ
         qLHRX/l2i4k2h6Hl725YAKJ3D/+pVwi0aQIW6hJ14Op2ghMU0Up9MO9STL/a1R09kypE
         87vGA+7CjQxnR7HZPiSCRvR/dgV08riRDMH8QmABDNeQWzNtmWJrhPWmp9nsWwwQfB0L
         zRYw==
X-Gm-Message-State: APjAAAVVMS+V2KMggzWQgSUfC0sNuo0LQXhuCgNY68FuzBa3fdvJs+M+
        OfUHnPndkZks1SJVJHPZnzCgbL9+E7yttwu/R6g=
X-Google-Smtp-Source: APXvYqwyeoDTEjC2wXAuDiIUTxh8+7P42PyGOb8MRlQq4tyvB0KSytD27BMLneDt/lyd0wL12hTNBDxaMwPGGGyrKk8=
X-Received: by 2002:aa7:d391:: with SMTP id x17mr71392edq.287.1555512400978;
 Wed, 17 Apr 2019 07:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190416203620.539628-1-arnd@arndb.de>
In-Reply-To: <20190416203620.539628-1-arnd@arndb.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 17 Apr 2019 10:46:05 -0400
Message-ID: <CAF=yD-K89Z2ea_iakjfP98GnfU-yXts8LU4GW3Rr_etJ+r92pw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Andrew Hendry <andrew.hendry@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
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
> Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: reworked to not break sparc64 support

From the discussion of v1 I thought you planned to unconditionally
call sock_gettstamp() for all protocols, avoiding the need to plumb in
all these new callbacks?

That is more concise, though this closer to the existing behavior. So,
fine either way.
