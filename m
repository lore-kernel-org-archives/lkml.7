Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57A4C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A400F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="XbbFf/ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfD1H5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:57:05 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43761 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfD1H5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 03:57:04 -0400
Received: by mail-vk1-f195.google.com with SMTP id g18so1659051vki.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VyYDCLck5MXh4xMkAw8CfYXVHyW1jbr6E3dsZXs4xrM=;
        b=XbbFf/epY0ivJbBTcgJv0aSg/z2Te6gGPfnzVtw1YvlTq8/bJvKqEQb4QlRhHkKjIi
         bFHi4KWIF5SM5mn/y2KHQgfYNch09UMT/+ks2Lv0mvgszmAFhTD610JugQ6JvzcRoDGo
         vT5SdgHufDMjfasAo665lxHW+W2TgRdSyge7w+oRiPXmtReBryA2X0Z6y34KaEegAqu2
         0upUW/2jyLNfHBdYswAQ4bTLJ32tcJ/r/+xQpRU7k4PyevPNTIj5OzWM4y+oMEhRLQj6
         LDVgfz0HKgQxtzvRA1ZrKRBA/ziYgka0L1yPGm6s4rI92zDuemeBO0r2NOvEhetk1jAN
         iZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VyYDCLck5MXh4xMkAw8CfYXVHyW1jbr6E3dsZXs4xrM=;
        b=JMmYhxgOl8I80jGvzUjDFT7XH0ve9Fgst5mkZiNcq/87/N2FcBqs+qvuiuWBSAKL4V
         KCSQ4xXUEP0wAHLcU16G8wS+8d2v4/+GicMLeYvv9pXpa3Ko/3rCs/5+6m6IoZKiMMuf
         H0a+nFxrwrxtGJqdASJmiB12z9u2fEllqEA6of6/RiScY0xO3dR17aXID4twZFwLJHj8
         vANzRcdDfZR2P3KsT5QH5YKg1BuaiaV9GWWLvESV7HmVLS/z1454SGIdEgOqgZRhrPpk
         kKqtzcXv0CSX080wUVslB/gbHXejED/QFlaO03wb0POrGhn7amVKc0wIgzvVSMwL9kD4
         ZWlQ==
X-Gm-Message-State: APjAAAVs4lK9MPm/NgR748be4aUXuFP7EAXMmFrs2IIF9fwjo0rSkSfG
        rmoX4YlcYccmj78Wed13+3FpfOBgIjOGRcL3huTBAQ==
X-Google-Smtp-Source: APXvYqxUir29y0XD4+4tv8nFVzMkaxDlh63X1GX7VkiJTfKxWPC6XsjDX4A6NsSvMdbSGLSOhZBHc2bEs3sKkYbXJZo=
X-Received: by 2002:a1f:b654:: with SMTP id g81mr2917648vkf.18.1556438223479;
 Sun, 28 Apr 2019 00:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190426164313.32308-1-yuehaibing@huawei.com>
In-Reply-To: <20190426164313.32308-1-yuehaibing@huawei.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 28 Apr 2019 10:56:51 +0300
Message-ID: <CAOtvUMfO1jvU6_Y7=otKQt0t9o_At0QBg7eqwV4SbeD9srbAqg@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: ccree - Make cc_sec_disable static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:43 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/crypto/ccree/cc_driver.c:37:6: warning:
>  symbol 'cc_sec_disable' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you!

The kbuit test robot already sent the same fix, which I acked.
It's hard competing with the bots... :-)

Gilad



--
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
