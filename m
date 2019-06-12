Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C14206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IFX91dVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfFLOoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:44:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43694 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732022AbfFLOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:44:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so9039204pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=bn95yZEQkFdm8IUCbmAacr/m8l86WxEth291aVhdSlM=;
        b=IFX91dVs/IB2uQK3729zPrJd1Knz4V7aZ3QpOygS7GTDRBVhMj7KbxcyEvtjveJJR1
         FXZzSv8Kt22j9edDD5+tQeVuKivqBejTI61b0MqQYaxytVcPL75KotXQ6tlJj2UeUYG6
         wmvi++xeRnLF6l4+9zP3EmyJCLQ4PU2nvxyJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=bn95yZEQkFdm8IUCbmAacr/m8l86WxEth291aVhdSlM=;
        b=JqHr5K6B+C9OuPiUvm8KKCX7QnTZoBf1Evm2XZbIf6uxfjG++XNOUVOaaaQxz4SSBX
         9MrxQnnY+BJW6q4LBJAk0oEZmvKx9lxoqBBsCaj3GN22/rh23Q7hmmsxcrXY15pewuaI
         YUwXJDr5rxAleh53ur/qetfVnjqBXnC+QjePXzUJvXs1QpdH2NaYAUeXUrxpadZAUOKO
         nNcmCBrcLuD69o/4xOW1m8dcQQrTe3H+l5JYE3TZYw0S4908oud8YlMX7wlxcSMjq0n8
         Gom39qKmM/2kJytLZcFm4hgsqAEdVsfZ1kSPCNayHoLztdYOjKx9n+YXCMZDWL7tWMQ/
         t7KA==
X-Gm-Message-State: APjAAAV/Dejojw+w/Kj0mdCoIU3/0GpEDxuBLMQpElEk8KkZjRMg+NzY
        DgHlvqgnhO/MKZaFmaozDLAif1HxRMI=
X-Google-Smtp-Source: APXvYqw1pRLfvl+MD405r1Flh6E/r+OXWy06xK5xfjFjE5fHv/YEJIPlfXeLmPTH94Oncwk11xcypA==
X-Received: by 2002:a62:5487:: with SMTP id i129mr82578482pfb.68.1560350677533;
        Wed, 12 Jun 2019 07:44:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c133sm21450858pfb.111.2019.06.12.07.44.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:44:37 -0700 (PDT)
Message-ID: <5d010fd5.1c69fb81.e7b77.87ae@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
User-Agent: alot/0.8.1
Date:   Wed, 12 Jun 2019 07:44:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kefeng Wang (2019-06-11 18:00:11)
> When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler warning,
>=20
> drivers/of/fdt.c:129:19: warning: =E2=80=98of_fdt_match=E2=80=99 defined =
but not used [-Wunused-function]
>  static int __init of_fdt_match(const void *blob, unsigned long node,
>=20
> Move of_fdt_match() and of_fdt_is_compatible() under CONFIG_OF_EARLY_FLAT=
TREE
> to fix it.
>=20
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

