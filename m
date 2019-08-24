Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6497C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB8D214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566691112;
	bh=M1/H4AHqbV1FG5SmdVNCBOq8Z72AscE8HXdy4tYQpkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ehmasuZYOeljn4W4Hl8BNQpQDDQXA8HycynVbfTrIxQfKa3BRqznhtAtwR55Lj/U6
	 jQr8gdhrkt4aBMaznaJTg5XWJ4bwhqV3lzccIegJjD8PtEcEl/2gW1hBchLv9nY4nO
	 nQacLsj312fO8p9VZW8lP14kGhZbftwnpxRg5EtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfHXX6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 19:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfHXX6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 19:58:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 952CB2146E;
        Sat, 24 Aug 2019 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566691110;
        bh=M1/H4AHqbV1FG5SmdVNCBOq8Z72AscE8HXdy4tYQpkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VLmmmAQYvM86BVLQ3rx0sIRgOgK8wmNWAuTRLEvk0FKsiaGPjojwAz/OBewTTd3yU
         g+sz34F3MFg7Om9mm40XY7ji/6KHpCcL1CFvgw7typaRwp66ac+yKY3YA0OsvC2xDN
         rAXVTmMYQoTcLL71fZknTaaZVJb1irAy0cC3wGuc=
Date:   Sat, 24 Aug 2019 16:58:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/2] vsprintf: introduce %dE for error constants
Message-Id: <20190824165829.7d330367992c62dab87f6652@linux-foundation.org>
In-Reply-To: <20190824233724.1775-1-uwe@kleine-koenig.org>
References: <20190824233724.1775-1-uwe@kleine-koenig.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(cc printk maintainers).

On Sun, 25 Aug 2019 01:37:23 +0200 Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:

> 	pr_info("probing failed (%dE)\n", ret);
>=20
> expands to
>=20
> 	probing failed (EIO)
>=20
> if ret holds -EIO (or EIO). This introduces an array of error codes. If
> the error code is missing, %dE falls back to %d and so prints the plain
> number.

Huh.  I'm surprised we don't already have this.  Seems that this will
be applicable in a lot of places?  Although we shouldn't go blindly
converting everything in sight - that would risk breaking userspace
which parses kernel strings.

Is it really necessary to handle the positive errnos?  Does much kernel
code actually do that (apart from kernel code which is buggy)?

> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
> Hello
>=20
> there are many code sites that benefit from this. Just grep for
> "(%d)" ...

Yup.  This observation shouldn't be below the "^---$" ;) An approximate
grep|wc would be interesting.

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -533,6 +533,192 @@ char *number(char *buf, char *end, unsigned long lo=
ng num,
>  	return buf;
>  }
> =20
> +#define ERRORCODE(x) { .str =3D #x, .err =3D x }
> +
> +static const struct {
> +	const char *str;
> +	int err;
> +} errorcodes[] =3D {

It's a bit of a hack, but an array of char*'s and a separate array of
ushorts would save a bit of space.

> +	ERRORCODE(EPERM),
> +	ERRORCODE(ENOENT),
> +	ERRORCODE(ESRCH),
>
> ...
>
> +static noinline_for_stack

Why this?  I'm suspecting this will actually increase stack use?

> +char *errstr(char *buf, char *end, unsigned long long num,
> +	     struct printf_spec spec)
> +{
> +	char *errname =3D NULL;
> +	size_t errnamelen, copy;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(errorcodes); ++i) {
> +		if (num =3D=3D errorcodes[i].err || num =3D=3D -errorcodes[i].err) {
> +			errname =3D errorcodes[i].str;
> +			break;
> +		}
> +	}
> +
> +	if (!errname) {
> +		/* fall back to ordinary number */
> +		return number(buf, end, num, spec);
> +	}
> +
> +	copy =3D errnamelen =3D strlen(errname);
> +	if (copy > end - buf)
> +		copy =3D end - buf;
> +	buf =3D memcpy(buf, errname, copy);
> +
> +	return buf + errnamelen;
> +}

OK, I guess `errstr' is an OK name for a static function and we can use
this to add a new strerror() should the need arise.

>
> ...
>
