Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2655C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CDB21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ4X7ZDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfI3O1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:27:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43481 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfI3O1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:27:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so3971225plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txZ1VUvm2fYL5KKS8Cpb2n4hdlyJJoHpUG0YxLbY0aM=;
        b=pJ4X7ZDiEmiNs9lhG5lisVCdC9Ni66n95/gDgTxtvU3n3nsBmHVKgeO5NIRwtiuKYi
         v5VOEPSpS9YY40/1TDxBHubgTs/0/TAy8L2iuAcU/abld0vM0RN8LtZkmvYk4z61Pmtc
         9lDxpwCLbocjOCWUf4tWy5+INYVN5GSzMK2wyZxDz2YLuFlq1bNk2JLozmaO6bgiL4+2
         VIQovS+Tjz6ViZWMEbJjyK8smVlcMkAIMlos0wKjXYvbUOy3mPHPlsFCHnqRBywTaubR
         VQAoxk6w5543EOInZHHJBk1igJKB/XFo2nspAiv537KikDFixYNwmfM+doa20s+6bYG6
         FujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txZ1VUvm2fYL5KKS8Cpb2n4hdlyJJoHpUG0YxLbY0aM=;
        b=fkFTejL2QI1jwFf5OlH3KskqdI2WVUv2CPMv6A1Nl0znIKMNAHkAXd5ukhBEPvT6EP
         3zzhsOMPmEDCBkNMoFdcHg7vwIaIEbA0Kc8Zrk/+F7sqN1Xqzn+qcZUrB4yR/lWRP+Zj
         ghhIff1LyLKB3q28dzK4w4+EYhnplrhi/B9FYXicOyT8AYsUFR62J7JHcm54Nr7flrRE
         3OPI9QULD/PiaHPGqjbI31VvF7zo2paMuFZ0tngcuicHBmi6sD/ZsDD7qrzpNPHJIm06
         9sd1gkxV+i/JN+WdfeYqekY66PvF0YZW0aiDw/yRyLAUtb0HuVFlRiJV9BqNKjHhb7XN
         h2xQ==
X-Gm-Message-State: APjAAAWturgoCIRiPQWANno+oU13ED103WgylpfLzEaKFxFvuhuxXnrb
        EduJAIlZl1C+643dIZwnCi0=
X-Google-Smtp-Source: APXvYqyHYhEAiq3el5CMjZijDSysZcxfjmO+6pmUZjHTCqkQDq3EyVwiCZt+RMTBKVDPv8wpQi6n/w==
X-Received: by 2002:a17:902:7d92:: with SMTP id a18mr20467503plm.243.1569853621669;
        Mon, 30 Sep 2019 07:27:01 -0700 (PDT)
Received: from Slackware ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id r24sm11275940pfh.69.2019.09.30.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:27:00 -0700 (PDT)
Date:   Mon, 30 Sep 2019 19:56:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC] Makefiles in scripts dir needs to move  one place
Message-ID: <20190930142648.GA30066@Slackware>
References: <20190930081041.GA11886@Slackware>
 <20190930081816.GA2036553@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20190930081816.GA2036553@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10:18 Mon 30 Sep 2019, Greg KH wrote:
>On Mon, Sep 30, 2019 at 01:40:41PM +0530, Bhaskar Chowdhury wrote:
>>
>> Hey Greg ,
>>
>> Absolute trivialities, but might break few scripts, but make things
>> clean..
>>
>> We have so many *Makefile.* cluttering in the top level scripts dir.
>> Can we please move those in one place, means create a dir and put all
>> of them in it.
>
>Why?  What would that help with?
>

Cleanliness of that directory. Nothing else,kinda organized way.YMMV

>> And call those in the scripts with that dir preceded . Kindly , let me
>> know how awful that would be.
>
>I can not parse these sentances, sorry.
>
 :) All , I was trying to say that , the path to the makefile inside the
 scripts will add that directory to the existing path.=20

 Say, present is like /foo/bar/hoo that will become /foo/moo/bar/hoo

 that "moo" directory will holds all the makefiles.

 Okay,  as I said ,in top of the mail this is absolute trivialities.=20



Bhaskar

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2SEKIACgkQsjqdtxFL
KRWh7ggApWrB/7M2aXW+L12kaJCRL7uVhh+VCHMqhxzTwjc6yq//sdMTY5aRDGQC
9qHITsYU4OPHppE8HaDG0olvPl6uiFH7KDS/F1R04it/2cfZbDMUNmBDoRkQC53h
8ZpJOXOID3onmrm9waYr4VPDHW58HOVK0X4R8PngRXktZPegsCYWET1CFCQjQxcH
6+2w1pWsaWB4CLVqTZMExapCe88wKRWJP48YnfQsH1Jct2rYs44FTZpn2V0OvS1/
CIWXV9YDJogEC+TvVNbHyYF7CZC49CRytLZa6WxXSyHg5Woa3AFLqoSXuVZWkSNH
bZnrj51wiw562bWhPsXWWM0az1IH4g==
=J2lD
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
