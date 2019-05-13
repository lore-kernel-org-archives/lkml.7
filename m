Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CF8C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7931920879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7Q83/nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEMXjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:39:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34902 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfEMXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:39:23 -0400
Received: by mail-it1-f196.google.com with SMTP id u186so1921522ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YUShKsu1mlefSObA9gWPBMRHq32qEb9zAgeub9ROZA=;
        b=v7Q83/nN8cXIWxD16ouamHjL3KoM7vwTleYxg7RJ7yzZJasmYIJH3ws+2Y+fbMWJKO
         +XpSSZO4gjaG6AYU0js6J2A49zKWFL3GbuBS6CalxuqDjXWL9DsiIndW2SYPh9i9S/Jy
         ZJLlA8O1T5ON66DqSd4bxz46/w+4kYLihDC0zJoZmGBB/QkQPu1ANU7H5jyOwUw4enuo
         nXeMQuuXHlee0rdr0G0qnild7SNXe6gMR3mUCriHbQu2UmDqBPzx0WdlwhGhgGfB64jE
         3sekWIKoRBMHON4KrPJBFDPKbcsNL9jnS4oncYqGoHR82LAV2lADdZ+4qtOnD4c2k2Un
         grPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YUShKsu1mlefSObA9gWPBMRHq32qEb9zAgeub9ROZA=;
        b=RZOWWwbosoLRsFrKK0vNfkwHi0eu2/oqbBU/FrMKgPhk/Pt3znbNHxiUYioGpkG+fq
         LMX6/027gYZaW8QsPmWjTf9KvuiwcUE2QHp1h8EgJ0Y2GCKYXZ1j0yERkXbBPSr2SVM2
         nWK9+rYIs8Npf1yQKINyELf4PxJHHG3cWHVhSu0OfNsOJnwdkQYlN+tSjbsUEbNgB4SN
         dAQ2jyz8WwX9gNf+HQlnI/QKwiCcaMPzxT1xKEuPKzJGoNk2+WPXJaismrqDawoWcKVU
         EgT8AU8QsCqCTxtl5Z2UaBpkF7S/FOkwm/JBisyNUMrXpNRwuvNQtKyTd/Z2VKLLT592
         v6Ng==
X-Gm-Message-State: APjAAAUewG2cDgXDY0VjfvWEGkw7JdT0y6tVuxEqlV0EMC/6JYRleNre
        Mw0Avzt1qDWuS9znQ786Hv/vj9ZpkthFf1bf0tUx/A==
X-Google-Smtp-Source: APXvYqzdi7u/5RibX15NmmU9JlMri5q6z796biepWXtSO/bp9G/pre4Dr/BJUuNwb97soOWDHIfniBe55kAFhrwG14c=
X-Received: by 2002:a24:910b:: with SMTP id i11mr1347612ite.110.1557790762377;
 Mon, 13 May 2019 16:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190513222109.110020-1-ndesaulniers@google.com> <20190513232910.GA30209@archlinux-i9>
In-Reply-To: <20190513232910.GA30209@archlinux-i9>
From:   Jordan Rupprecht <rupprecht@google.com>
Date:   Mon, 13 May 2019 16:38:54 -0700
Message-ID: <CABC7LbRp0EQUDuQP5oJN2a1iyHYAk34D6386eHomYgacwovuNQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, keescook@chromium.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathanchance@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000f1d550588cd6d0e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000f1d550588cd6d0e
Content-Type: text/plain; charset="UTF-8"

Nathan: is your version of llvm-objcopy later than r359639 (April 30)?


From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, May 13, 2019 at 4:29 PM
To: Nick Desaulniers
Cc: <keescook@chromium.org>, <clang-built-linux@googlegroups.com>,
Nathan Chancellor, Jordan Rupprect, Arnd Bergmann, Greg Kroah-Hartman,
<linux-kernel@vger.kernel.org>

