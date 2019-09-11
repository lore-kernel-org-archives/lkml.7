Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611C7ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B7D21928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VuZMT/9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfIKJF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:05:28 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38764 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfIKJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:05:27 -0400
Received: by mail-io1-f47.google.com with SMTP id k5so18845067iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rcHZ7V9Te0/ZBIfH3p5NzVwZRy2kREKEbZcXarQ/wOM=;
        b=VuZMT/9XyJEIM69eA46bFbypZPJF66OB0+eSboBzzYL5ASttwOQDAvjxBBR4sJslqo
         RMQdGFnVp/sy5tBDcpa85qTZS9WjktN0bXZqAhhyXtpuS1uQTovRyqMQm8eXoPkA4rLt
         DZgllNzl7KB8TbmGFGr3QuS06gigYWatW9pjg0uU2D1wimW2rIhLCw+txOdMN51hhfB4
         45ndhddr33F7vXCu/e4xNx+hjQMJMa6fP+LveWJlypqHRWl5tfOFIn0D+HGp1JzB7v/0
         3NmwX/4Pi13AZbC/c2Q0EjUzPwNMM4HVXo0s9SirPfru7sxaCaBA8SeFZ9tBXWJDGlVP
         0VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rcHZ7V9Te0/ZBIfH3p5NzVwZRy2kREKEbZcXarQ/wOM=;
        b=pZOsku1Z0SeO+0ahtoMzIspXc/qpW7Cse2YBh/IW+8/zmP/BFBbax0mbgfqT0JPP9J
         YjzQ8FCcotLgZdC02bFe5MUX1nC2afQ1CvWl1RyhgBfdehDmleF15evMFBl63iNoDUMs
         9gTafU6vmRGCMh6u1eoyRwEdcX2hpX5/qMxL+/iskh2bU8Ew8icZuyNmn1joLBR3pdHo
         E2Ge1QjD2OauvtNPJCZsMihkaD2q+39SHiPQ9cvJnB7ldPhRXFadjKHoFe4jbAMzqEdS
         0GxSY3aplYkTKX3WXnpAihOd1oiyyRWWnMlyivR/af1eXE8rGupzz/3/XwChwYbb640s
         n0ig==
X-Gm-Message-State: APjAAAWQV8wZ4nZO4/EhfSAtMi+BT1/cavXKwyGCDOt2ryU1tzB2KTCR
        jbpJsJZSEUHJaDUlzHlxumTtQg==
X-Google-Smtp-Source: APXvYqxMF51CnJ0mEaL1+NJdgmTNVeMqdL8V/PSvNSEU5r+6PqGq+T4qLRqwfbLWRxw4GTVfEcRVrw==
X-Received: by 2002:a02:c790:: with SMTP id n16mr37716992jao.10.1568192726929;
        Wed, 11 Sep 2019 02:05:26 -0700 (PDT)
Received: from [192.168.1.138] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id u6sm3745241iol.49.2019.09.11.02.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 02:05:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC] buildtar: add case for riscv architecture
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <NwVOGH2ZdDQaDK35QUy7y8GS__G8IYSIUUIBAJsimZq5BgvI3SzLS3uY6fV7Pgppq-RTRHzpT-8KrsLjDN74CPWwHTCWoSgHkGbeJNvyS30=@aurabindo.in>
Date:   Wed, 11 Sep 2019 04:05:25 -0500
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EF02DA7-46D3-4EA8-96FB-27708BF25DAC@sifive.com>
References: <NwVOGH2ZdDQaDK35QUy7y8GS__G8IYSIUUIBAJsimZq5BgvI3SzLS3uY6fV7Pgppq-RTRHzpT-8KrsLjDN74CPWwHTCWoSgHkGbeJNvyS30=@aurabindo.in>
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the available RiscV platforms that I=E2=80=99m aware of use =
compressed images, unless there are some new bootloaders I haven=E2=80=99t=
 seen yet.


> On Sep 11, 2019, at 2:07 AM, Aurabindo Jayamohanan <mail@aurabindo.in> =
wrote:
>=20
> Hi,
>=20
> I would like to know if something extra needs to be done other than =
copying compressed kernel image, when making tar package for riscv =
architecture. Please see the attached patch.
>=20
> --
>=20
> Thanks and Regards,
> Aurabindo Jayamohanan
> =
<0001-buildtar-add-riscv-case.patch>______________________________________=
_________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

