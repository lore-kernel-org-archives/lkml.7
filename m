Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD51C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20182082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShN/wlRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfFJIUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:20:16 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45851 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfFJIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:20:16 -0400
Received: by mail-wr1-f48.google.com with SMTP id f9so8166782wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s4CuSQBNjpCCNw2nzrPLspN54vVYUiRnMZOt2mADAck=;
        b=ShN/wlRZ6+T44YTTak7qIefyrWi2CFZpPHiFhwCs+6agNStIZl1VrtoRnwiAM0giZH
         IAwfc0CH0F4tiD3rFC4avNyeVdYZ6SnX2Bq/7D/tKM+S6r1BRT2JYQ6XNmpvZ/nizexF
         0lnXpdRjyFe0c1z5FobfClGzY0GDVCh5ptL25eI7JnK8KFmopfny2JNzAT0J9JElyoxP
         7NGTznHV5Rjbx7fviSoZ1YLTCNdo1WxzQwPTEm5ygMLqr2hjqAnGLHRUXs3O9Ffpi8Ck
         jb/Fe1KXTTaiFa7yR3iziFOKj8R2lcOeLwmPPYpJAwkVTiPZEHiKSRAizxcp7h1NgrsV
         1eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s4CuSQBNjpCCNw2nzrPLspN54vVYUiRnMZOt2mADAck=;
        b=Vbld1gQZQEiQwJ/T6FND4fA9AMD+vSTp3yCaNjB7cCfvW8rt4RwkWPo96uTYN5k/6K
         0Sct9/SuEMjObTrBVwQmOle6qt6CTutpABIhO10gs/2s+KyAxJrJ87Dm8ZjgRkVhSaqt
         4W0E/up2ifa5eAQ7lLXq8sfYtrgiW99nhBjsXmtLxa46x3DlMSjGVHkmU8t3Ng3hPqrQ
         M8XtUhvzjwrKdf90AFUOCFd4DoypAwYY/70D7pCswxRVx/ssYDhTM0GOZ2vseMiXCE1/
         jT/JMNpNZu3JKBL/ZphFXzYRYAvOicOPD43GoJpvH6Cc/OGUVNpv9iAsrmV9b3wM0kgY
         zqQw==
X-Gm-Message-State: APjAAAVoF09hF2ZZGfFzB0OEuSc47yrSi28L5KDN9Dwu9jlyNveXWQcJ
        F9nJ4UGhrJH9sMqKJCiuSztm5Q==
X-Google-Smtp-Source: APXvYqwZMgo/mIX2mHjN3PTc4kasBDUVDC60B5GI5hdZc40wSrHoaFk89PunjVBNxAjDf3jnFeSU0Q==
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr17554731wrw.98.1560154814655;
        Mon, 10 Jun 2019 01:20:14 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id o185sm14013441wmo.45.2019.06.10.01.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:20:13 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:20:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [GIT PULL] Immutable branch between MFD and Cros due for the v5.3
 merge window
Message-ID: <20190610082012.GK4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
 <20190604055908.GA4797@dell>
 <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested.

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3

for you to fetch changes up to 3aa6be30da899619c44aa654313ba66eb44e7291:

  mfd: cros_ec: Update I2S API (2019-06-10 09:15:08 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Cros due for the v5.3 merge window

----------------------------------------------------------------
Gwendal Grignou (30):
      mfd: cros_ec: Update license term
      mfd: cros_ec: Zero BUILD_ macro
      mfd: cros_ec: set comments properly
      mfd: cros_ec: add ec_align macros
      mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
      mfd: cros_ec: use BIT macro
      mfd: cros_ec: Update ACPI interface definition
      mfd: cros_ec: move HDMI CEC API definition
      mfd: cros_ec: Remove zero-size structs
      mfd: cros_ec: Add Flash V2 commands API
      mfd: cros_ec: Add PWM_SET_DUTY API
      mfd: cros_ec: Add lightbar v2 API
      mfd: cros_ec: Expand hash API
      mfd: cros_ec: Add EC transport protocol v4
      mfd: cros_ec: Complete MEMS sensor API
      mfd: cros_ec: Fix event processing API
      mfd: cros_ec: Add fingerprint API
      mfd: cros_ec: Fix temperature API
      mfd: cros_ec: Complete Power and USB PD API
      mfd: cros_ec: Add API for keyboard testing
      mfd: cros_ec: Add Hibernate API
      mfd: cros_ec: Add Smart Battery Firmware update API
      mfd: cros_ec: Add I2C passthru protection API
      mfd: cros_ec: Add API for EC-EC communication
      mfd: cros_ec: Add API for Touchpad support
      mfd: cros_ec: Add API for Fingerprint support
      mfd: cros_ec: Add API for rwsig
      mfd: cros_ec: Add SKU ID and Secure storage API
      mfd: cros_ec: Add Management API entry points
      mfd: cros_ec: Update I2S API

 include/linux/mfd/cros_ec_commands.h | 3658 +++++++++++++++++++++++++++-------
 sound/soc/codecs/cros_ec_codec.c     |    8 +-
 2 files changed, 2915 insertions(+), 751 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
