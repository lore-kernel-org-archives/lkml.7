Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CA92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGByz+C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfCYOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:21:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:21:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id bg8so24710plb.0;
        Mon, 25 Mar 2019 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UnF/9honZDd8DVGfAvHXwlIlHr1wXerQv6yjnIO6gU=;
        b=QGByz+C1six86cJd2DABX9eothnWDpeO4m9JBHeiNWG0FjbRdY3mTyKVU9jOMTb41H
         Byjlpjsg6311YyiNiK+6XXnGI3Pi6cpdMHuvpiQjXBRVWVhFxlzl0o21Z59AHX01EXvC
         bSrabRkb42u8xQoo+8Cv2nhrFU9dZgLTRld+euwVpbrWU7Qq83rqDs+HNnadMTisCwxF
         7Vpbsj0t10KV3bG94GH6vaI9pikSh1HEDZVEuLQtwdWcvIcYrsYMrlDvZYnqHYcY5XMd
         WkeC7Wfm5jze5dTkq3Iobt4CPwPIocgjTwgcxsNihIMZ5f3FWG/U3x0b8UVRO/r3CReh
         wsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UnF/9honZDd8DVGfAvHXwlIlHr1wXerQv6yjnIO6gU=;
        b=n3oFYQQWhfX1MMN4kPPkhwkQG+tsttQE7Ok3Qkn5ySH0p5OtdQfZgh3iH8Ixme7Uqt
         a89uppEciumR9pHaAH40AcAxEpShIl08RRQ0ixLAeUu7ox18uxDMI0aGlv545nNx8DMN
         nprtPAIBsazrnPGEt+3dkCjtnYyg28NfM99Q9BpPgQ7tAtwuM+N7JZja8q0CM/Od/x8T
         hv3LpSV47eREh+2X/w1NHNeL5Eoj0G3jXS6+QybkFreAc4M6iXBL/kQja96hobU/zuS5
         7lKz50RgGiJta2fEiqP67WeT03ljNOI+oIaAQMB2Y1zWYZiUXgqRw0u3fpB3A0pAnVCL
         9OOQ==
X-Gm-Message-State: APjAAAVv3Kg4XkVxq0sJcYfoTVpuPHLzFwQlw1avAOXAzbQllCmXlCJX
        9mYlnJnBWiDVGfUkAQ1v/2o=
X-Google-Smtp-Source: APXvYqwaz2gxs2rMs5SDRr4BxlM2pN33OPV7pQYUwwufc1v72dCMJMzwmTZU0FzO9rIzMpa6Uk1zAw==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr26088330pld.25.1553523664176;
        Mon, 25 Mar 2019 07:21:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 139sm20393158pfw.98.2019.03.25.07.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 07:21:02 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
Date:   Mon, 25 Mar 2019 07:21:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325121232.GF7284@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 5:12 AM, Mark Brown wrote:
> On Sat, Mar 23, 2019 at 09:55:46AM -0400, Pierre-Louis Bossart wrote:
> 
>> I'd like to highlight that there is a fundamental flaw in the way the
>> machine drivers are handled. Since we don't have a hook for the machine
>> driver in the BIOS, the DSP driver creates a platform_device which will
>> instantiate the machine driver. When errors happen in the machine driver
>> probe, they are suppressed due to a 'feature' of the device model, so you
>> can end-up with a broken configuration that is still reported as a
>> successful strobe.
> 
> These are driver specific issues not device model issues as far as I can
> see?  The issue fixed by this as is that you're storing a pointer in the
> ASoC level (not device model level) probe that you don't free when the
> component is unbound, causing you to dereference it later during
> suspend.  There is absolutely no problem with the machine driver not
> being guaranteed to bind at the time it's initially registered, that's
> perfectly normal and should cause no problems.
> 
It is actually a bit more complicated than that. The stored pointer (drv->soc_card)
isn't released. The problem is that dev_get_drvdata(drv->soc_card->dev) is NULL,
which causes the crash. I don't think there is a UAF involved - I built the
test image with KASAN enabled and it did not barf at me.

It may of course well be that there _should_ be a UAF but it doesn't happen
because some pointer that should be released isn't released due to some memory
or reference count leak. But that would be a different problem.

Overall the implementation does seem a bit suspicious to me. I don't really
understand why the platform driver handles suspend/resume for the cards.
But that may just be my lack of understanding. However, either case, I think the
Haswell driver (sst-haswell-pcm.c) has a similar problem. I am also not sure if
there are more problems lurking - I see a similar but different crash in v4.4.y
but have not been able to track it down. Actually, I found the problem fixed here
while trying to reproduce that crash with the latest kernel.

Guenter
