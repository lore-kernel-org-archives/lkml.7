Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272FE205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEGRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:45:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:49477 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfEGRo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:44:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:44:58 -0700
Received: from unknown (HELO [10.232.112.171]) ([10.232.112.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 07 May 2019 10:44:58 -0700
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <eb4f578c-2126-c4e8-97a9-2f65e4784359@intel.com>
Date:   Tue, 7 May 2019 11:44:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> This enables to capture snapshot of controller information via device
> coredump machanism.

s/machanism/mechanism/

> 
> The nvme device coredump creates the following coredump files.
> 
> - regs: NVMe controller registers (00h to 4Fh)
> - sq<qid>: Submission queue
> - cq<qid>: Completion queue
> - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
> - data: Empty
> 
> The reason for an empty 'data' file is to provide a uniform way to notify
> the device coredump is no longer needed by writing the 'data' file.
> 
> Since all existing drivers using the device coredump provide a 'data' file
> if the nvme device coredump doesn't provide it, the userspace programs need
> to know which driver provides what coredump file.
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
