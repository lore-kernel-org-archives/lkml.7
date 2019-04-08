Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE98FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B9C20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDHJHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:07:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:43389 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfDHJHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:07:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 02:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="138442916"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 08 Apr 2019 02:07:45 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Apr 2019 12:07:44 +0300
Date:   Mon, 8 Apr 2019 12:07:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 19/36] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190408090744.GK3622@lahna.fi.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-20-mika.westerberg@linux.intel.com>
 <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
 <20190408073517.GA3622@lahna.fi.intel.com>
 <20190408085337.slcnajkgxjq4twkh@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408085337.slcnajkgxjq4twkh@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:53:37AM +0200, Lukas Wunner wrote:
> Hm, what other cases are there, i.e. what is the meaning of a tb_regs_hop's
> "next_hop" field if "out_port" doesn't have a remote?  (And why does it
> need to be tracked on the out_port?  In case a remote is added later?)

We also need to program HopIDs for adapter ports (PCIe, DP, NHI) in
order to enable a path. The "next_hop" from NULL port to an adapter port
tells the HopID a packet gets when it is routed to the adapter port and
the adapter port registers then are used to specify which HopID means
what (for PCIe there is only 8 but for DP there is 8 and 9, for NHI it
can be anything the service driver has negotiated).
