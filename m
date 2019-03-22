Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32939C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE62083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfCVRzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:55:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:4115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfCVRzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:55:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136401075"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2019 10:55:05 -0700
Date:   Fri, 22 Mar 2019 10:55:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190322175504.GA11213@agluck-desk>
References: <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic>
 <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic>
 <20190315174956.GA20831@agluck-desk>
 <20190315180206.GD12523@zn.tnic>
 <20190315181108.GA21111@agluck-desk>
 <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7D53BD42@ORSMSX110.amr.corp.intel.com>
 <CAK8P3a0WjUi+mBZ0nO2FFFCRvy5mA10frZMAaXisGWOs4pnPCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0WjUi+mBZ0nO2FFFCRvy5mA10frZMAaXisGWOs4pnPCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:00:25PM +0100, Arnd Bergmann wrote:
> Sorry, this was my mistake, my email was garbled. The patch was
> correct though: the idea here is not to change the Kconfig symbols
> but to change the Makefile to do the right thing even when Kconfig
> is set wrong.

Well this does seem like a "clever" way out of the randconfig
problem.  New patch applies and when I set .config to have:

CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_SKX=y
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_SKX_COMMON=y

I don't see any build errors.

There are lots of "skx_" symbols in System.map

But I'm not at all sure what happened to the I10NM driver.

I don't see it mentioned in the output from "make".

It didn't get built as a module (no ".ko" file for it).

It doesn't seem to be built in (no ".o" in drivers/edac/built-in.a)

So I added a #error line to the start of i10nm_edac.c and
ran "make" again.  Nothing.

So, I don't think this is doing what you think it should
do.  Even if it did, it would seem very confusing to a user
that asked for "one module, one built-in" in Kconfig, but
found both built-in.

Boris: I'm voting for Qiuxu's most recent solution (moving
all the EDAC_DEBUG bits out of skx_common.c).

-Tony
