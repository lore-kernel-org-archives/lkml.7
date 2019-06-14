Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC068C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E472177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpzB1R91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNQCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:02:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:02:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so3110983wrv.2;
        Fri, 14 Jun 2019 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQsuYi+KebcM7tlxMdU3Khi/bx1No/cabfItgTIubfs=;
        b=tpzB1R91nqlxSZ4kdloWLRCtwL+SliQaHgaRq7AhvujgiQ84Hp/01tTOijZAOlPS2T
         xvrB/FsycJWBsLL099dN6PwZwvmWM2rmVYIYkv9CupgZi8PqEy61h66yHCR3Iw9yi+vW
         0Fn6w6Nfy7Fk2Hw15k2i+a4yXC8J9up4AM+bLHMiMr4cFcDI7FLzK//TStOfJ5F1eZ17
         JBONzh8xEO0KYWLjcYbQ86ytDRpsJYLFjiUEqSPjMn/yGi/lv+T3hDrLe72jAggawACK
         PYng6e7t9yq97U2u27MZtlm8AWYv74hiUdaM53zSthNnQcJ4YhwPPhIsqwiPpGWaGmDL
         C3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQsuYi+KebcM7tlxMdU3Khi/bx1No/cabfItgTIubfs=;
        b=OxSEHmHcDHGEC+PLeYI6gO7AH5sm/s4HYaw/mSsv29VbifAyIX61QhRIFweWEu/LxE
         hKuYZTdvQnT4xul11KSyATeNVXyh8mGFSjzB6bYkeoJe35p/asJHPTtcKpEmbi6fq3lg
         lm2zLmBJ4L7g8aaLtcIhgoZ9eqU3mSPjKjJ1F8cDZsQ9qKQpgjTsOUGGmYYETeb1c4G/
         5TB4xKVYmB7ZPsNU5hURhxPg2EUzYnLf5VmpVXrPmIYx8OpeD6oFF33CtkzD+R9XPY7q
         rrCNnHXeriQOwQjbcwqZ6ukHcJnHc7MEACdG18n4jzFBkNW5DzFdchgWGhA0f5URJGwl
         5jbA==
X-Gm-Message-State: APjAAAU8wsrFLfQ4GWsi+OWiIxcNs8sbvQPicHvgauPU8G4BIk4PaKHn
        4qEZt9eDlE8BOQ+TOSALnTQ=
X-Google-Smtp-Source: APXvYqx9Toxm0ZJf+Ly7O8F8BYRLKGsArVNs1xI5C8m55JLZcfH71qhzCj9IG98Lhj6OjVgdkUP2GQ==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr64468279wrq.344.1560528156220;
        Fri, 14 Jun 2019 09:02:36 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y6sm2409416wma.6.2019.06.14.09.02.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:02:35 -0700 (PDT)
Date:   Fri, 14 Jun 2019 18:02:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] memory: tegra: Fix -Wunused-const-variable
Message-ID: <20190614160234.GB28409@ulmo>
References: <CAKwvOdn930hhHcnCA9arJ5=9SsT-6BfFC_1punmUZX2xWM-Hnw@mail.gmail.com>
 <20190613182610.238801-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20190613182610.238801-1-nhuck@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 11:26:10AM -0700, Nathan Huckleberry wrote:
> Clang produces the following warning
>=20
> drivers/memory/tegra/tegra124.c:36:28: warning: unused variable
> 'tegra124_mc_emem_regs' [-Wunused-const-variable]
> static const unsigned long tegra124_mc_emem_regs[] =3D {
>                            ^
>=20
> The only usage of this variable is from within an ifdef.
> It seems logical to move the variable into the ifdef as well.
>=20
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/526
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
> Changes from v1 -> v2:
> * Moved definition of tegra124_mc_emem_regs into existing ifdef
>  drivers/memory/tegra/tegra124.c | 44 ++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Applied, thanks.

Thierry

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DxRoACgkQ3SOs138+
s6Hufw/9Ec9XB2EyJYZEW3fBZ6EdkkTZ89eyLwpbp/7Twoh20GQItlUGEJZFNAvK
enZi2pOoGHMFp5RDmGdpwwk11a4f4e6h4LYGAAko1vg3LOZ6PKSNixTe1AFJKBI3
0H/CLUARvTEeM8450C8VZnFDIb9Il8xByUY/d/hHYDgHsBFWLu8zTvBmsH23qVRZ
DfUbVsuPEWM2Q4kxq7unVx/RME1k6GJZw0wCWRy94q/sj6AjgBOCTPteoH5DSWF6
paGobJgw6AZQo2pjTUi7w159dvqN5SJwn59FMwEbiqtv0yVuEfb1KHSFIgp1AwSL
34U4MchsRD7EnMF9DDlFnva76qfXCME/oB5Kux+GZXqJjrCaIwlcEEmqSI10KWC8
hv9u1Ss2aBdWE9vZwD2ykoanyz3BLPeVquVqFz0RXS+tQ9D1pIr4E6INEsPzASM1
xAsp3E7eC+OdWsdOfkogWh/RlW3OFRIIXkBdqaXlgFzizpztruIvDTVnArDTXUbI
F6ckVy3BzhZnnWQQI6UxMzzSRqDXy9PyAxBg6ErroXTu6QjBQ3psREQ3KTICPMNW
ALMOMHJamxvapi6K1Ghcqty3m8wjoSXcMjB6D382lQ6ojHmxMzxQ2CjVAD2OmD9a
G3mdQpg8wk0jmxY3ZgYL/T/tz228kvs6HIEcFU9bvPt7Ir7QcnE=
=KQH8
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
