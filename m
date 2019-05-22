Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76291C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3996F20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/Wfywd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfEVPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:34:52 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33623 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfEVPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:34:52 -0400
Received: by mail-vk1-f193.google.com with SMTP id v69so620090vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZ7wpIvoEkeLq6FBM1KkrI1MSDApRyeyZAyhjJ4c/Jg=;
        b=O/Wfywd0s4mY7h0+2IscQOPlZ/yTMmy48pO4ogf4j4wwWqwfIC1jNvI2xbSwImPtMN
         +1GU+Col/vGn1jOmS10cSTnnu3rj94VkxQSUaB8px/4eh//rFgLYdDJUrbOsWeGFLX9X
         /6K8P0wOjwVbBd8F59mzhYJ08e+4P7/hgx8Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZ7wpIvoEkeLq6FBM1KkrI1MSDApRyeyZAyhjJ4c/Jg=;
        b=mftt9N30NmAlFy+68T9sgjK+5BPUaKwXZWjOs45DwDXZN2GOy22TD/rvNDeqzmNcaL
         vexGmr6D8TctstoUSG8GuOtyJSsPJf/1FzrH6E0r53GRM3Urpy6DK0IRu/RXAabdPyT5
         V4i7fdXT9Y3v6/+1B9Ar68qGWgW4ugew2RoWmxiiqTcJqSsVQDXRdKd6wY5U9hjtbKEP
         xnKNVIpzXvyOlw8obqxKLu0tN+xks7pOHNRkuoZvSYIsuR4/DRHOFnAnH+8LLSXRpGtV
         5SF1iitGOBBhoQZJRv9prWdwEgphrbNGCCtjKIzUck7uAlBdb2gsmZTqkcq/X/rth4ut
         4EbA==
X-Gm-Message-State: APjAAAVpRneu/OhOFN0aHBLD8JmZ+nN6XWt6fegRmqxgFovUDXu4D0bt
        Uk55m/M3SWFtylAH7EsgXMacU3AjpZw=
X-Google-Smtp-Source: APXvYqwjYWzrHMqu//EJCSB4MPP0VhXkrS/RAVOlmkEovKbOPFujZS+U3Wne7OYCSiGfbTAVn0Wcwg==
X-Received: by 2002:a1f:ee09:: with SMTP id m9mr1880926vkh.82.1558539289238;
        Wed, 22 May 2019 08:34:49 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id v141sm28869717vsc.8.2019.05.22.08.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:34:47 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id h72so605161vkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:34:46 -0700 (PDT)
X-Received: by 2002:a1f:1e48:: with SMTP id e69mr15455909vke.16.1558539286538;
 Wed, 22 May 2019 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190522141236.26987-1-heiko@sntech.de>
In-Reply-To: <20190522141236.26987-1-heiko@sntech.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 May 2019 08:34:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
Message-ID: <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
Subject: Re: [PATCH] Revert "thermal: rockchip: fix up the tsadc pinctrl
 setting error"
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangqing <zhangqing@rock-chips.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 22, 2019 at 7:12 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> This reverts commit 28694e009e512451ead5519dd801f9869acb1f60.
>
> The commit causes multiple issues in that:
> - the added call to ->control does potentially run unclocked
>   causing a hang of the machine
> - the added pinctrl-states are undocumented in the binding
> - the added pinctrl-states are not backwards compatible, breaking
>   old devicetrees.
>
> Fixes: 28694e009e51 ("thermal: rockchip: fix up the tsadc pinctrl setting error")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/thermal/rockchip_thermal.c | 36 +++---------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

In case it helps with the urgency, there are lots of people who have
all independently needed to identify which commit stopped their boards
from booting mainline or broke temperature reading.  I'm aware of at
least these reports:

Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Reported-by: Vicente Bergas <vicencb@gmail.com>
Reported-by: Jack Mitchell <ml@embed.me.uk>
Reported-by: Douglas Anderson <dianders@chromium.org>

I can confirm that my board boots again after this revert, thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
