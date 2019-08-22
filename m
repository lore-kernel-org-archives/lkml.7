Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FEAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CC92064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495060;
	bh=kGtDqeZxm0c6tbdZKyPuwPX3uKUXHVT9pNmGAeapP+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1Ui7ttcF0BI4w7tJ58OoOH5JSHpZKj3xZC4VtMvhM7wX73N28CE8ZOScts0v/MmY
	 K8uV07UW3K7l7P/oMrzHaqWHiqZMvkbpMU5Xpx9zv7YFp9jAO8c/AGKcErtF+Z0HWW
	 sBCBqpPLitPkyzegtSnK/eU60ijC8yH8XqeyXdLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbfHVRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:30:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:44331 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392174AbfHVRaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:30:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 10:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="203494684"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2019 10:30:53 -0700
Date:   Thu, 22 Aug 2019 11:28:56 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ashton Holmes <root@scoopta.email>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NVME timeout causing system hangs
Message-ID: <20190822172856.GA15785@localhost.localdomain>
References: <3a3b2436-b6e0-1504-fe69-756380f373cc@scoopta.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3b2436-b6e0-1504-fe69-756380f373cc@scoopta.email>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:33:45PM -0700, Ashton Holmes wrote:
> When playing certain games on my PC dmesg will start spitting out NVME
> timeout messages, this eventually results in BTRFS throwing errors and
> remounting itself as read only. The drive passes smart's health check and
> works fine when not playing games. The really weird part is this will happen
> even if the game I'm playing isn't installed on that drive. I wanted to
> bisect this but it happens on every kernel version I've tried. I've attached
> my dmesg log. This was originally reported here
> https://bugzilla.kernel.org/show_bug.cgi?id=202633 but no response was ever
> given. In that report I state that 4.19.24 for whatever reason doesn't
> trigger this however that doesn't seem to be the case anymore. I've updated
> my UEFI since then, I wouldn't expect that to make a difference but I'm not
> sure what else would have changed that.

This really looks like your nvme controller has gotten itself in an
unresponsive state: it is not responding to IO, admin, or reset
requests.

The only recommendation I have at the moment is to verify you have the
most current firmware from your vendor installed on this controller,
and update if not.

 

> [  170.678837] nvme nvme0: I/O 128 QID 2 timeout, aborting
> [  170.678845] nvme nvme0: I/O 129 QID 2 timeout, aborting
> [  170.678850] nvme nvme0: I/O 167 QID 2 timeout, aborting
> [  170.678853] nvme nvme0: I/O 168 QID 2 timeout, aborting
> [  170.678856] nvme nvme0: I/O 169 QID 2 timeout, aborting
> [  201.657527] nvme nvme0: I/O 128 QID 2 timeout, reset controller
> [  232.372876] nvme nvme0: I/O 8 QID 0 timeout, reset controller
> [  323.643688] nvme nvme0: Device not ready; aborting reset
> [  323.675893] print_req_error: I/O error, dev nvme0n1, sector 1088653384 flags 80700
> [  323.675902] print_req_error: I/O error, dev nvme0n1, sector 1001346664 flags 80700
> [  323.675915] print_req_error: I/O error, dev nvme0n1, sector 1088646984 flags 84700
> [  323.675920] print_req_error: I/O error, dev nvme0n1, sector 1088647240 flags 84700
> [  323.675923] print_req_error: I/O error, dev nvme0n1, sector 1088647496 flags 84700
> [  323.675927] print_req_error: I/O error, dev nvme0n1, sector 1088647752 flags 84700
> [  323.675931] print_req_error: I/O error, dev nvme0n1, sector 1088648008 flags 84700
> [  323.675935] print_req_error: I/O error, dev nvme0n1, sector 1088648264 flags 84700
> [  323.675938] print_req_error: I/O error, dev nvme0n1, sector 1088648520 flags 84700
> [  323.675942] print_req_error: I/O error, dev nvme0n1, sector 1088648776 flags 84700
> [  323.675993] nvme nvme0: Abort status: 0x7
> [  323.675995] nvme nvme0: Abort status: 0x7
> [  323.675996] nvme nvme0: Abort status: 0x7
> [  323.675998] nvme nvme0: Abort status: 0x7
> [  323.675999] nvme nvme0: Abort status: 0x7
