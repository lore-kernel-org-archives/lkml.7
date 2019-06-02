Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD3C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F46212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFBVbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:31:38 -0400
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFBVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:31:38 -0400
Received: from spider (unknown [109.63.145.211])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id B68A01BF404;
        Mon,  3 Jun 2019 00:34:03 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/i915: Skip object locking around a no-op set-domain ioctl
References: <20190321161908.8007-1-chris@chris-wilson.co.uk>
        <20190321161908.8007-2-chris@chris-wilson.co.uk>
        <878sv31mqk.fsf@depni.sinp.msu.ru>
Date:   Mon, 03 Jun 2019 00:31:33 +0300
In-Reply-To: <878sv31mqk.fsf@depni.sinp.msu.ru> (Serge Belyshev's message of
        "Sun, 19 May 2019 00:22:43 +0300")
Message-ID: <878suj8yiy.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch causes lockups in firefox. They appear like non-fatal hangs
> of the webpage contents, "fixable" with alt-tab or a background system
> load.  I have verified that reverting the commit 754a254427 on top of
> current Linus tree fixes the problem.

This is still broken in v5.2-rc3.

I have also verified that the particular commit, if backported to v5.1
release, breaks firefox there too in the same way.


(for reference:)

commit 754a25442705c4f90e0d05f1a7bd303ffe700ca9
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu Mar 21 16:19:08 2019 +0000

    drm/i915: Skip object locking around a no-op set-domain ioctl
