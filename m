Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE213C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821D2206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5jHjY/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfG2EoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:44:16 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38170 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfG2EoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:44:15 -0400
Received: by mail-pf1-f180.google.com with SMTP id y15so27334928pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFDI6SML6T6xaZaSiFzp/ikbG+8fwaD6/E8/Mnuljfg=;
        b=h5jHjY/K6yyqOXtr5yOFQiZMVcjFt24L6rHKI5BuA7OBu3Cjn+VR1YEZlnBj7VInC6
         +XNc4pCtZhXR8YuDKQiaCoOXSDd8YiTC/Ly6N2wgQBi7BQ3cGaYrMO4ToyHKFjVqti8F
         A0tWvJhOIqveB3JbCmV8q8U/WNkJjZ4A5Kkv1l52kvNv0MxNU4B14YsIbrcJlNirsbN+
         b58rS1tbIv5jjCiQHcpm01lw+XZySDgAIaeYSE9G4mqLbU+vN1klIjXyxlI2+E0aL4Xm
         SjgXYAxPS2fzaaQ7Zzesk2ME/qvFJ/AKgSRpqsNizd1t3Yj2aoWWDQbcChaPitj1oiOF
         luCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFDI6SML6T6xaZaSiFzp/ikbG+8fwaD6/E8/Mnuljfg=;
        b=VwdoDtCEPty91Nk2Au8aHTIv5zCcUB0UpkTlSHFXaWxfiB9j82GkqHM2cB8elfKRG+
         9/JZq2dJQs2QpYeGM862wJeww98JWlwDi2MGnzSBlC68RZbVO9Yy54rOiNYhVzvI8Pg4
         axjYaabYFc90Wp7GoT7JzxhhrWE9nVFYsYGnzxVGD830MZOKEberpEy8f9mvIqOQs/zO
         o4ApqoJErE6r6PyVy2QakoaT9wn2Grzi94VRyyhoUGQlTwn3CuhU2RQXKk1hBbvdbBVl
         3pKrC6SUKUDjUNHOD1KQ5I6vVwd9pGm10Qt+MdSq4H1/kxraG6G3ySo6o3xpGmJ4PriF
         V81w==
X-Gm-Message-State: APjAAAV5JqiZ9+cUAbTF2eNHrHfVsVgoR5aK3UCfMTWnxForiUJKbrkQ
        eLsN5B2a/WIxfEz89IM/xsxfAaxmfnsBjQ==
X-Google-Smtp-Source: APXvYqxX94zHNdhAue7Yk3IksR9BaJt7Qg//LgZYQuJL1V+4Kkm3SpOBcIiiSN+iFdIo+B3IXXwYpQ==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr102007247pgd.13.1564375455041;
        Sun, 28 Jul 2019 21:44:15 -0700 (PDT)
Received: from OpenSuse ([103.231.91.66])
        by smtp.gmail.com with ESMTPSA id h11sm60843675pfn.120.2019.07.28.21.44.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 21:44:14 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:14:05 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: build error
Message-ID: <20190729044403.GA27065@OpenSuse>
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Matteo,

it's look like gcc is not in your normal PATH. Could you please locate
that fellow and realign it ,where is suppose to be.

Or if I understood right (I doubt that is why asking) that you might put
explicitly the architecture to target build with make also, that might
help.

Please do let me know, if I derailed grossly ...am not sure.. :)

Thanks,
Bhaskar

On 22:08 Sun 28 Jul 2019, Matteo Croce wrote:
>Hi,
>
>I get this build error with 5.3-rc2"
>
># make
>arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
>
>I didn't bisect the tree, but I guess that this kconfig can be related
>
># grep CROSS_COMPILE_COMPAT .config
>CONFIG_CROSS_COMPILE_COMPAT_VDSO=3D""
>
>Does someone have any idea? Am I missing something?
>
>Thanks,
>--=20
>Matteo Croce
>per aspera ad upstream

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl0+eYAACgkQsjqdtxFL
KRWD8gf7B3C4eQbJDjr+qcikIHk5D7vFZl6zTkyjyELHFJF9PLCpPjkBPV6XTBqt
+LzajOLzOhVQO30b/8uwi6FZYECxAFWGfk6qVmAJ4sjFFAvzFapoBdAe72/9D9Bc
3pQAKpgmuHmrE8gG2f7FXoSd4/38DWg69AvhE+a0wMHMAu2Ku09khH4BB9TZkZBG
OQrdPHhWDBZmBVRauaPjCrQlEJWvHXrjxSLhCBipxStTp4KbfhzdLPiaF1s3AbJi
c6aalQYBQj+KVhWKUS4RrTHXCJ1XHFhTVZ9buoRrSrM8qHuN9TzOsSzo51d5B8wB
PAYzSd0RSH4eCyCgGsCUW7og4QizXA==
=sTEb
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
