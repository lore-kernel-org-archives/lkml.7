Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86198C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C73B21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577964809;
	bh=Yt1VY/j0TGIIB859c29ReVlv8mUX3f+l/kjMgy/It3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=sZgqFVu2IBsHOlKQICZC3gpFUbzdWFup4r9mmYnk5v9UAsSX9aHJ83Ons0Pf0PU7x
	 EKkZd8sVdU9LqjTdCehN+6Swe2EI38/mcDK2OoVhTFfCSbOwyL3aA5gBEmsz9v9oTm
	 5Hq9ngSl4BgI9+yKrP2xLeDL6zdpbg9pfw/25cJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgABLd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:33:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40053 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgABLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:33:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so40381067ljk.7;
        Thu, 02 Jan 2020 03:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Yt1VY/j0TGIIB859c29ReVlv8mUX3f+l/kjMgy/It3M=;
        b=jdcgdeu4Lk496FcrbhnaSzTx87bPtS3KWWDConCPBtRLilRhlL/KX5suSw72NqWaZe
         D4QTr+X/H9Gz9iwzQIJ6pmbamICkD3t85K5xarQ5Yp3rf20lszhwH8G2CTYc6G6NTTDt
         i3xsQK3kh1rJzb8Le4k32aE/RvAqVXtpX9fgH2gVGlZkeIYRVABkja02oTh8O93P7lRP
         lICTIWuasf0Ucw5ihlYBP8Cp6mtPpYDpRpp5sFHH7yPoo8s5kcxR6zFC/J1i5XZYpT+Y
         3hm7qL/+HHFtPgaHgYBUrN8SUyDPyCFXl+D5bDfMy7bhIBrnaNgC4P/b8RMwoSKboVHv
         Netw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Yt1VY/j0TGIIB859c29ReVlv8mUX3f+l/kjMgy/It3M=;
        b=ULdRvkmIozPFt5usJ39dzJzAg01TXTnZ9efAfNI3AVSPuYs8EJVol+EpuCLnuYq+WT
         xeWs1IXOs7kLS5tyOKhCIEO8jIsF40V2uGGOlD6auoOJfitrnaTj7FAOKmpzKXCM7dGo
         hS73xk/qdVgX7MMxuwm66nQS+1CriObGAZNbaX9NEypF/sCqVpc0RiONhPvsu2j+USaa
         LkNxgneZoMkK0tJrzTJbD0IF45U26ji+5QeLVZymKyZ+oFJjhikLsWREJJ81Cc3GXxVC
         gB3/LoLCulnOboUQzh/HCZ0nQnEZwokCAM6V7Htw83ylo+Z+55JS9e6/8xTbdJU2EUuL
         AShw==
X-Gm-Message-State: APjAAAVfn4lCIV0zJcQRM3Ru1PzLCeuA8JEJklg21MWc+BS1JBbftfPn
        ZOZAWUoshTD5VKkZ44vqnc8=
X-Google-Smtp-Source: APXvYqygBYeKqrIrR2UfhmiCUnIcXOWBB9CsVGmFoEfPfmqE1tf5KYfGieECiO8eHB8aLzwbneFDkw==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr40422038ljg.73.1577964805303;
        Thu, 02 Jan 2020 03:33:25 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id s22sm22615229ljm.41.2020.01.02.03.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 03:33:24 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     gregkh@linuxfoundation.org, nsekhar@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: gadget: legacy: set max_speed to super-speed
In-Reply-To: <20191223064735.24662-1-rogerq@ti.com>
References: <20191223064735.24662-1-rogerq@ti.com>
Date:   Thu, 02 Jan 2020 13:34:08 +0200
Message-ID: <871rsiks7j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> These interfaces do support super-speed so let's not
> limit maximum speed to high-speed.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>
> Hi Felipe,
>
> Please queue this for -rc. Thanks.

This is probably one of those "has never worked before" changes. Doesn't
seem really important for the -rc. I'll add a Cc stable instead

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4N1TAACgkQzL64meEa
mQZXXQ/8DyALVTCnVPskGXceUQRTlGV1vmU3pbijjMlMdf4FwpcE41UpTkmIOXzy
6LxbuQJZvr0KJjaFIYQ5rTJSIj7OQjWH8ATHNToGMh8XITRzXdbq2lYLU+4XXYW5
tHng7/zCqGU3N9HOAF+4iYR8zi0/An6Q8II0HienO0unUF+HhEsnIkPOFWnM/UES
9zDktF0jlNSem/pjdGJExGcV894YTpd2tuxg9+IIBAYylETMYwIqiksZJIP+aCdf
UK4ebDnYJozPGCEQS/tQmw4nSOeXf/Kwkl++L0cYRniElwpW5FjELxYg7mkjjn4Z
JrDW+OjfAwqmT2lJUsXVYJU2fmV//YpzaZrZqOpk4w7iFOXjJMhCJBZX9IksnSN7
WeMpKfU74ZFUeif1PL45auBEhfBgp6P7ZKxehjYTbcB3S7uwAHCxsQluIFDfcDl0
34jKnE6pGAwrIECQNbsNKKS8heorsd32GqBveUG/iXmoDJBpIdL90IJ6LQuaIi9d
G6uWVup2Yp+KTPOylCguwWQL8k75GAZmQ2hEBUImS/NpXRhS4vT2ZYpSeebRM6PP
QU6MM+bBiP7vRcx7eacN5wmVL/sMZ3hh+enPeqLNU1lzfzmTtdvn97RJTXGo1ILU
V2iGIgnMKUWgCpkGcyqbvaH1u7d5ZCxyjPD4N8sUO6yPzJa2cjg=
=WRVQ
-----END PGP SIGNATURE-----
--=-=-=--
