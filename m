Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E141BC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41221773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h2Owf/A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfEWQNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:13:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:13:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so3377488pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dxcl7qeoBSGm7yM9sqTozFqzilaB2ov2JQxOkdUbcHI=;
        b=h2Owf/A2KjV8Ud+sGliPrzwL6UypMFI8zBq5XI+wlYkZ789Wpy7eO5lnkkBc3dQCWs
         98TcJWT8asc3gMOlX4yAPaldzJs9Th424Mlg78neTsB6g5KGBL79l0jLSotb5j1hBb7W
         ULbuwWls34VU+AgosN0afn6g/hgRPU94NfzxDZ49g18bI3nQC24o9gy21jLN4rX20jGk
         rniUgFaEyLztyEg2wynMy7pVYHbLPasse1kZYojMaAn1CnYu+hmslbg0DvgfDyNivzXc
         fPRDlcHC9eddT8WWIaAro0yypWuKWjviYf6/fj6ezuviK/Tc9r5gdXkMcRcXPpPiOax0
         eUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dxcl7qeoBSGm7yM9sqTozFqzilaB2ov2JQxOkdUbcHI=;
        b=GGY+grmEDs50L1JMdTqbzRm5oHY/IqWU7R9qyW5YABOuzekrhL6lkdAtiELCp8AkFv
         yOrdcuia0ottGXiP/YokAeTG9rWafXB9GN/WBOZQRWXjpPh3DH2rEgleq4Vr8ah+gIDC
         YPr+gSTFoL0OAQNgzWMqtm5dwLHl3HLau9PZVq2t770aNdgXV2yVSbb55JjjY7yKA40h
         mP66s3uAVvUBMYuP9Wf6M0pNDXPzh3ghnjKr5SnOlD/aY9g13e2JZXMbkgQYnEC53SzO
         vsmW71mrfiRBDZot0JeN3GOIRIZlbR20NcdIh3OoTePG5b6CyUqQ0UhQh2j5DUfC+EmI
         lufg==
X-Gm-Message-State: APjAAAUlwOk/qqI8kbrdkCmE6i7SGPN3Q9z59/W9sGkcEM8/Tl0PcGYu
        C1Q4fLTgSQnYr9hyhI2tsIz8lg==
X-Google-Smtp-Source: APXvYqx/tCamAz6aS+Mz79lzll1VAvooHEJ3LVVUfQLgtPgLrRHNqNAT4LbZn6jhpfGEP0d6dikK6g==
X-Received: by 2002:a17:90a:2322:: with SMTP id f31mr2407129pje.9.1558628020974;
        Thu, 23 May 2019 09:13:40 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id d6sm3356394pgv.4.2019.05.23.09.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:13:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: dts: meson: g12a: add drive strength for eth pins
In-Reply-To: <CAFBinCBmgTdZBDd5D_rCVQwO4UcJpXjX=Rc+0qgADF9sW-wFWQ@mail.gmail.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-3-narmstrong@baylibre.com> <CAFBinCBmgTdZBDd5D_rCVQwO4UcJpXjX=Rc+0qgADF9sW-wFWQ@mail.gmail.com>
Date:   Thu, 23 May 2019 09:13:39 -0700
Message-ID: <7hftp54098.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Mon, May 20, 2019 at 3:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> With the X96 Max board using an external Gigabit Ethernet PHY,
>> add the same driver strength to the Ethernet pins as the vendor
>> tree.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Amlogic's vendor kernel (from buildroot-openlinux-A113-201901) does the same so:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Kevin
