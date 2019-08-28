Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A9020828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1Nqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:46:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47860 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbfH1Nqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:46:54 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7SDkrh5030898
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:46:53 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7SDkm8a014158
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:46:53 -0400
Received: by mail-qk1-f197.google.com with SMTP id l14so2527586qke.16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=6dlfkMiIJoG2i19B9uaZmEjU8eFDQ1sIWjxdg+T91HE=;
        b=Qz1bXNcNCskUAOUp9z1mm9J5CASnaybxWF2p9V1P96hD1q7zbnIBCcV4DLbZ3ZNQB1
         ty2A7GHdDMjBLSzTzTmMNue73SbFZEi//8ue1dQMluqFAZ40aXBOXV/9xoSZSZw121wQ
         1d7bVclwqWAdGJAzg3uSpT8Sd+YMndnwLpDtJUpfV61jV9pwzIl1YK55roRtwLwGyMgW
         xQZ8K1ypr9IEPpaMz1IUygA5zHxXF0h3eSPgo+PElnfe6snNQX7xMncOpn0jau0O5Nwr
         6CehbeHdL3pLD8uYGPQwr6HCya4dlHKgj3/eDz7iMwAAWkOAFVfoiFo/+UadL1pDj1Fb
         1Vtg==
X-Gm-Message-State: APjAAAUlFyttymkXnK/ks884JRJ+vViGawT31cjrEBUauPXQvuHZ466I
        5RO0S9DxX55h1UzmR2SNRDn8mzmSArTmFUs8x7mZyn3bscny7ksl9xOdrYZ3L9PbQ7YqL0jHxwQ
        L/HKGbQE3W94LlLkog6v2YhZtwMgVuGH3bx4=
X-Received: by 2002:ac8:7543:: with SMTP id b3mr4241829qtr.13.1567000008084;
        Wed, 28 Aug 2019 06:46:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQaF6n9TNJ7UANQVE9yf8af37GlOyOcqa4tTFHjolQSwZt4CkCi4+VJt/bQM0T+/UKVBdLGA==
X-Received: by 2002:ac8:7543:: with SMTP id b3mr4241800qtr.13.1567000007811;
        Wed, 28 Aug 2019 06:46:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id g24sm1327307qtc.38.2019.08.28.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:46:46 -0700 (PDT)
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
In-Reply-To: <46bcf493-9dd6-bf5b-089a-be158739a13f@kernel.org>
References: <20190826154252.22952-1-dinguyen@kernel.org> <30608.1566933924@turing-police>
 <46bcf493-9dd6-bf5b-089a-be158739a13f@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567000004_1612P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Aug 2019 09:46:45 -0400
Message-ID: <292438.1567000005@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567000004_1612P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Aug 2019 08:34:20 -0500, Dinh Nguyen said:

> > Does this DTRT for both old and new U-Boots? My naive reading of
> > this patch
>
> What is a DTRT?

Do The Right Thing, sorry...

> > says on an old U-Boot, we end up attempting to bring it out of
> > reset even though they had already been brought out.
> >
>
> If the peripheral is already out of reset, de-asserting the reset has
> no affect.

OK, thanks.  There's been hardware where doing that sort of thing twice will
confuse the device and cause issues.

--==_Exmh_1567000004_1612P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWaFxAdmEQWDXROgAQJZPhAAopKhP6wn5B9evWUpllhb6CIajYqxhob3
zLAF1vVdOpPXyTT3PaFMjwrqKiPt9QnMLHW5odZ5UswcH4dBRByhwb8Hr8a/Ibo9
Nb6BdK1KuilWx3bCvw63nNH9aB+tPvcaOUtux73gD+HaPa/XCvzZvObCnFCXa4oa
9gQJl8GG8pRLfH03QPSYGKAzyJ35qt2RBarVa0Z19NZPB5LDDePLKwxblatRFICW
mhdH1t6uC7CuxMqfHKbG5MyhdmgmmOyHg16tHxZ85B8f0CoCFAHx9sNzvS3dmXZd
bP2+r7cQ4kNkIWI/PNPzh+s8D9ZlWYdGn1p2VQU/4FKMh2d7IDS5MvLgA5rf0DiE
bOPBbqzfZ/DsfyW96M9e4/53OYYK5gqC+ZaePJKY4BkAHLNtKewczCw6E+kck7OW
4ya+eOEFQzl9wC5XNMrYkdV8DLhftU4qEzAHuNH2vHIK7BK+3ARGB4tSQyTMNi/x
yOPY69cLv4llawfjD/y0PSqmvKN1MlIjmxeAD9kh6AoTUNNNRgj0F+T/Ma91uBeV
50x+YgZZ104bD6d3s5U0kIgykQJARE0JivC9fkFuKZXE6vtIAssE3FFLw2NKncXw
Sq+YA6DuuSvCdhAWEmYJpbpwREHEGAjLsN+JBxPhV7vbbGhVV1UuYXPDVfp18Moy
fW9l0ZeoE+c=
=tC0P
-----END PGP SIGNATURE-----

--==_Exmh_1567000004_1612P--
