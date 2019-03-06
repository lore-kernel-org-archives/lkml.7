Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B2EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B96F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3RoKVVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfCFFTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:19:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35766 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:19:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id u128so8865475oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 21:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qO4QBSTksbdWwJmd1jRGaW+gqmNZtNsdVRJHwDZtmvM=;
        b=L3RoKVVO5Z6cT7b+fbAF0AxzeIWM9cyxyQUcxDQwzwVtXWChqRPan8Sjp9jH2/1qgl
         KvqpjeJyBvDTBxwvWVlAEl1YmrqKJxs2VLBrQa0Op8C5IXQhWiOgug0Ajq2YvuJsA8EP
         nViTSwGARD5O6by9Ir8E+40spoyVrIsfoKihRFoTsfJZaT+4vniYEC3QTqqHWh2yGyZU
         JoeZQvXudyBkNerHL5nX3YJtjzJ6qxdBQKDXLRRogmwEqylEmy4aZiUOUrprkNMalwku
         GWTHfLcyrFOQpogRQoYXbZysHDvjhCdhGHIhqF0N9/xFYx8246LVpPEGP/YTSWdxKNlc
         xepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qO4QBSTksbdWwJmd1jRGaW+gqmNZtNsdVRJHwDZtmvM=;
        b=gtJXWWj2hMkC7ahOWQVAVlGAYOT6sp2Tv/3xJPnS1+IH0dBR1NwoXBm710YwYKQgzb
         d/8njBrJh0R+1DzbbbtHMKO+0Rqw0g4lpEo3RNMHh1sZSOALKV2JMj6YEXSdt7/5ipr5
         3oGh3mG/IRjx3N69B5n20X4on/UMX9mTg+jR41LwbTG5sNaxmLWkk/cobd/eG3Zbb86c
         T9gVT454Fbo0WCwSAL05AkYR+Br1DXq8XSz9S1gC/XHucwtQIEUsaEMn5P21dOv8D+ox
         7boN57kbv+cra9Meus4Yo9QIjMzHhR4nycNZiUGKNbvDjBAP1XKADOsnVVOrh/QTlT5N
         7n+Q==
X-Gm-Message-State: APjAAAURzifRtJ1N9YCLlreCsUlMX06jOrcouKfCYhKZ11ureJdDvRXs
        qCz18UAmJldEsnfLzBExxrDNLiePULrhvEnLmlA=
X-Google-Smtp-Source: APXvYqz/cd+Q3e1/ynSKoaH09g3aCeNSf0mk2bw6R0fLlMrRngdCILg2bTvndtlE4MvylsKYGE7au/7UjTlNcEx8pRw=
X-Received: by 2002:aca:d702:: with SMTP id o2mr589850oig.113.1551849588039;
 Tue, 05 Mar 2019 21:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20190219092148.4093-1-saumah@gmail.com>
In-Reply-To: <20190219092148.4093-1-saumah@gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 6 Mar 2019 05:19:11 +0000
Message-ID: <CADVatmMHV5oszv4Owz4CNJktoHViSWkzS=QVuyr6XQ8SGmF+zQ@mail.gmail.com>
Subject: Re: [PATCH V3] parport_serial.c change for fix hanging problem.
To:     saumah <saumah@gmail.com>
Cc:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Morris Ku <morris_ku@sunix.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 9:23 AM saumah <saumah@gmail.com> wrote:
>
> parport_serial.c change for fix hanging problem while suspend machine. pa=
rport_seria.c support the same vendor id and device id definition as sunix =
multi-I/O card driver, when the sunix multi-io borad driver is installed,th=
ere are two drivers to support the same sunix multi-io card,it will cause o=
peration error.
>

Please use checkpatch to check your patch.

> Signed-off-by: saumah <saumah@gmail.com>

> ---
>  parport_serial.c | 180 +----------------------------------------------
>  1 file changed, 1 insertion(+), 179 deletions(-)
>
> diff --git a/parport_serial.c b/parport_serial.c
> index ae9e01e..f54d1d3 100644
> --- a/parport_serial.c
> +++ b/parport_serial.c

This doesnot apply. git is showing error:
error: parport_serial.c: No such file or directory

> @@ -38,29 +38,10 @@ enum parport_pc_pci_cards {
>         siig_2p1s_20x,
<snip>
>
>  /* each element directly indexed from enum list, above */
> @@ -127,29 +108,10 @@ static struct parport_pc_pci cards[] =3D {
>         /* siig_2p1s_20x */             { 2, { { 1, 2 }, { 3, 4 }, } },
>         /* siig_1s1p_20x */             { 1, { { 1, 2 }, } },
>         /* siig_2s1p_20x */             { 1, { { 2, 3 }, } },
> -       /* timedia_4078a */             { 1, { { 2, -1 }, } },

You are removing support for the parallel port of these boards. Can
you please point me to the driver with which it conflicts.

--=20
Regards
Sudip
