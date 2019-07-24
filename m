Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C66FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D925E217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGXHLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:11:03 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:33830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbfGXHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:11:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 13EEA182CF673;
        Wed, 24 Jul 2019 07:11:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sail18_25ca87690f746
X-Filterd-Recvd-Size: 1645
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 07:10:59 +0000 (UTC)
Message-ID: <023c0194641abe411c2338e4eed9eec876888e48.camel@perches.com>
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 24 Jul 2019 00:10:58 -0700
In-Reply-To: <dab1b433-93c0-09ab-cceb-3db91b6ef353@rasmusvillemoes.dk>
References: <cover.1563889130.git.joe@perches.com>
         <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
         <ce1320d8-60df-7c54-2348-6aabac63c24d@rasmusvillemoes.dk>
         <c9ef2b56eaf36c8e5449b751ab6e5971b6b34311.camel@perches.com>
         <dab1b433-93c0-09ab-cceb-3db91b6ef353@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 08:53 +0200, Rasmus Villemoes wrote:
> BUILD_BUG_ON(!__same_type())
> strscpy(dst, src, ARRAY_SIZE(dst))

Doing this without the temporary is less legible to read
the compiler error when someone improperly does:

	char *foo;
	char *bar;

	stracpy(foo, bar);


