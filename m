Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E963C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2190A215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMIQU7r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfI3P0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:26:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37561 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3P0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:26:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so4052472plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=za/+pdxL3ZGIApbiAJlOW1cAaGy2Sk3kwFoit3vPZ8g=;
        b=QMIQU7r21I0ard9fi0iRzy/oB4szVm5pzLK3tQlH3ZPz37hRnis2bdDWbVgGXE1S3A
         HAo7Af4bfoNPMnfmzSqTL42R1Bpa/TkraJHyVOwbhfKxHfjLXSy2zg/NpyucKxCnF529
         VcWqpeRcu06yl/ZYcJlTVz1XSyiGTedNrO7acvGJVEpMvr+U2FaxhdUU6VAyPwnWmnqD
         30Y2w8AjJfYHSlah54s4c2nqoOMtLf+vPacQMSiymeCo6VIvSjuqlfhfLMSLrR6uUUV2
         K2iMQu0jYkAOsU3IbAUvJx/OWrYRs0PCAtigDLEZdPiGQlbHnKoZizzKYMadp5LkfSzq
         wO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=za/+pdxL3ZGIApbiAJlOW1cAaGy2Sk3kwFoit3vPZ8g=;
        b=gTz8nAfVOio2G8Le0KUYQW40g7UhmiYMVRTLkXOqIOKnntbofUHdka/Fdi8nQj6l/t
         /04vbcZWwGplzNOD6xS0iCEWBB/as3Ls1NH/n0PjupthK7+pLTzdzS5JyjfqmBBLfukc
         K2SWPQX/F6g2WriGMJ3J+GR0edpfexXpDo6X93JAExAk3vh0zd7K/XVGYX5uUn5fy0xS
         0+sRqzIIWMojyeXuWuc37BVtVxpfvYyYYlwNmqpgymsEA2kGmHFUl0KnRCdNnehSpxKG
         fsvONdrRbQnKo77q5g1khdeU3FCrKunzYSIeTrAy2QjPVXXdbUuMlIT2QGstYBhxOBVC
         3wWg==
X-Gm-Message-State: APjAAAXDZSh5NGIAbmMvbl/LZfjQleI+VMzWpZMDydD+qz0g9S1OYNw0
        5O3cNRbO5pgd7Do1x33pPAt+aowyMGI=
X-Google-Smtp-Source: APXvYqxAads14Jb6nufP1iUi6BJNIDf9mJtUDsB233KbuoKYr2HAW8FMRQDETrVIua5w7ySiNf1/ew==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr21661177plt.30.1569857179351;
        Mon, 30 Sep 2019 08:26:19 -0700 (PDT)
Received: from Slackware ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id c8sm16862010pga.42.2019.09.30.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:26:18 -0700 (PDT)
Date:   Mon, 30 Sep 2019 20:56:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove dead mutt url and add active mutt url
Message-ID: <20190930152607.GA27688@Slackware>
References: <20190928151300.GA18122@debian>
 <20190930081310.7e3b9c52@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20190930081310.7e3b9c52@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 08:13 Mon 30 Sep 2019, Jonathan Corbet wrote:
>On Sat, 28 Sep 2019 20:43:03 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> The following changes since commit 4e4327891fe2a2a4db342985bff4d4c48703c707:
>>
>>   replace dead mutt url with active one. (2019-09-28 20:11:00 +0530)
>>
>>   are available in the Git repository at:
>
>Bhaskar, I'm not going to take a pull request for a change like this.  If
>you would like to make this change (and it seems like a useful change to
>make), please send me a patch that is:
>
> - based on docs-next
 I have no clue where do I found out "docs-next" Jon. But I have
 stumbled over these places..

 https://github.com/torvalds/linux/commit/81a84ad3cb5711cec79f4dd53a4ce026b092c432

 and this:

 https://git.kernel.org/pub/scm/linux/kernel/git/rdunlap/linux-docs.git/

 Now, do you want me to make changes there and sent a patch?? I am
 absolutely not sure .

Kindly shed some light.
> - properly changelogged
> - demonstrated to build properly with sphinx
>
>Thanks,
>
>jon

Thanks,
Bhaskar

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2SHokACgkQsjqdtxFL
KRWkxAf+MBFZTCp5h51mQyWGgB9nMU8+9aGxbKTwuWs98gfcNeycxFpbLyoB0nnP
Pba8VQWBpkDjBcsgPF9I4LeemKsdRGGUmayLrs4dhCXcDy/l6iHRRNZvAGC+dn6H
0DrCXQZmfvudoVXQQxbHOlr0Ggrr2bbMOxlG3QZNNM+WiRFaTycuQhjgQytK2A21
MDHpQ4dWM9h+uzwN77EQ3UqTUH3AkT5FAl0FrPI1zupCbZhvRGYtHNGgl310qKdQ
L1zgPQ8Hr2w0zVcdfOVFa/1Kon704gqEBmDH4SbeSpIyIpiZCc0XJb8fL69Xv8J1
yuykRYoVfVw/+PSzMyCks77j0/HFVA==
=4xUQ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
