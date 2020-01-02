Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FFC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F6A21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577964642;
	bh=/3LP6kQ4cTJYiGwewWnUFXG3M77l9nXB/nSInDBy1G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=jlWRMAlr1OVE4cDlocO2DayevuhpxLVLRKwDa6GEpIXlsUNE/K1vTLCixdYGkZ/hS
	 SXkrVD1dc7OvKuVUUedJJ0cHQagYTkGZ0EYdSwPSNmVI6mJQO3r9NXZdpKuDUnxpIm
	 g+gKgugLjmJ+8kQuPpNTEIiCImJVx3OfaCaVmssY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgABLam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:30:42 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46290 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgABLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:30:41 -0500
Received: by mail-lf1-f50.google.com with SMTP id f15so29671403lfl.13;
        Thu, 02 Jan 2020 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d3dulXjQFXVkZX4ZQNVnL00Ue1i2kbFWKIQHBA/xvtE=;
        b=Ufs1HBNV8DbSoFNg9hHko7POoRf9xSir2oprEOboSNzyqghhVX9IwG5eMU+j66N1Od
         JMeTy5zH8D7kozKgZ7xHJgzqymMCvwDCtej1ZP6egJxsGvS46KHVCUH9khqP3f7HIDUQ
         0cAL6Pb2pBP6himB+ATXRXkFmYwbUeiM1JvMtroe5tDJGI8gCsbszfGvE2ign4GZLe3K
         LZqlBLj6iaTjPguSlMA5WAEfi/V7ywj/jSgKz4v+PKdqBrozdJPYjMFMl7E85BzdGOZK
         ZJRTcf3QRA2sZJAnSRH98C6J10qo0Su0lMUUsHMiTccC/IcSqRThjfbZUgtCSOGzZCxy
         gbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=d3dulXjQFXVkZX4ZQNVnL00Ue1i2kbFWKIQHBA/xvtE=;
        b=NEO6srMLlM/Cw8ex9D90vsZlooVfZp81XJpUf2dLAKH2a+OshLUX2EgWthZSHOcUyQ
         0nol/lOmnaMESzCtMb2UjNjxvJnlw3ASeOvuym/CBz2l3X5cwWQ9KxRZgJJzpE1hwNgv
         j+2RDDhVQlzH4qmZ06Mk1UGeu2dcg3H0D/o3g3YfHM0OpRYW0JtxyZBWOZGyWB975mro
         Z3ur4OeXN4seg8xr4jYyEvrjgEBs/6laYK1yE5gKpqf+a99flrJ/6MHrQ2tRk+Ux5oS7
         Le9h82JGUA4vKxG5EBMLoakwj5egeyJ28qhHcgXxsjZKSQDLF3OzetEA/r2VyiTDRNxO
         NHAA==
X-Gm-Message-State: APjAAAV2E4r5STVbWWYzGBicIm+Itt2r3J8mFhGthkhg3UaHuh5kVbMI
        NsMuVZdW5WL0/5UROujbDJM=
X-Google-Smtp-Source: APXvYqydhz/yS3LGeOOAz21CKMjo5DUc3Su4P1UZuXNmhprFWKWkuDmBSprupL8KRIAruZLi6LRbTQ==
X-Received: by 2002:ac2:5605:: with SMTP id v5mr48019847lfd.136.1577964639485;
        Thu, 02 Jan 2020 03:30:39 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id i9sm22970376lfd.6.2020.01.02.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 03:30:38 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCHv1 2/2] usb: gadget: add udc driver for max3420
In-Reply-To: <CABb+yY00xOZw2uw6oK3N6RBcOurJjhiPXHs0ShCSVauwZn6TNw@mail.gmail.com>
References: <20191210003135.32427-1-jassisinghbrar@gmail.com> <87eexclkj0.fsf@gmail.com> <CABb+yY00xOZw2uw6oK3N6RBcOurJjhiPXHs0ShCSVauwZn6TNw@mail.gmail.com>
Date:   Thu, 02 Jan 2020 13:31:22 +0200
Message-ID: <874kxeksc5.fsf@kernel.org>
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

Jassi Brar <jassisinghbrar@gmail.com> writes:
>> > +static void __max3420_start(struct max3420_udc *udc)
>> > +{
>> > +     u8 val;
>> > +
>> > +     /* Need this delay if bus-powered */
>> > +     msleep_interruptible(250);
>>
>> should you check if you're bus powered?
>>
> for some reason, even for self-powered, it helped reliability.

Perhaps update the comment, in that case? It would be better if we had
a proper explanation for this sleep here.

>> > +static int max3420_thread(void *dev_id)
>>
>> Why do you need this thread? Sure you can't live without it?
>>
> All the slow spi-bus transfers are handled at one place here without
> blocking any api call. IMO it is cleaner and easier to manage.

Fair enough, I won't complain. But it looks odd :-p

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4N1IoACgkQzL64meEa
mQYumA//SLi6nGyho7AKjNXUijFlpjaeLmciwptf1cywEjRc8vdVq699u6H+Z+yr
bQq3iGahlsfYszmsGWsGUYauJyY3+gxBVJb7xmPMpzrzmM3bchdNGLyIJBDfoKoX
OJSMSbll3C5cKEM+hImwnp4ikEoKp4yGdHaPKxH0RKfHMLfIWaOf5Q1NeTOnF1K7
6Rw+8S97fVMwy8zL/roatNlC3Y6dSYjD4ahU3WVXL5CrC9IYhpIYomZ7+MzQ0iWN
tDsT+QsLpBEIJaMMT9WCfnymCAKbvTvRq2S07SSbZMXx6g8TQtkGhA8E8zglt7hZ
0tsCHi2kLBmKTKzOZ+/VEFFQaAuMFC6G3nMl70Pf5LIiYTQTUu3BBO1E1YwIGNOr
ukWKCmBC48/wig/C/juMKotiP8gg8V1OX9rnHQjsHXq4jfj2DCu9bOBD3a5/bokn
uwtC+ULssM4B7JqASQXygzsM1eN9daLGIqKdI10lnruPW2YuSXqEoYFQx0tDiZdD
bqEmo+9UMBNVzH7ehawJ90FixIgrnxsFbd6vwuNGqUF09UDKzKRkEIljah2gkyK4
Xfpo53Q4Y1QEAayrtycA05Wpilwf3sTAVg6cu0LvMsbbDcCw7kPMhjEC9HJA2Z2T
HY3SbjksbpEqiqH3k4bVnall6ltCYdBOlFqXx70Aao0CCZhDP1E=
=sA7L
-----END PGP SIGNATURE-----
--=-=-=--
