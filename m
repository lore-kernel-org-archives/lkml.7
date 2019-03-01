Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DF520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfCANIR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:08:17 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:49940 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbfCANIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:08:17 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15743600-1500050 
        for multiple; Fri, 01 Mar 2019 13:08:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190301125207.30973-1-jani.nikula@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jani.nikula@intel.com
References: <20190301125207.30973-1-jani.nikula@intel.com>
Message-ID: <155144567811.6459.11821776880949183246@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] log2: make is_power_of_2() integer constant expression when
 possible
Date:   Fri, 01 Mar 2019 13:07:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2019-03-01 12:52:07)
> While is_power_of_2() is an inline function and likely gets optimized
> for compile time constant arguments, it still doesn't produce an integer
> constant expression that could be used in, say, static data
> initialization or case labels.
> 
> Make is_power_of_2() an integer constant expression when possible,
> otherwise using the inline function to avoid multiple evaluation of the
> parameter.
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

It does what it says on the tin and allows for

static const is_pot = is_power_of_two(32);

or in the actual case of interest,

BUILD_BUG_ON(is_power_of_two(x) ? test1(x) : test2(x)).

The only question remains can build_bug.h include ilog2.h and use this
macro instead of having its own copy? Or that may be overkill for a
single commonplace macro.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
