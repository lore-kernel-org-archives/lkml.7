Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D1E2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408897AbfFLKiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:38:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:28394 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405292AbfFLKiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:38:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 03:38:04 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 12 Jun 2019 03:38:02 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Jun 2019 13:38:01 +0300
Date:   Wed, 12 Jun 2019 13:38:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] thunderbolt: Make sure device runtime resume completes
 before taking domain lock
Message-ID: <20190612103801.GW2640@lahna.fi.intel.com>
References: <20190605140438.39000-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605140438.39000-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 05:04:38PM +0300, Mika Westerberg wrote:
> When a device is authorized from userspace by writing to authorized
> attribute we first take the domain lock and then runtime resume the
> device in question. There are two issues with this.
> 
> First is that the device connected notifications are blocked during this
> time which means we get them only after the authorization operation is
> complete. Because of this the authorization needed flag from the
> firmware notification is not reflecting the real authorization status
> anymore. So what happens is that the "authorized" keeps returning 0 even
> if the device was already authorized properly.
> 
> Second issue is that each time the controller is runtime resumed the
> connection_id field of device connected notification may be different
> than in the previous resume. We need to use the latest connection_id
> otherwise the firmware rejects the authorization command.
> 
> Fix these by moving runtime resume operations to happen before the
> domain lock is taken, and waiting for the updated device connected
> notification from the firmware before we allow runtime resume of a
> device to complete.
> 
> While there add missing locking to tb_switch_nvm_read().
> 
> Fixes: 09f11b6c99fe ("thunderbolt: Take domain lock in switch sysfs attribute callbacks")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to thunderbolt.git/fixes.
