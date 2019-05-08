Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F165C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F1216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8yhU8FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEHQhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:37:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42502 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEHQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:37:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so10180507pln.9;
        Wed, 08 May 2019 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Rth5LMPanMApgd/5gh0bE/u6yHTk5Ixmh3ZXSY6tUE=;
        b=s8yhU8FHqNYA+4qZIRdGTOgMBb6OO9HAEyWtfylRB390Y5/R0FVMpDFgZPhU1PxIct
         9FnDcP/32W2R5UztHlyttVCHcn1Fy1Uya6CB8NFC09/un5EwTZGBEXAkeYi+d+cLmDEV
         Dq9KCUkxpmurCBYwT5rpkdos3qCpu2wQaXe07g7GSZlw4zFbPejlGrcD+yJKA4r2EBpJ
         /5mxLEUnMYtDL8FQu6KxaAtykzaiBPWc2KZXuamz5C6uRIJhxh581AVT7Y7Gt3mz4GsY
         qUaRzSjr+bEpZzT1GIpc6adHzjgFnI+bzc+VGdHkCUyyMFpedJoYtC3NcS6cramN3Qda
         gAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Rth5LMPanMApgd/5gh0bE/u6yHTk5Ixmh3ZXSY6tUE=;
        b=DvfVCICzzAv99duC/xdvF7YXCfVnQ0MRjFrmtWWelKYxuTuYO0E5GRW000h5llIXqI
         4Ek/3vktQsLQnRfO9yo3hasfaocFbX+ERYAOiux3rsGdOmU6R2862sYModEN5xb5cHxu
         oi4srhSveeG21dHChqmvd9qPWsmcrFZJ7Ll56FWvouZnrmh4zxTrJunIwDseaFB+bEp+
         z9ltf9lHmn4i2ys7xz6a4C/Ient38Dxjv+/qyNjeAQs2GRQR6JRNYccLpvyHLTJ76bna
         GD0lbqA7exrbuKOYjq5hRrgETsI/T0SCc5u4/51RGOARRcPTjcKgCi+/YiPJ0uzOX5Tj
         R1YA==
X-Gm-Message-State: APjAAAUnHMLKw0lvKJDJ44CJgIXYdYuEI86+CvOamr/QFNtZFVxD5iPO
        220I7xNqBkf16xTt96bGWDJHds5F
X-Google-Smtp-Source: APXvYqwalOY72qOhZHHeKJXR+QWtGOoZtNa9wH0KJnHZO/ldDmlVSKB5HcudwDRGOypSHDg6IjVyWg==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr48740289pld.191.1557333435960;
        Wed, 08 May 2019 09:37:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o81sm28457340pfa.156.2019.05.08.09.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:37:15 -0700 (PDT)
Date:   Wed, 8 May 2019 09:37:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190508163714.GC5495@roeck-us.net>
References: <20190507230917.21659-1-f.fainelli@gmail.com>
 <20190508113452.GA27209@e107155-lin>
 <8421b37b-5d20-ab0d-3ae8-b6f63048c156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8421b37b-5d20-ab0d-3ae8-b6f63048c156@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 09:26:10AM -0700, Florian Fainelli wrote:
> On 5/8/19 4:35 AM, Sudeep Holla wrote:
> > On Tue, May 07, 2019 at 04:09:15PM -0700, Florian Fainelli wrote:
> >> Hi Sudeep, Guenter,
> >>
> >> This patch series adds support for scaling SCMI sensor values read from
> >> firmware. Sudeep, let me know if you think we should be treating scale
> >> == 0 as a special value to preserve some firmware compatibility (not
> >> that this would be desired).
> > 
> > So are we providing raw values from sensors.c and handling conversion
> > in hwmon layer ? I was thinking of just providing converted values
> > to hwmon just in case if the scaling thing change in future with
> > newer versions of SCMI.
> 
> These are the reasons why I went with doing the scaling in scmi-hwmon.c:
> 
> - scmi-hwmon.c is where we know the target units that should be matching
> the HWMON conventions, if we put that scaling into sensors.c that would
> be a layering violation IMHO
> 
> - within sensors.c we don't have a struct scmi_sensor_info to work with
> when called with reading_get, we have a sensor_id, so we would have to
> look up the id to struct scmi_sensor_info which is an additional loop,
> doing this in scmi-hwmon.c gives us access to that structure directly
> 
> - scmi-sensors.c is also the location where the mapping between SCMI
> sensor type to HWMON sensor type is done, so if we need to update the
> scale from one to the other, we would rather do that where the mapping
> is already done, which goes back to the first item.
> 
> > I am fine either way, just trying to keep
> > hwmon-scmi simpler. I will check if scale = 0 needs to be treated as
> > special(I don't think so, but will read the spec)
> 
> My concern is not so much with the spec but with assumptions SCMI
> firmware writes might have made while populating sensor values. The spec
> does not indicate any special treatment about a particular unit power of
> 10 scale being done or not, and a power of 0 = 1, so that should work okay.
> 

FWIW, I agree with Florian. hwmon decides which units it wants to use.
Anything else would have to be more complicated: hwmon would have to request
the scale from SCMI, and SCMI would have to adjust its reported value based
on that. It is much easier to just take what we get and adjust internally.

Thanks,
Guenter
