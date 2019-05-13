Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71691208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfEMPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:14:05 -0400
Received: from foss.arm.com ([217.140.101.70]:59052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfEMPOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:14:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5C7341;
        Mon, 13 May 2019 08:14:04 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655D03F71E;
        Mon, 13 May 2019 08:14:03 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Use drm_gem_dump_map_offset()
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190513143244.16478-1-steven.price@arm.com>
 <20190513143921.GP17751@phenom.ffwll.local>
 <155775884217.2165.11223399053598674062@skylake-alporthouse-com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <0b7f0b7f-3e14-f5bb-368a-08037c2a8529@arm.com>
Date:   Mon, 13 May 2019 16:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155775884217.2165.11223399053598674062@skylake-alporthouse-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2019 15:47, Chris Wilson wrote:
> Quoting Daniel Vetter (2019-05-13 15:39:21)
>> On Mon, May 13, 2019 at 03:32:44PM +0100, Steven Price wrote:
>>> panfrost_ioctl_mmap_bo() contains a reimplementation of
>>> drm_gem_dump_map_offset() but with a bug - it allows mapping imported
>>> objects (without going through the exporter). Fix this by switching to
>>> use the generic drm_gem_dump_map_offset() function instead which has the
>>> bonus of simplifying the code.
>>
>> gem_dumb stuff is for kms drivers, panfrost is a render driver. We're
>> generally trying to separate these two worlds somewhat cleanly.
>>
>> I think it'd be good to have a non-dumb version of this in the core, and
>> use that. Or upgrade the dumb version to be that helper for everyone (and
>> drop the _dumb).

I'm slightly confused by what you think is the best course of action here.

I can create a patch dropping the '_dumb' from drm_gem_dump_map_offset()
if that's the objection. Or do you want a helper function with two
callers (the 'dump' and the 'shmem' versions)?

> More specifically, since panfrost is using the drm_gem_shmem helper and
> vm_ops, it too can provide the wrapper as it is the drm_gem_shmem layer
> that implies that trying to mmap an imported object is an issue as that
> is not a universal problem.
mmap'ing an imported object isn't a problem as such. But rather than
going behind the exporter's back we would need to call dma_buf_mmap() to
ensure that the exporter can do whatever is necessary.

I could add a wrapper in drm_gem_shmem_helper, but I'm not sure what the
benefit of a wrapper here is?

Steve
