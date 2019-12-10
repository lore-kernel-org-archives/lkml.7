Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF3EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77834206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pcg4dJHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLJSsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:48:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46946 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfLJSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:48:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so13749848lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOSCVw9bioi+5hxnz7bz/OpGazg6+xs3kBeEbrtXG48=;
        b=Pcg4dJHJx81bsDelVo2J311YXVKJfxTmtD9q4K/3ixqYZ3o9fcUZASvkvpmsNECc2m
         goyWlV33/Y8CabpTc3jtAu198H4wWXtuNEOLsTX9j6W1blZgb9ZTwXUjsO0keytLEoFo
         HSRPniaTF99B5LfPCNLoU/RQTDtXK0m3ygND4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOSCVw9bioi+5hxnz7bz/OpGazg6+xs3kBeEbrtXG48=;
        b=jO3S8pzTEcM6pCeOx/tR/2hbiQ0NR1iq7g59NIKOZkrVjUnFD+XVRsUvWtUSPohYf7
         pXiTWrue4UGZY8P6kNAw8RdBiwRJSJDxFRAKPQy5AoiZz8f7D7nK3IkIp2U6qpaFj1gh
         Iq53hdbjKftc7ZsBja2EOLBPCtFjb1bq+8gT0DtJFdHFXLhCwxfIixwuUGV9dtmt8+8z
         5aFJ6q+721vLGEQwjPQBrFfgVcN1LZzWeSw6xsJJovQo5ijW2NSgosYSTwG785nlHpmL
         H52UanuyMSFSLCUDHl34JIEZzDsMGinWLk81W/iwMaTK0h2Y9jOpDL9Z+k+uJrHo4qMD
         rLAA==
X-Gm-Message-State: APjAAAXpEyfXwTJOwLEE6HOeZ/FlwQ7/jqB8Ykdo9cxzvwawDhfK3QdR
        ZJ7Z01MGbqvdwZC7GzP9aRsU81zYWGA=
X-Google-Smtp-Source: APXvYqzomwaaHIXctcQoYmBZzzidNSKnULCQrfiWxyzRzThbPRF4rwhaj8WBVXxgujhd0Tzm29lL6Q==
X-Received: by 2002:a19:cc49:: with SMTP id c70mr13042717lfg.73.1576003716094;
        Tue, 10 Dec 2019 10:48:36 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v14sm2246685ljv.105.2019.12.10.10.48.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:48:34 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id i23so2116235lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:48:34 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr8691484lfj.79.1576003713698;
 Tue, 10 Dec 2019 10:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20191107000917.1092409-1-bjorn.andersson@linaro.org> <20191107000917.1092409-3-bjorn.andersson@linaro.org>
In-Reply-To: <20191107000917.1092409-3-bjorn.andersson@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Dec 2019 10:47:57 -0800
X-Gmail-Original-Message-ID: <CAE=gft5mLSqsJzj=DtesH3G68_wSKUr8rZ5iubOerimQmZKegA@mail.gmail.com>
Message-ID: <CAE=gft5mLSqsJzj=DtesH3G68_wSKUr8rZ5iubOerimQmZKegA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] phy: qcom-qmp: Increase PHY ready timeout
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:09 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> It's typical for the QHP PHY to take slightly above 1ms to initialize,
> so increase the timeout of the PHY ready check to 10ms - as already done
> in the downstream PCIe driver.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Tested-by: Evan Green <evgreen@chromium.org>

Should this have a Fixes tag for 14ced7e3a1ae9 ("phy: qcom-qmp:
Correct ready status, again")?
