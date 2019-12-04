Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF370C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E1E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nldiMngI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfLDTXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:23:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34686 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfLDTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:23:35 -0500
Received: by mail-yw1-f65.google.com with SMTP id l14so194504ywh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUxkaUmtQbpUCJr8ZpcwWbKJcmlT2fymrv39Ke8j/1w=;
        b=nldiMngIVUFVnbe/D2VRFoDLfMsQXKtbCkKpgFzaP66vRavVzrn/LL5qpLbC0nA42T
         vWbphHCuOhI1Zb8SbnKaVPptFE+yYx0bjikuVpiNfiybFVt3ZS3US0IeymTWIUjn6co0
         YfS4UMDgWEsxdsdJxe/j7/kLlEBm9GYTp5myVZIYczm4Oy5dSObGuqZJt8cpXLGEZ/hm
         jbjkl/A/hwxHbVIXXBgy5IxmfU5pGv40L4ECdgW9J3zvTTH+S+ILqXk2JJP9R9yxSMh6
         Pt1NmD69V/67XoOXxLShANVnRLDuUp0LfLxf+ORwr7hmwriuqtIAeE2+DlhtjC3PjNms
         XaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUxkaUmtQbpUCJr8ZpcwWbKJcmlT2fymrv39Ke8j/1w=;
        b=Jk6Q5HJaQQN/4gW3u5qwIVh2HhpGK7KBkrOCytLMZOv8gYpKrddvXWcnq1PoNFeEDQ
         kMSSrgaIpICHHH4KB6k/draEcpdr2FFNE9uAyhAZ5BmwjNRNR1AnTBLqE0OrYiWuVDja
         MvGTtUCyganXhsDREW51/L5FsPbKCwiZ0iHld+IwGkeg/OJEcdaHPC+5y5pHY9N9VU1s
         QO2OludkgDKkfulznskXGEHb5ig/eg6sEOJK8APGpKrZzIRssMsekxBtE0vEQA1CYjo4
         9HFDhKTk73jclW9U968nb+qKjpfTwRfrkqkk5y1PHe90VJ1GD2ZgkmsPDSiRWHG7iiZc
         Cgtg==
X-Gm-Message-State: APjAAAXOiFmn6pZi0KRvZZreWZRSq9FEjWhd30doEIh+OIPH0KiNO7nM
        gXQm2G3LijnN2Nc2waWbPoTshrgb
X-Google-Smtp-Source: APXvYqyGC/TlVwj2FUEIFI2RToAfe6vXNaVG8COpY/RS7O+ByaTTfkSBcsdAEdey9S0ixpaU8lgRFw==
X-Received: by 2002:a81:78d7:: with SMTP id t206mr3523289ywc.104.1575487414218;
        Wed, 04 Dec 2019 11:23:34 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n129sm3490745ywb.75.2019.12.04.11.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 11:23:33 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id k17so444019ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:23:32 -0800 (PST)
X-Received: by 2002:a25:c444:: with SMTP id u65mr3453976ybf.443.1575487411650;
 Wed, 04 Dec 2019 11:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20191203224458.24338-1-vvidic@valentin-vidic.from.hr> <20191203145535.5a416ef3@cakuba.netronome.com>
In-Reply-To: <20191203145535.5a416ef3@cakuba.netronome.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 4 Dec 2019 14:22:55 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
Message-ID: <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 6:08 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Tue,  3 Dec 2019 23:44:58 +0100, Valentin Vidic wrote:
> > ENOTSUPP is not available in userspace:
> >
> >   setsockopt failed, 524, Unknown error 524
> >
> > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
>
> I'm not 100% clear on whether we can change the return codes after they
> had been exposed to user space for numerous releases..

This has also come up in the context of SO_ZEROCOPY in the past. In my
opinion the answer is no. A quick grep | wc -l in net/ shows 99
matches for this error code. Only a fraction of those probably make it
to userspace, but definitely more than this single case.

If anything, it may be time to define it in uapi?

>
>
> But if we can - please fix the tools/testing/selftests/net/tls.c test
> as well, because it expects ENOTSUPP.

Even if changing the error code, EOPNOTSUPP is arguably a better
replacement. The request itself is valid. Also considering forward
compatibility.
