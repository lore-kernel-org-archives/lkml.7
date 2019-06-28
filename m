Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B181206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZU3+JPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfF1I3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:29:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34753 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1I3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:29:23 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so10842488iot.1;
        Fri, 28 Jun 2019 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lEUN5IUuOCOSnK+6+Wu6+QVLHr1nY2ulPTI4/a9L6YY=;
        b=rZU3+JPxxchngzA1soqhb0hiWhtadkNNjWpFRkIhDxzciqOgD1BzGNaB/g81ys11r8
         zEs35DFfn5OrWbYjZHfn4jTszTHqexUYwU8+K8SUfal4RfyCwpk37MGhZwMhZtwS+wxb
         3+icYPYkdyoGYgaAEYESoHFcsO8CKnD753woHYbk5xbxbmQU/W6MzEloSL7zYLF1rp3r
         /TfyNZIJn5A0sr5LfBhSz9xlQP1+Aarpxs7AuZWmywy9c/JNAlx1B/hdryxH4aKn0eLD
         32jdR0qCqOGY/oxzklift1WxKn9hImoUpdDeynuziL5iCzam6YcBafMHFPyCFvnyg76e
         wzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lEUN5IUuOCOSnK+6+Wu6+QVLHr1nY2ulPTI4/a9L6YY=;
        b=TPAea5koGqfihmVb/DCXsf2N/OLl7hoE9ZE3layAlWtu4wi+CR2BUmx5Wz23uXtA5G
         x9c3c8rb60bED2jgHxfGFz9O9iTNAYLF/ovtNlejp3UsUeKuWWryLLqTjsCLE3BYxIgX
         gpQxLwrkXmaDHeJL01B6lcKOndDavj661YtomuwgcfkszuP7PxMzNw3+w5Z0RQN8CiDJ
         vmzQaOLwjVVLW8v6Y097cBTK0sYFqJSS1McZxjtmseDQMAvb9ufeS4d5OQzJPWE46wI8
         I2kebLLsoWBBOchWZmKFUt74IhQSYUjLtM1rpy1sfky32IbZXICr2k01HKy3vQijU9yq
         Nsqw==
X-Gm-Message-State: APjAAAX5pHQudJomKJ/Y7f/bSoTikLpmLvxDNwQdLceKgTNZoTcHpHLL
        0JJwqhPEO1QFkZ1XlpjWeek=
X-Google-Smtp-Source: APXvYqz5putxt1wdFBOPJ2PvEKnDU4Uu+E2Ka04oVw2UGUFv9pbEnJG54LhFEQk3Zwyjdz0xQnCOvw==
X-Received: by 2002:a6b:bec7:: with SMTP id o190mr9087203iof.158.1561710562952;
        Fri, 28 Jun 2019 01:29:22 -0700 (PDT)
Received: from [192.168.1.8] (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b3sm1313370iot.23.2019.06.28.01.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 01:29:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4.14 0/1] 4.14.131-stable review
From:   Kelsey <skunberg.kelsey@gmail.com>
In-Reply-To: <20190626083606.248422423@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 02:26:54 -0600
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <525FE383-E164-41D8-8890-B79D78843DC9@gmail.com>
References: <20190626083606.248422423@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled, booted, and no dmesg regressions on my system.=20

Cheers,=20
Kelsey

> On Jun 26, 2019, at 2:45 AM, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> This is the start of the stable review cycle for the 4.14.131 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, =
please
> let me know.
>=20
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	=
https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.131-=
rc1.gz
> or in the git tree and branch at:
> 	=
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git =
linux-4.14.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h
>=20
> -------------
> Pseudo-Shortlog of commits:
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    Linux 4.14.131-rc1
>=20
> Eric Dumazet <edumazet@google.com>
>    tcp: refine memory limit test in tcp_fragment()
>=20
>=20
> -------------
>=20
> Diffstat:
>=20
> Makefile              | 4 ++--
> net/ipv4/tcp_output.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
>=20

