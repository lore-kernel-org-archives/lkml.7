Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCBD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U44tSkfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCLSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:17:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43369 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfCLSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:17:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so3122807ede.10;
        Tue, 12 Mar 2019 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfmXygKDkeuu68yqiycFMP+CjNL+pM54Kl+cqYcWaDI=;
        b=U44tSkfvdGX8s+daWTt8qJfEObvxJ2BV018GDjvPegimxXT/FjAgnw+pR62XK5HVue
         oahUB99J3kyuefu0b4Vlr8R3eTkybWljN5ojH8XW7UhmlOzbQepLqi+C6RKEGeqRZShP
         BsJ4PAdQl/bmUmoc3gHUtOwcB4Snl9o+ZiG2Wmt+YVsTa47KWt0nXdhBwrucj9nRVJ49
         63iFE+wS/LqpJuB7xJEnRoKvmpwo69fBJj7N/TJPZPtUK3zVIWGg82JY35RRpvYnOBVp
         +FVzGxZjBVnpI0dc9R/1DwA+9YQ46t8OZi3Vv476EUd4A2pl/ZobRrtWiUf2CdKGK8VW
         mhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfmXygKDkeuu68yqiycFMP+CjNL+pM54Kl+cqYcWaDI=;
        b=MjfMq86oBBDX1lQSa40WFv/dIXBWD0Fhi9yTvsYNVn/UjFaAHWmoCKH5R/DxW8TJAY
         p/xAcG5KYjHT+7kHPM+jtZCAZIxjtENPhocgjV1cq9OUL2X6L1ThR9tuqQO3hbroD1Jw
         xhvxObUq3Zg7QNuiHag8KJPYj4/HIEnjTPeevjDAUH1Vc44/LhXbelMFNgDDVL8ews7w
         kXhcXMo/XB11JnLaUWnigEWG7L6zMgOpI3STjjoV6DF/MkMqirq1ZYrNVVXjs/xeoK1S
         3t+0GLOwi7N5YC9YByhNqVrx7gNx4oZLUZ22vtju4BZNqnxECX4nUN8n95wNFjFRBIib
         Pr5w==
X-Gm-Message-State: APjAAAW0Nob59WRN/Bc5aZdooNzmnCFuYVI1f/vT6GNmEs0x6UgZycZa
        QcuZPMnC1YNIkjb/Qo2tnpE=
X-Google-Smtp-Source: APXvYqxzdJPga8oPyzSp59tVYuI5vbitURc/rU33S5FkKKDHOL912xUIIfOl3kGwjVNnttSsIHNSVg==
X-Received: by 2002:a17:906:2e9b:: with SMTP id o27mr26460419eji.98.1552414236414;
        Tue, 12 Mar 2019 11:10:36 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z20sm3835595eja.6.2019.03.12.11.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 11:10:35 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] drm: rockchip: introduce rk3066 hdmi
From:   Johan Jonker <jbx6244@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190302104116.1535-1-jbx6244@gmail.com>
 <20190302104116.1535-2-jbx6244@gmail.com>
 <20190303202308.GD13157@ravnborg.org>
 <b6b818d5-8c24-e01a-572e-97c1754c80e8@gmail.com>
Message-ID: <d53892e0-17f9-1c7f-b7d3-2794fad09207@gmail.com>
Date:   Tue, 12 Mar 2019 19:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b6b818d5-8c24-e01a-572e-97c1754c80e8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 11:48 PM, Johan Jonker wrote:
>
> With regard to the bugs something between rc1 and rc8 results
> in a freeze on poweroff. Power domain doesn't seem to turn off
> the vop and hdmi in rc8.

The bug is due to a patch revert earlier this year.
To shutdown MK808 one can continue to use the patch at the link below
until this issue is fix by them.

drm/rockchip: shutdown drm subsystem on shutdown
https://patchwork.kernel.org/patch/10556151/

[for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on
reboot/kexec"
https://patchwork.kernel.org/patch/10714725/
