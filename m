Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC31CA9EC9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24220862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkipk/vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJaCO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:14:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34350 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfJaCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:14:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so3257703lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsH3A1DqDOFl2XsHUyxDjmPi6g5GPerOQXufskJ4zsE=;
        b=wkipk/vmz3K+UqUSWwx9TakqLnbKR+02jMAR5SGMZCzif8JAFmJ08VLcACypiWHgd3
         Nq3A9LCWfNpUNIycEwlJ4UAxP5zL23OJiIho6/dnsB9Q36nvjP7/yqh7dc8MTagsv+FN
         AAqP79LixqCc1p/WSlBvTZWZFa4zOOvid5BNy/2G4O03423a8n8czYonP/S1X7AzJei+
         xFnAp1z2bYsMIRUatRet7wQ9djRfkazHtwwoJqZNe14MmN+igdTj+tXsgOE67YF8E3qO
         ecbGQkektDWSE7iJ49llVAzwhgYwCscfYLsFMckewsT8APYyRdOiFPK6vFFNQb4UEuxg
         dXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsH3A1DqDOFl2XsHUyxDjmPi6g5GPerOQXufskJ4zsE=;
        b=pxAUh3fZHzoo6R6Qp7l0iGHHFbpRP/T6JrdkoiOU6SD1cDZdaiZ4XekiMNzKwT2Z4F
         ggQzg/7yUq/RyHkUuJoR5OkDlbTIfau0TTerRlzpIZ+9AaanNo9NIUZZbH/RoEbElV1k
         nIgTRuxaJqdJq+Um6AA6A7+1IEUKXK8qxVZb7aiYhb7VquJE0K6Zwdn1E5sWLCE8Roa4
         gr01qq6p+fJUePDYeun5gsYLPh0LYIMcZQZE/uiG/bS+hXg3F9dVua7PaYlCN2NPz6Xf
         nuSVAfQlriQI3wwSH/8r7bZGUlk0P7SsyodptzyXS4lauHXlYSZ46ejZF2GP7zukYH91
         yAgw==
X-Gm-Message-State: APjAAAVaOMqnPA5oi0doBpKg3BBYylLPfG3tBTQTNeocwlbWWKGjU/0R
        V+o5J8dOfG4db+0ZW1r4Qw0Fu431d5oQg8iz0iRjLQ==
X-Google-Smtp-Source: APXvYqw+VI3/9pmeyk/FQBCxrTYSXbxKCCcEUYb6gLT2e3GJrpxbjpDnQJnhwJNDWQ47aNAf2rbGE63JO7PrPoICa+g=
X-Received: by 2002:ac2:420a:: with SMTP id y10mr997190lfh.65.1572488096719;
 Wed, 30 Oct 2019 19:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572245011.git.baolin.wang@linaro.org> <00202f739348258555dcc40982c330542ac61863.1572245011.git.baolin.wang@linaro.org>
 <20191030143949.GA18637@bogus>
In-Reply-To: <20191030143949.GA18637@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 31 Oct 2019 10:14:45 +0800
Message-ID: <CAMz4kuJ=8dOj6XbayNHKAYW7LD1EOaqv+Q4hYk_-7+R-z_m2Xw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: power: sc27xx: Add a new property to
 describe the real resistance of coulomb counter chip
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        baolin.wang7@gmail.com, Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 30 Oct 2019 at 22:39, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 03:19:00PM +0800, Baolin Wang wrote:
> > Add a new property to describe the real resistance of coulomb counter chip,
> > which is used to calibrate the accuracy of the coulomb counter chip.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> > index 0a5705b..fc042d0 100644
> > --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> > +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> > @@ -13,6 +13,7 @@ Required properties:
> >  - io-channel-names: Should be "bat-temp" or "charge-vol".
> >  - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
> >  - nvmem-cell-names: Should be "fgu_calib".
> > +- sprd,calib-resistance: Specify the real resistance of coulomb counter chip in micro Ohms.
> >  - monitored-battery: Phandle of battery characteristics devicetree node.
> >    See Documentation/devicetree/bindings/power/supply/battery.txt
>
> Needs a standard unit suffix.

Got it. Thanks.

-- 
Baolin Wang
Best Regards
