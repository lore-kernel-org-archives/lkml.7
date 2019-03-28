Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96978C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8C221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfC1I2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:28:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:18848 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfC1I2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:28:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 01:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="311084113"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 28 Mar 2019 01:28:25 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Mar 2019 10:28:24 +0200
Date:   Thu, 28 Mar 2019 10:28:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over
 suspend/resume
Message-ID: <20190328082824.GU3622@lahna.fi.intel.com>
References: <CAB4CAwc-SFtw4+74Qe-vX57JRGDjJMt9xM2+ev3OiipzwxBPBw@mail.gmail.com>
 <20171116124431.GS17200@lahna.fi.intel.com>
 <CAB4CAwfHx8DgCYk0piVnrTa7YP2=6A8Le4ekoENFPyNVF9g1rw@mail.gmail.com>
 <20171117064904.GZ17200@lahna.fi.intel.com>
 <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com>
 <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com>
 <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327172940.GR3622@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:29:40PM +0200, Mika Westerberg wrote:
> I wonder if it would be simpler to save it always and then upon resume
> compare them and if changed, log this in dmesg and restore the saved
> one.

Actually I think better is to restore hostsw_own only for GPIOs that are
already requested by us. The BIOS should have no business messing those
anyway once they are owned by the GPIO driver.
