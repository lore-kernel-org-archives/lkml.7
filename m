Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A87C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75B420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQqHnoIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:39:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38564 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:39:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id z3so1414248qkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oZzHL6ADFAcvdNMLTc0JLwSyZOJrYg7gIph9iiVyz0=;
        b=mQqHnoIpK+qRswawfRkDB7NnNht/sUtu8BtLLcSZqkIU/I0jJA4tY5ibYKMdxwzau2
         FUCjuB+o/vt3PhO0iIl/RcQMpts9oraE+Jaqb+xuoP90AoFJ1gVBqoudcsEYB2YjGqKa
         4c+4TnoDWoJD/9xRDvVM0U3B/o0oMBFC8JTzBLWmnfnTJLG/jrU85dc3IxqPZ0p5hBN1
         in1Q02fJTdUvRgzdAxZ2VVUXO1zTLWEZRzOEBJN14Ev/XGAzKERrgXdWA38rxAybnWpq
         zjva3VjxcXqdw/6n5vMvHkFdzqxkvVqlesZ3T0yEvCOIwjmCW/k+dGbOgo0+Cfj9Bpec
         e1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oZzHL6ADFAcvdNMLTc0JLwSyZOJrYg7gIph9iiVyz0=;
        b=kyZrgOyt5B1V0IDCqsqPTeTSbQHAk+YCzm6OmPI0DLxWu7vNPMh0Dk4pnlteRcQ/c4
         foTDDfnBBSgt2CEvyNFqsXHOAfKNpWxqnaxyqZffxo3WJwuclv/Hx6TsmTvp2R+GVxaW
         iPhKEcWA8Gok94nAuphLPKEKX35RDuhxHTLCcX6qhIjC1k6WbbRn+hoEUXZxOmcjNMNE
         /jWIN2MqPkto4eeAl7f5SuJFfKb1ngSVdbYJxMs0sp7Tz9H0dopeSZbb/eUZBp4ulHXC
         cbDu5GqRrgvneJ+322B+vhay59Wn7FP2BgtwhpRilYxfn2t8B0dkgzSE7BRgL3nx0k68
         RbNA==
X-Gm-Message-State: APjAAAXirufoaNkPyScW94gR5pXUUWWaHsDAr3OvCNKfrgiTutYRb+8N
        SVatsimII2CqSXe5Xl6+zL9/Frj87K3RKSseJhigpQ==
X-Google-Smtp-Source: APXvYqyaCToKcyrSmAHkW5ZCV+ZfFAceYTNHFieTkW7LKkCLe453KGoy84qo8R5Gbr9zor3/sFEfTrHjdtkENpbDAD0=
X-Received: by 2002:a37:7885:: with SMTP id t127mr8795678qkc.109.1551951568173;
 Thu, 07 Mar 2019 01:39:28 -0800 (PST)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFo_O36=N9wM2jFnUvkga1TFjPMibr+0MRU6bLOpq7nH7g@mail.gmail.com>
 <5b531f55-b8a0-5a83-4a7c-727013a66820@st.com> <CAPDyKFp=AO27hmG9u8JHrRa3JW7RNMbxC8+vMb2y_qGo=mLWQg@mail.gmail.com>
 <15ce68e6-136f-7e9b-553c-968a0653a9b8@st.com>
In-Reply-To: <15ce68e6-136f-7e9b-553c-968a0653a9b8@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Mar 2019 10:39:15 +0100
Message-ID: <CACRpkdaYn0qQZZRqTrLnUc_syVROSNP0M5doM9BJNMOL5Zx0=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:09 AM Ludovic BARRE <ludovic.barre@st.com> wrote:

> I could have a snowball board, I don't remember if it a ux500v1 or v2?

I think they are all v2.

> This board has been removed of u-boot mainline, do you have a specific
> repository for snowball or what branch do you advise?
> do you have a snowball wiki (up-to-date) for flashing...

I have some information here:
https://dflund.se/~triad/krad/ux500/

I'd be surprised if you don't have U-boot or fastboot on the board
already.

Yours,
Linus Walleij
