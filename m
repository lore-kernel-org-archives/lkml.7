Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A9ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C6206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZxDiYAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfJKVhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:37:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJKVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:37:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so11739499wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2/M/8TgqevPZJIJaGzIq/ho4pN/Lhe0LOV+9JQIHxQ=;
        b=LZxDiYAjMh7s97t8vdMHFSdouK4Oj4tixpFRD7BzT9HHvz5juTnQRQfMvCRkZNrgDC
         SuYBsC1LDYkoHxuLIBTZhlWti+VJGF7WUdZyK9/4v3U1geembF/likHdA50ZhFNPwh5/
         BEr2fhx/2yic3fEEgVQ4kqPoMf1KJlWMENFfqJrRIvtoFsSPrOnqoY8FIkismt6sNzkq
         pjgUd+leaVx1kD0Gu2kHXogOJmIvxmhaoO7uJXyL9yw1vUsgv7wVkO04zurbwO+Z16uL
         /jOTe5Ymt5FDKBqRyRNM87V5e/8bfvNS0C3VsxJ16c+mBoLYyad8pzXv0gli2VbSK4Td
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2/M/8TgqevPZJIJaGzIq/ho4pN/Lhe0LOV+9JQIHxQ=;
        b=MVJ9gbTgyKV8NhPKAijpwMfC3d87pnobMAqi0JPB3lXLzHjF1dsVAA8LQQK/RkvZJ3
         tNd9eB1w9y9RawQBhrXuY896oPyjWJ4aWcnVl7Pchu8UXrsxFReSHyq0Lg7+bC8BixdW
         pVeyBv4KAKNNpb8UjlunmDBq4LD1yn4ndwc6gJJDzvA+7N12iN3LPydvVlslKEdZjbJT
         jjWE5x7FesIYOwNxYY6ydny8YKlWBaoY7xm36HbJJllmRdHqTvI857/mUhpwCAYUwsL3
         7JSpXXZGaias+paI4Jy8HzZvRTiVkFCB+5tZ1tGzLDGR91LMc7BQf3u0wVJ7mObBKqcB
         4I6g==
X-Gm-Message-State: APjAAAUu5/Aki6lOsdKk2HTtRE/o1dNm5mWXrX0oVwoyG9f2u36XUiRx
        bcQ6WmTDI71gXA7qGrSWNATvRJRTCPcs1oTJTxRbfg==
X-Google-Smtp-Source: APXvYqx4gZWC/4gQM1g8hp9U5tg4gqchraRc6bVe8Z/AhWCS77QFgSgadFAGVzprms6Zklt+yEo0j0Y2p8uXKz/MHcc=
X-Received: by 2002:a1c:444:: with SMTP id 65mr4935377wme.84.1570829857168;
 Fri, 11 Oct 2019 14:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191010185631.26541-1-davidgow@google.com> <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
In-Reply-To: <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 11 Oct 2019 14:37:25 -0700
Message-ID: <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for the
 'list' doubly linked list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000acf18b0594a9535a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000acf18b0594a9535a
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 11, 2019 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> <looks at kunit>
>
> Given that everything runs at late_initcall time, shouldn't everything
> be __init, __initdata etc so all the code and data doesn't hang around
> for ever?
>

That's an interesting point. We haven't done this for KUnit tests to
date, and there is certainly a possibility down the line that we may
want to be able to run these tests in other circumstances. (There's
some work being done to allow KUnit and KUnit tests to be built as
modules here: https://lkml.org/lkml/2019/10/8/628 for example.) Maybe
it'd be worth having macros which wrap __init/__initdata etc as a way
of futureproofing tests against such a change?

Either way, I suspect this is something that should probably be
considered for KUnit as a whole, rather than on a test-by-test basis.

On Fri, Oct 11, 2019 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 10 Oct 2019 11:56:31 -0700 David Gow <davidgow@google.com> wrote:
>
> > Reply-To: 20191007213633.92565-1-davidgow@google.com
>
> That's a bit irksome.  Deliberate?

Whoops, this was supposed to be In-Reply-To. Please ignore it.


On Fri, Oct 11, 2019 at 2:07 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 10 Oct 2019 11:56:31 -0700 David Gow <davidgow@google.com> wrote:
> >  lib/list-test.c   | 738 ++++++++++++++++++++++++++++++++++++++++++++++
>
> Should this be lib/kunit/list-test.c?
>

The idea here was to have KUnit tests co-located with the code being
tested, but with the linked-list code contained to a header, lib/
seemed the best place to put it, being alongside list_debug.c and
similar.
lib/kunit just contains the implementation for the KUnit framework
itself (and tests which test that framework).

Cheers,
-- David

--000000000000acf18b0594a9535a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6wYJKoZIhvcNAQcCoIIS3DCCEtgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBRMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
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
CCsGAQUFBzAChjRodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2h2c21pbWVj
YTEuY3J0MB0GA1UdDgQWBBSZyvyRreTRp+gUyf6vW7p8tyBSITAfBgNVHSMEGDAWgBTLOBKwx5nA
eJKMsyGV5vQmYsDgPzBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzA7BgNVHR8ENDAyMDCgLqAshipodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzaHZzbWltZWNhMS5jcmwwDgYDVR0PAQH/BAQDAgWgMB0G
A1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDANBgkqhkiG9w0BAQsFAAOCAQEACwT27gzXkl6b
7+EfswyCAA1ILEwMiRx2hozR/i7o6qlwQW7aLeaUdNH0FfdGzmDm1/E4z2/F8OUAftiVa3Njd74k
vmE0XVZa8nojKjsQ97cHmZWO21L92O7ASV5OXSpmbebF2fvyFaX8q31upLngnrv5BzEm1ayGGj1I
vFK3Sz/VGxNVen5WDJZ0mb22I2FOdK9nPP5i/thaLXIHUxlsMj0TL+d6F7UUwR/kjq23qaW1rqWf
zai0PSzQ9GJu060idigAOkoMlSkWphhvLMjdeQ/BOtQWGbQmjXeAaTCicoGh/PInMrvWsqeB3UN7
tS993eH1GtcIzD4HO7q6+RjXFTGCAl4wggJaAgEBMFwwTDELMAkGA1UEBhMCQkUxGTAXBgNVBAoT
EEdsb2JhbFNpZ24gbnYtc2ExIjAgBgNVBAMTGUdsb2JhbFNpZ24gSFYgUy9NSU1FIENBIDECDDj8
hcuhQo0nUVK3VTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgsmg0WHll6RkeYzMT
a9MGnqI8hjYMfY7gYaSTvbCgPd8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTkxMDExMjEzNzM3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGC4CfZNTqZtHGAzL/MghDyvfCOgPwvrqC2O
s6s/VBPtSLHyl3o4nfWgvbjReLiGsIASIIjBPLfSX5C3G2gliG0xksYnqiXhp0c8YER+O7C2VYqe
A358G9lpVKkfbPPngD0Xn/BdvmQpyNPd6VxoD5TvEaCsOSZ65mbrNeB4qzucLK9Edy9CQsVIpsnC
tQIZYSryVxWgXY/J061h4nec/9EZPNAzO8MQQsxyrwqilAY8C5kzw9dA96LE1ySBk8NRMEA6G2OO
8NYNT7wi9q6H35pkeNNdXfl2kNMXiesTXAHaWijpmP3Hf/CVC2Jwlxt5ZKihYUSCzJQ3nH2iZt1m
AZU=
--000000000000acf18b0594a9535a--
