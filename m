Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E198EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00DB2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573739872;
	bh=GB5ZNZwpUnrvTVpWesWOxcFz8LGlrrjCF/2UjAprWow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I7SoKgFJ1jqwJTCRVYiCHaeZ7giImKqXNEHXMErzqNKhSkFbgkCB1QVR5ljrGl5ri
	 2TdASiDiVbr8YcLtGpe6aXexGtSk7pNhF3ooP1KcHvDL0bI5jUlOCiNoSj/kufutmq
	 v/q3TM70omyjogZqaMcrcnAMw/HG4IHcfIGKHQWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKNN5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfKNN5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:57:51 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7580020723;
        Thu, 14 Nov 2019 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573739870;
        bh=GB5ZNZwpUnrvTVpWesWOxcFz8LGlrrjCF/2UjAprWow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DYUqRhBS/0/ZWwPyWgKQMpSSxeMvAecfdApg1bCdDt9EKfmb7Yo1HHuOZ7fWBEcGV
         0Q2EKCCbPwEkyIj7bg3vpRuS8wmbpbGnFvY6pIXDaIpJm9qX1aCrI640uHbEJqRgYz
         pARS+Q7caIIdin7QRA7Q+fyYp98hhzth1wHsxfFI=
Received: by mail-qv1-f51.google.com with SMTP id g12so2335056qvy.12;
        Thu, 14 Nov 2019 05:57:50 -0800 (PST)
X-Gm-Message-State: APjAAAVnuSaeUdx7kt6wna0vCn0J9RPaB0y+gmqw58TS+DswsgEoS0dN
        w+bUBNrEtjhO/USHuNqC2tbedwZxTS4fP16RUPs=
X-Google-Smtp-Source: APXvYqyBwvvpAdeB4tgNqw9NSS0VCm/ghop0mnQxOg76y+Cc8IN2tg15+QDHF2Yk/XPly8FONJJ4zXVNSp1SW8FSCJA=
X-Received: by 2002:ad4:4089:: with SMTP id l9mr2672727qvp.241.1573739869543;
 Thu, 14 Nov 2019 05:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-33-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-33-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 14 Nov 2019 07:57:12 -0600
X-Gmail-Original-Message-ID: <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
Message-ID: <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> -       if (*iprop)
> -               qe_port->port.uartclk = *iprop;
> +       if (val)
> +               qe_port->port.uartclk = val;
>         else {
>                 /*
>                  * Older versions of U-Boot do not initialize the brg-frequency
>                  * property, so in this case we assume the BRG frequency is
>                  * half the QE bus frequency.
>                  */

This bug in older U-Boots is definitely PowerPC-specific, so could you
change this so that it reports an error on ARM if brg-frequency is
zero, and displays a warning on PowerPC?
