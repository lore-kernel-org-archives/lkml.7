Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9EC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481752075D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6RR3j+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfI1LS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 07:18:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45096 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfI1LS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 07:18:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so2944536pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8sT6SIcK6jRm2xE3oY90NMunUqoKu7f4Evu1cgn3pk=;
        b=d6RR3j+bKFNgQUE5G2xIqXT+jV6jbCcCrcK2Bwm9T1ASSKvBpf0qR7lbCkM+n+Km13
         ylZ8DsyQYU48WUNsSWXrKPIHuOR+E/mGo/yfsKugSoWh1011+xZQoh1lQhCUiRPB7XGr
         +ZeYWwLKCdR6R79+vpMoevkGLxmKuMic6mIItXHukQ7y5Wa46EmwngVJFPYdw1msssTB
         0ioMc0vgPChCH+iWy18pa/wPXOHHQdVzxmfanmPh4oez6HaMi38eLrH1oJS9qua4foEm
         h78AXUGtqQTj6/qJKs+si3C04HOYwT8Ku3JXSPwKXj0ZziBwzG7UyzmO6JRyHqHbtM9T
         VSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8sT6SIcK6jRm2xE3oY90NMunUqoKu7f4Evu1cgn3pk=;
        b=X10MedqnrVjQVXhr/lgcfXuFci2vCH0A2912x4zR8K0aRRP/wyG6SqTVcHNjIO/oue
         F9ecLTLPW1cCPBWbJ/FrL1wJISLi84dnE7KvLFsLg3Vw/9PhzQxi8JorNIVywq3oVQZa
         bpNlfDl+GvRqbIl3DoIBKOuxSBz+kOXmwLZ/v0g71vJ543xQ1bDFVliFrjy24aRvyvlN
         8aB+wYvgw7i5Bw5dg0vHWXRrHQE2OxYMZOizWExC7II+A7QH7RpgPBNXsdCn+XqtSNri
         GN7+Tk4sM8RM9UJhoRfbOkRqirjmmFn2Fv659vo2W2cxLO6NNHjsKLhSomfn59w1AdRD
         aMLQ==
X-Gm-Message-State: APjAAAWuvubcMfXXdZQfWuBq/mE6tCFhbs2fjnHyBpAWPPdD4NIi6A4b
        5PeEh5FAj/T0AEnzcDpeYN8=
X-Google-Smtp-Source: APXvYqzZ3zFOmcdPwcMNVF7j1yZPBvTEZltk6wfTgLxGiOGAugH02C4X5OzgppNBMEV8OK/7zebMnw==
X-Received: by 2002:a17:90b:149:: with SMTP id em9mr15486521pjb.135.1569669537675;
        Sat, 28 Sep 2019 04:18:57 -0700 (PDT)
Received: from debian ([103.231.91.34])
        by smtp.gmail.com with ESMTPSA id a23sm2032464pgd.83.2019.09.28.04.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 04:18:56 -0700 (PDT)
Date:   Sat, 28 Sep 2019 16:48:45 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re:Need your input [PATCH V2] Remove dead url and added active url .
Message-ID: <20190928111841.GA1956@debian>
References: <20190927144411.GA167835@ArchLinux>
 <20190928012359.38874015@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20190928012359.38874015@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01:23 Sat 28 Sep 2019, Jonathan Corbet wrote:
>On Fri, 27 Sep 2019 20:14:11 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> diff --git a/Documentation/process/email-clients.rst b/Documentation/pro=
cess/email-clients.rst
>> index 1f920d445a8b..15781bf10b8d 100644
>> --- a/Documentation/process/email-clients.rst
>> +++ b/Documentation/process/email-clients.rst
>>
>> +The Mutt docs have lots more information:
>> +
>> + https://gitlab.com/muttmua/mutt/wikis/UseCases/Gmail
>> +
>> +  https://gitlab.com/muttmua/mutt/wikis/MuttGuide
>

Okay, few noob query ... curse me as much as you like Jon...

>So you clearly didn't generate this patch against any upstream tree; I
>can't apply this.
>
NO, I have genrated it on Linus repo directly clong in my laptop.

if I fork Linus GitHub repo to  My GitHub repo , and then made change on
it, does it work??? I mean this the way ...or some other way???

>Also, it seems clear that you didn't try to build the docs afterward.
>
I have tried to run on local tree=20

=2E./../scripts/kernel-doc -rst "thae changed file"=20

Am I doing it differently or plain wrong??

Or do you think , I go through to install sphinx and do all those
stuff??=20

I failed to understand.

>Please give this one more try, with a bit more care, and we'll get it
>merged.
>
Certain thing..because it started to bug me..

>Thanks,
>
>jon

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2PQYgACgkQsjqdtxFL
KRVvgQgA1nUrA9dP0zfYeRf4vgwuRERTe5rDweBhV2wxJeVgiilOFPoj8j+cKsir
gVBq3zN+9gO1XU2k4DX3U0MjSc3fucsbUsp4cGtC8kg/usNFC/prvmiUgP+3XZAk
7GJZEDiRob0J4dv/AVEQbhziv5Bm1Hqry1zuIpW3KQx39qyPYWzhdvEXQChEwQvx
e1hQJ17RjCkap5iqt943Tq6AHoOZtzLCw8UA4TPd0Sl7oQUIbsjYZpaVb+HIDMla
rIkmdm5WEkVe4Vu/YHur6S7W4gIZzrxMTuMdLspa1gWhArHqXkJU5k7YrST2MBvI
H7iyjNtZ/0e3p677687eInuun4nUZA==
=0Pf7
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
