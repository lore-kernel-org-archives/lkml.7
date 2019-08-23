Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85591C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6623402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6SBn6sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405037AbfHWIvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:51:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43216 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391054AbfHWIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:51:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id h15so8116698ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXtQDuMScF/1nReve4eretX2TO/jfCiedtGuRQR2hjM=;
        b=p6SBn6sDUBeFLX9nMJmZGZC+PTQMLkZJ8aTvGmL+qINEfOstq/jNuLob/ghlirv1KJ
         cZRyeXtQ1faKYUnTHuBCVNy/y+gs5O1Ob5u1hV9AU5ut4mXZX+Okq3HmZsxsT+DBbIGs
         J7sCK51VUU3lrdn3m0sttx9PyWO3QwemGQnd1cRnP0eZPC4Pa8fqdl0xMWR23wDeqeAt
         FBxKNcv/H0DFEFdPjz9wsTwbnCzc2Hnz2I0UXU6Qlf1/20m+dC5NojBZhY02m301Xx20
         8SBl2+ZAWxgHnmt/joknqH100+Al87qai/W4q6tyFUZ1rvjBxGuZwVUWExcs1/CQ4lLY
         4fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXtQDuMScF/1nReve4eretX2TO/jfCiedtGuRQR2hjM=;
        b=mu47kB0s/krAOJristyiql5SYx07yjDLVh4xO8cnE28s7bmnliGdOum1e8Z4istRU/
         h6LSlTsn4AD7kSkb4298KlsGl7lbKquPJtUrZ9i5YcS6QWOdfbDDo7a7F81LB6P2cm7e
         oGGdeqaPMwWEzuYmnqnA8m5t+5v2stE13u3HK7n4DWzPXkmqZ46A1BdVbwTnzkCaSTpy
         OCeF+/mBzbGDtZhVkxDscgxNI6J4wZp81uZ0/rfYI6lXayLTVKLfssBcsMepgT5alGKP
         RR+9cSPENegP9Rs3qRKa6ZYAVA/CM7t0CWXcNDkZgpr8TPy0L9cQfmflE1jmvwijcRJw
         mV/g==
X-Gm-Message-State: APjAAAXx3PktQbyB2X5BEsajThqSVYzZkFSd8CPjYK1Xjl0uXUG1u5c4
        DbY0VE5YNrYdtfWEUY2Im04+1evQLLc+OYukOiMqLA==
X-Google-Smtp-Source: APXvYqyppYyNq83SxxmmRdWOnL0oOzeUD0rB8qh3X7YKYtXA9sxXcXqHi/9iYmrgLahKeTty/OM4UHWE1xxoqpX3Dgw=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr2124440ljg.62.1566550276856;
 Fri, 23 Aug 2019 01:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-4-git-send-email-mars.cheng@mediatek.com>
In-Reply-To: <1566206502-4347-4-git-send-email-mars.cheng@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 10:51:04 +0200
Message-ID: <CACRpkdY4sVV5oyFa+a30dY2A9tsKpzTeuQ8ChmnXcm-5_eZkVA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: irq: mtk,sysirq: add support for mt6779
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:22 AM Mars Cheng <mars.cheng@mediatek.com> wrote:

> Add binding documentation of mediatek,sysirq for mt6779 SoC.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>

I'm relying on Sean to review this and ACK when he's pleased
with the result.

Yours,
Linus Walleij
