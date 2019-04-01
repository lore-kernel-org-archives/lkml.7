Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E769C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91820857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="q8PJjbyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDAPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:08:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:20346 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554131318;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=F2HAQv9qThTOM9UY9KIYr3U+mj5UM9htNBvnnNlPyJg=;
        b=q8PJjbySixiElj8miJ/lGoxuSXEXLbLINFAYX33IdRhU+aWv2vXUknCvZ+OB3WN8zd
        Tn5EylMjC8buR0BGm4IS9sQnpcUz8T1zazCI0bDokLQgW3tPJ509WJAblBeGabXdxpHD
        GXZhhKLqbleJZbOGhYe7KCp1iqfk5lxmjyQIZH6eyq1QOtl84S9vOkWey5ES/JmVHVOI
        vNSd9tUn5sK4NhmC9IvHMa8szseFphYoyaJvIHPV4A+HEhh3y5MLPLo1lOWD2bzDpxFj
        CvApfbBeuFTcL5T3D2ERCewkGHrdxbnr3QiZrQzS4AmhBJ306/N2nyQo5lnSWfHZIgwU
        D16A==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.18 AUTH)
        with ESMTPSA id L0be16v31F5JNn4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 1 Apr 2019 17:05:19 +0200 (CEST)
Date:   Mon, 1 Apr 2019 17:05:18 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <805637056.1640115.1554131118962@webmail.strato.com>
In-Reply-To: <20190401112510.23145-1-geert+renesas@glider.be>
References: <20190401112510.23145-1-geert+renesas@glider.be>
Subject: Re: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-IP: 188.195.25.140
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On April 1, 2019 at 1:25 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> There are several issues with the formula used for calculating the
> deviation from the intended rate:
>   1. While min_err and last_stop are signed, srr and baud are unsigned.
>      Hence the signed values are promoted to unsigned, which will lead
>      to a bogus value of deviation if min_err is negative,
>   2. Srr is the register field value, which is one less than the actual
>      sampling rate factor,
>   3. The divisions do not use rounding.
> 
> Fix this by casting unsigned variables to int, adding one to srr, and
> using a single DIV_ROUND_CLOSEST().
> 
> Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
