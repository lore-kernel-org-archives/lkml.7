Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BAF20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XXEnzswY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfCYAQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:16:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40120 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfCYAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:16:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so5163469pgo.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Vve4evhn0lRnLQezicMi7GhNDGoE6UDoZug273oRMZ0=;
        b=XXEnzswY1jeOkcGf35AsJsOWVik3AN3tVasK0WJ8/rD4ExFkeLInq5BJiQ6WSr37zs
         E8jvmdDn/1PDVOwKMmFaBKbh036ef7fRgXxItuKlQG2+W4GP+0sABr6+ccJWQz4G4FJB
         vGitIPolrs8/iNfGzxq4zJli0Zl1mp5tHp6JuU7nJAR5XV+ItVrcvpTgpk0yUy2FfhuA
         20jThP6PEX2lE8htYjEScOMvzeWAL6ApDnNsjOL9z5anyTLb0+054KXZ7bXVMBfhxiMo
         Pp6tsitHDv5t6PmoY9edqXYnBVUtBPSEIULonF+kDM+VdTZUU0xUaStOrp3ibQQcE8yV
         IYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Vve4evhn0lRnLQezicMi7GhNDGoE6UDoZug273oRMZ0=;
        b=bsynYnWCvqGsr59MjffWG1Znq/5XL8qL9c2otZy3v36WNQpLBVx4I5WE38s8iOSYsm
         n132cXht+HPpII1yOiyS1j93ATAn2uQZhGA+KNyHtPrTVHKPcF6Yq2OwkCXJn74Y63WP
         WZslZqpEW0SRkNhACraob/cp4ve5Syr++y0lJCXS7722gf0v1wm3S0h17P8lpcA/eW1H
         5783oRHQ38aQXYaK8Mi0waK23I1RjQHAjToMyLd2fNvRghj3aT9HMNxNaJmm7KNQKGdT
         uMhM+gsStZK+WQNEbY4jqNpRxFZdYeXRuHkXmWGVkTUYIf55SfNhj//6C1B6TanBJ5Bb
         XMAA==
X-Gm-Message-State: APjAAAVPKGhas/SIkELOYN1JzSlshfkQ2UBcGD3wHXRDouCGFejtdM0h
        a6SSuLP3ofymvAqi62bvif9OfQ==
X-Google-Smtp-Source: APXvYqwoY8F8b4unLXEd5uXPG6iBkpF6y3j8pspmt3vdMCRCHVZK48S/RA+b8EhpK2fEdEJ0H3ftiw==
X-Received: by 2002:a62:54c5:: with SMTP id i188mr20825688pfb.188.1553472978496;
        Sun, 24 Mar 2019 17:16:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j9sm22106586pfc.67.2019.03.24.17.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 17:16:17 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:16:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Borislav Petkov <bp@alien8.de>
cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, aou@eecs.berkeley.edu,
        mchehab@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
In-Reply-To: <20190312092842.GC28589@zn.tnic>
Message-ID: <alpine.DEB.2.21.9999.1903241705460.8028@viisi.sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com> <1552382461-13051-3-git-send-email-yash.shah@sifive.com> <20190312092842.GC28589@zn.tnic>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, Borislav Petkov wrote:

> Please no EDAC drivers for a single functional unit with RAS
> capabilities. Rather, a sifive_edac or riscv_edac driver which covers
> the whole platform or even architecture and contains support for all the
> RAS functionality there. See altera_edac, for example.

Looking at the Synopsys, Highbank, PowerPC 4xx, and TI EDAC drivers, all 
of those are clearly for IP block error management, rather than platform 
error management.  Has the upstream guidance changed since those drivers 
were merged?

The core issue for us is that we don't have a generalized "ECC management" 
IP block.  And I would just as soon not fake one in the DT data, since the 
general DT guidance is that the data in DT is meant to describe the actual 
hardware.

Would it make more sense to put this driver outside of drivers/edac?


 - Paul
