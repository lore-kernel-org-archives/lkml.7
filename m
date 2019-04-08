Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E39C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015AC218FC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDHXX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:23:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:28006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfDHXX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:23:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221709030"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 16:23:25 -0700
Date:   Mon, 8 Apr 2019 16:23:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190408232325.GA17000@agluck-desk>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk>
 <20190408203431.GM15689@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
 <20190408205013.GN15689@zn.tnic>
 <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:48:34PM +0000, Ghannam, Yazen wrote:
> Okay, so drop the export and leave the injector code as-is (it's
> already doing a rdmsrl_on_cpu()).

It's still a globally visible symbol (shared by core.c and amd.c).
So I think it needs a "mce_" prefix.

While it doesn't collide now, there are a bunch of other
subsystems that have "banks" and a variable to count them.

Look at output from "git grep -w num_banks".

-Tony
