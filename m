Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2982C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8624321744
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMMfpxPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfHZIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:31:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHZIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:31:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so10134354pgv.13;
        Mon, 26 Aug 2019 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LwFJoAiBTJqjRbajQHLI63mMomcTvX2ijDqC2auoANI=;
        b=QMMfpxPT5vT1rQngAn9iZMdqUKlHmYyYnktsza2d98pd8zikPhPfnlSAh+rarm7+eH
         qQf3AVp/EB1RG2rvrk6M3aj4oC3aEdN4lOgKQbDECdn0qmdXtb6pFoPWlM9VIqgeAkK4
         U2FSfRp8ugyunHB2xlXHkVmubLQKoUZ6fpuSaBW3BP75MoIblqLoB/PGer2IfszEFzfs
         MsPJLy+HHeDl9ewwuo63oUI2k/76OTy4SSpgNL51naVuRhCwU6DERCN9zeiYs3y/WNXA
         XAzIlInxIUevxZIxj42uurg6wTvpfzaQ6X1NxlgQRc1X0iwiZozCbTPsxx4BuAkzp32f
         c3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwFJoAiBTJqjRbajQHLI63mMomcTvX2ijDqC2auoANI=;
        b=d6etBngfA70JkUV3yQQA+ipTkYULjdgK8q705ulC7kGi0lh3wYtod9inXrEUzYI7O4
         WHlNLFS7LhIKmAyuuWT8tlLTiGB42ikW4yQ0/BiBB3ObYqZ8SSvl7L7Qld0WtQPhzueZ
         vIz6/wRSFaP/9jXHXX80Fy81MbM7uE9Z7tD296ATlCYq/yuXnaOylACyQbab1WjOprQk
         aVJkw41cq+zMnDyPpZYK2mVsFp1FZVEb7uFeGuq3GfIrHQxaih/8f3ZOBCwEg4ougYqg
         KX309UxoyK8Ei4030lwCT0kge7b9GbVdUTpypBqzXdE9IGrTaa3/VaL4mcIWE+Fy0nNT
         NPEg==
X-Gm-Message-State: APjAAAVyJh23FEqtafl9kp1i9DizUPJnriyZMzL0cZuD7omInAYH0sW+
        B0mtN6uXz1YVx75p5/lEW20=
X-Google-Smtp-Source: APXvYqyE7y3JGmvt5Q72nOjf1rE9b5kbqIjcGRIfv/7LmiZPcgIvw7svyR5VPw20rzwz5jOfI9Lvdg==
X-Received: by 2002:a65:5043:: with SMTP id k3mr2175803pgo.406.1566808270917;
        Mon, 26 Aug 2019 01:31:10 -0700 (PDT)
Received: from Gentoo ([103.231.91.35])
        by smtp.gmail.com with ESMTPSA id p20sm9534790pgj.47.2019.08.26.01.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 01:31:10 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:00:56 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org, jslaby@suse.cz,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Linux 5.2.10
Message-ID: <20190826083054.GF31983@Gentoo>
References: <20190825144703.6518-1-sashal@kernel.org>
 <20190826063834.GD31983@Gentoo>
 <20190826080107.GB30396@kroah.com>
 <20190826082138.GB31262@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <20190826082138.GB31262@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:21 Mon 26 Aug 2019, Greg KH wrote:
>On Mon, Aug 26, 2019 at 10:01:07AM +0200, Greg KH wrote:
>> On Mon, Aug 26, 2019 at 12:08:38PM +0530, Bhaskar Chowdhury wrote:
>>
>> <snip>
>>
>> Due, learn to properly trim emails...
>
>*Dude*
>
>Ugh, email before coffee...

ha ha ha ha hah :)

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl1jmLoACgkQsjqdtxFL
KRUyFwgAyd+hB72P5rmbmbQdasSpAjJqQ0JoPX7CRnwxG7XP/9uO4odlUTUH9RTg
k5+677oH7sQ+OjR6m1xDA4WUk0e2OvhARvJ+3eiR+EaGTSYqLry6ojkbbph9UShQ
lmgYRNScEojYqN60ixedj5h2ptWAokYmx+BzzeuSeryxQ4fK3seMqkIUtcFvFlD6
2vtxNRbppJ2Xe/rolprTHBom4rmy3s11meIwnjY60P7MoUPijOVTKTfUzEUvx07i
ph3DRjBB3QNmLNTEjKCdcjelooZcI0zvm7D/4N/hyvzMVmOcRt/4lwXXFepqdaOR
QamXu7zV8K2QNgleBMx8WUEdW1LICQ==
=FT3m
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
