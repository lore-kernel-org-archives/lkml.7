Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFA521848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIV5RTsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394762AbfJPVtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:49:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394721AbfJPVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:49:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so29658716wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+X7Hc9+9kZ9bvpM8j/9p1fpCYhA60kt0JDHGpFj+5jQ=;
        b=IIV5RTsu/wsF2/pG92OGHkVY+WtcDtHGJENZGEUl4ecpYY/EdHl7ZV24lWSE/7bg75
         awpDLSfhp6Rt2GPFWVsace2lFiTdjrG2GHSkVpV9dW8glXMi+PdZu5nDwjrQ/zIbXnJm
         wSkUtLBxErpeuxGX44IIuQ8ak4MmAoTl0ti7JKucEXDimq82FcwVEMj8Lk0uHmQH/ibd
         hUTmcfVF8yHVJPCREXIxnFlZeXGYa/jHfW+kAicUmMFMgBkhJffjJP80BboGz50yno/h
         zKMa8UqmfubQMSOq6O1AmBUP1dIxTEt2MgHxNbhMWw8SsUkgLVBXB5NlHHtx1AuQS+30
         kfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+X7Hc9+9kZ9bvpM8j/9p1fpCYhA60kt0JDHGpFj+5jQ=;
        b=VwJm6IWUg7g4WQCzmxM5qyeGzLKUsG7Wu0zjtIEld70ZRuqZ0tMeB1Cw9UxQXUAGLJ
         TTPkQusiqSIn9eCoKgxtiHpnFckVCMgm/6JjtWja4yUib2B3eVUoddoxraJ9gaV6Co65
         whTOjcV5QxHlx/mTKwCuXdt4D/t7NKo7BmczS5TuI4EyLzcbZ+SWtaCTZMbHIAiYbVPl
         pPDWKbta5O82FuL7igOap2oo1OrNwy88g/QZSj4YKRSKfycxsQhfR9sH8eymEIRnwvXx
         G6PLBIa0tP3me+d45XQzf6fZchtJB3odHUhnERuU4Cmggosn37rIqwUtX0H7PRY+n1TE
         1s3A==
X-Gm-Message-State: APjAAAX93nKxzbFmaRDoBaGe4ds1TkAqfqNudG29VD5uujPdvQH2NXSM
        fC2IF4zpbLdZA8b2NqbZcH9Wb/lnc+KTJIJbys+6rA==
X-Google-Smtp-Source: APXvYqy2ifTj/41CUJKYlnNnPwUNZyeUFAW1IL2uPIvDye8iXvKbGZf1qbfoyxHPUr/zGy6mTaUMmPY3A5iLHFg3OT0=
X-Received: by 2002:a5d:4302:: with SMTP id h2mr34229wrq.35.1571262550711;
 Wed, 16 Oct 2019 14:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191010185631.26541-1-davidgow@google.com> <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
 <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com> <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
In-Reply-To: <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 16 Oct 2019 14:48:59 -0700
Message-ID: <CABVgOS=W4cfFoE=JT4mbk1zkUsreucrw_B81R2jwDCFPocomHQ@mail.gmail.com>
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
        boundary="0000000000003a8a3005950e1215"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003a8a3005950e1215
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thanks, Andrew, for the review and for adding this to the -mm tree --
having some soak time in -next has been helpful and picked up at least
one bug.

Since KUnit is not yet in Linus' branch, though, it probably makes
sense to put this test into the linux-kselftest/test branch, so that
there aren't any chances of the list test getting in without the KUnit
infrastructure. Ultimately, once KUnit is upstream, this shouldn't be
an issue, but it is probably easier to consolidate things for now.
Does that sound sensible?

In any case, I plan to send a v3 patch out shortly which addresses
some memory allocation warnings (caught by Dan Carpenter, thanks!). I
could always do that as a separate bugfix patch if people preferred,
though, but if this switches to the linux-kselftest/test branch, I
feel we might as well get it right in the original patch.

Cheers,
-- David