> On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > --rename-section=.text=.rodata
> >
> > Rather than support setting flags then renaming sections vs renaming
> > then setting flags, it's simpler to just change both at the same time
> > via --rename-section.
> >
> > This can be verified with:
> > $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> > ...
> > Section Headers:
> >   [Nr] Name              Type             Address           Offset
> >        Size              EntSize          Flags  Link  Info  Align
> > ...
> >   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> >        0000000000000004  0000000000000000   A       0     0     4
> > ...
> >
> > Which shows in the Flags field that .text is now renamed .rodata, the
> > append flag A is set, and the section is not flagged as writeable W.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/448
> > Reported-by: Nathan Chancellor <nathanchance@gmail.com>
>
> This should be natechancellor@gmail.com (although I think I do own that
> email, just haven't been into it for 10+ years...)
>
> > Suggested-by: Jordan Rupprect <rupprecht@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  drivers/misc/lkdtm/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> > index 951c984de61a..89dee2a9d88c 100644
> > --- a/drivers/misc/lkdtm/Makefile
> > +++ b/drivers/misc/lkdtm/Makefile
> > @@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o    := n
> >
> >  OBJCOPYFLAGS :=
> >  OBJCOPYFLAGS_rodata_objcopy.o        := \
> > -                     --set-section-flags .text=alloc,readonly \
> > -                     --rename-section .text=.rodata
> > +                     --rename-section .text=.rodata,alloc,readonly
> >  targets += rodata.o rodata_objcopy.o
> >  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
> >       $(call if_changed,objcopy)
> > --
> > 2.21.0.1020.gf2820cf01a-goog
> >
>
> I ran this script to see if there was any change for GNU objcopy and it
> looks like .rodata's type gets changed, is this intentional? Otherwise,
> this works for llvm-objcopy like you show.
>
> -----------
>
> 1c1
> < There are 11 section headers, starting at offset 0x240:
> ---
> > There are 11 section headers, starting at offset 0x230:
> 8c8
> <   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> ---
> >   [ 1] .rodata           NOBITS           0000000000000000  00000040
> 10c10
>
> -----------
>
> #!/bin/bash
>
> TMP1=$(mktemp)
> TMP2=$(mktemp)
>
> git checkout next-20190513
>
> make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP1}
>
> curl -LSs https://lore.kernel.org/lkml/20190513222109.110020-1-ndesaulniers@google.com/raw | git am -3
>
> make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out mrproper allyesconfig drivers/misc/lkdtm/
> readelf -S out/drivers/misc/lkdtm/rodata_objcopy.o > ${TMP2}
>
> diff ${TMP1} ${TMP2}

--0000000000000f1d550588cd6d0e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFKZQ30Ba7tWpco9X1w1+rCj3EL7PMB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCBYqYUFE+i
TQMkmb+REO8oqnVizOlEwetvWj6JZ52MR5R/GnVUDk93HaQ0/HPTsQXPjdRW6ovhwacPvyVibPqO
sNhBQKGIhraFU63dGxjKV+hf0XGZ6eWTdGCgKM3oERM3CQZP0CoVM4XQZWOmEDmEecI+f4HuXM8Z
ke711gfqtr2Y6tBaGuMcfNWecBvSKadT4UGd7waeJeQNQVy+iW7zQn5n2FM0YdolPpGuxDf66s9r
OJQs4wIGQDe3Hv8oXW6P0mhRTnj1vy/V+sEQ3wTaW5eYVmMQ/81uvoWbVUCFKxZYfawzn7D3Y7eZ
RdJJn32S4sSsQDobjysjGC+x8rJUMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
QtCKlclgib8R2wpxMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBPFSKJZfB0uUMF
GCoCear34zEBJEWrML+B5ShWDxNxVzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTA1MTMyMzM5MjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANT9CfqeMHrLr+D72G+ABOcHydznIjEde
RWidmy/1QpmWFh8kRlomOZwnSnk31TxBCUF19ySaCVsITBfguJwhRyTd486FIAhqWWG9prYX8G1h
+iJqYQLZIrfvUSbbr19a/Hc+0ebzkKfu+yRq/nrO9tpeeoXoJgsljLXb5CLvcw10QjqG/dSfyyi3
MTf58lklpqHtRXvlqealFpZck0atUUzxVLKwpbThqY0JEP3oOzV9ZA34NfbcjQnqcchcBNlc2byr
S3ZJx4GuFtBBBQKCifYTJp9tBenmu/fgvtScoRiQUJvSY8J11Ujvy68kPZw5WnQQXbdDeRy9kB+7
6j+w3A==
--0000000000000f1d550588cd6d0e--
