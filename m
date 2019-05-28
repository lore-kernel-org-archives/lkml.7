Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0937BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF32182B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/tDQsto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE1Pxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:53:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1Pxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:53:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so11251055pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=gZdVe4KYsQOsjAdrlH5pjQLw2I8u7ZqIj2eBsmzs94M=;
        b=H/tDQsto+r3bnOsQ2Dr3G9DPtN6VFJ21sEuBJ25/pR8vNxEeLnmJnk/0c9YuW8bkDe
         b5W3NUIWMGHJCKZiVPs+K+9bO3xF+nnc6gxysYXLoxJtPhNQwYf8eD8U9JBxqFz0r8pv
         GDmox1lVt5VuEkJhsEpbB7no06+vFaqML/62g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=gZdVe4KYsQOsjAdrlH5pjQLw2I8u7ZqIj2eBsmzs94M=;
        b=k/5j2LY2GgpMLqSoZrBGbEvEm3+GXVEGxwVGMRN2zNowTL4c6P5QNnKF3tPg17UrsJ
         kJ3bauUUdiWDIHBTDqmyd/U9uF8rQwm1CcXo51dOyWFJK3mAa6OH1djQbOfNMuKpMkYa
         YQSo+9ofzKmikQRIXdCa7RFwrQINUrZuGHBoCklrkuCcL6X7kx7+KYW1OoThGIJ0ezHf
         Gu1CBRPX5C3UBcirpyMVUGRrgQ0eXeDwiCbh+KVxjwUKJ9FTiFDKDGBWencp3wQyFgrK
         dDS58t7i2+EVUXdy2CevFYyXa7uhWYIEQ2TYgOJuog5uYXl3Vh8Txoz0vTwtjY9bp4MM
         RHkw==
X-Gm-Message-State: APjAAAXSYo/yYyT6KVRD1b/de0JNi4QW0+fHhJWgm32Ez8cbScZl1TcH
        2uI0gAMH3M9jXibkfWow8XPF+w==
X-Google-Smtp-Source: APXvYqw6/Wgo8S4X+4IdRoxCALLE8MCP8dhzdasnJiMxFjFHV3zRdny03KvOcEq5wVUfOwMG+APqMw==
X-Received: by 2002:a17:90a:17ca:: with SMTP id q68mr6883350pja.104.1559058830791;
        Tue, 28 May 2019 08:53:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f17sm13153090pgv.16.2019.05.28.08.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 08:53:49 -0700 (PDT)
Message-ID: <5ced598d.1c69fb81.dabd8.339d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190527043336.112854-2-hsinyi@chromium.org>
References: <20190527043336.112854-1-hsinyi@chromium.org> <20190527043336.112854-2-hsinyi@chromium.org>
Subject: Re: [PATCH v5 2/3] fdt: add support for rng-seed
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
User-Agent: alot/0.8.1
Date:   Tue, 28 May 2019 08:53:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2019-05-26 21:33:35)
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

