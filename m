Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8105F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1g34ePl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfDDNzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:55:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43482 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfDDNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:55:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so2367049otq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SM7br/73jaRvXeycgmb7b5oDcueCBzlpPV8Gowg7u9c=;
        b=p1g34ePlDqZiwR32PySBrWU4K1IUFYORtvBNbBzJDr2bG1svX3GZxvT0TMs0thSRmW
         eFjyuek+j2wWIkx1+J4W2FJQwJFc0seICi9v7eouOhX0mF98YT4xJ6ClVIYDWEZh8wvV
         GljcnT3r3XJSz6gRYIup2fOAgr6vzakbOT+7/EcYSIQH0m1atk8aq2IbMK81Jk6RTyEJ
         AiuEIe9FbS1Krb7eAL6MZaFIHuO9vsBbLE1R/egaWrM14X57yEg+fo5y9GukVp0RFd7R
         bSFMz+1LbcJhHZOLviM4+SA2iydJNyTESxA1F8IfNDSSFITBh4MuzJbikNVwJdb+nirS
         d7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SM7br/73jaRvXeycgmb7b5oDcueCBzlpPV8Gowg7u9c=;
        b=l+EjHkEop2BVoIBKXNBg1CWCYYh54SMzc9+sWR4+dp89UVLtl6JgMr4I4cSn5mBSuK
         BsGITRZqbO15CFdeMhbPmTNitnJGkDKSyx+RYhZkJympWNydLDj1sRjzcJhCE/bCs0pA
         ADo8e412TOBIhl69tpol4sEkR094LBBULlxdFhONcTIylZlwwImk4nraCKiBzq+oc46+
         fUCX9IRX6riNhBLOhkY7wfePicc2jpchHqehdTb3AzBPv2cvjem6YmhaQCZWUHTORPiw
         deUc+6u4vUCKX3HSsOaw70uJMS1L8p/Qqhs5HfCUKBb5O1RfbM01NyAjai3ZFO9nL6Oe
         oRbg==
X-Gm-Message-State: APjAAAXAdqwjZcMfWhTcDKLQhFaGUdbE/nA6VQQVQ8qEluta4hpT5kKQ
        eYfq2oVijJahpXPd0WgklRPq+EHpH9S+MP4D3LoR+Q==
X-Google-Smtp-Source: APXvYqwnCv+EI6vu/nhv/4nBkoBEHJSpJkjOmG46rmFwfq6sRYOaTRQEgeHZs+nGEhCOZsCpMO8lw+Tv7WiIo8bP+Nw=
X-Received: by 2002:a9d:dc4:: with SMTP id 62mr4137734ots.211.1554386136503;
 Thu, 04 Apr 2019 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com> <CADVnQy=hsPrDwXoym18j7YzCc36669NJ1kVBR76y+FgK6Meytw@mail.gmail.com>
In-Reply-To: <CADVnQy=hsPrDwXoym18j7YzCc36669NJ1kVBR76y+FgK6Meytw@mail.gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 4 Apr 2019 09:55:19 -0400
Message-ID: <CADVnQyks1T8KZibJF+UWR0zWGvqs+fUBkCYPJFxATx5PU-csSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 9:48 AM Neal Cardwell <ncardwell@google.com> wrote:
>
> On Thu, Apr 4, 2019 at 8:24 AM Tilmans, Olivier (Nokia - BE/Antwerp)
> <olivier.tilmans@nokia-bell-labs.com> wrote:
> >
> > From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> >
> > RFC8257 =C2=A73.5 explicitly states that "A DCTCP sender MUST react to
> > loss episodes in the same way as conventional TCP".
> ...
> > This patch replace the clamping of alpha by setting ssthresh to
> > half of cwnd for both fast retransmissions and RTOs, at most once
> > per RTT. Consequently, the dctcp_clamp_alpha_on_loss module parameter
> > has been removed.
>
> Acked-by: Neal Cardwell <ncardwell@google.com>
>
> Thanks!

FWIW, my vote is that this is an important bug fix that is appropriate
for the net branch and -stable releases, rather than net-next.

neal
