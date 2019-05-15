Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4B320873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557939021;
	bh=7dYD8EWc+6lYAgEl6bVHxWTQKwYRKTC7OokjvBWBMW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=beLzsUety14aN8ttMe6AZ6IT5/uZjIufTRVtQ+oeQLtJYjpCSdlbuvbKPoZ3MmAn8
	 4IReaiiC3E3pzSRMYG4yQ9jIqy3qaAZBKO0QNe9idXHoFsFA6qO4gIe+yBE9v0gz51
	 d2JgIYIOXAN3vIrEoJnGuzjJJhzmBsWYGrKi/EyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEOQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEOQuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:50:20 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B562920881
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557939019;
        bh=7dYD8EWc+6lYAgEl6bVHxWTQKwYRKTC7OokjvBWBMW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JBdrSqnOaS2pHUR9XAffw6PyEf1N/MTlCP3T9gaXwbsqCxjG4G73SbbsoucB88HXr
         GHwrP4QtJUB8zmWVkR9hkgahbsqB8SkW1E/sS+niM09oZc5tXtKU//SLslpvOo4Y2i
         qMj6CdDaNP7Gn31Qt5L+51BWuvBmxCPAwKkes5Pw=
Received: by mail-qt1-f169.google.com with SMTP id y42so443526qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:50:19 -0700 (PDT)
X-Gm-Message-State: APjAAAWxAVRypgMgU70knx328k6u0F2JrrCBPiWvmlXUnYQBfmF8quVa
        WEJtoMH11qyeVZXJjNJQyJKgdP6XC9Rz6HDx0Q==
X-Google-Smtp-Source: APXvYqz5rWpeCdEqfqN13e8iw24ki/RNn8YX3lZWk59nC3g2TOG8biR7Rus/sOG+5AUpoQxrvuEhgJL80nb9tvnLdMk=
X-Received: by 2002:a0c:b0c7:: with SMTP id p7mr1843852qvc.246.1557939019006;
 Wed, 15 May 2019 09:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-4-elder@linaro.org>
 <CAK8P3a3KLj5x-5VS5eUQfNVhPL101Dg_rezEzra4GFY5Dva2Cg@mail.gmail.com> <fa75eb5e-90bc-b164-740f-4dbba8bccc46@linaro.org>
In-Reply-To: <fa75eb5e-90bc-b164-740f-4dbba8bccc46@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 May 2019 11:50:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLz_ALmzhV9ezjPCvbuBmZmzMCeowYJkHo7WfNvqruubA@mail.gmail.com>
Message-ID: <CAL_JsqLz_ALmzhV9ezjPCvbuBmZmzMCeowYJkHo7WfNvqruubA@mail.gmail.com>
Subject: Re: [PATCH 03/18] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 7:04 AM Alex Elder <elder@linaro.org> wrote:
>
> On 5/15/19 2:03 AM, Arnd Bergmann wrote:
> > On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> >>
> >> Add the binding definitions for the "qcom,ipa" device tree node.
> >>
> >> Signed-off-by: Alex Elder <elder@linaro.org>
> >> ---
> >>  .../devicetree/bindings/net/qcom,ipa.txt      | 164 ++++++++++++++++++
> >>  1 file changed, 164 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.txt b/Documentation/devicetree/bindings/net/qcom,ipa.txt
> >> new file mode 100644
> >> index 000000000000..2705e198f12e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.txt
> >
> > For new bindings, we should use the yaml format so we can verify the
> > device tree files against the binding.
>
> OK.  I didn't realize that was upstream yet.  I will convert.

Not required yet, but it puts the maintainer in a good mood. :)

As does CCing the DT list.

Rob
