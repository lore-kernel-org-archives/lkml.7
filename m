Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDBFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54432222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbx44p0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKMOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:48:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727831AbfKMOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573656493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=l1Qv7aCu0tMW7OtYm3xxr/Z3wqpzcl/ymo6pe6jRGuQ=;
        b=Zbx44p0mBLC3AVsGeFnu1eSknjQ0vckjlAy++JB3nvM839R3osYncVG1uKE5QH1javNlfu
        fayyKa4JaGxAJWpyk6T7oONQiXwFNPqFsuns4bLw6ChijfFd+YpJkQMh0+OSwxe8olHfTN
        QTJwcu005Or3Z1CbGBNP0arOWs1cj6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-GU9DzmQfPTKDTnh88FKbKw-1; Wed, 13 Nov 2019 09:48:12 -0500
Received: by mail-wr1-f71.google.com with SMTP id j17so1720394wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yT7ZKZSSm+kX84++2Q1R93ukDGNcfckJnyzL498YrpU=;
        b=htRk4vFRJQyfreOTHyNjYlJU2/GD0qQhK+3mB/qfvYVVn7AOj3pPK9vt4Xmk/zMpv6
         TAA8r6AoB2T/3gd4CJsPom3geb+7Cw9RPsRd01M6+yA4WtvDEQsrPG8EtKjyAxSK68Cz
         BGF83cotl4TTW5ZO/BK9XX7P+zpmWy6VuqFj9faIVNs5Mc1d2ocHp1FEhADJuDn0TACk
         EILJeKpCcLslltodfd10m5HE9sfuCZXMf5qxwhFZuq4U9MsJlwZIcT5gxhZoxiuVaPqH
         XmPv0CCf4zLytHlcSppNX2SBgjRBlFefDPMbu6XPB23t+SY6Lc9jimm+ulTVweCwoJNV
         eQ3A==
X-Gm-Message-State: APjAAAWi4BBJQHG8lPgf0nL1ce09U3Qg+oFxDxRBfN/Jx0BFomVgr4db
        pIPrLFTTXJ0CzjV+5yTeYwyvHBiWOKhcarPj3JDxe41oWtkc/YsBHNHoozl1TNMDUZ7SNrkJAfi
        yuKoFa3O909KC0zlV6yehNb9A
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr3341870wmi.64.1573656490870;
        Wed, 13 Nov 2019 06:48:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxr+4rLIvhy+ld6W8KwaCBq7eLefRn6XMnMwnAj+lSMGeaJWA8x4Re3qzAwTQpTUb02Kwolxw==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr3341841wmi.64.1573656490560;
        Wed, 13 Nov 2019 06:48:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:64a1:540d:6391:74a9? ([2001:b07:6468:f312:64a1:540d:6391:74a9])
        by smtp.gmail.com with ESMTPSA id j67sm2748757wmb.43.2019.11.13.06.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 06:48:09 -0800 (PST)
Subject: Re: [PATCH] selftests: kvm: fix build with glibc >= 2.30
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20191113125115.23100-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f439dee6-012a-d9aa-5f16-cbd911d6d55d@redhat.com>
Date:   Wed, 13 Nov 2019 15:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113125115.23100-1-vkuznets@redhat.com>
Content-Language: en-US
X-MC-Unique: GU9DzmQfPTKDTnh88FKbKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 13:51, Vitaly Kuznetsov wrote:
> Glibc-2.30 gained gettid() wrapper, selftests fail to compile:
>=20
> lib/assert.c:58:14: error: static declaration of =E2=80=98gettid=E2=80=99=
 follows non-static declaration
>    58 | static pid_t gettid(void)
>       |              ^~~~~~
> In file included from /usr/include/unistd.h:1170,
>                  from include/test_util.h:18,
>                  from lib/assert.c:10:
> /usr/include/bits/unistd_ext.h:34:16: note: previous declaration of =E2=
=80=98gettid=E2=80=99 was here
>    34 | extern __pid_t gettid (void) __THROW;
>       |                ^~~~~~
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/assert.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/sel=
ftests/kvm/lib/assert.c
> index 4911fc77d0f6..d1cf9f6e0e6b 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -55,7 +55,7 @@ static void test_dump_stack(void)
>  #pragma GCC diagnostic pop
>  }
> =20
> -static pid_t gettid(void)
> +static pid_t _gettid(void)
>  {
>  =09return syscall(SYS_gettid);
>  }
> @@ -72,7 +72,7 @@ test_assert(bool exp, const char *exp_str,
>  =09=09fprintf(stderr, "=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D\=
n"
>  =09=09=09"  %s:%u: %s\n"
>  =09=09=09"  pid=3D%d tid=3D%d - %s\n",
> -=09=09=09file, line, exp_str, getpid(), gettid(),
> +=09=09=09file, line, exp_str, getpid(), _gettid(),
>  =09=09=09strerror(errno));
>  =09=09test_dump_stack();
>  =09=09if (fmt) {
>=20

Queued, thanks.

Paolo

