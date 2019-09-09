Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CB206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfIIATb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 20:19:31 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40188 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731816AbfIIATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:19:30 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x890JTbj012818
        for <linux-kernel@vger.kernel.org>; Sun, 8 Sep 2019 20:19:29 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x890JOCA026374
        for <linux-kernel@vger.kernel.org>; Sun, 8 Sep 2019 20:19:29 -0400
Received: by mail-qk1-f198.google.com with SMTP id 72so14254763qki.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 17:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=XURxT6fvT6QjdpaE2ZV90LKqGI9hHt918jy1XDFcpmk=;
        b=klp/+qArjpcUpVvqiIY6BBz80VT/D2xSu4PffpMQit3vYXsHqu2wPBMiWcEvFkIwMd
         q6e8HIFvBOvCT3oRpx39+kIvKaRQbK+qq0XUnxsAK8yI0sgIGlI3J5QdbJ01F8+0JBTr
         1Ar8cmkdNwmhbuICgilvdy4z/h8e7Q0Epm4Jk+U4Is9DmluGixmS+Q/29nYU24RF/KTO
         thHnzMkowwpQJrhY2DYkl4ULRZIplN1GOrz1oF8PHz19bC7fACAWpPYbCQH4/he32Im7
         IvQsNbH1j2kLGXoZj8GxNxQOw/bGNjWLu4JOiqR0GeTGxCD8E/XqGyRTNGKR7vali+0G
         +6Cg==
X-Gm-Message-State: APjAAAXR4r5+gRfq/xyTeRzE9KseWGopUMKnXboTPKuRyc7KlabJ/yqE
        aws9dzqo2sAJsofrJZQm2Xmc0uinC8ZGFcXGy0j+WnujbZkrWKbxjfuWuMlYR/0OjdrIZmh5c+o
        gvGna68R+KzHyPa6srHFQBzIcqPVsAz42N/M=
X-Received: by 2002:a0c:f98b:: with SMTP id t11mr12572429qvn.31.1567988364056;
        Sun, 08 Sep 2019 17:19:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaGBbeJbYRPCwlef2f7pIb586nP6RILE2CiiNEXS2BHBzkyQ8Uf6j3CqKu3ReBIs3SgmZ6hQ==
X-Received: by 2002:a0c:f98b:: with SMTP id t11mr12572417qvn.31.1567988363743;
        Sun, 08 Sep 2019 17:19:23 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id d25sm5281456qtn.51.2019.09.08.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 17:19:22 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: exfat: drop unused field access_time_ms
In-Reply-To: <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567988360_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 08 Sep 2019 20:19:21 -0400
Message-ID: <1049678.1567988361@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567988360_4251P
Content-Type: text/plain; charset=us-ascii

On Sun, 08 Sep 2019 16:10:14 -0000, Valentin Vidic said:
> Not used in the exfat-fuse implementation and spec defines
> this position should hold the value for CreateUtcOffset.

In that case, rather than removing it, shouldn't we be *adding*
code to properly set it instead?

--==_Exmh_1567988360_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXXWaiAdmEQWDXROgAQJaiA//XmY9hFhK+ms7UdhqDGjmxCcRVXkvAKjv
i9Vfg6FtiyXGUBpJfkNSx2ZKbccm9BxPXOnvHpGaVVWY0VlyJn2/s/MXIThsrFpC
r+tEdWfbU2ak6emc3h7WvuSpSKnpHnbfVHakRF/oCJxB17c0XzfmtI9MUTciv7DZ
/FgDpxKCgbfsr3BxpXho0p92FdMIDFeeF8cZkPz760dA5Kl5XwwdnxrsNh2z9cyq
2gQFNudxx4ONCzbYsz0WTWlhiP+zMZqIzywaIFb5VElW3zSZfnzUn2cWFbb5bN6T
CWl0NIcEzM6LVWxYNj6klvuXQv8qhBuAEMKpCQ/xxp0zJCOE4C5w9mt+REKX+VLY
HzXmFP+cG5KeX/NiT7W7Ct+tVmpH9RFV31ACqa9oASwd9abCsWo52MJf6QIijEI4
kxTXpeGHTWi19U0j1hl7TjaiWiCrFfrPvM/OthuNHVN03YvPrLXYT3Zl63TQ6EBn
sMPmgibc3jgGFn/OwRgwsGvjJZUh+fMjKr2FAXhR9EE3HsvusgA0UiC79fhwDrdV
7soVdVuGXTi0BcJWhYZaRoGKqwmrrxHp1Ka+wler4i8HVDQZREbuYqsDgFJOVPck
ScgjgJv9VV/H0hdygeDr8Xl2Nz772uyxUqYEx++OkpEKPQlXKRtz3O0Nwp5RcsBN
gg0FHdjqh3s=
=Bf+t
-----END PGP SIGNATURE-----

--==_Exmh_1567988360_4251P--
