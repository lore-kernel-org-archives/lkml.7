Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944EC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DCB2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="thWHGLVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfEYUqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 16:46:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEYUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 16:46:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so2243923pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qo8JrOOZqi12jkLNvRxgMvVScnv0tXvVQTmMYH0OKSE=;
        b=thWHGLVr4cU7dJKLdMWPO72IcwgIUO6hCDtvYPNJxvRmFABU5gDC/mRGcgxLAmjdFO
         Oh0yt+kdymYu11rdgIzECutsKWeYt5hzZggVnh7yjPN3iKgtTUaDX71jipxAXNjnZwdU
         9zm0rBy9oCa+p5uezRtBcDS0eb+z8ywJ1Cy3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qo8JrOOZqi12jkLNvRxgMvVScnv0tXvVQTmMYH0OKSE=;
        b=qLl9Nf9+xBGqMJONxkY4PwSnbzfVNWFu143X+2IGkUu0ymzstj166pfiOSeBGZRqck
         jk8UoloD5xmgH2GDbeH1uZxDU6bbUU1NDEdn9QTue9MgGgvVZNLHhCixu2hfoBnqckTP
         eckiAoGYjA72SXghSSdieDRhoztQg9jf+cFG+cTsNoemRLt8n7tZ/jUtFw4fIB+W6aL1
         oF3Y8dTYo/XhgsGaRf6mt2qY8D//LM8DNBSnIsIDahBQxYPnxGccGMQj5Jd3jEGOrWZh
         4iF+J5Yi1y3dgVQrArS3aZzVKzlbdTmuH2S15FpbzJt9t1+oz++k/1Nj8rsclrlcOWRI
         lPaA==
X-Gm-Message-State: APjAAAVQGKBtcMHKGMRBdxud4pxPddotYten9f337zAQpPQnHfusYsN0
        20lK/UTCAgv21FkghLQRO3vWtQ==
X-Google-Smtp-Source: APXvYqzPaHFWQxMwohp9Yc0Omohint92w9s29CVWXD2wQWQNWaD5UzsOvqltGy2QkyvJLRqj3EN7KA==
X-Received: by 2002:a62:5653:: with SMTP id k80mr121841807pfb.144.1558817168926;
        Sat, 25 May 2019 13:46:08 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id p16sm6510085pff.35.2019.05.25.13.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 13:46:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
Date:   Sat, 25 May 2019 13:46:07 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FB4B2F6-A7F3-4565-8D53-CF0E5A3EEFA4@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2019, at 2:39 PM, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
> Zerocopy notification reference count is managed in skb_segment. That
> should work.
>=20

I=E2=80=99m trying to understand the context of reference counting in =
skb_segment. I assume that
there is an opportunity to optimize the count of outstanding zerocopy =
buffers, but I=20
can=E2=80=99t see it. Please clarify.

