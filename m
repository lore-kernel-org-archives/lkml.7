Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DAF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCVIlX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:41:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38387 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:41:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id q14so977746edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z9APwViyrgW/Rfkhm/jCELx7kXyDm0QeqvOkUHMWQAo=;
        b=RF3qaIoPVKnyvibj59ebUCEKXbKp2IApaCJ0fl4U8EEcC5tZR43QNIZPsWh0EfsjK5
         JEuE5gsFPaTtY0NCn6j9u/C8Ka1o3Rz3Ef3I3Wuk1ax0HBlUcLW0o7HB5jMxuYUXlLM+
         uEIkhYqCB43sKVyShk51DPKEmIIALiT118YpcWu9S+nQlCy6fG9ye//Ph8LpTNEVCIIm
         aQof7LE5V/Qe3/RdoBqPVavHJuvVQlxatDpFll+l1PiqqOTvLWjM7m7u2PmUqdw4YF8d
         cPIaYDGGDHIxo6i/OplKcUgYkocYgu8BEoryyKpzIlVXMKOhxodlLNyp1cZPob1/c5si
         mWxQ==
X-Gm-Message-State: APjAAAXlONcwPCw1guyJ6z9prGBRIZTs4XD8UslMM8EksbRMrgrGB3D3
        i3j8fsqGmOaWRiuEsJcYOUYZ2VXRX0I=
X-Google-Smtp-Source: APXvYqzjgHsqB5PRPu7etOjvx+co0p4XLqLu5LpHLLH9iWun+c+qDhyCriqPt1MU52a4T9K3BaSQkA==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr4783151ejd.139.1553244080462;
        Fri, 22 Mar 2019 01:41:20 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id y21sm2359101edb.54.2019.03.22.01.41.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 01:41:20 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 4so1266600wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:41:19 -0700 (PDT)
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr1944344wma.99.1553244079362;
 Fri, 22 Mar 2019 01:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190320165643.GA3886@embeddedor>
In-Reply-To: <20190320165643.GA3886@embeddedor>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 22 Mar 2019 16:41:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v65iVRZkrgGrQGnfcYp0wbdquOw5eHqyYaV_WrfHObTQ4Q@mail.gmail.com>
Message-ID: <CAGb2v65iVRZkrgGrQGnfcYp0wbdquOw5eHqyYaV_WrfHObTQ4Q@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 12:57 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/regulator/axp20x-regulator.c: In function ‘axp20x_set_dcdc_freq’:
> drivers/regulator/axp20x-regulator.c:1023:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    reg = AXP803_DCDC_FREQ_CTRL;
> drivers/regulator/axp20x-regulator.c:1025:2: note: here
>   case AXP806_ID:
>   ^~~~
> drivers/regulator/axp20x-regulator.c: In function ‘axp20x_set_dcdc_workmode’:
> drivers/regulator/axp20x-regulator.c:1115:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    reg = AXP806_DCDC_MODE_CTRL2;
> drivers/regulator/axp20x-regulator.c:1121:2: note: here
>   case AXP221_ID:
>   ^~~~
>
> Notice that in this particular case, I moved the whole comment
> "Fall through to the check below.", which contains the "Fall through"
> comment, at the bottom of the case, which is what GCC is expecting
> to find.
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Chen-Yu Tsai
