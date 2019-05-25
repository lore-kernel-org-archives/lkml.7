Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA0C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CAC20851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="LVMTPHC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEYUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 16:47:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36852 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEYUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 16:47:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so5520248plr.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XsXZTRyeWuLP6fK4F6hmWWRDqlIpu+fyRzG4Gw4fJtI=;
        b=LVMTPHC1vfnF/E6bbu+1zdXCceZS+5L0Kj75tIu2UUWMsT3K4u6ktGLSgRV0TpFgmF
         QwHGGEOoqB39Fb7KUZucVLUx+j29aZy1V4UCJPw+GVLwytFlZj2hOTDBGoJUJg+LwI5u
         eyzq8IPI4d20mVUNvKrNDqGVJH/kvSB5tYj94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XsXZTRyeWuLP6fK4F6hmWWRDqlIpu+fyRzG4Gw4fJtI=;
        b=uCDB4AciX4yTsft2cwCHnXvoIcJQxzhGVHisIAthf9nbjTWsvJ5PPDneg5aVHlicky
         AxtxTSWdkXsLm3gOIhN6zjhbe+8TleqvhNwPMBhW1bIKR5hgDjCGZaIEgfWHni11A4HV
         8YEUBQXOAbIswkQXEcLqObciaQ88pklo41huOAFzy0+5XjJ2Ly38iyWQrztuo/om5/7m
         wGDoxCipR4DegAof4QhJ9TtosIpSENWeUcF+vlUjJGBJbl13QRejSz3bjF7vddkJZ8eF
         Y41IUaWjmr2ct5lT85LX6u8VGNYcvThplTDATP4ieokzOWAQG3wDaF/8h5ljNTR5jex9
         cQGg==
X-Gm-Message-State: APjAAAU2oHsc9IezZMZ48I0PAslN2tvJYla7clgPD3zjvbyCc0xPECI2
        6K0vpC6uthPYIn5HhQCDV0ZIrw==
X-Google-Smtp-Source: APXvYqw1rCjCeyK7XfWkj/GJIF7Vs7nWGODe+/juQ5iWPQxsPh/lhql/IToSXn005IZ436+zJKgV8g==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr7617984plb.297.1558817270305;
        Sat, 25 May 2019 13:47:50 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id i3sm5393413pju.15.2019.05.25.13.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 13:47:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-+4g-HjmCnDWaVfdsyruePXqYeUDJgnffz9ro+rgNGv1g@mail.gmail.com>
Date:   Sat, 25 May 2019 13:47:47 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B6F9771-011B-4BEC-8454-4D324856DDF6@appneta.com>
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
<willemdebruijn.kernel@gmail.com> wrote:what exactly is the issue with =
IP_TOS?
>=20
> If I understand correctly, the issue here is that the new 'P' option
> that polls on the error queue times out. This is unrelated to
> specifying TOS bits? Without zerocopy or timestamps, no message is
> expected on the error queue.

Please disregard last message. I think I was chasing a non-issue with
TOS bits. I will remove all references to TOS.=
