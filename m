Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADBC206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCrErmxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDCPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:52:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39439 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDCPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:52:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so22076938wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m7qplqu/2+oy26DB0Pm6tiDZFg+/RROap+cgmPWZPC8=;
        b=WCrErmxYI+LrXDFsd+5LvTzh9uDixA+IxHshBjviGKEfGfnqqEengQsRlj01EY+UNL
         wjvakVt+zUba41q0DCxNrSQ4A/5zcHIUeztvjyA5/CY/g2I/hKjQpAunt04p/2xZJu81
         yNT3f2pz4+0H1ToVCdCyHo9g56lYNuer5atl2hUeADGRk46i2BFqGYYje9SiS8MwSG0x
         w5rwDHiGkZMoMjX0eOWf0avt53qNXYjJ5wD+l5TZwyeYoAyQ9vi246mmSuKA9k/hjLrr
         2FblCmMD+NjxOXEHpEcLLRPVxCHOh4uGD5xNWZ7Vy7x8JjwgpzHtf17YQzK5p5QzaDIx
         tfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7qplqu/2+oy26DB0Pm6tiDZFg+/RROap+cgmPWZPC8=;
        b=sCTySI01dnDojNw14V0+zMkkaZoD7wvObPBlughXB4SS/7RtlxPiOOVLIcOJQVK88G
         pTTGNJVsqkOLn4OFXuCUUrsmcUMH5vnyj9IG465uIgaZGZeER50ZWSd83hDWs1qgiFtb
         OiP3Yy2P8XD+my/6zuvdksElvBeKebcXhJlSJkTCfLxan5MsDS2trvD6dEYKLwEX13N7
         PIh2uKkygp9DFrT2HW+fF8ayeNTg1/qiW+SKNOnZ4RYY5KGpzIzDndF0Y4np2Mof3hOZ
         Lh7yM0VZr2fynIzJbsZSJC2Qbk5LzACRGRYfEorOe1q3ote3qpjxghbc+rXNKDZuQ4ZH
         cNXA==
X-Gm-Message-State: APjAAAUc5wOyflJvfHxqGgL989zXdS5stEctEKJb1lkDa31NDRuqwXV3
        IOthtPmbjcnn7rdGnkknPhqug3eYdaUSMv0ZRYRuiQ==
X-Google-Smtp-Source: APXvYqzuf0bnJVTeRGST9QEGrXNaCv0YJpyYQSmpz+mZTZTXSGlCyz5zX9Qv8HXWVBHDdom1zOW1h4HHDQ7p7XrqQCo=
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr169928wrq.151.1554306732143;
 Wed, 03 Apr 2019 08:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com> <CADVnQy=m7REuTMd7kOs95DwaG8A6gR+hDRfMsSKcyvB4M+PWzQ@mail.gmail.com>
In-Reply-To: <CADVnQy=m7REuTMd7kOs95DwaG8A6gR+hDRfMsSKcyvB4M+PWzQ@mail.gmail.com>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 3 Apr 2019 08:51:35 -0700
Message-ID: <CAK6E8=eB_GoMugQXSFDOmvUkM9Xm37Xd=1EYC0zei8VsE1R5+A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Accept ECT on SYN in the presence of RFC8311
To:     Neal Cardwell <ncardwell@google.com>
Cc:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Eric Dumazet <edumazet@google.com>,
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

On Wed, Apr 3, 2019 at 8:39 AM Neal Cardwell <ncardwell@google.com> wrote:
>
> On Wed, Apr 3, 2019 at 9:50 AM Tilmans, Olivier (Nokia - BE/Antwerp)
> <olivier.tilmans@nokia-bell-labs.com> wrote:
> >
> > Linux currently disable ECN for incoming connections when the SYN
> > requests ECN and the IP header has ECT(0)/ECT(1) set, as some
> > networks were reportedly mangling the ToS byte, hence could later
> > trigger false congestion notifications.
> >
> > RFC8311 =C2=A74.3 relaxes RFC3168's requirements such that ECT can be s=
et
> > one TCP control packets (including SYNs). The main benefit of this
> > is the decreased probability of losing a SYN in a congested
> > ECN-capable network (i.e., it avoids the initial 1s timeout).
> > Additionally, this allows the development of newer TCP extensions,
> > such as AccECN.
> >
> > This patch relaxes the previous check, by enabling ECN on incoming
> > connections using SYN+ECT if at least one bit of the reserved flags
> > of the TCP header is set. Such bit would indicate that the sender of
> > the SYN is using a newer TCP feature than what the host implements,
> > such as AccECN, and is thus implementing RFC8311. This enables
> > end-hosts not supporting such extensions to still negociate ECN, and
> > to have some of the benefits of using ECN on control packets.
> >
> > Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> > Suggested-by: Bob Briscoe <research@bobbriscoe.net>
> > Cc: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
>
> Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>

>
> Thank you for this patch, Olivier and Bob.
>
> thanks,
> neal
