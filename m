Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A7C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7315E216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/abIgi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfEKGUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 02:20:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34208 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfEKGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 02:20:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so4365718pfa.1;
        Fri, 10 May 2019 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qJ6baBOhjbTgfhgQ7m0z/YKuXkTsd3b70o/ipcNU1J0=;
        b=l/abIgi17jUI7sh4Ke8I0OIwPiOLxb7fi1Dlc6rsou7M0rz/nMXkjJvZyWy6AmSXVe
         nTEPSIDwapqVlf0hkZz3Jc0GlyzIryKQ8tmfo18Mbm4X5SfZzUtVlOyq0lmcTxI2/V+X
         tzKpCQHJT1uBuP9ORtt3W6rSrcXd1dToueekCEmhj0feNm6Z3V2o4p7pM0CER/7dNaK+
         rxQjOa7r4di5+Wu0ODcjZKAYPrRkBTMRJe5QA7+bRmnQLzUBnYnP0lZenChnlaD4BQsv
         GS7wvRAyab5J85T5ccvosSO/Kj9H6IbYyzdbZSNs96FAFYGHjlNe62+Jf7MF6jYvFTP4
         WURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qJ6baBOhjbTgfhgQ7m0z/YKuXkTsd3b70o/ipcNU1J0=;
        b=SXXoHslxi+/l00N0BOtWKyO/BsHz3hBff1JW5QfHHv44G2EQnewua0mGPeOcUvbKH3
         uuK4ckH0jxFtyqTh7Hwz+vgfHDIOUODZmHYxDA7z/P/r/s96MyQ0CGQC+P01YCrzYqok
         /FzXVx2DMh4HQf8Ld6zgdr3SzO6wwdiWcp94b3dPvut0iikhovL/d7H31y0deqIIVTjO
         An0I9HX+bWhiWxTHrVN3UA9fDbl5W8uumbzSaRxqzrcOYT7fbcgMF0X1GpvvfYa5dHhh
         og0uB2oBp3veoMcfF/J4hey4f9OBvZkRv5i6Bs2l6I/bvzTJza/DN4dsydJU8J3Teo1J
         0iSA==
X-Gm-Message-State: APjAAAXD+jXm7JkqTImSl4vLs98tPSbeA+y2y5X0rPUnC8BBjuXxqycI
        tpBG2dJn07sWlz9hrR4ibkA=
X-Google-Smtp-Source: APXvYqxZ6WWkgD3Uu87LcJG0AWsxWGz9OUOcMujZFe/mKEoTSFbmXY9lfsPMxpsDVWnE+SkB6Aj2wg==
X-Received: by 2002:a62:5103:: with SMTP id f3mr20323036pfb.146.1557555647336;
        Fri, 10 May 2019 23:20:47 -0700 (PDT)
Received: from NixOS ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id y10sm10284128pfm.27.2019.05.10.23.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 23:20:45 -0700 (PDT)
Date:   Sat, 11 May 2019 11:50:35 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Linux v5.1.1
Message-ID: <20190511062035.GA1827@NixOS>
References: <CA+icZUWSJSnKcoYeh__v_BLnXP5O0XGewLdGenz13extauRr_w@mail.gmail.com>
 <20190511055210.GF14153@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20190511055210.GF14153@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Dinner happened before I could get to them all :)" he he he he Greg! :) RO=
FL=20

On 07:52 Sat 11 May , Greg Kroah-Hartman wrote:
>On Fri, May 10, 2019 at 09:47:14PM +0200, Sedat Dilek wrote:
>> Hi Greg,
>>
>> I have seen that all other Linux-stable Git branches got a new release.
>>
>> What happened to Linux-stable-5.1.y and v5.1.1 release?
>
>Dinner happened before I could get to them all :)
>
>> Is there a show-stopper?
>
>Nope, nothing was "supposed" to be released until today, according to
>the -rc announcement, so there's no real issue.
>
>Dealing with 5 stable trees at once is not trivial, please give us a
>chance...
>
>greg k-h

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAlzWaa0ACgkQsjqdtxFL
KRWGuwf/cQgzTbFCkLqcszTWEUmPw3cbO/COTclMJT9rExEO1hwelLwPYQKQavhC
/oCKp1Nr09qvZDJla2O4HW9CjyBBVPaO93ClIb6ydGBLYkvib0H127o0SKRFEk7p
oGGKE5uaHqib6TAgH+hS3KlxtCsM5oVyEGFRj/rKYzo4ZebLzM6cs7qT6C5DAsQ2
0SjccrsLBHDQCjGl2d7/wzhAA1v/+V80wgJDphQ5OYAJfTQfGJLV5O/d0mRVTitE
Z+dNIsKsgT2O23ffJ12hDobccih3QQuOtBpCdBLfFj2KgmSGfPCfN50obuvaL+G9
gkF/BzH0RqPE1niXoUjM15GKA+WjOw==
=+ZYm
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
