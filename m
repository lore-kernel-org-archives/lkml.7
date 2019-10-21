Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA258CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805662089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4plsD5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfJUHw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:52:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44851 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfJUHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:52:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so9242594edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lshseq5695iLMWS2/yTnU4q4phMFdnGbVyLcqMyDgNw=;
        b=f4plsD5OF7QI01+J/daaDJeoz3LkteQ6BQB7+jftsCG7vHACEuYAS0/ifg1VOZ+2bv
         DVnIY34EwF6RV/LyAIkxxcICf5gDAB5lJnzvHZwPiIbqUNd0/Lda6KhsIL7Vv666qS53
         0dm2LtJmUWVBz3Z6INSe5m7WXyh7OwRPV6IN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lshseq5695iLMWS2/yTnU4q4phMFdnGbVyLcqMyDgNw=;
        b=jyw1eSXtFu2tz96a7M3b4FjOaM5yXCofKnAGHkVhObX7uXspzWgallI8eT1T82zlwZ
         rBbsI2DDAzhntkkNSlSKmlbiAjCei6aVlJdCElvZG9RleYQVRBLmuDNON9p5xKlgfs6E
         HoVq3W5ipsyNdjKb+ZwVyKVvs17GmTi/pvcms24isLQD6XifPFBshQhTBiULbRAmZ5Av
         yIUDD1nP+f1qrqHlEoU0nQdWTqFA9DdnW5u+a6Xh9yvZQ3+1T19YD1WIXJMl7NCvVFg4
         A3i65+rR+MRxVjVXLeTFhk7fFl/2kUqJNCPdy9gYUZDms7iTJVir+dHagwfjzWoJWbWC
         I6SQ==
X-Gm-Message-State: APjAAAVNQ2NJ4RdV4C5fOagBZL0kzrZZVMxGbpuRueTI3Uwh38/ei31u
        oNRPiNZzGTXQB5WefB1XAx3tahg8Y3pnMGe2nl9eMQ==
X-Google-Smtp-Source: APXvYqzlkUpYGQn2syS3ZLVsVWF/tTk0yVfY4fQyTuFCwfaWNooQm7u2tuJVHYSsQtBTu3rWlHNporZiD288c1BLvm4=
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr23548337eds.87.1571644344157;
 Mon, 21 Oct 2019 00:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906100514.30803-1-roger.lu@mediatek.com> <20190906100514.30803-4-roger.lu@mediatek.com>
In-Reply-To: <20190906100514.30803-4-roger.lu@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 21 Oct 2019 15:51:48 +0800
Message-ID: <CANdKZ0dAWWy7QMMZhNHAha5ZpcBo1GHebPc5_FRu5gvBc569QA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM / AVS: SVS: Introduce SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, yt.lee@mediatek.com,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Fri, Sep 6, 2019 at 6:06 PM Roger Lu <roger.lu@mediatek.com> wrote:
> ...
> +static int svs_resource_setup(struct mtk_svs *svs)
> ...
> +               for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> +                       opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> +                       if (IS_ERR(opp)) {
> +                               pr_err("%s: error opp entry!!, err = %ld\n",
> +                                      svsb->name, PTR_ERR(opp));
> +                               return PTR_ERR(opp);
> +                       }
> +
> +                       svsb->opp_freqs[i] = freq;
> +                       svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> +                       svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> +                                                    svsb->freq_base) & 0xff;

Should have dev_pm_opp_put(opp); here.

> +               }
> +       }
> +
> +       return 0;
> +}
> ...
> +static int svs_status_proc_show(struct seq_file *m, void *v)
> ...
> +       for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> +               opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> +               if (IS_ERR(opp)) {
> +                       seq_printf(m, "%s: error opp entry!!, err = %ld\n",
> +                                  svsb->name, PTR_ERR(opp));
> +                       return PTR_ERR(opp);
> +               }
> +
> +               seq_printf(m, "opp_freqs[%02u]: %lu, volts[%02u]: %lu, ",
> +                          i, freq, i, dev_pm_opp_get_voltage(opp));
> +               seq_printf(m, "svsb_volts[%02u]: 0x%x, freqs_pct[%02u]: %u\n",
> +                          i, svsb->volts[i], i, svsb->freqs_pct[i]);

Same here.

> +       }
> +
> +       return 0;
> +}
> ...
