Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C693C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15E52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac6RBWFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHNN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:29:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37494 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:29:06 -0400
Received: by mail-yb1-f196.google.com with SMTP id t5so7681773ybt.4;
        Wed, 14 Aug 2019 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=feHFiHeHvTpFde0tn91rp6H0MBIr1sa1sTvgeV402JM=;
        b=ac6RBWFxnGnpiZqQA/EYd//8dG4n8myv7wQGfVHqiBTTGPRbII9ak3Bp7Uu3XUlkdr
         85xhvuyQ5gR0apLrD1GDoHYw7xLKKr8sq8n5JixRq6kv89QGu2+dnhoaW1896Rk7R1yV
         LlymwQSaAtL3yaPo3MiAM4mAsXeULIqyhk9sCUJ54d3a/s1kR/Tkd55oWfc4fza3kbDe
         ZBZx+RlHTH6yhNR92OVxL2UEhSG4tMuB7uESR8P+DxZNzoDfWH30MCSzmUm2DCL4noCQ
         DfPDKTa4NIO3TcXsWtc6QVxjJdutnyur5T7BLkORpKL4RFpXjTk1kzcQNYO5z5h5dyVB
         6m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=feHFiHeHvTpFde0tn91rp6H0MBIr1sa1sTvgeV402JM=;
        b=kD4N+IlujKXuZ6Iz0TQfOWGEYhOyydZloLS4mknU1d4hGyXeNfOXmXehr5vJKGg/8G
         a8O91B7lRyFUNAVor3vklg0n0Lj6p+iMMdOhfWh6YE3QaoXv4aBjPkuP6CvmMMqRDUHI
         T+EcZSItqJPXWU146SEPefEqLUvesAuWCNz/Nmsr3HnaoUU10GS5cl692vA9kVCtPmB9
         31IgiZ5doM4fZF1JHpej+tILbJjerCzXKhKNj/bH+9WV6ctjhdMniiP1otlgN2A7LaFH
         8GfFLLZyM4V9TP2kaBefwxz8UlDRaW365OFL6Ak29bUMEnYc1mW8W2MWxVEK6zaCHfMG
         7CEw==
X-Gm-Message-State: APjAAAWJ005S4VGFjNie9JP9xw8RAOqBJfIQ46T+zm6iByl7OrcLG/Q8
        +yff1e0EionnGgLHp3H9ElqdwT25JJ4MV4f0efE=
X-Google-Smtp-Source: APXvYqy3AqQMungyg/xB+l2qARditdM8VXFFojcSBu1UaUOjytXLxcZJavyaAwTWZx/3F8rjkKQpTLcSWn/ANfaZArk=
X-Received: by 2002:a25:790a:: with SMTP id u10mr29982888ybc.379.1565789345382;
 Wed, 14 Aug 2019 06:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <1648748.TWHgARQioU@jernej-laptop> <20190814132001.GC24324@Red>
In-Reply-To: <20190814132001.GC24324@Red>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 14 Aug 2019 15:28:53 +0200
Message-ID: <CAJiuCcfASQriPLMuwuDCn9bU=_8q4jL+KkPo8NmMrrYpOqy2qA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for
 pine H64 modelA evaluation board
To:     clabbe.montjoie@gmail.com
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Aug 2019 at 15:20, Corentin Labbe <clabbe.montjoie@gmail.com> wr=
ote:
>
> On Mon, Aug 12, 2019 at 12:56:56PM +0200, Jernej =C5=A0krabec wrote:
> > Dne =C4=8Detrtek, 08. avgust 2019 ob 10:42:53 CEST je Corentin Labbe na=
pisal(a):
> > > This patch adds the evaluation variant of the model A of the PineH64.
> > > The model A has the same size of the pine64 and has a PCIE slot.
> > >
> > > The only devicetree difference with current pineH64, is the PHY
> > > regulator.
> >
> > I have Model A board which also needs ddc-en-gpios property for HDMI co=
nnector
> > in order for HDMI to work correctly. Otherwise it will just use 1024x76=
8
> > resolution. Can you confirm that?

Schematics Rev A:
http://files.pine64.org/doc/Pine%20H64/Pine%20H64%20Ver1.1-20180104.pdf

Rev B:
http://files.pine64.org/doc/Pine%20H64/PINE-H6-model-B-20181212-schematic.p=
df

There is a DDC_EN on REV A not on REV B

Regards,
Cl=C3=A9ment

> >
> > Best regards,
> > Jernej
> >
>
> Sorry I didnt use at all video stuff (like HDMI), so I cannot answer now.
>
> Could you send me a patch against my future v2 and I could test with/with=
out.
>
> Regards
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20190814132001.GC24324%40Red.
