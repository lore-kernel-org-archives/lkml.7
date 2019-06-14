Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A081C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37719208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFNDYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:24:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfFNDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:24:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so1302554edq.9;
        Thu, 13 Jun 2019 20:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AfQZDv35ufBp3E88y1iMFldBKX1WcqrUozmSOVMRmA=;
        b=oq3OWHrk+TxK0de+YgduayRtaOPWWIyvnXnKegfxVwALeToWtfGehQvGsiWruJGeL5
         4UpcGylzr8wjY26071CTLpAbU+P8Xt7BYTM/X59XSZ48oQgHcH6qUFQXLhPoAcKd70wL
         Ueka7V5RKMq+aencEEXctMol3mQb7fzR03kKDcA8k+PpxjXd+2/XUWQs9WWSUzx5RgtB
         Uh0apItdwyWUtSEpUYjpOYg+QrwO1yjvFWssJFMSo8ISs6usCo/eNm9HwsKnd/XgOdJh
         AEYd0dS9XzeL0GTYaPTZ+I0ZBrWnzcTqBoLESXMLieNxO77EET6x0ebZgJXd68jBToZX
         FgVw==
X-Gm-Message-State: APjAAAXRyR6TxOdPCuqT7muhWidCvdJ/3Ukljx6pVCnVYi6f7R1v/3VL
        pkqlthOEHvfCrF/0GfgunvlGOtFz8dg=
X-Google-Smtp-Source: APXvYqz/d6MpViCFkUo8aKztq1VgveNFch476c7m90mDd4fBmTqa5cov0d4a+KPquN9ghZTtnvSneg==
X-Received: by 2002:a17:906:fae0:: with SMTP id lu32mr57234942ejb.283.1560482682227;
        Thu, 13 Jun 2019 20:24:42 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id p15sm334111ejb.6.2019.06.13.20.24.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:24:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id x17so866639wrl.9;
        Thu, 13 Jun 2019 20:24:41 -0700 (PDT)
X-Received: by 2002:adf:fc85:: with SMTP id g5mr62039461wrr.324.1560482681552;
 Thu, 13 Jun 2019 20:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com> <20190613185241.22800-5-jagan@amarulasolutions.com>
In-Reply-To: <20190613185241.22800-5-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:24:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67eNu31pQExMTxAki1Wp4tdqRH87Oh+1j4Cb0cuK8pQRQ@mail.gmail.com>
Message-ID: <CAGb2v67eNu31pQExMTxAki1Wp4tdqRH87Oh+1j4Cb0cuK8pQRQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/sun4i: tcon_top: Use clock name index macros
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:54 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> TCON TOP mux blocks in R40 are registering clock using
> tcon top clock index numbers.
>
> Right now the code is using, real numbers start with 0, but
> we have proper macros that defined these name index numbers.
>
> Use the existing macros, instead of real numbers for more
> code readability.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

However, you might want to rename the clock first, then switch to
using the index macros?
