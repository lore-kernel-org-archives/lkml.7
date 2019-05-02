Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A50C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049142063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEBNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:03:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:32995 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEBNDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:03:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 06:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="147550129"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2019 06:03:07 -0700
Date:   Thu, 2 May 2019 06:57:23 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
Message-ID: <20190502125722.GA28470@localhost.localdomain>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:59:17PM +0900, Akinobu Mita wrote:
> This enables to capture snapshot of controller information via device
> coredump machanism, and it helps diagnose and debug issues.
> 
> The nvme device coredump is triggered before resetting the controller
> caused by I/O timeout, and creates the following coredump files.
> 
> - regs: NVMe controller registers, including each I/O queue doorbell
>         registers, in nvme-show-regs style text format.

You're supposed to treat queue doorbells as write-only. Spec says:

  The host should not read the doorbell registers. If a doorbell register
  is read, the value returned is vendor specific.
