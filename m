Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74727C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D621929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="P1TDOu+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfJKBRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:17:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38079 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfJKBRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:17:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so11575726qta.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FRAhjU6zbOujsKrU9OXTc20iXWxJB1PbXELLM5EnWz4=;
        b=P1TDOu+hLEOcYZdp+RsC60/WrDZp/0xsV3XEPvMb+X1f2sb8KVh050ChS/DzqZuxu8
         LfIixQWkK/AwqxVuEVLOrPZjVGRc6zmnjWRM9aUwlWSTj5xkRz8xU7p99/Qvaynfepcf
         uvsihaoCaRpQWHf2MCAo0RG7xtTRnRD4nq3OsDCv6m3Xy6UY6F/0Q2e3xamg9fFlx88B
         dTEcIY4+AwFNN/rzgizAzI9XEoUwBaH7h3NhapVmfuzZWvdafnrP4nD9jdNIC6FczlsH
         zed2XaA9tN0P9Q3eDjBeau2NNwysV8CtKdbCM2i44OAO7zFoclfCovDLWkJ6fTixQURX
         5EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FRAhjU6zbOujsKrU9OXTc20iXWxJB1PbXELLM5EnWz4=;
        b=GPd0pDevND4adUdPqnZA1agE811VCMIInrgjJeKzWQhiSaHKNJ+sSW/uVMgwAJuX7+
         b/rwlpmyzleEpO2IhbdazT/tKoH/MD2VzNrUVUy9uILbYz2CBXG1O1oPYRxihTOCGlmm
         mrPpTfjvnu8z0cyj72LjF0QiLppxKkfVKCH6BFVrUMHfV+Z57/s210UQ411ic54c3w5E
         A52A9cYxJFRGuh2I+0dvlReiWRvBIJl1aNO9EtmUjjP7jPK+izaZHQpSKUAyvZi7u9ad
         fZ7oWs8gygc+duuUFkN93nC7IoSm+TjKiPNpjqel4lTM699X7DR0mBndO5+QCkvarccE
         r5Eg==
X-Gm-Message-State: APjAAAVUTteWtr56nvQCUj4+wzMd71ZPR6dAReZLU7Da01yxvPJiLtjg
        HflnSvXF/zDdKmuia8KIwy+4yw==
X-Google-Smtp-Source: APXvYqzOjSHMUU98eUi/w1xmBfaHzCT2guSL+N5oE5fPyX4+S+M5Qlk63IT5XbmdeS8oaoRfnXpgbA==
X-Received: by 2002:ac8:7557:: with SMTP id b23mr14086447qtr.384.1570756628331;
        Thu, 10 Oct 2019 18:17:08 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a190sm3908987qkf.118.2019.10.10.18.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:17:08 -0700 (PDT)
Date:   Thu, 10 Oct 2019 18:16:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, Andrew Lunn <andrew@lunn.ch>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
Message-ID: <20191010181651.5abd4c21@cakuba.netronome.com>
In-Reply-To: <4B7340B5-C35C-4B18-8D8C-B5B8D16BA551@fb.com>
References: <20190911194453.2595021-1-vijaykhemka@fb.com>
        <4B7340B5-C35C-4B18-8D8C-B5B8D16BA551@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 19:20:47 +0000, Vijay Khemka wrote:
> Resending this patch again.=20

Perhaps I'm missing context but what's the intention here?

In case this is resubmitting the patch for inclusion in the upstream
kernel you need to send it out properly with git send-email or such..

> =EF=BB=BFOn 9/11/19, 1:05 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
>=20
>     HW checksum generation is not working for AST2500, specially with IPV6
>     over NCSI. All TCP packets with IPv6 get dropped. By disabling this
>     it works perfectly fine with IPV6. As it works for IPV4 so enabled
>     hw checksum back for IPV4.
>    =20
>     Verified with IPV6 enabled and can do ssh.
>    =20
>     Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
