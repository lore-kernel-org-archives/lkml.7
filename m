Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5C213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCYBOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:14:35 -0400
Received: from mx.sdf.org ([205.166.94.20]:64035 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfCYBOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:14:34 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2P1EU8d018718
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Mon, 25 Mar 2019 01:14:30 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2P1EUQG004384;
        Mon, 25 Mar 2019 01:14:30 GMT
Date:   Mon, 25 Mar 2019 01:14:30 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903250114.x2P1EUQG004384@sdf.org>
To:     Jason@zx2c4.com, lkml@sdf.org
Subject: Re: [RFC PATCH] random: add get_random_max() function
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
In-Reply-To: <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
References: <201903241244.x2OCiL8P011277@sdf.org>,
    <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P.S. The cited paper calls your algorithm the "OpenBSD algorithm"
and has a bunch of benchmarks comparing it to others in Fisher-Yates
shuffles of sizes 1e3..1e9.

Including all overhead (base PRNG, shuffle), it's 3x slower for
32-bit operations and 8x slower for 64-bit up to arrays of size
1e6, after which cache misses slow all algorithms, reducing the
ratio.

If you want a faster division-based agorithm, the "Java algorithm"
does 1+retries divides:

unsigned long java(unsigned long s)
{
	unsigned long x, r;

	do {
		x = random_integer();
		r = x % s;
	} while (x - r > -s);
	return r;
}