On Fri, Oct 11, 2019 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 11 Oct 2019 14:37:25 -0700 David Gow <davidgow@google.com> wrote:
>
> > On Fri, Oct 11, 2019 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > <looks at kunit>
> > >
> > > Given that everything runs at late_initcall time, shouldn't everything
> > > be __init, __initdata etc so all the code and data doesn't hang around
> > > for ever?
> > >
> >
> > That's an interesting point. We haven't done this for KUnit tests to
> > date, and there is certainly a possibility down the line that we may
> > want to be able to run these tests in other circumstances. (There's
> > some work being done to allow KUnit and KUnit tests to be built as
> > modules here: https://lkml.org/lkml/2019/10/8/628 for example.) Maybe
> > it'd be worth having macros which wrap __init/__initdata etc as a way
> > of futureproofing tests against such a change?
> >
> > Either way, I suspect this is something that should probably be
> > considered for KUnit as a whole, rather than on a test-by-test basis.
>
> Sure, a new set of macros for this makes sense.  Can be retrofitted any
> time.
>
> There might be a way of loading all of list_test.o into a discardable
> section at link time instead of sprinkling annotation all over the .c
> code.

--0000000000003a8a3005950e1215
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPCgYJKoZIhvcNAQcCoIIO+zCCDvcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxtMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
KwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMFEGCCsGAQUF
BwEBBEUwQzBBBggrBgEFBQcwAoY1aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NzbWltZWNhMjAxOC5jcnQwHwYDVR0jBBgwFoAUTLcFidZTzSNAougPeBrkbVxM7NIwPwYDVR0f
BDgwNjA0oDKgMIYuaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc3NtaW1lY2EyMDE4LmNy
bDANBgkqhkiG9w0BAQsFAAOCAQEAJ/zitSY5ytjRHvjJRs//GXSqWUC9k+0tOBStoNWdT0W+IU1B
1LFJELO6cCMS7c1z3KsQoLfLNc/eSYUv/jVWQoXht3qEyYjRS0s/yq8fxvm89uCGbGqtPjygIohU
o4MsxfvqX/0D3LDZjBSQFsM5pzdIj2c+yEsDuTz1ZZONpsYJZ8e+2sd2soqYkQPjgrTw/DC4iLup
tRDKk7xLOvTS4GEcnNBZx8EPg9sKqyP51KSxSKQRKAH+fuugWhJTI582FJI1zXnFXW7CywdhCCfI
nCNqI2fk/FFl6FVqgaJKm30Sp4GZUd2VnH0aGYJq3gYFVph+jvojHGcUqOO5ggMjPTGCAmEwggJd
AgEBMF8wSzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExITAfBgNVBAMT
GEdsb2JhbFNpZ24gU01JTUUgQ0EgMjAxOAIQARE2WR1lhjWKYHwTHLtF1jANBglghkgBZQMEAgEF
AKCB1DAvBgkqhkiG9w0BCQQxIgQg4r8Ard2+L1AsIa986Utq7TyDAveQ8MCG6UsBzr/kWJUwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMDE2MjE0OTExWjBpBgkq
hkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAH6rfUbR3IsK7gb8ynVOPvTJ4OWmRmC83xgKKgfIxwtAx376fjRyH7kkNENBYuVOHOYz
zRK4L5UVb5MgVcvI9Rw9H6bfgHz1Svm6SYtXQGydqxtBbMAyA0eUBUtPdsAEuPuJ6ZChEHjnVyvu
AmnCX7CO9t1EniCZx0qKFLUHq9tJenLBgXDlt9ksKlNSF+y2Ozx4UN2Eq6o8/JG0PW2TYFPhInBS
agrd7kVhYONNogMlwpHnS5WXIXEIem4RTcMgmmSQA7gcynvcbCFhBoj3UZZNpxeGcZNk0EBcpd6V
5HPTtFMjkcKluvL/vJQg4hRqUaSkNXYxI+H3vH5YgMWtzU8=
--0000000000003a8a3005950e1215--
