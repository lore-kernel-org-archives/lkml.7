Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D62217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="rF/c4EZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfEXCKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:10:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbfEXCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:10:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so2121021pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r8aR7hYQG+ubgZWmIyHO8z2MgnIQ/QsQT2Ue4fje7os=;
        b=rF/c4EZ8c3QOZMdL+RJCZhR79P0PB+UO/3P9pS47gYj6fG0TNXB9sIyNUYrxLSYbbE
         Vqf74VN+TN/R1V5tWM0jX3W/4fJOy37GCogiOKVydMill6Qotfiut3jywy58ReSv0Yl6
         tdn8gTiMRDrMoStFUJM6JGjBCgY43E9vrv62o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r8aR7hYQG+ubgZWmIyHO8z2MgnIQ/QsQT2Ue4fje7os=;
        b=Aq4pmXLP3lUe23hHbHQpwm+pd2Pi3XnNobjqDDQpMiFH0c9mrBV1U2+ZvI/TBufhEW
         SZGd5NQ/O+kLlpFpCmUz1R3YVdCfr9v7rdu3HGLO3GTTxz/fIRNxmwyBVPvtFCjevQK4
         19pgKNGI8mGZwzzKiFEm9/+D0nLHy69tD5q89La9g7HwRol/W5zMW8HYf/sS+AGCKOPS
         Cb7fHgH0AyLpu5nJ8hAiRkWDNZzEGDdoxb0pqAJYFmwRShKOP1gjb7DSHA1GWfKUVf9s
         fupUVdjDdk+4TznSkgtuGNqDZzki5sUiDotwbhUGDxkTZ45P+zSnteJmPkYdat9ajUNf
         D3Pg==
X-Gm-Message-State: APjAAAUAduivXRNEreUfQv+cFCYmtQ2SVLV+X2vLpEfYd99qlhXvl0La
        uEWPIIKmgSs9mmuTbUgL8LoBPw==
X-Google-Smtp-Source: APXvYqzpLMGgRoPIpMdu2vTVvILTyJ/GmRZUoOY2DKkOgL3PRqdmfMmZtuVofLdgdW3OqFBzbbJFUA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr102378028pgl.103.1558663807475;
        Thu, 23 May 2019 19:10:07 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id m11sm537865pjv.21.2019.05.23.19.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:10:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 2/4] net/udpgso_bench_tx: options to exercise TX CMSG
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-JBf6k7VLa6FQowuD5xDFbq5cB4ScTi7kb1hieQFDKnbg@mail.gmail.com>
Date:   Thu, 23 May 2019 19:10:05 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5061E2A7-EF7A-4C3C-9819-34AA8DE2CD0F@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-3-fklassen@appneta.com>
 <CAF=yD-JBf6k7VLa6FQowuD5xDFbq5cB4ScTi7kb1hieQFDKnbg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> To ensure that we do not regress, when adding options, please consider
> (just a general suggestion, not a strong request for this patch set)
> updating the kselftest to run a variant of the test with the new code
> coverage. In this case, make the code pass/fail instead of only user
> interpretable and add variants to udpgso.sh.

I had a look at how kselftest works, and I absolutely want to see this
work with these changes. I=E2=80=99ll investigate and implement in v2 =
patch.

I will most likely do a 5 second test. This seems to be sufficient to =
get
meaningful results

> can use more precise CMSG_SPACE based on worst case expectations, like
> in udp_sendmmsg
>=20
>> +       char buf[1500];
>=20
> no need for payload
>=20
>> +static void flush_errqueue(int fd)
>> +{
>> +       if (cfg_poll) {
>> +               struct pollfd fds =3D { 0 };
>> +               int ret;
>> +
>> +               fds.fd =3D fd;
>> +               fds.events =3D POLLERR;
>=20
> no need to pass POLLERR, it is always returned in revents.

