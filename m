Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77800C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E2218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiaOf0rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCUIVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33436 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfCUIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so5578345wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qwrQdvVKh2EI1cOM8sw79r0P69OGwUUrFBIWX2NuVRA=;
        b=FiaOf0rYcglNOphlyRprni17TOYnIXUDBNgir1CsQ54J78HSDh798vJ+aKPoo5wnu/
         xWLa5J0zgW/Hi2FQzcOSviDba5kqENQAwDfwj6igzLuJNFnaV8RGLm+F/TtTnhsvramj
         ASN1V/5R+rNtV9COj+12pQuJfzlkzcSZMn6w9E0gyeYqcKvWevD+8lpl2ZikGaiZ5w1I
         xGVLlMjpkPNsGnJdX5MIKyAt7hbQGEH0UHDCgFwXxFmS56LRlzbCWck7BWa4DjisiD2A
         Rj7cN63lj32AoJUv80i0n4MtqrzZnsnFNfmKOqnfkUa0XN1doGTX8/Ea+TYGhRR0E/+B
         5djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qwrQdvVKh2EI1cOM8sw79r0P69OGwUUrFBIWX2NuVRA=;
        b=bIm2+gepUsQhxKJyHr/G8Uo5c1KWTJGYQklTIydxoIbn9YrHyi0X5zBK7gw17EQeNG
         DnuSIxYHLL3J2+Ufqf8pKqBHO8Xwlqi4nt/38thMs6pYTjPW5gYw381RD2IXnZq3bnye
         ppA9VkQwei/BUhpzITpxa8aYmMnQO67SwC7a31L7ts97/+uNMJg8h/+QnPa9LCaChLO0
         6zFwZECgXfm5GV/laZzy/XcxxXCiSZPW6ekf35nAmJtSakkw0XS3vEA1GYHUNqOOsWlQ
         7BXDWKbsqP0bR+kyfXINVmahSgBXTJIkLLqC8hLfLnHuWiD3henuH7YTU6o2bYQuf+Q0
         PLLg==
X-Gm-Message-State: APjAAAWGOUjR3lun4TbupReSWjo7EFyz61onz1JLG8tusFv1JVBoVZ7D
        HCik+a1pJKUPmujV48mZPJTehQ==
X-Google-Smtp-Source: APXvYqzzOPKHqo0/FUfYZ6A39EM4t1qrttxbwpLg0Y7D0J+bA7ZRHSz7PjRIvdfAp1XlG05abiFOnA==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr1121010wrq.318.1553156501228;
        Thu, 21 Mar 2019 01:21:41 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id a9sm6100368wmm.10.2019.03.21.01.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:21:40 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:21:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        pavel@ucw.cz, tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190321082139.GS4731@dell>
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190313123249.17258-4-dmurphy@ti.com>
 <a7ee025e-361e-90b8-e38d-53546a542102@gmail.com>
 <7b3d8a13-d255-e36e-979b-cbd337078d30@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b3d8a13-d255-e36e-979b-cbd337078d30@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Dan Murphy wrote:
> On 3/20/19 1:59 PM, Jacek Anaszewski wrote:
> > On 3/13/19 1:32 PM, Dan Murphy wrote:
> >> Introduce the Texas Instruments LM3532 White LED driver.
> >> The driver supports ALS configurability or manual brightness
> >> control.
> >>
> >> The driver also supports associating LED strings with specific
> >> control banks in a group or as individually controlled strings.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>
> >> v4 - Updated code to DT doc changes appending "ti," to TI specific properties -
> >> https://lore.kernel.org/patchwork/patch/1050124/
> >>
> >> v3 - Removed switch case for register setting in favor of an algorithim (v1 comment),
> >> https://lore.kernel.org/patchwork/patch/1049024/
> >> v2 - Added look up tables for als_avg, als_imp and ramp times, fixed brightness
> >> control when ALS is in control, added property value checks to ensure the values
> >> are not out of bounds - https://lore.kernel.org/patchwork/patch/1048807/
> >>
> >>   drivers/leds/Kconfig       |  10 +
> >>   drivers/leds/Makefile      |   1 +
> >>   drivers/leds/leds-lm3532.c | 681 +++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 692 insertions(+)
> >>   create mode 100644 drivers/leds/leds-lm3532.c

[snip 700 lines of churn]

> Ack.  I give post v5 tomorrow.

Same for you too please Dan.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
