Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E387C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE4820B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406887AbfHIMxx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:53:53 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51995 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbfHIMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:53:52 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17943319-1500050 
        for multiple; Fri, 09 Aug 2019 13:53:46 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Martin Wilck <Martin.Wilck@suse.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
Message-ID: <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
Date:   Fri, 09 Aug 2019 13:53:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Wilck (2019-08-09 13:41:42)
> This happened to me today, running kernel 5.3.0-rc3-1.g571863b-default
> (5.3-rc3 with just a few patches on top), after starting a KVM virtual
> machine. The X screen was frozen. Remote login via ssh was still
> possible, thus I was able to retrieve basic logs.
> 
> sysrq-w showed two blocked processes (kcompactd0 and KVM). After a
> minute, the same two processes were still blocked. KVM seems to try to
> acquire a lock that kcompactd is holding. kcompactd is waiting for IO
> to complete on pages owned by the i915 driver.

My bad, it's known. We haven't decided on whether to revert the
unfortunate recursive locking (and so hit another warn elsewhere) or to
ignore the dirty pages (and so risk losing data across swap).

cb6d7c7dc7ff ("drm/i915/userptr: Acquire the page lock around set_page_dirty()")
-Chris
