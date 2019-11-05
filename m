Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A3C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B08421929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfKEVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:21:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:16568 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfKEVVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:21:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 13:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="403501742"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2019 13:21:05 -0800
Message-ID: <3a56071a7b2c157698ed781d09e47051e3974958.camel@linux.intel.com>
Subject: Re: [RFC][PATCH] x86, mce, therm_throt: Optimize notifications of
 thermal throttle
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Tue, 05 Nov 2019 13:21:05 -0800
In-Reply-To: <20191105205617.GF28418@zn.tnic>
References: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
         <20191105144411.GC28418@zn.tnic>
         <810bfb95a42090ff64f86e4154e2bd2cfda29f27.camel@linux.intel.com>
         <20191105205617.GF28418@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 21:56 +0100, Borislav Petkov wrote:
> On Tue, Nov 05, 2019 at 12:36:32PM -0800, Srinivas Pandruvada wrote:
> > > That wants to be a bool judging by the context it is used in.
> > 
> > I can change to bool, just didn't use it
> > https://yarchive.net/comp/linux/bool.html
> 
> And are you using it in a union or where the size of bool - which is
> implementation-specific - plays any role, esp. in your particular use
> case?
No.

> 
> > They are architectural MSRs and the fact that we are getting called
> > means that they are enabled by looking at CPUID bits.
> 
> If the CPUID bits guarantees their presence, then the error handling
> is
> not absolutely necessary.
> 
> Thx.
> 

