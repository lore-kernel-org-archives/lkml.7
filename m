Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BCC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E0206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/AYvTgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLPK7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:59:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727466AbfLPK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576493953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ6sYFdb7LHBsbEybHzcurKWWaevQ2cyS6out70xyhQ=;
        b=c/AYvTgowKMwins/NcMjhTP0exSHdQ1HFu6mcm6kLfPk6d2lrHe6ILK2zBo7GfNFXRFJWP
        C4snqjIsqLcCnlJ1+bsRUCG2NK5e3VsNluROMgyx1vX1uQp3kVrOUx1JiiPqh/e4G2Cx56
        cVDA31dt1kmXFcqvjvgyhiBuRCcphDU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-IcMG-EozPwO79TxUqnJe1Q-1; Mon, 16 Dec 2019 05:59:12 -0500
X-MC-Unique: IcMG-EozPwO79TxUqnJe1Q-1
Received: by mail-wr1-f70.google.com with SMTP id i9so3558553wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQ6sYFdb7LHBsbEybHzcurKWWaevQ2cyS6out70xyhQ=;
        b=TVeYCIhIbClPt2lgwQJJA5I2FGG3bi4DXdz2znqd2z8DMiz59ICyTsZoelrLO1tPGY
         Y6LFTvAX8VvUKxKTYo8GlZ3lDdTO0NQsn94ystBLvK/kmjtw3byIM8h3+t/oio8t0f8a
         dbtnNDpEG21hlk3xXTGpYG8gFJvRg4/PeA16o6cBEhZm+It6Ttb0wWzLw8CCVjxpr/k2
         NbQSy6VAe7RBLuVzLe74A3BB+WcFU0y4razRIbMNChbqy9yltOBigEnvuNS7BKszSiGt
         uoEWJOpyxCuCoVMj1Etn9X3lS5Mlx0kf4vJ7pUHSoPGALjvXh2+Qcau1bS1t/Fq6cSlp
         kxdQ==
X-Gm-Message-State: APjAAAXGZnpmK4EkbwNreraDoi8B1nrit/TQ+BIsihgoIJVi3fujrXlk
        xdViOkw19xQwcgk78gDz7CWFC160xyiNvZF9/o9TRBm3HRcH37q2EHTNXY5Y5gVs5c5+CQx6gq/
        /UKFU+RZgYjyPk4Y0e9RrxS4b
X-Received: by 2002:adf:d848:: with SMTP id k8mr28536784wrl.328.1576493951612;
        Mon, 16 Dec 2019 02:59:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuvaGOybV0XNDKQ0IqtqC93KS7+4qbR1CruhBbHrdFS8xkO4lkM5kRrehoFB3fnxoPD5bNoQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr28536750wrl.328.1576493951322;
        Mon, 16 Dec 2019 02:59:11 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id s19sm19808552wmj.33.2019.12.16.02.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 02:59:10 -0800 (PST)
Subject: Re: [PATCH 0/5] drm/i915/dsi: Control panel and backlight enable
 GPIOs from VBT
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20191215163810.52356-1-hdegoede@redhat.com>
 <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a356fad-a473-3e37-4a7b-731594524862@redhat.com>
Date:   Mon, 16 Dec 2019 11:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-12-2019 11:26, Linus Walleij wrote:
> On Sun, Dec 15, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Linus, this series starts with the already discussed pinctrl change to
>> export the function to unregister a pinctrl-map. We can either merge this
>> through drm-intel, or you could pick it up and then provide an immutable
>> branch with it for merging into drm-intel-next. Which option do you prefer?
> 
> I have created an immutable branch with these changes and pulled it
> to my "devel" branch for v5.6:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-pinctrl-unreg-mappings
> 
> Please pull this in and put the other patches on top of that.

Great, thank you.

Jani, a question about how I am supposed to push this (when this has been
also reviewed by some i915 devs and passes CI), can I just do:

dim backmerge drm-intel-next-queued linux-pinctrl/ib-pinctrl-unreg-mappings
cat other-patches | dim apply-branch drm-intel-next-queued
dim push-branch drm-intel-next-queued

Or I guess that dim backmerge is reserved for other drm branches only and I
should do:

dim checkout drm-intel-next-queued
git merge linux-pinctrl/ib-pinctrl-unreg-mappings
cat other-patches | dim apply-branch drm-intel-next-queued
dim push-branch drm-intel-next-queued

Or should I leave merging linux-pinctrl/ib-pinctrl-unreg-mappings into
drm-intel-next-queued up to you?

> I had a bit of mess in my subsystems last kernel cycle so I
> want to avoid that by strictly including all larger commits
> in my trees.

I understand.

Regards,

Hans

