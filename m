Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C0CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6121420862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bth9SGMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbfJ2Nup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:50:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388802AbfJ2Nuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572357043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JexFLIXNziOY/Hp82j+M6Mi54TFENjbZDKoY1+D14r4=;
        b=bth9SGMvqXdA/vWKZSyU4IpVWDYVSQP92k7waestwNnXl5OBHxxAMFCwjkmKnoDAiLy5tf
        GzHWkvp1AIVluZhDMmaiBHbOSfb//XH5rXWwCwugB0JfKTn2x8VvJSAEKuJ2zdSEh9yXLK
        suGKoagl2IriKTJZFB/h+3cSzrRrPqQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-aEpLgleFMjm2j_OX6W--IA-1; Tue, 29 Oct 2019 09:50:38 -0400
Received: by mail-lj1-f200.google.com with SMTP id q185so1868299ljq.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7ErEh4B9TcCeKpNzW2UWWVl8b/qcD3YHSeB/vQRjds=;
        b=CQveCdI7YWVMZAlJvBBg21KEdDspJrhNx3zPLXG5FgxhkocSP4HZcWJx4XQBQIQyu0
         3EAUAP9N9qW9YbYNQ09/QNOk6kAlq6bL1QTBRgn9jfpEYwmBFE9SSn8EzQRTPi5b/uYs
         E9DW+nRdrB/CxFo8Kbjs5uVR7eTwIuQIDeTHqr5NV1ApJL35OfyKsUcBZQf/ud7aawWg
         pTb823BYJaN5b05/TCWSxIjMIsST+h0xhn7rhqFV9Xs4BuxZTPBBFZ6dW95gzSY9zw/C
         8cmxv+YSewjT5a10Oe/rXcDR1t5Jd9EXnwqqSXOB/QljEkJ13PKKYlGWniSOOAD7ntWk
         5D8w==
X-Gm-Message-State: APjAAAW9Fvt2w0DJ1hMIK7hIs7sDR6nhKOiSb1qPa4nVZWI7bp9OODg7
        Buhfoenx+23ad0DiYJpDXcNgovp/w7nFHsOGkK35bpEc1Kkxrs8Q0zC65Pxa5DrYbDms8JOW5M8
        zaJwFagOkJg34Bw+VDglNBuJV5CnENepZOJch8Z8Q
X-Received: by 2002:a19:f811:: with SMTP id a17mr2560871lff.132.1572357037147;
        Tue, 29 Oct 2019 06:50:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyS0UuN7bz4jqf2X5flMLGKB+vIexXwx20Tv6+rGjAW/vVA7aL+e9LoFg4VwxLEI2u8dP1p9NiIJwVVaZmFIpg=
X-Received: by 2002:a19:f811:: with SMTP id a17mr2560865lff.132.1572357036976;
 Tue, 29 Oct 2019 06:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191029134732.67664-1-mcroce@redhat.com>
In-Reply-To: <20191029134732.67664-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 29 Oct 2019 14:50:01 +0100
Message-ID: <CAGnkfhzzjxeS8mTXEf_f=JyH1u0tY2HQn1Hyub+1BVo5_J4DOg@mail.gmail.com>
Subject: Re: [PATCH DRAFT 0/3] mvpp2: page_pool and XDP support
To:     netdev <netdev@vger.kernel.org>
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>
X-MC-Unique: aEpLgleFMjm2j_OX6W--IA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:47 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> Hi all,
>
> Last patch series for mvpp2. First patch is just a param to disable percp=
u allocation,
> second one is the page_pool port, and the last one XDP support.
>
> As usual, reviews are welcome.
>
> TODO: disable XDP when the shared buffers are in use.
>
> Matteo Croce (3):
>   mvpp2: module param to force shared buffers
>   mvpp2: use page_pool allocator
>   mvpp2: add XDP support
>
>  drivers/net/ethernet/marvell/Kconfig          |   1 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  11 +
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 232 ++++++++++++++++--
>  3 files changed, 220 insertions(+), 24 deletions(-)
>
> --
> 2.21.0
>

Sorry, discard this, it just slipped out, bad copy paste :/

--=20
Matteo Croce
per aspera ad upstream

