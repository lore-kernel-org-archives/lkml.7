Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA2214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mxwougxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbfDRUGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:06:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42511 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbfDRUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:06:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so2552272oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6psBRnFpB7DT4kJqxN1R2rbuZUxd3M/O30vwsyGIaQ=;
        b=MxwougxjhQcCTyKYfeGv+CT6C1LW/27c3RnEo5RB48icabS9MZuNIbfzLAdKFm9cg4
         pUx2CL/lVJnirHDWUJNVkr0qYSSGsvwpl7863zjCXPdLnL4HBDSy9qjpOSlheODczUQq
         sd+PxYHPXb5h+vtiOGlbQjCahO9uKZ53r0q9j8i2Mi+v7wxwT6A9nEV5/hLZ4pyP1LUb
         SSWu3CizXPA45sQeFs8cCaLTtkYv9ws/lHoOLtXo4UM4eFODiRlvLSOHil3Pq1/8W3lS
         QLYoAxwPtG4KtZYML60KS0kdzbzSunUbB7+3SB9Gz+aqyA+QSiz4Q1VfaDI89A9cHLbq
         rwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6psBRnFpB7DT4kJqxN1R2rbuZUxd3M/O30vwsyGIaQ=;
        b=QMbMEWWImszp91nemyI2566WjAWzdtl7jah2lcFQmSwqjtYWLry7JE1+I8ASlzj7ad
         Ig8VquJ19z1N4gg2mg34hjJM0oQXv9kcKnuRcbjplP4qd4IAX/9f5eMfC11eiKJ8mjlS
         qBUvX/cNUUaIc4ZLCA8WEHonQXOwp0zs5xdcmwtDcCBUZlaIvaJu9NpPIcf6n+X0HxKg
         SYsTR5C5NuxxNN/wCkPYmj2m4Vio2ndkXt2OhFI3YcW9Iw0nmrxDiPvH+ToOxSgNa4Yj
         LdMS4FHAwcjPLUfE9UVjzdX5AFLkRAxyWKI1R8p3XiaU7smX4O/CEIo8JAoUi2ZC4ZpH
         OsUQ==
X-Gm-Message-State: APjAAAXFLypezD7H8B2ZffczNWSInwc0mUepfhUstTkPwF5cNyTOZKW0
        Z58PNCLfoLlpWLuNLOnovKf9D/voqJPWMj69WdYjqQ==
X-Google-Smtp-Source: APXvYqyk4amR67SqzEPJyzNej8ggsRvFq0vQ+XpcnpCGh+Gt+LDcWGHGbOpTd0FBTt/m3DAZjGuclb1S5HSyLQEe1GA=
X-Received: by 2002:aca:f20b:: with SMTP id q11mr3206032oih.4.1555617967313;
 Thu, 18 Apr 2019 13:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190416025934.115252-1-khazhy@google.com> <20190418115326.GE28541@quack2.suse.cz>
In-Reply-To: <20190418115326.GE28541@quack2.suse.cz>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Thu, 18 Apr 2019 13:05:56 -0700
Message-ID: <CACGdZYLCi+Or=afmBK8hbP3Ay8x8Oaqnp0Yr+jf1PoQiMc7_DQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: add cond_resched() to ext4_mb_init_backend()
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006269a80586d38844"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006269a80586d38844
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 18, 2019 at 4:53 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 15-04-19 19:59:34, Khazhismel Kumykov wrote:
> > on non-preempt kernels for filesystems with large number of groups we
> > may take a long time (>50 ticks) initializing all the groups.
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>
> Thanks for the patch. I'm not opposed to this but I'm just wondering: Has
> this caused any real issues to you? Or how have you come across this
> particular loop? Because I'd think we have more similar loops in ext4
> codebase...
>
>                                                                 Honza
>

We have some instrumentation to warn for these longer periods without
scheduling, which admittedly does trigger relatively frequently from
various places. This particular loop just so happens to be during
system startup where it caught my eye.

