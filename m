Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8DEC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0CB2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hycMa+7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGEW3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 18:29:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38893 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGEW3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 18:29:20 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so22152703ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2xFeB/vxfBJWIi2SCTq+vsVIJL+pCcb0P3THlDfvNk=;
        b=hycMa+7f59LmBeoZx7y+T6iB+NqeRfKUCiEwPvr1G17qNMYTgFWeGgJnfHmpt58y3R
         pE2x4OswYZw80bCfWurEXT3RSUYQLZGIm/hAun3Zsi1gdbn1j5dxcQTLo8sHPU+Ciz7o
         iDfQh6cgbrxML1qV0b61RieVtvOF/c3yjVMQI4kcnTJHkz3r+Xp2keXGFHneyVDSqFe6
         g4Yik34C0kIqHBkyqItwiZt00TrFmr8pZUvduDej+ANXqBVq2TKmE0PkuRWaAIypt0tb
         5n+qAkievhL51pi8/Pk3ZX+Zpn0q4OOrs0azQb3ZvUf+vI+YpFAf4M4GatHRVj+GVVUc
         2Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2xFeB/vxfBJWIi2SCTq+vsVIJL+pCcb0P3THlDfvNk=;
        b=cBUmk+vqJUX4BfsCQZr+Exin3xhO6JCZdMGENMJ6FHJQAY+gcTZRQLIvhfb8VKEjrq
         Z1sUiT3CDTnURyNl3et0EYuwgQtOwa5yoNjG9Tw4EKFjWGctAAysYyjtcaSswtEyMAwp
         aC6sDh/aolHTHQs2MgVjeS6gBbKt+3wX3fRlpi7hWbabZqgghYb2ZSUs3zsvXRn1Mv+B
         g6Vx5CWkDlS883oI+eqLflXIasoXGe6yEVu+doMnQn4htC4w1/n9/eqDH29O0jjd13Zm
         mqvFWx5wz0jlWCN153geJO/SnUxfXhwAD3PpP74NYySwrB/jAZjaa+eHJqj8TgpnEJcM
         gM9A==
X-Gm-Message-State: APjAAAUOQJukUGUjEwBJ4GeAYqFt64WS8VJuskgT3p+JQZGVO+rab8lT
        2IuaDsB0rqIeWfimRaTvkAm/Z104nDGkms+HrxG6Eg==
X-Google-Smtp-Source: APXvYqwtqdru004WFVZFoC69PGQmOPnOHdWCXRH4144sBC3NkbqjrE+G/DO1ByoQUCVa7iOf555pJHgtt5vr645kXJM=
X-Received: by 2002:a5d:9642:: with SMTP id d2mr2393845ios.278.1562365759537;
 Fri, 05 Jul 2019 15:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559635435.git.baolin.wang@linaro.org> <15AEA3314E88B01E.21242@linux.kernel.org>
In-Reply-To: <15AEA3314E88B01E.21242@linux.kernel.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 5 Jul 2019 15:29:08 -0700
Message-ID: <CAOesGMjdnQuLdvphBDM3xmH6o+Nca8+65mw8-EajV0Eb_8MS5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mmc: sdhci-sprd: Check the enable clock's return
 value correctly
To:     patchwork-soc+owner@linux.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 3:25 PM Olof Johansson via Linux.Kernel.Org
<olof=lixom.net@linux.kernel.org> wrote:

Hmm, well, that didn't work like I expected to. Sorry for the noise.


-Olof
