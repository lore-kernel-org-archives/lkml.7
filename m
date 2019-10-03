Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CA7207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvjKgRek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfJCQKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:10:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33808 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfJCQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:10:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so1752572pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=v9Xix4ukYpxBHBe1n3DXedqcwTHB0Vaz/YT0zLakIIo=;
        b=EvjKgRekrDRXydliKainNvs1EDKpTaQC9hbAsmM3L4SgVhnCamPwwGeWgzLCmD/6ZN
         YJihKrj4Aua03JcGiXSnnv9gCPNFzimjX/dj6do1v8Tarr4QDToU5Y7qaBlDo7r0dOjB
         7MqZGdDBTEaz9H1tW70rmHCyl63UhJarLzgIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=v9Xix4ukYpxBHBe1n3DXedqcwTHB0Vaz/YT0zLakIIo=;
        b=CPELijN4UdoJQOBVp46+sZe/+On1Tce9Twss9HSO1zD7n03OJRBM/0xvz3AtP+TX3Z
         bQlJ5JR451e+7AgXOdTudOB26N8j2FToeZ/S+czUUScPObn3oSXGi4CXKDu902fBTqc/
         tx7SZzOOUKHvknVI+JvvYz5/ToP/aDQ81PRKowdYy/zIECL+JiIy6gmcz4IeE4LotkV9
         kkyWhBq0P9tU/HMyXrFOBy9FsbcacXWY8SOJenqehnf5ODl39q+J/kBQTIjtW0Aac/Tn
         5D9kYsc0ACkrGM7s6I19+qRNltSjuhZr1vQeGSbdOuZC9pL+CTNkgvXIx4lU4vwwKivf
         pIQA==
X-Gm-Message-State: APjAAAWZQEplBN1jivHmKQLGAGtNmJh19Nmx1LVdJGuBQGa7BdmCgpeV
        Ng2J7fbzux3OgeSsZwYZnWpBpw==
X-Google-Smtp-Source: APXvYqwv9TynoMmQOqZjRuUUV4/ZHjd2t53y5sK2b6fAukPfOM6uRj4H5n6IfZmi7UusPIcmhIpQeQ==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr9926433pls.293.1570119017817;
        Thu, 03 Oct 2019 09:10:17 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm3516011pfb.132.2019.10.03.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:10:17 -0700 (PDT)
Message-ID: <5d961d69.1c69fb81.43b1b.addf@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001180743.1041-1-geert+renesas@glider.be>
References: <20191001180743.1041-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] serial: sh-sci: Use platform_get_irq_optional() for optional interrupts
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:10:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-01 11:07:43)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, scary warnings may be printed for optional interrupts:
>=20
>     sh-sci e6550000.serial: IRQ index 1 not found
>     sh-sci e6550000.serial: IRQ index 2 not found
>     sh-sci e6550000.serial: IRQ index 3 not found
>     sh-sci e6550000.serial: IRQ index 4 not found
>     sh-sci e6550000.serial: IRQ index 5 not found
>=20
> Fix this by calling platform_get_irq_optional() instead for all but the
> first interrupts, which are optional.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

