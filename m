Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207A8C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB1E206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MFPeuk++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfG0Shf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:37:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33974 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0She (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:37:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id l12so42590550oil.1;
        Sat, 27 Jul 2019 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBIzNXvHil/fu8SCS8NI8XluTndXyvzRiVM7klKHDWY=;
        b=MFPeuk++dsK3XqoacpJy3hmU4qTrsWJ8kslGxjpVjGcFl1eiBvjcAbS6Ifcx+bD9cq
         Sq9Px8szgMy/79mKOYmZo6vpA7nItcbObUMqpfS1lVGwqQk8IYv1844qCG99wb4IQc8z
         mR59QIspKWk/ioSiYwuG4M5bL2AbUx7xxbg+iEghYMB7Sb+/cNCyCleS559vKS0JI5a4
         TxgvMbXQ5W5hprbosfihDPl6NHDb6Ft/LeyUU/w0k0rgv1dg5JnIVsCQhF5OpQA5OLUZ
         yR4gMNyztHr4rBEFjx+4DBHzIo7JzrviA0UFmfJjF1vzkG8wW1vK2SGYEcOEnYB7yBcN
         FaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBIzNXvHil/fu8SCS8NI8XluTndXyvzRiVM7klKHDWY=;
        b=a8fUnChF8H4j89UOLgp4yVMoW5jVMeeyKyI+8raZ7FyoLyH/7CC6p5lHaX8YhapCvI
         /LMYSsNKLrwRG+3XespCohJ2NslDOmf2WpfyFLLwYKvrNqiL7+LqfSBs9zqt0F0iXxBO
         xxbRn6hMbfw+esxiEVDExd/v1exVr/LiJtpurbFq74JpX2e4xWf+gRU1pjG5itLsLMZZ
         wm5eHY5Dr/zlV65C8wqRrDMb7FQbD9VBLGTzHJsWvN82jiEryDm+rwG1p7ITsh5rPgAZ
         rsgYlqk/iJsa8ga0b9JlUrJ8C+U258cO6vBvNpEE1pqjbA0bi+B4GNWOoDGGFbZJ1D1D
         LlVA==
X-Gm-Message-State: APjAAAUk6ssoS6MRD7kZwBB5gkmUR7W/8WbOYEtBzUnXHj3K4oF4Wzjv
        LfYCk8SxgVMmv2Kd23HrfwjrRvAetW8K4be+3QR98A==
X-Google-Smtp-Source: APXvYqzgBFliiTj38LcPPprvpgvBMNIcljc/GRpVz3JnqlYSwL3X+++t3YViczjhWcnAE3WSgzfq3lchyWGUwLn7zFM=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr48517851oie.140.1564252653681;
 Sat, 27 Jul 2019 11:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190727175315.28834-1-martin.blumenstingl@googlemail.com>
 <20190727175315.28834-3-martin.blumenstingl@googlemail.com> <d0ef8f73-3555-b53a-eb2b-40066827b6d9@phrozen.org>
In-Reply-To: <d0ef8f73-3555-b53a-eb2b-40066827b6d9@phrozen.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Jul 2019 20:37:22 +0200
Message-ID: <CAFBinCCrjUuw=+1FThnxCR7m0a1rHo=A+fdge2VrV4+AYSpkBw@mail.gmail.com>
Subject: Re: [PATCH 2/5] MIPS: lantiq: use a generic "EBU" driver for Falcon
 and XWAY SoCs
To:     John Crispin <john@phrozen.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Sat, Jul 27, 2019 at 8:35 PM John Crispin <john@phrozen.org> wrote:
>
>
> On 27/07/2019 19:53, Martin Blumenstingl wrote:
> > + *  Copyright (C) 2011-2012 John Crispin<blogic@openwrt.org>
>
> could you change that to john@phrozen.org please
sure, I'll update it when I have to re-send this series


Martin
