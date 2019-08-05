Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8734C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3D2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564993902;
	bh=6GDlY6Oj/pMsxqqXmrShaQDXNdC8M9mTC8Uh+0WR7cw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=GslPh7qbDdOwmqxDmPJZNfK64hlheLRTkv5PUOfgeJMDooZAOFMqyrywFCc0aKX3T
	 OTE2BcTpTuBrEDu3ZvPCj0hFqT5uZaJvRigH4bk8/zinbfnvPApZ2YNgm1KHwYe7CD
	 6v95Qy7Q2WcXFnYwXsf0PDTb1F0PoRf7ywHX6Jpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfHEIbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:31:41 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0BB20B1F;
        Mon,  5 Aug 2019 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564993901;
        bh=6GDlY6Oj/pMsxqqXmrShaQDXNdC8M9mTC8Uh+0WR7cw=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=peHYXbmKGBkRGDkgiCG5T0LLnNYHuvThB7B3ZZZnfMAD4dBao3elfqPZWeYSLgv5m
         mgxeKfu8ZWuAS8b6dcFyko593cTA9bWGo6IGV9Jxp5cXtOJQEFvdOepvRLByQEsPcN
         MS8Q7SLbllXv+ymRvocxkzEptTK+NEInF7m/Q3Xw=
Received: by mail-lf1-f47.google.com with SMTP id s19so57243330lfb.9;
        Mon, 05 Aug 2019 01:31:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVYiTCYAq9OL/6CBRwFW6vf4xC20YDCYhPaNOqkgrb4xMT5wO8P
        MsyQmBM1p7m1SYIthcKOv7a0XuJJIHGME1YZm1A=
X-Google-Smtp-Source: APXvYqyWaflWWQ8wwvaO1d9cbgBslefLEtgX0rPNgijTABssXm+H4yZIkYKO5j/21nYMMWJoveT1E8Ew7gsDV7eLoD4=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr68291107lfi.159.1564993898942;
 Mon, 05 Aug 2019 01:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAF-0O_47bLysYD9qn2ekNC7PmNj0LguB6ab_9mdw6NaoGPj4rw@mail.gmail.com>
In-Reply-To: <CAF-0O_47bLysYD9qn2ekNC7PmNj0LguB6ab_9mdw6NaoGPj4rw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 5 Aug 2019 10:31:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe9nY4wV+Dj4BHMO6=WmtxjMnSe+z6ZywaokUNPyyvOuA@mail.gmail.com>
Message-ID: <CAJKOXPe9nY4wV+Dj4BHMO6=WmtxjMnSe+z6ZywaokUNPyyvOuA@mail.gmail.com>
Subject: Re: suspend/Resume Sound issue workaround
To:     Jaafar Ali <jaafarkhalaf@gmail.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2019 at 14:36, Jaafar Ali <jaafarkhalaf@gmail.com> wrote:
> Dear Krzysztof,
> The sound of Odroid-XU4 after suspend/resume cycle has an issue. As a workaround, the I2SMOD register value should be set to zero after resume, the i2s_resume function would be:
>
> static int i2s_resume(struct snd_soc_dai *dai)
> {
> struct samsung_i2s_priv *priv = dev_get_drvdata(dai->dev);
> printk(KERN_EMERG "i2s resume of dai !\n");
> priv->suspend_i2smod = 0;//workaround-1 , to force using internal codec clock source (CDCLKCON bit = 0)
> //see another workaround inside hw_param
>
>         return pm_runtime_force_resume(dai->dev);
>
> }
>
> Also, inside hw_params function, the rclk_srcrate must be halved to solve unknown problem of clock shift, so before return from hw_params we must insert:
> if(mod == 0){
> priv->rclk_srcrate = priv->rclk_srcrate / 2; //workaround-2, clock is being halved due to unknwon bug
> printk(KERN_EMERG "i2s hw_param rclk_srcrate after %lu !\n", priv->rclk_srcrate);
> }
> return 0;
>
> With these two workaround sound issue was solved, but I hope we can get concrete fix.

Hi Jaafar,

Thanks for the report. Preferred way to send bug reports is to use the
public channels by sending to Linux kernel mailing lists:
linux-samsung-soc@vger.kernel.org and linux-kernel@vger.kernel.org,
with the Cc of other interested people. The best is to use the
scripts/get_maintainer.pl tool (with -f for example) to get the list
of addresses to Cc.

Best regards,
Krzysztof
