Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7388CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D6D2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDATRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:17:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDATRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:17:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667F915AB;
        Mon,  1 Apr 2019 12:17:29 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E623F59C;
        Mon,  1 Apr 2019 12:17:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8cc9ab56-3c50-9081-7276-a918ab23c924@arm.com>
Date:   Mon, 1 Apr 2019 20:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 09:24, Neil Armstrong wrote:
> On 01/04/2019 09:47, Rob Herring wrote:
>> This adds the initial driver for panfrost which supports Arm Mali
>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>> T760 Midgard GPUs have been tested.
>>
>> v2:
>> - Add GPU reset on job hangs (Tomeu)
>> - Add RuntimePM and devfreq support (Tomeu)
>> - Fix T760 support (Tomeu)
>> - Add a TODO file (Rob, Tomeu)
>> - Support multiple in fences (Tomeu)
>> - Drop support for shared fences (Tomeu)
>> - Fill in MMU de-init (Rob)
>> - Move register definitions back to single header (Rob)
>> - Clean-up hardcoded job submit todos (Rob)
>> - Implement feature setup based on features/issues (Rob)
>> - Add remaining Midgard DT compatible strings (Rob)
>>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>> Cc: Sean Paul <sean@poorly.run>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Neil, I've kept your reset support separate for now. Let me know if you
>> prefer me to squash it or keep it separate.
> 
> You can squash all my changes and add my sign-off.

FWIW, looking at Rob's branch there's a little bug in panfrost_reset_init():

+	if (IS_ERR(pfdev->rstc)) {
+		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->clock));

Looks like that "pfdev->clock" should be "pfdev->rstc".

Robin.
