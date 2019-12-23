Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CBE206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLWKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:13:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:44066 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLWKNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:13:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 02:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="222995369"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 23 Dec 2019 02:13:18 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 23 Dec 2019 12:13:17 +0200
Date:   Mon, 23 Dec 2019 12:13:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: fix memory leak of object sw
Message-ID: <20191223101317.GF2628@lahna.fi.intel.com>
References: <20191220220526.11307-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220220526.11307-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:05:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the call tb_switch_exceeds_max_depth is true
> the error reurn path leaks memory in sw.  Fix this by setting
> the return error code to -EADDRNOTAVAIL and returning via the
> error exit path err_free_sw_ports to free sw. sw has been kzalloc'd
> so the free of the NULL sw->ports is fine.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Greg, can you take this to your usb-next branch where the rest of the
USB4 stuff is?

Thanks!
