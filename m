Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD4206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573791994;
	bh=9wOq687Qi/2lX8IlVmx3X62wxNLXabR/kcOYgP+5Zic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gzr5bo/FjPkfeh75ssZ5vS07khu1N2fbblGz8+wHsP/6xEPXbffYjgdsPkooNYmeg
	 M2gtwbeytEh21z2rnrmXXDRBuGsGaXpUPaTS8jId1e9zbj+/aBp3RLrZFdnxxUZoRj
	 Z/OCBXqRZiZdcONDxCwkpq6IHbUqZRA6LFqppPDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKOE0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfKOE0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:26:31 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760A020731;
        Fri, 15 Nov 2019 04:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573791990;
        bh=9wOq687Qi/2lX8IlVmx3X62wxNLXabR/kcOYgP+5Zic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRpj0jxqSegt9Nw4hWezOFc+3piXWWS0uzU6orlkh5W/H0zEhswSnT8XaLD7HuLtl
         7oHNud3SfJmDxTgZ33qFavoPYuHMwP59ZF93vdykTnucwKJyjd3s/0RUwBlDBMwson
         RMC9Epl151y4HMRqHoOmLSH2j+LfU+ftqc9i7S7w=
Received: by mail-qk1-f171.google.com with SMTP id m125so7097973qkd.8;
        Thu, 14 Nov 2019 20:26:30 -0800 (PST)
X-Gm-Message-State: APjAAAUE7B22djlh3bhDr1bgenZ1puDZKlUVv9mDHXGiqc0xoN1Ltnms
        BTL6PDC8BJl6rcaclxJ/GfY/0LOcsSwv1Hn2RDQ=
X-Google-Smtp-Source: APXvYqyLFzHjZ7tEQMeLkCQSkpPg0rZdqFl6WRIPEi5xIjuml+zSKU9pde3u+lplCRandR9s/b1zLnOoGmwvymczkds=
X-Received: by 2002:a37:9d44:: with SMTP id g65mr10614078qke.302.1573791989555;
 Thu, 14 Nov 2019 20:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-33-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-33-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 14 Nov 2019 22:25:52 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVpDSk2AWT7pYjrsk5HUmAeosCNf8zWX1CEEtZshAh9Sw@mail.gmail.com>
Message-ID: <CAOZdJXVpDSk2AWT7pYjrsk5HUmAeosCNf8zWX1CEEtZshAh9Sw@mail.gmail.com>
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
> +       if (of_property_read_u32(np, "cell-index", &val) &&
> +           of_property_read_u32(np, "device-id", &val)) {

I know that this is technically correct, but it's obfuscated IMHO.
'val' is set correctly only when of_property_read_u32(...) is "false",
which is doubly-weird because of_property_read_u32(...) doesn't
actually return a boolean.

I would rather you break this into two if-statements like the original code.
