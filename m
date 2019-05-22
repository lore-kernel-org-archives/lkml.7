Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71494C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198D521479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIvrTlaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfEVFxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:53:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35378 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfEVFxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:53:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so756692wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AHUIOEByr0m4e8bmYKW9unkrzC9v4z2NQ+RPUysVTIM=;
        b=rIvrTlaAD1pLZoNAm/8UsZc40zqWwcdIuRSZI4meDNRFXqHG2OQD7koy1hVMkWXOUE
         QNeK1pGllRWZxezOJHvyyQj5ZhV78Jr9a/gVLLQT+CBFO2WFbY4yfBz9v+AcE9xOScFp
         pv8Lvkq6M9UF/PWeNFnfN9NJc5NeMgP2m9GZj11ejOkKQvKDETcDTQDYUNn9w9iu+i8w
         dq0UfI1Lw+Sc+RMWwk0XfpfUtoVyvq+a+R0j1h6qBz3Tg37S+2YnPBuJZyOjcTriI4dr
         G/XUSurOODzJOS0LSuuOzKp4euciSkNuFH6jPrfKWHrJQAZ65+5qJlaUM+bt+WFth7P+
         W5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AHUIOEByr0m4e8bmYKW9unkrzC9v4z2NQ+RPUysVTIM=;
        b=OBzNhrgtUo3fbdby4bIlOtAL34DuLMDCewSKPIEdqRqSzWpXjsMAL27P4E36p+GbSi
         XD/eRp5MKh+bbooGA+LtL+xwjbpbj4oht3Ov0xYIA4ZwLSaGU2CDLF2qJA8wZUz05BU/
         6oqGAFWRizRkKbH5tvr+AntArZuuFeV2F39xRaky9tW9f9VBRkal54by7D9Ty04h8Kz/
         UgsJ0x4uKcSxaxRlHblcEVHL3oUhWEGcG9TrNXwW4Ut7W1bJlBZuKIZ4sHUljzbaFAsf
         3b20p80EjYVWO8pjdhdbDOL2xRL/jaXNqwGBka36GgeIYK7hda/9rZS5WwD/AzNrJnOI
         rSfQ==
X-Gm-Message-State: APjAAAWzGnwOXFOldBofRz4vE0Ttp2q+Odg3FNx1f8oCqZCgkLKI5ZiR
        sppOlTkEJTCxN41qbwhk/6lPlQ==
X-Google-Smtp-Source: APXvYqyXvQ6YlCncCaZyohVXqePSWI1HJn2NNbAQ6uQJ/JWVBjAhrtNXT3/rA0VJbHm2Bp8ks8sTHg==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr1612015wrr.32.1558504388344;
        Tue, 21 May 2019 22:53:08 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h8sm9733712wmf.5.2019.05.21.22.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 22:53:07 -0700 (PDT)
Date:   Wed, 22 May 2019 06:53:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190522055306.GC4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
 <20190521174438.GA2821@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521174438.GA2821@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Benson Leung wrote:

> Hi Lee,
> 
> On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> > On Fri, 17 May 2019, Gwendal Grignou wrote:
> > 
> > > Lee,
> > > 
> > > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > > used on chromebook using a squashed version of these patches.
> > > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > > respectively)
> > > Please let me know if you have any questions.
> > 
> > Is no one else from Chromium going to review?
> > 
> > These seem like quite important changes.
> > 
> 
> I've gone ahead and acked the whole series. Enric and I are OK with this going
> in for 5.3, and as Gwendal mentioned, he's landed these changes into our
> production kernels for Chrome OS as well, so this is what we want to sync on.

Wonderful, thank you.

> Let me know if you have any other concerns.
> 
> Thanks,
> Benson
> 



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
