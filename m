Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B16CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95811217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvWxHBvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKAWrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:47:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727355AbfKAWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572648473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AbnmotS4GX9fzPBPwmbaz4gXNWAgBddj71xKQDFLh8=;
        b=fvWxHBvtLDj7sUcK/owIPp20UIfeG0tSTjP/ts3vIlJhnjG5+bJfKHimXmhx6kKOnO4CLk
        0+WKmYnl8IrlWNVKO1iiG+UBfrmo2t4iEfDKjkcOmJd/tMlCZTGNOXDPM6ahCaupzFK0Se
        iI3fBukuFYJ8Gp9A/i7p7SjhzBefnGI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Zq6Pj0PtME6stIvQrd-B8A-1; Fri, 01 Nov 2019 18:47:52 -0400
Received: by mail-wr1-f71.google.com with SMTP id j17so6174179wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1w2dwPc3mjEgCi5ISKwx4I9slR+xAJYMQCO80tIGzcw=;
        b=Wha0rk3LMD/ZYsIiqv8jJs7jJKpMwDF8GFqBIhX6SxttQkD7AcdSs/zxjB1ZchNiZg
         TXa80D5/JsT6O30mD3ID9MkTyZMJMoa2odrYMpG5/fu4HNUxEaHY+LKvdkkwle+kCSGC
         Ra0AB8xeWVwRKAo9L8zMj9vDXuYzvyai6HhYGxKc6v0FYTeCj5v7BEOEGyuMm/8mjFXZ
         jmBEgqdgE3ggGJFjb43lX26eZL7VirzGa8YS9IglCcivVf903Wy5GLGV0yFb7w1iLDUF
         SksYbUblumwxaZ1M7uK3KiqlJTch2WKrLTxtGxd3zFeCFd9S92AE0jejUKqTuZ6UyXOr
         FJsg==
X-Gm-Message-State: APjAAAVLqJrWH0Frf6xEkRYJCgqbahP76zSj/+qZRBoiXmTrWycMpzXQ
        dp8e3SqbZWEGlKSamKXISsge2fvIwxqIZhYtmG0gLGIl5W88fCgOwiSqpcpc7AXsl3ThCmegF+k
        p77wsWha638OzfiMkTbV6xgKx
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr11715766wmb.97.1572648471201;
        Fri, 01 Nov 2019 15:47:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwN/jcsNi/ctBdMAzUSO/Z1IRdnXDc72udPBZiDioY5UtZhUAZXY1QOnnbQRhBPBL4fgTL/cA==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr11715756wmb.97.1572648471004;
        Fri, 01 Nov 2019 15:47:51 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C68FD.dip0.t-ipconnect.de. [91.12.104.253])
        by smtp.gmail.com with ESMTPSA id v16sm9025494wrc.84.2019.11.01.15.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:47:50 -0700 (PDT)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drivers/base/memory.c: memory subsys init: skip search for missing blocks
Date:   Fri, 1 Nov 2019 23:47:49 +0100
Message-Id: <3B456200-E7A1-454E-A70B-92B4A72743C4@redhat.com>
References: <b72983e6-0560-972a-57c8-9006942ab2a1@linux.vnet.ibm.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com
In-Reply-To: <b72983e6-0560-972a-57c8-9006942ab2a1@linux.vnet.ibm.com>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: Zq6Pj0PtME6stIvQrd-B8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 01.11.2019 um 23:32 schrieb Rick Lindsley <ricklind@linux.vnet.ibm.com=
>:
>=20
> =EF=BB=BFOn 11/1/19 12:00 PM, David Hildenbrand wrote:
>> No, I don't really like that. Can we please speed up the lookup via a ra=
dix tree as noted in the comment of "find_memory_block()".
>=20
> I agree with the general sentiment that a redesign is the correct long te=
rm action - it has been for some time now - but implementing a new storage =
and retrieval method and verifying that it introduces no new problems itsel=
f is non-trivial.  There's a reason it remains a comment.
>=20
> I don't see any issues with the patch itself.   Do we really want to fore=
go the short term, low-hanging, low risk fruit in favor of waiting indefini=
tely for that well-tested long-term solution?

The low hanging fruit for me is to convert it to a simple VM_BUG_ON(). As I=
 said, this should never really happen with current code.

Also, I don=E2=80=98t think adding a radix tree here is rocket science and =
takes indefinitely ;) feel free to prove me wrong.

>=20
> Rick

