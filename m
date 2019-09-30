Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73747C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BE821906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYj0BxkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfI3OiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:38:07 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35876 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfI3OiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:38:07 -0400
Received: by mail-pl1-f178.google.com with SMTP id j11so685787plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nrz2IUrj33GgmjR54VOTYEGCWrGtCKIOTHnB+tuTggE=;
        b=hYj0BxkMzOSWJ9qVG8vivY1DSijQIWTGFXbIQWMbX+pNT41Z5s6jkWEJvrgidKkzvv
         RNXqHQnayMrkzoofHJMcvvTaOllLoBrxR/h6HyUKAYBi85HWU46baPupGOhXRkjPJHwc
         T7OEYoKNyYJcBXdI+oDlWOa5Cr47BJGKbdIurNzZrXlvfX3iP0eZGQ5wJz7Tq2iMHB+Y
         CYL04F8RkQlMKN103zwWEJqiAUZ16IAgmDTuj1v+fOgDvCSde9nSeBnXxW/zn2eVQxAA
         HdWux0STYn29vaw08s9SjYM3pzigxha9XKRkpmEVvNUDjPs5+2ZqzgONwS+vGFmNN5Rv
         a/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nrz2IUrj33GgmjR54VOTYEGCWrGtCKIOTHnB+tuTggE=;
        b=OmT52dCKRxioNo2i/NTpd+4ZM0LxiR7jQ4SJLZUZ75mvVc5Ivja3D46HQbh9n9hRS6
         u1SAeIhFw2r3G2WZMLr3VV8ez22vGB+PJkgrZnfdHIOacu9fSy993SqiVIpjw/LW6E7I
         1pECn73CEUWlbdGIBxyKlj4ZxHTE9pomjVjea0R0YDHPRNyZUE6Wc3ACTdjLmc1Oxnkl
         eMWl2eMeBPeiAOVKrEISu2Iqq2509UvNhlaQMcRRz8Ninsqkh1M00BayTijESyTcj6Y5
         R3F9TmoQWBOl7tAPSJqYBD6Ue6IEGtOzPC0bAOBxig6ivikAXevpiWhsSlmg84uUb30Z
         qwUg==
X-Gm-Message-State: APjAAAXleL1MRYxK0ua2CeSbKN3SEzHj/YpPzuPW5PHJyz/fr0k1EfVb
        vS3LgEv1TNZQc9KuAZI4JoNZ0K+bwb8=
X-Google-Smtp-Source: APXvYqxMnYoEle8gh3tPSix9AK1DfPpkhRwiOw/aa3JW9SasNolyTF+mD3FLzd0+Lqg0Cr1/wwHAqg==
X-Received: by 2002:a17:902:b209:: with SMTP id t9mr5103408plr.116.1569854286323;
        Mon, 30 Sep 2019 07:38:06 -0700 (PDT)
Received: from Slackware ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id e4sm11103665pff.22.2019.09.30.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:38:05 -0700 (PDT)
Date:   Mon, 30 Sep 2019 20:07:56 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove dead mutt url and add active mutt url
Message-ID: <20190930143756.GB30066@Slackware>
References: <20190928151300.GA18122@debian>
 <20190930081310.7e3b9c52@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20190930081310.7e3b9c52@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
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
> - properly changelogged
> - demonstrated to build properly with sphinx
>

Will follow your words, Jon. Hopefully ,next one will be alright.Sorry
for the bugging.


>Thanks,
>
>jon

Thanks,
Bhaskar

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2SEz4ACgkQsjqdtxFL
KRXp1Qf+I8whd598TaGIF5lt7Gb9g3W138oZuA4MJHb31FwC7fKpLozuuh7qtA8f
E/pnQgKSv3UqXcw3UEfBon6J88dMkxRkxR7D5nLD0XHKvVKgDtK04JTqrfbYuSTE
REPTvbe8hDRQsLBKF1CSgfsENb0nojAgPFwVZISf6x8lcSGHAl8NuVz0uxtRleLn
BpFUwjCLiZ7FEwnm9srnXBBfi6VbHz69u8kSBvAql+z+iX96DrYjV9I4h7oeO7gv
x8ah4674EwAxEcae3nJHSBJd72CiJV2FrZmSApImnc/5+z8TpljL/ZH9W02lVeCJ
SzIHwvovBu7+3crSl1KHWzVPFPn6lg==
=affU
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