--0000000000006269a80586d38844
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
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
9w0BAQsFAAOCAQEACskdySGYIOi63wgeTmljjA5BHHN9uLuAMHotXgbYeGVrz7+DkFNgWRQ/dNse
Qa4e+FeHWq2fu73SamhAQyLigNKZF7ZzHPUkSpSTjQqVzbyDaFHtRBAwuACuymaOWOWPePZXOH9x
t4HPwRQuur57RKiEm1F6/YJVQ5UTkzAyPoeND/y1GzXS4kjhVuoOQX3GfXDZdwoN8jMYBZTO0H5h
isymlIl6aot0E5KIKqosW6mhupdkS1ZZPp4WXR4frybSkLejjmkTYCTUmh9DuvKEQ1Ge7siwsWgA
NS1Ln+uvIuObpbNaeAyMZY0U5R/OyIDaq+m9KXPYvrCZ0TCLbcKuRzCCBB4wggMGoAMCAQICCwQA
AAAAATGJxkCyMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAt
IFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTExMDgwMjEw
MDAwMFoXDTI5MDMyOTEwMDAwMFowZDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24g
bnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVyc29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hB
MjU2IC0gRzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCg/hRKosYAGP+P7mIdq5NB
Kr3J0tg+8lPATlgp+F6W9CeIvnXRGUvdniO+BQnKxnX6RsC3AnE0hUUKRaM9/RDDWldYw35K+sge
C8fWXvIbcYLXxWkXz+Hbxh0GXG61Evqux6i2sKeKvMr4s9BaN09cqJ/wF6KuP9jSyWcyY+IgL6u2
52my5UzYhnbf7D7IcC372bfhwM92n6r5hJx3r++rQEMHXlp/G9J3fftgsD1bzS7J/uHMFpr4MXua
eoiMLV5gdmo0sQg23j4pihyFlAkkHHn4usPJ3EePw7ewQT6BUTFyvmEB+KDoi7T4RCAZDstgfpzD
rR/TNwrK8/FXoqnFAgMBAAGjgegwgeUwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8C
AQEwHQYDVR0OBBYEFCYkkosf00SvsbAbba/udNKMeAADMEcGA1UdIARAMD4wPAYEVR0gADA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzA2BgNVHR8E
LzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24ubmV0L3Jvb3QtcjMuY3JsMB8GA1UdIwQY
MBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQACAFVjHihZCV/IqJYt
7Nig/xek+9g0dmv1oQNGYI1WWeqHcMAV1h7cheKNr4EOANNvJWtAkoQz+076Sqnq0Puxwymj0/+e
oQJ8GRODG9pxlSn3kysh7f+kotX7pYX5moUa0xq3TCjjYsF3G17E27qvn8SJwDsgEImnhXVT5vb7
qBYKadFizPzKPmwsJQDPKX58XmPxMcZ1tG77xCQEXrtABhYC3NBhu8+c5UoinLpBQC1iBnNpNwXT
Lmd4nQdf9HCijG1e8myt78VP+QSwsaDT7LVcLT2oDPVggjhVcwljw3ePDwfGP9kNrR+lc8XrfClk
WbrdhC2o4Ui28dtIVHd3MIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAw
TDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24x
EzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAw
HgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEG
A1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5Bngi
FvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X
17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmm
KPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hp
sk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7
DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQF
MAMBAf8wHQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBL
QNvAUKr+yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25s
bwMpjjM5RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV
3XpYKBovHd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyr
VQ4PkX4268NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E
7gUJTb0o2HLO02JQZR7rkpeDMdmztcpHWD9fMIIEZDCCA0ygAwIBAgIMUqKgP3W+3hLte8EVMA0G
CSqGSIb3DQEBCwUAMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIw
IAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxMB4XDTE4MTIxMjA3MDI0MVoXDTE5MDYx
MDA3MDI0MVowIjEgMB4GCSqGSIb3DQEJAQwRa2hhemh5QGdvb2dsZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDW70t47nXgqc/kXZ+wTkjd6Yo+epB5+DB1RyaLG2TpDoO/aYAD
lA8aw1qOwUV82/pbV7xLqKUUZsep8TR1q26tzBWMTCBS25nstbabZThDjAIMvXfVJiw97N4DsAHE
1qrNrck6NXYdDEvbc1Sqam5GQetyHNanL90LwZTZ2074ZG1fvr5H31Q2DlRpnN/JpqJpeB3aPNBd
oiDV8zALMTLAOkwdnsJwEJOWcMP/GnhHSe0r+5W0opsoCHni3FbvFE79zNhnL1jWal9iB36Xe5bv
EL+zyZHbzlQevJWN+vvZ3LvToayXav2eEZuSTvKYppPwV/kBMMtWeXidXR1V6VvRAgMBAAGjggFu
MIIBajAcBgNVHREEFTATgRFraGF6aHlAZ29vZ2xlLmNvbTBQBggrBgEFBQcBAQREMEIwQAYIKwYB
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFKmLvcm3Ia5yfcpBAXvZPJQvNwYIMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQAV9Ke+xXuLkzE6liqU
yHyMQ1P0LVYdCKlZOyJIcaM5FY+j+7C+dJwCvhVsEKAT+a7Fox5a2NbXOxyLFPN1QfaWFSefFYnN
iGoWjodq6mD4b4jK87qup40DrYGHL8qRgeG66TGoBrpm4S46655OCQo8iU0OE/aXr3uP3QIhHz9G
++2p88zFfj2bDwDx0E2Wd7ZxYbYZBH3dG9isCYexTn3gikT9Roj8FQwgrbv62Yklh9qIYaClGRvd
e0FTck3j3QEozkqeiTX2ENxGzTejkwBNVSXNEcgl9QDKDadAy//DTYfTW3VrW6CQsj8UvKt0QOXc
QnI3xjacoILpfqGbX4WCMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMUqKgP3W+
3hLte8EVMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBcWeEQEMygPjNR8QK665B+
weM0unAKfZJBdJ0u9VVR+TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xOTA0MTgyMDA2MDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAndu0nlmMX4AaRSMIAyIDUiRkiSpODxJjutHJR8Xg
u5e1yPWiXMmyK3IbOTYOchjWioHQIAqCCt5VFBNZhD10Eo1/VOt2hrO7DX4LXZJ3rzExgTMC2OXy
Kc3yWeB4J56KOERL38qyxCPFJZABHJCiGoScEzWQQ+9aQbJr+Q8TMBGwKyDq0OK+RI7dQKIs5jtQ
bgMoUuKd/i7e1ufbDokMndhM5X6E5FSaaq19D6wIcMy42b8IymXovy1I19hMjMrLRqSxNxAIqD6x
BPcGF6hO/uVsMbkjkyv+iYxn7+62yoGqBUiToNW0M7SAG5kRv29WFIcRiOwIKA+zfCNrssmdlg==
--0000000000006269a80586d38844--
