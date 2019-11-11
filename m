Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB17C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB8020856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaKzTLAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKJzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:55:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:55:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so7074212wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gybf1/2X828gYds0XJm1yRNQvfU7LgDOs8KBBOEIR6I=;
        b=QaKzTLAmgKQAew3pQIQYl7GmvT7T2OvypC5mj7USCrZ86/l6FwOR663z/m7YeSCFA5
         6u/3P7Y5LBQZ3UrswirpO/MhkXHJKSrtuNM7tUaHTeD/Cay/8boD4uz/NarPAIkiHZFs
         CdcacLcaSGTk1yLDZm6pgS7NbYzsWQ5grLcRKsqPUH6SdhSmKTwPGP9s+k5yialvCdvp
         JJbphSvrMH5j2DCeYE9kMHedQpX+dGTvQ+5Om0NQI14x1XqDF0Di6ZJNF0rCEs3FQwkz
         nOE33oFO5rtcoh+uFapJyu0LnqvfcWNbhSjcbWvxTV5sOK3U0mHCSjymziaa8T8bYCip
         l0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gybf1/2X828gYds0XJm1yRNQvfU7LgDOs8KBBOEIR6I=;
        b=YB2kdw5ANkT9ryklxTF3SSEokNiaPRtauilgB7cGfER4xwckECz30x+mc1CE3/Fe0a
         qp2wAEaPHudpwTnlGsUwD+83ZpmWgWb4J7gAVGv63j/NmVu7yTCT/Qvph+37rnhZyzQV
         uf8LQuIdgZi9JEgAwfvYbFSMH4fGeknqtI81mnI4C2KRcXFjFPWMomF6EtLLT3zIflDz
         KqYFZhbq8jIA1bOd4XQYNkC6oMqRmwNfVkUiENhpNYPstzwMs+jIxF/6WOiC6leQYaDm
         4rbzDYplSA1U5krPAlUmfcfSuEE6VriGpEF2SVHfkK2g24ezf2K3ovH2+k44cODsYHoU
         aLhw==
X-Gm-Message-State: APjAAAUX7pJ9QlUUXqDbTes2x+y3zmVD2OJ3RtQoapJpsjJAyemMuDnn
        V6/EXZHPG8RdtfjSiHQxZ9+J1Q==
X-Google-Smtp-Source: APXvYqxTlFFHRltdDLX3nlxD7ri/LPn4CQxB7t8iu9ZXgxOwm6kOYoOj1NPkCxZAOIiIgYu9rZq3Eg==
X-Received: by 2002:adf:a119:: with SMTP id o25mr14985475wro.74.1573466140765;
        Mon, 11 Nov 2019 01:55:40 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id g4sm16120987wru.75.2019.11.11.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:55:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:55:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: madera: Improve handling of regulator unbinding
Message-ID: <20191111095532.GB3218@dell>
References: <20191105114040.22010-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105114040.22010-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2019, Charles Keepax wrote:

> The current unbinding process for Madera has some issues. The trouble
> is runtime PM is disabled as the first step of the process, but
> some of the drivers release IRQs causing regmap IRQ to issue a
> runtime get which fails. To allow runtime PM to remain enabled during
> mfd_remove_devices, the DCVDD regulator must remain available. In
> the case of external DCVDD's this is simple, the regulator can simply
> be disabled/put after the call to mfd_remove_devices. However, in
> the case of an internally supplied DCVDD the regulator needs to be
> released after all the MFD children, except for the regulator child
> itself, have been removed. This is achieved by having the regulator
> driver itself do the disable/put, as it is the last driver removed from
> the MFD.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I'm fine with it, but Mark needs to review.

> ---
>  drivers/mfd/madera-core.c        | 20 ++++++++++++--------
>  drivers/regulator/arizona-ldo1.c | 14 +++++++++++++-
>  2 files changed, 25 insertions(+), 9 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
