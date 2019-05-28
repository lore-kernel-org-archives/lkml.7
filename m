Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE7208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE1KDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:03:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:48752 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1KDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:03:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:03:40 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 May 2019 03:03:38 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 May 2019 13:03:37 +0300
Date:   Tue, 28 May 2019 13:03:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v3] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190528100337.GU2781@lahna.fi.intel.com>
References: <20190527111805.876-1-sr@denx.de>
 <20190527111805.876-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111805.876-2-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:18:05PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
> Changed by Stefan:
> Only call mctrl_gpio_init(), if the device has no ACPI companion device
> to not break existing ACPI based systems. Also only use the mctrl_gpio_
> functions when "gpios" is available.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3:
> - Only call mctrl_gpio_init(), if the device has no ACPI companion device
>   to not break existing ACPI based systems, as suggested by Andy
> 
> v2:
> - No change
> 
> Please note that this patch was already applied before [1]. And later
> reverted [2] because it introduced problems on some x86 based boards
> (ACPI GPIO related). Here a detailed description of the issue at that
> time:
> 
> https://lkml.org/lkml/2016/8/9/357
> http://www.spinics.net/lists/linux-serial/msg23071.html
> 
> This is a re-send of the original patch that was applied at that time.
> With patch 1/2 from this series this issue should be fixed now (please
> note that I can't test it on such an x86 platform causing these
> problems).
> 
> Andy (or Mika), perhaps it would be possible for you to test this
> patch again, now with patch 1/2 of this series applied as well?
> That would be really helpful.

Unfortunately I'm not able to test this anymore. Andy should be able to
test this but he is on vacation this week.

Regarding the ACPI changes in this patch, they look good to me so

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
