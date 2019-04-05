Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7521872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfDEMU6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:20:58 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60765 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728683AbfDEMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:20:57 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16145021-1500050 
        for multiple; Fri, 05 Apr 2019 13:20:44 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190405121331.6524-1-janusz.krzysztofik@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190405121331.6524-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <155446684177.8259.3979238916498240519@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] drm/i915: Don't panic on non-empty list of free cachelines
Date:   Fri, 05 Apr 2019 13:20:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-04-05 13:13:31)
> From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> 
> If there are active users of a device during driver unbind, the driver
> now panics on non-empty list of free cachelines.

This panic is there to say that fini is being called with active
contexts, that it is being called too early. Those requests should be
cleaned up first, unpinning the contexts and resources, and so letting
the timeline be freed.
-Chris
