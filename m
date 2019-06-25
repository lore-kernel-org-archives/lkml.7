Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23348C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB2620644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfFYKOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:14:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfFYKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:14:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 5E67D266AD9
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
Message-ID: <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
Date:   Tue, 25 Jun 2019 12:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

W dniu 25.06.2019 o 12:03, Russell King - ARM Linux admin pisze:
> On Tue, Jun 25, 2019 at 11:46:34AM +0200, Andrzej Pietrasiewicz wrote:
>> It is difficult for a user to know which of the i2c adapters is for which
>> drm connector. This series addresses this problem.
>>
>> The idea is to have a symbolic link in connector's sysfs directory, e.g.:
>>
>> ls -l /sys/class/drm/card0-HDMI-A-1/i2c-2
>> lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/i2c-2 \
>> 	-> ../../../../soc/13880000.i2c/i2c-2
> 
> Don't you want the symlink name to be "i2c" or something fixed, rather
> than the name of the i2c adapter?  Otherwise, you seem to be encumbering
> userspace with searching the directory to try and find the symlink.
> 

Thank you for your comment. So you imagine something on the lines of:

lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/ddc \
  	-> ../../../../soc/13880000.i2c/i2c-2

?

This makes sense to me, I will send a v2.

Andrzej
