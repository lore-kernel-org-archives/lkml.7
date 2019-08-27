Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB982186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfH0TZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:25:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42646 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730423AbfH0TZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:25:34 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7RJPW3U010329
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:25:33 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7RJPR17023447
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:25:32 -0400
Received: by mail-qt1-f199.google.com with SMTP id l22so17296706qtq.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=/VrYLSYfcVcWU8zr6i2AquUrruupT+f/dYq6MTZWV9A=;
        b=rbp9eJLU5jpXFcyGgNoPuuFN6lCeFbqjp0R/fYyBPCglCuF6tGNMz0OwUwW31N0gAP
         f9TZAqbuqgVZKTgO39aiwgVhqDbE/2Lu9ewA/HoJQ1gwUawCwpgLge2+KD8QeUbj8YUc
         ta1Unt5fACMA51DD7CfGPhp8spuEYpf6ff3+cATN6HGvfVlj+/U+SCR12Lw7eOLV6fAa
         1+9T6ddb2q4qd91o+/FEtprNTe5TBB/4ISucihZdXmOr9wu4rW8xc5bitzpJ2a4EiAYX
         JQ6d2eCbZ4jFfNblo+ekLv7dPTsKcgFCjcp+HMeIKCDOBwrezNZiYFmGhURVyKI0t2Ku
         ApFg==
X-Gm-Message-State: APjAAAWEX/ohxtuBu7MFcHFqa4rGsU3Pvh5MLN9bwzAceK/eY0zjtM9w
        OQPj3rTIzFch7Coe4q/qMlPLPNUSVqiKiCfzjlmHbYzYYwcgSvT/6LERUCGJ8C5K2WdOcGuTtEN
        hHc8z/KWt/z1OfiXwzANzLiIBbBd0SZ7D6Qw=
X-Received: by 2002:ad4:4301:: with SMTP id c1mr135708qvs.138.1566933927557;
        Tue, 27 Aug 2019 12:25:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0pbhFIG53y1qAT0fpDgiysZVyE9tsfzlFkV4m2v3eE8h31MrmRk0phL4zAQ9B/pjlGvPJjg==
X-Received: by 2002:ad4:4301:: with SMTP id c1mr135669qvs.138.1566933927147;
        Tue, 27 Aug 2019 12:25:27 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id m10sm154810qka.43.2019.08.27.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:25:25 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, daniel.thompson@linaro.org,
        linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de
Subject: Re: [PATCHv5] drivers/amba: add reset control to amba bus probe
In-Reply-To: <20190826154252.22952-1-dinguyen@kernel.org>
References: <20190826154252.22952-1-dinguyen@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1566933924_1612P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Aug 2019 15:25:24 -0400
Message-ID: <30608.1566933924@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1566933924_1612P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Aug 2019 10:42:52 -0500, Dinh Nguyen said:
> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals
> that are not used are held in reset and are left to Linux to bring them
> out of reset.
>
> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset properti
> is not present in the device tree node, so the driver will continue to
> probe.

Does this DTRT for both old and new U-Boots? My naive reading of this patch
says on an old U-Boot, we end up attempting to bring it out of reset even though
they had already been brought out.

--==_Exmh_1566933924_1612P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWWDpAdmEQWDXROgAQIdrxAAon/T5pCtAGieFVjdAdhJjdPwqAhckoGF
6pdEvZoDtGgXHLPcNmX5YO0BXVRyCmQg8x57sEFISk2PrmS2Ax+UCVUpEaLQMjbD
Dd0vJxZKe9Sz95p4ELvhEVvXPVq9+rkIEmWsVUVNGWN4sbpQc7vs2+JtHwFlx+2n
m/taFbOH5qIRVYJQalBesf8WUcltYiA9ox4tKNYDSyKMqWVrGgvkxjO81appgJAZ
78x3eX94SyB2l7pJHNmRYdvr69kdFFzQDSbm1Y8rQnzar03fKUtpRmn1yXGc87wc
SG08stZRhvr+H98MHe4LjkjYNxNO+k6R0q+jmdjMwD+NaDveKt43ydl+xF4kbYbl
GzX+t51GUeU1PWnuHj+frYnUc0hv4N0xwC5SSWQ8vh0+0xQZsxYRluHLSEAw/VRp
Qh8+wBX3rZ8Q8dQfoXPfj9z4DdWgXAlDoB1yAJDtdRG8sdcKfGL71bZjv7hB0Z6I
XWnRsfqNevx/9Ev6shSve1jSHqGuuVb0ggOQVIcR9qaEeXI9UiRHOgK4qahEA6rI
Im7p+uPlHE4agtwgvXy4QTXksuKqFj8xouyI9QQc5PtI60bT83/PXQzS7ywotkZh
mFrpIGzD7D4xB4dQY4MB4jrGlPIArWfIKkqQ9jnTgD5dugR1CfejVwe7im0Lotyt
0bip0m4JQ/U=
=XqAz
-----END PGP SIGNATURE-----

--==_Exmh_1566933924_1612P--
