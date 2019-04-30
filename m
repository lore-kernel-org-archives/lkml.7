Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F602087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tYmHnixE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfD3U2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:28:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3U2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:28:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so22480296wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6BX6/WUNOoSiFLmAFQqGnF6/PRbz+EhjmT+iJ67/mUY=;
        b=tYmHnixEDXEt2SAOXn0QJ2Vj/azLQQUXwgXGIkZmZNXwc0/pdtI/uQl2yIUyLmh94g
         1NR4t88UJ5eNIR58MgE8GCkz4Nkf4+F8vSMhl5t/ePlHWPTxEmeDrz5LzTyPnFPOGwbI
         fn3HB0SlYx2JPz/gcR+/lxXMP6XAE67l5/sPgAmDCS5Cx/JT8rDzInP37Ay7rfK8o8nL
         8vCnP3C/8PAY3BhSAMyyLCXVDFXH5YQUII8ULcpyo89oUOiEHag/FhFBUIOVqkK42Job
         Mq+DeFKSFStprkJWPSDyOXehOIeanq9S5z8s7sCM6T4Ik286C0qudiAxbMEBRwU61Cg4
         AHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6BX6/WUNOoSiFLmAFQqGnF6/PRbz+EhjmT+iJ67/mUY=;
        b=geaZ4oxLbF9lr/1EzK6yjsnvch6qZrwA8almoiw4VBttWj4mGFuou46sDbF5PTqUJK
         hbCI9U1SLausNiWQ+dgpi/W16OmhVjjzMIvGqO05OixBJ4vq+DED3zl8Qq9tAX4KYwIQ
         Qr/8uJ+1MI1F6wAKzTujaPkLHmjdBEpT6sMB6ISfKh/nICI8Lz3gonOF981bPDI9GUBP
         8oaEJh2LjuIhMiv3MVHr2dh142uXy8K1EUms/qsbUaa3EsAMRnjr0Delz3DpRtvzxr6C
         m6AzMS/b4GQrR5+UnxsK5OiYOmjqJpeCHvYJBDLPf0BpzmiEBUdzzUivRq77QeZf4qKD
         KD5Q==
X-Gm-Message-State: APjAAAWHq2kGMVDuiIzqRX2JPWuTRgFVNN6z9HUOHNYQrrKNywg2xXyW
        AJDyOpg9dS7uYmNHoDrSxiU6KA==
X-Google-Smtp-Source: APXvYqz2S/xfszL0oWRG5GwXUJqfH6R2Vhb5FSkaVEgWr59FELVaoP/P20oTjWxy+aom60m3VdZUeg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr7146640wrx.193.1556656112020;
        Tue, 30 Apr 2019 13:28:32 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id o5sm3076191wmc.16.2019.04.30.13.28.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Apr 2019 13:28:31 -0700 (PDT)
Message-ID: <0bd1e9c25ab11112c9f2913c2cb3483e8802099d.camel@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Apr 2019 22:28:27 +0200
In-Reply-To: <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
         <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
         <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
         <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
         <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-30 at 22:02 +0200, Martin Blumenstingl wrote:
> > Thanks for effort but all this just maintain the blur around HS400 on amlogic.
> > 
> > Let me rephrase it:
> > Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
> > and HS200 modes. In HS400, this should be taken care of by the data strobe.
> > But we have not been to enable this reliably enable this on amlogic chipset ...
> I wasn't aware of this: so far I assumed that we're not setting the
> phase correctly, end of the story.
> thank you again for taking your time to explain this!

No worries. There is the MMC in general, I think I understand it a bit now but 
I might still be mistaken about some stuff. Then there is the HW we have and the
related black magic.

I doubt this is the last update in this driver ...

> 
> > ... and I believe we are back to the original commit message.
> no need to update the description just to explain how HS400 works in
> general, so feel free to use my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


