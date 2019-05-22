Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B23C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA321773
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfEVMjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:39:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEVMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:39:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83A4780D;
        Wed, 22 May 2019 05:39:07 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9483F575;
        Wed, 22 May 2019 05:39:05 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] drm/panfrost: Use drm_gem_shmem_map_offset()
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Rob Herring <robh@kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20190520092306.27633-1-steven.price@arm.com>
 <20190520092306.27633-3-steven.price@arm.com>
 <CAL_JsqLzefOvopTCuyBsNhJDGbFV3JdVce0x398vMaGy3-+fVw@mail.gmail.com>
 <155846303227.23981.8007374203089408422@skylake-alporthouse-com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a4cd9ada-aaf1-3bd8-a138-f61308baf70c@arm.com>
Date:   Wed, 22 May 2019 13:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155846303227.23981.8007374203089408422@skylake-alporthouse-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 19:23, Chris Wilson wrote:
> Quoting Rob Herring (2019-05-21 16:24:27)
>> On Mon, May 20, 2019 at 4:23 AM Steven Price <steven.price@arm.com> wrote:
>>>
>>
>> You forgot to update the subject. I can fixup when applying, but I'd
>> like an ack from Chris on patch 1.

Sorry about that - I'll try to be more careful in the future.

> I still think it is incorrect as the limitation is purely an issue with
> the shmem backend and not a generic GEM limitation. It matters if you

Do you prefer the previous version of this series[1] with the shmem helper?

[1]
https://lore.kernel.org/lkml/20190516141447.46839-1-steven.price@arm.com/

Although this isn't a generic GEM limitation it's currently the same
limitation that applies to the 'dumb' drivers as well as shmem backend,
so I'd prefer not implementing two identical functions purely because
this limitation could be removed in the future.

> have a history of passing names and want a consistent api across objects
> when the apps themselves no longer can tell the difference, and
> certainly do not have access to the dmabuf fd. i915 provides an indirect
> mmap interface that uses the dma mapping regardless of source.

I don't understand the i915 driver, but from a quick look at the source
of i915_gem_mmap_ioctl():

	/* prime objects have no backing filp to GEM mmap
	 * pages from.
	 */
	if (!obj->base.filp) {
		addr = -ENXIO;
		goto err;
	}

it looks to me that an attempt to map an imported dmabuf from user space
using the ioctl will fail. Am I missing something?

exynos_drm_gem_mmap() is the only (mainline[2]) instance I can see where
a transparent mapping of a dma_buf is supported.

[2] mali_kbase does this too - but I'm not convinced it was a good idea.

I could instead add support in shmem/panfrost for transparently passing
the request to the exporter (i.e. call dma_buf_mmap()) - but I'm not
sure we want to implement this if there isn't going to be a user of the
support.

Steve
