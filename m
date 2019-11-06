Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA7CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF1D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfKFJe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:34:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:23359 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfKFJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:34:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 01:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="214185072"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2019 01:34:21 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iSHhk-00008U-Ls; Wed, 06 Nov 2019 11:34:20 +0200
Date:   Wed, 6 Nov 2019 11:34:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        cezary.rojewski@intel.com, gustaw.lewandowski@intel.com
Subject: Re: [PATCH 1/2] seq_buf: Add printing formatted hex dumps
Message-ID: <20191106093420.GZ32742@smile.fi.intel.com>
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <20191106035317.7558e47e@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106035317.7558e47e@grimm.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:53:17AM -0500, Steven Rostedt wrote:
> On Wed,  6 Nov 2019 07:27:39 +0100
> Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> > +	for (i = 0; i < len; i += rowsize) {
> > +		linelen = min(remaining, rowsize);
> > +		remaining -= rowsize;
> 
> Probably should make the above:
> 
> 		remaining -= linelen;
> 
> Yeah, what you have works, but it makes a reviewer worry about using
> remaining later and having it negative.

OTOH, the original function and followers (like seq_hex_dump() one) are using
exactly above form. Maybe for the sake of consistency we may do the same and
then fix all at once. Or other way around, amend the rest first.

> > +		case DUMP_PREFIX_ADDRESS:
> 
> I'm curious to know what uses the above type? By default, today,
> pointers are pretty much obfuscated, and that will show up here too.

Good question. Current users are:

arch/microblaze/kernel/traps.c
arch/x86/kernel/mpparse.c
drivers/crypto/axis/artpec6_crypto.c
drivers/crypto/caam/...
drivers/crypto/ccree/cc_driver.c
drivers/crypto/qat/qat_common/adf_transport_debug.c
drivers/dma/xgene-dma.c
drivers/mailbox/mailbox-test.c
drivers/net/can/usb/ucan.c
drivers/net/ethernet/cadence/macb_main.c
drivers/net/ethernet/cavium/liquidio/octeon_droq.c
drivers/net/ethernet/intel/...
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
drivers/usb/gadget/function/f_ncm.c
fs/ext4/super.c
fs/jfs/...
mm/page_poison.c
mm/slub.c

Not many.

My understanding that it's still useful in conjunction with some other messages
where pointers are printed and developer, who is reading the logs, may match
them and do some conclusions.

> > +	}

-- 
With Best Regards,
Andy Shevchenko


