Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11654C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216F2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfH1HdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:33:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:60308 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfH1HdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:33:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 00:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="197497463"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2019 00:33:03 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 28 Aug 2019 10:33:02 +0300
Date:   Wed, 28 Aug 2019 10:33:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
Message-ID: <20190828073302.GO3177@lahna.fi.intel.com>
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:09:07PM +0800, Brad Campbell wrote:
> G'day All,

Hi,

> 5.2 is the first kernel that has allowed me to use 2 Apple Thunderbolt
> display on a 2011 vintage iMac. Awesome work and many thanks!
> 
> I boot this machine in BIOS (Bootcamp) mode as that gave me brightness
> control over the internal panel.
> 
> I've been using it with a Thunderbolt display and a standard DVI display
> since 2012 as the Apple firmware would only set up a single Thunderbolt
> display at bootup. Didn't find that out until I'd bought a second one and
> kept it around as a spare.
> 
> When I saw the changelog for 5.2 I thought I'd see if it would run 2
> Thnunderbolt displays, and it does after a minor fiddle. I have tried this
> with the Kanex adapter unplugged just for completeness. No change.
> 
> When I boot the machine it picks up both displays :
> 
> [    1.072080] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
> [    1.072086] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
> [    1.392076] random: crng init done
> [    1.595609] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
> [    1.595615] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
> [    1.905117] thunderbolt 0-303: new device found, vendor=0xa7 device=0x4
> [    1.905121] thunderbolt 0-303: Kanex Thunderbolt to eSATA+USB3.0 Adapter
> [    1.910098] thunderbolt 0000:07:00.0: 0:c: path does not end on a DP
> adapter, cleaning up
> 
> Display 0-3 works. Display 0-1 remains blank.
> 
> If I unplug 0-1 and re-plug it, it is detected and comes up perfectly.

Can you add "thunderbolt.dyndbg" to the kernel command line and
reproduce this? That gives bit more information what might be happening.

I'm suspecting that the boot firmware does configure second DP path also
and we either fail to discover it properly or the boot firmware fails to
set it up.

Also if you boot with one monitor connected and then connect another
(when the system is up) does it work then?
