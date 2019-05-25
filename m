Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771CC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C36520815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="f6PCNT+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEYUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 16:09:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfEYUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 16:09:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so7303451pfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RgPCIfxuZ555TvIgZetIb3MKb+1IZVq/PG/zzoybCLw=;
        b=f6PCNT+KbyNH9XDsMP4I2Lzq7C2iqzb4jUh+UEFRfZLxBiSOvtaVfcEUip+0sl2VlV
         MEKJxQJIDUUTest+T7tuD6gxJlkp2mHdH5SVG1g3PY/WMu6EvhNKkPrDVzz0R1kCqHt0
         WUA1fwMvRztMYvYTUMoSLwwhNLtZwHNB52EUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RgPCIfxuZ555TvIgZetIb3MKb+1IZVq/PG/zzoybCLw=;
        b=E15Gil32+UmOZMKTw6dlioM5e468DDp8xlSf/1VQOOJGvbO3ieKIq+iq+KId1PqpJ2
         8SAbOn6zswgB0+nsrt/1kj+UyEXZ5W4yHqzibjJPRczSH1hCqhto07BIvwmxfA7EOfEH
         UsQ5X5AaZO8xRkni5WMPd5EjnH0BOG58HoKWqN5wDKDu9/7un1Xw7SKDjo43P/YpSliV
         5Drh7z949NgKx9ufn9tswPADORV2ssQYW/5pLzaQY8oylJqDHbZ7gGPJ/Ne39lY6RUIJ
         ycGyuPSBNHdwesud8DlN4BIA2a0+1sAcY4OxNLApThN280KktWlM2ogSbip47Sw6ykk7
         d3Eg==
X-Gm-Message-State: APjAAAXeWdPxhiJfavWOAfJ3WtmePdLmZwVeEkF5vN6+v+8hQptzjDmP
        zwXDQtahSY6fFmdKNjleQAJFbw==
X-Google-Smtp-Source: APXvYqySEgcKPmmo4fwPbOtEf9K0ORowxlH1vXJoq79O2o2u9E7lsGoEKiUWAO4Ma4jKRCgVmaOFLQ==
X-Received: by 2002:aa7:93a7:: with SMTP id x7mr123334287pff.196.1558814976191;
        Sat, 25 May 2019 13:09:36 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id 206sm5235555pfy.90.2019.05.25.13.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 13:09:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-+4g-HjmCnDWaVfdsyruePXqYeUDJgnffz9ro+rgNGv1g@mail.gmail.com>
Date:   Sat, 25 May 2019 13:09:33 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D37889F4-104C-4E9A-B5CB-A0FCCEFF2D93@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-+4g-HjmCnDWaVfdsyruePXqYeUDJgnffz9ro+rgNGv1g@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2019, at 2:59 PM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
> what exactly is the issue with IP_TOS?
>=20
> If I understand correctly, the issue here is that the new 'P' option
> that polls on the error queue times out. This is unrelated to
> specifying TOS bits? Without zerocopy or timestamps, no message is
> expected on the error queue.

I was not able to get to the root cause, but I noticed that IP_TOS
CMSG was lost until I applied this fix. I also found it confusing as to
why that may be the case.=
