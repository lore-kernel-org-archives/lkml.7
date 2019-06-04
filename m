Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D26DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4942070D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDUV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:21:58 -0400
Received: from mail.skrimstad.net ([139.162.145.221]:35832 "EHLO
        mail.skrimstad.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:21:57 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.skrimstad.net (Postfix) with ESMTPA id 7C155DE701;
        Tue,  4 Jun 2019 20:21:52 +0000 (UTC)
Date:   Tue, 4 Jun 2019 22:21:49 +0200
From:   Yrjan Skrimstad <yrjan@skrimstad.net>
To:     dri-devel@lists.freedesktop.org
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay
 with non-blocking
Message-ID: <20190604202149.GA20116@obi-wan>
References: <20190530000819.GA25416@obi-wan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530000819.GA25416@obi-wan>
Authentication-Results: mail.skrimstad.net;
        auth=pass smtp.auth=yrjan@skrimstad.net smtp.mailfrom=yrjan@skrimstad.net
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:08:21AM +0200, Yrjan Skrimstad wrote:
> This driver currently contains a repeated 500ms blocking delay call
> which causes frequent major buffer underruns in PulseAudio. This patch
> fixes this issue by replacing the blocking delay with a non-blocking
> sleep call.

I see that I have not explained this bug well enough, and I hope that is
the reason for the lack of replies on this patch. I will here attempt to
explain the situation better.

To start with some hardware description I am here using an AMD R9 380
GPU, an AMD Ryzen 7 1700 Eight-Core Processor and an AMD X370 chipset.
If any more hardware or software specifications are necessary, please
ask.

The bug is as follows: When playing audio I will regularly have major
audio issues, similar to that of a skipping CD. This is reported by
PulseAudio as scheduling delays and buffer underruns when running
PulseAudio verbosely and these scheduling delays are always just under
500ms, typically around 490ms. This makes listening to any music quite
the horrible experience as PulseAudio constantly will attempt to rewind
and catch up. It is not a great situation, and seems to me to quite
clearly be a case where regular user space behaviour has been broken.

I want to note that this audio problem was not something I experienced
until recently, it is therefore a new bug.

I have bisected the kernel to find out where the problem originated and
found the following commit:

# first bad commit: [f5742ec36422a39b57f0256e4847f61b3c432f8c] drm/amd/powerplay: correct power reading on fiji

This commit introduces a blocking delay (mdelay) of 500ms, whereas the
old behaviour was a smaller blocking delay of only 1ms. This seems to me
to be very curious as the scheduling delays of PulseAudio are always
almost 500ms. I have therefore with the previous patch replaced the
scheduling delay with a non-blocking sleep (msleep).

The results of the patch seems promising as I have yet to encounter any
of the old <500ms scheduling delays when using it and I have also not
encountered any kernel log messages regarding sleeping in an atomic
context.
