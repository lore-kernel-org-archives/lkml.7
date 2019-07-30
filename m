Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F132C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCiOqmTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfG3Puq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:50:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41869 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3Puq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:50:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so62561191ljg.8;
        Tue, 30 Jul 2019 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjZf+MF90g13zAX26LAEhRqKIVvf2OUOjoC3kV1A4hg=;
        b=VCiOqmTYTGpW6+TzwBMHfJxMPqrUu8XF30lk6st37bbgYF0Nf7k/Ayzd0LJg8IBLBq
         B3nvq4nVJBAQxNrRqb7+W+Jm6ixv8nCgbaSG6aa4rLbAnY8luPpY6ID6P5a5Nw3+J5Vp
         NPKJjRJpfwWiwxG33PpNADm57+cWKpUJallVPjO8oxqWC6rZo1F2IHOuJzfN9gSUdbaR
         mopvFTWRS4ljV2AxObuvoOxuWM1rbjnoJlMoPhjnW+WsmxmmDHPoF/4hSDABmRprWtLP
         GU1NqSCyGEgJG4UB3Coad+OcB9LKekzx4b08QHehDl5s4aH/oDP1GZExKz5AD2EL1i91
         tJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjZf+MF90g13zAX26LAEhRqKIVvf2OUOjoC3kV1A4hg=;
        b=LtwYJzksIIj4VKXFb76yw3iblmhH6AFpQOKmkatUVSuDEMTQ/EUA56QpIL4ySiZdeG
         Rbts1YEwIuwUUhLWVJQurpr2DxHZ6TqWcFsrM/vA2U/9nT7qoptr0aMhQgX4esPiiAGw
         +/Fp8RqSJJVk/OaJt04pmW4sABTDMxx0WXLLpta6HX7TijoBWhXfCmD1iJUMubGtPVVt
         Oh/bTGmwBTYGXxo+dNBNuw6z2+Kv5O07+neAseFsm2/Xtk6WjdGlYNZzq5uth7GhbgSX
         2jMg/3+F00iMOdHX9DM0NIfaN8cR15mJU2vRRgf31qxuubvJd/QnGMZ0nChRbd0qCrdb
         0azg==
X-Gm-Message-State: APjAAAXYDNQNx9mUO8grho5+Aht7hsvWVEbPq0mcIxEUm7Bf9grkBN+V
        KgotI923XCi6DtHjy2p8LaV31nUv9BAQ2l2aF9w=
X-Google-Smtp-Source: APXvYqwkPXJqhZBbFxl4c3kyyps9obbir8sQKSKYcOVSdu+a9rKp3mkmY8WgYDRqTdAoVGsUk7BE8h3GnFHlnbo87c0=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr4643059ljg.80.1564501844026;
 Tue, 30 Jul 2019 08:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190730101451.845-1-h.feurstein@gmail.com> <20190730140930.GM28552@lunn.ch>
In-Reply-To: <20190730140930.GM28552@lunn.ch>
From:   Hubert Feurstein <h.feurstein@gmail.com>
Date:   Tue, 30 Jul 2019 17:50:32 +0200
Message-ID: <CAFfN3gXxC+t7nStOfTd=iCodg6S0ZwdtV309_qpYrrJ0eweVzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: dsa: mv88e6xxx: add support to setup led-control
 register through device-tree
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 30. Juli 2019 um 16:09 Uhr schrieb Andrew Lunn <andrew@lunn.ch>:
[...]
> Sorry, but this is not going to be accepted. There is an ongoing
> discussion about PHY LEDs and how they should be configured. Switch
> LEDs are no different from PHY LEDs. So they should use the same basic
> concept.
>
> Please take a look at the discussion around:
>
> [RFC] dt-bindings: net: phy: Add subnode for LED configuration
>
> Marvell designers have made this more difficult than it should be by
> moving the registers out of the PHY address space and into the switch
> address space. So we are going to have to implement this code twice
> :-(
Ok, good to know. I'll wait for the first implementation and take it
as a reference.

Hubert
