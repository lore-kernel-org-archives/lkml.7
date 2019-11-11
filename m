Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC64C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A52214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+nzXDHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKKThs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:37:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38299 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:37:47 -0500
Received: by mail-io1-f65.google.com with SMTP id i13so14543352ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tjpx5W7e7hh3YundOT3Y5omRle8TPAfSWZ5zGMH9jMc=;
        b=V+nzXDHw0skWoqJdyWz9Rdx7fNPDeHhrAd8kmRI2OMSc0u7Jg9liQSmQF3eteMdg64
         N7K1Mt6HYT8g0Mi/ZFZ7Su1w6rOVUR+QiqTw8RKfH10TpFVKkQFBQaPtaGt6wkKKbb/8
         O53R/ZMO2RQCQ+8SlSir2Cg4uM43UWTBjK+sESIAyXMvNg2s19L4iOeXfpWG4j9qCFri
         nXb1+BKV+F/5vh5QaJdbCWbbJAFdRj564A+3/ZweIGORbKn3dqiaN+TGayhHbsHc1QxY
         lxCyq3yA13b8+j5ervk2YqJZjjKvXv1PkWXEEPVvWeTaHeY7SVbRyqU3PHodlCkXUEt/
         LpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tjpx5W7e7hh3YundOT3Y5omRle8TPAfSWZ5zGMH9jMc=;
        b=XXIIm5RkZ+q3VR1XkAyGYhCL8JdC/RJOqZtNHBn/Fgseb82wP4xf+/IJcN2gTEkoNm
         89YM8XamZgK/Vn9szsvnI4WEDwBJ5qDdlZWIO/rdxPWySKy22kOI380rxLu9eoOMy+UM
         hTFdBbCIWcAJFaSwbp916w8z/j13P8i47vQmTQCkET7JbtyI22gfRFoo0cb7yEgx2vGQ
         VUkQ555t6JJIv/ntOQdNx1I3PkvalUbW7o8ka2V6U5aAStHjRLzbh7PBBIEKEGBNoN0E
         mxhF29hUY1b3hddCn/TtPOmUjjHxo9EbyQ0WRVlAjsRSHgOJVhlfs3gglqZPT9EZpbe6
         7Gxg==
X-Gm-Message-State: APjAAAV/3o6UhHuUBgrw0veo6yA4gKbdZn5NqHEJrxC6VzxpMExY7z47
        z9v1vIe9kg3m/T+k6vLC2cGZDg==
X-Google-Smtp-Source: APXvYqwgn6zN2XKEdcnAdpxA3h/aPY56cMiq5P/zNmFabJ/SWU/jO7LQBfMsKg2bkrcRgPyoTfN2Gw==
X-Received: by 2002:a02:a402:: with SMTP id c2mr13107642jal.5.1573501066412;
        Mon, 11 Nov 2019 11:37:46 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id x5sm2287716ila.34.2019.11.11.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 11:37:45 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:37:43 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Jacob Rasmussen <jacobraz@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Jacob Rasmussen <jacobraz@google.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: rt5645: Fixed buddy jack support.
Message-ID: <20191111193743.GA201426@google.com>
References: <20191111185957.217244-1-jacobraz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111185957.217244-1-jacobraz@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:59:57AM -0700, Jacob Rasmussen wrote:
> The headphone jack on buddy was broken with the following commit:
> commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd
> detection").
> This changes the jd_mode for buddy to 4 so buddy can read from the same
> register that was used in the working version of this driver without
> affecting any other devices that might use this, since no other device uses
> jd_mode = 4. To test this I plugged and uplugged the headphone jack, verifying
> audio works.
> 
> Signed-off-by: Jacob Rasmussen <jacobraz@google.com>

Reviewed-by: Ross Zwisler <zwisler@google.com>
