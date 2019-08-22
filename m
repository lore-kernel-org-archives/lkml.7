Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D742233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKZVyQ6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfHVHLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:11:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42039 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHVHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:11:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so6406787qtp.9;
        Thu, 22 Aug 2019 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjGrToOEWeMlpOS5e+zEaXYac5JbBU5qP/ippadIYok=;
        b=LKZVyQ6y7LhITaq+dPNulHmPllHIo9YQhD3YZH4XHzKUvfTokHfwav/6NZaHD1+CtO
         gMotuBGp+Mk7z/XTZdAJdM4t1YA/CBt9XKwUyCVSJ646dW8zOSqxckjP8toX4sTJCyY3
         sbdvq4944IWRmom98sAuYG8taznl2tiSGQBSy6yocpOMJyqB5o3QEgjbLZKr+/w34CXd
         D6FQbNXH/1PaHdbzcZgDTqBPepq9QB7RJWrFVIhaUC4vaeJLHtrUdPr5omqlEnI7WSVa
         WUbqIv7EW+sOGyKiD4wxQR6JkbdbGcWrFa+dAY2uI9HaGDnoEFMKtEc3Q4WJo54N3bHV
         n4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SjGrToOEWeMlpOS5e+zEaXYac5JbBU5qP/ippadIYok=;
        b=mzbkxoYVWzSj6GwBn0YyzA8JRXS7PN/fPBhzsAoC8IFFncso+QdZqUuI0775xPHFRm
         Ubi7ZTUo4BZcD79Zu/xrxZlRd96ewJayafj6s1aMOanIHPnydh/xUXsEkJCnQvf9vBsi
         J3v580RddQECDOFzqTTgLYMHI8SiEGteiujf4jZK95Ei90G7lfMkGBMd5b+JGw/NzdX/
         f/305t7wIbwbJtbU7iUJTi1EU3S7EBwb/M/rvM6ltb0Rz0yw81J0mZoh47+vOeDE3l5w
         0PrEbEQM99w7wcF2FdtLjxdNkNTU3zd77QfU/bFyau8S1tWh9UjF0DYHSnKcDaevx/Ys
         0zlw==
X-Gm-Message-State: APjAAAXeqDWn8oDYACXlQ8uYriVroXFXQUvGyvrIM3xY9rvxjWM5fcbN
        /o/LEZggj/VYQTH1SnFnQhsUCMwsroJZBOfiF90=
X-Google-Smtp-Source: APXvYqyWQZWb/ChKK9DWXD7EsDI7AMCn6gtCPdeGFgRHaHJ3x+JZm5cWp5mQ3p5et4V49xISmc9KhtIMuOtJHlCTQ8Q=
X-Received: by 2002:ac8:5247:: with SMTP id y7mr36273264qtn.107.1566457870403;
 Thu, 22 Aug 2019 00:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com> <CAKgT0Udn0D0_f=SOH2wpBRWV_u4rb1Qe2h7gguXnRNzJ_VkRzg@mail.gmail.com>
 <625791af-c656-1e42-b60e-b3a5cedcb4c4@samsung.com> <CAKgT0Uc27+ucd=a_sgTmv5g7_+ZTg1zK4isYJ0H7YWQj3d=Ejg@mail.gmail.com>
 <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
In-Reply-To: <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 22 Aug 2019 09:10:58 +0200
Message-ID: <CAJ+HfNgUe3xGHeLsK0eKV76BOgeV-ZFcNwWKOvxbzcGRcg58dg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
To:     Ilya Maximets <i.maximets@samsung.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, William Tu <u9012063@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 18:22, Ilya Maximets <i.maximets@samsung.com> wrote:
>
> On 21.08.2019 4:17, Alexander Duyck wrote:
> > On Tue, Aug 20, 2019 at 8:58 AM Ilya Maximets <i.maximets@samsung.com> =
wrote:
> >>
> >> On 20.08.2019 18:35, Alexander Duyck wrote:
[...]
> >
> > So is it always in the same NAPI context?. I forgot, I was thinking
> > that somehow the socket could possibly make use of XDP for transmit.
>
> AF_XDP socket only triggers tx interrupt on ndo_xsk_async_xmit() which
> is used in zero-copy mode. Real xmit happens inside
> ixgbe_poll()
>  -> ixgbe_clean_xdp_tx_irq()
>     -> ixgbe_xmit_zc()
>
> This should be not possible to bound another XDP socket to the same netde=
v
> queue.
>
> It also possible to xmit frames in xdp_ring while performing XDP_TX/REDIR=
ECT
> actions. REDIRECT could happen from different netdev with different NAPI
> context, but this operation is bound to specific CPU core and each core h=
as
> its own xdp_ring.
>
> However, I'm not an expert here.
> Bj=C3=B6rn, maybe you could comment on this?
>

Yes, you're correct Ilya.
