Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2AC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063E2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSqbPH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgAIMGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:06:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52243 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAIMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:06:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so1078873pjh.2;
        Thu, 09 Jan 2020 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmIycbUVcS+pfeeCibTBHWK6WtvOxVuFBuQ8992eW/g=;
        b=BYSqbPH5N78ZZCbnIMdjQooooI4YQxW+KN6VxpqanIrGHZ55CMqzP9hzQOz/HAfD2w
         4Gc56pO7WiLE2Y0kajzWARbpsg/C153u9Jd0rWfQnWKewlWHTAgmwKMqaV9pVlMpdjpV
         VomwRTZvUFb2XBkNeSc7ZMB14wgEHzH0In/6mRgLoMDJruXGzuc34vz3EjHiZ6fG5EJg
         FGsWarsnphSF5x6lYlHFIeCGrWI4XeTDX+ZUlGj+NamzS4kMi1fqPLqFXVpz5WhvzS+5
         PscuSuIqNWWnmpzb3/LeBQmv8et6w9k5uDCqCjy1IDSpqdg71vKeJ9CnDbJDXlBjFgia
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hmIycbUVcS+pfeeCibTBHWK6WtvOxVuFBuQ8992eW/g=;
        b=MrVpyB8ITeUQGZrMu6pTdU4yOIWB7qm60cSJR6jr0rv0eWve8/7AmQh64yjUYYC2oc
         PU5zGS1Vtxj/SaPYUg2sTvgvEVVRvr6tF7+WjxnKY7dcgRrDSHaSQiI89vH1Me6bpv8s
         ONmssDMTu4+2nvrlGqDiX6EmA1g9ZY4AqL7hM+GFt80/w+piqxlQd8Y2aVrK25Jz1rtS
         93TzauntLuVp67vLDhrKI2e1CtHAJ2+suX4rNTNzrUADlhVsou9vXBzt9ZWkJSyOMVqG
         7skxi1D4As5pS9A0TG39hMjANvcrfQ46ECEitUjAhA0BZMKeN+Vu7+DUy3KrlRlYsPxO
         XuJQ==
X-Gm-Message-State: APjAAAX2do6WhVgeHfo+Xq9FJEO2HM23nQnnITpDCYoW8HLr3LhVy0zB
        JpDgoCsWdsqM/MstgRFLUNE=
X-Google-Smtp-Source: APXvYqwasyKsQoLxmd3Ddy6w4uPDyQyZgmj/zsCEYdkq9WmS9xOe5NJNjxE9y4tmAcjM4e1E7jAeHw==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr1570928plr.157.1578571611109;
        Thu, 09 Jan 2020 04:06:51 -0800 (PST)
Received: from Gentoo ([103.231.90.173])
        by smtp.gmail.com with ESMTPSA id 189sm8036311pfw.73.2020.01.09.04.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 04:06:50 -0800 (PST)
Date:   Thu, 9 Jan 2020 17:36:37 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     StableKernel <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: What happend to 5.4.9??? Kernel.org showing 5.4.10!!
Message-ID: <20200109120635.GE19235@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        StableKernel <stable@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20200109114330.GC19235@Gentoo>
 <20200109115514.GA1270@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <20200109115514.GA1270@lorien.valinor.li>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 12:55 Thu 09 Jan 2020, Salvatore Bonaccorso wrote:
>Hi,
>
>On Thu, Jan 09, 2020 at 05:13:32PM +0530, Bhaskar Chowdhury wrote:
>> I am wondering, it might be lack of morning coffee for Greg  :)
>
>5.4.10 contains one followup, backport of 6f4679b95674 ("powerpc/pmem:
>Fix kernel crash due to wrong range value usage in
>flush_dcache_range") which fixes a regression introduced in 5.4.9 via
>backport of 076265907cf9 ("powerpc: Chunk calls to flush_dcache_range
>in arch_*_memory").
>
>Regards,
>Salvatore

Got it! thanks.

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl4XF0oACgkQsjqdtxFL
KRVifQf+IGVtZO+4SLRXXf/W/YaAEKGkYb52+z+OH8a3pdi834AexuHdgZi0Gg2w
21UGyUryXkHIspfQvVjgWeiYQS9sPtqoDbekXaM6ctiqfHpOs/PDA0dK3vvCyka/
rD63GAmRRAGUzPS+Ia9Fm4pd8Qx6S1+aooAeyX79aLgN3deaabXiOxZfURrTkeqT
V8+P99bVY1lH4ezsE/OjjYXuceFTDHfnW6qnPa/uBOTy9JjBZjulua57+WcMl0+P
G+kbSYwheUm81Vccldg5KWZ5f4P7vw1FloeYg3ZeEoH/R0og27/ZJopM8vkLLq2M
OPEiHyX8P0KuS/dx/TcVL/YLiVyNuw==
=j7Dd
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
