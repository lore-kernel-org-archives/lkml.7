Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6447421852
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCMXvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:51:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCMXvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:51:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2520811pfd.0;
        Wed, 13 Mar 2019 16:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+ljKQWjT4ARPUkGZsWYVzIbVQKEj0XxQ5Wv22F/TDU=;
        b=cMlbBKJ0SYX6URIVoqRuD1wHDLUqmZ2UGN/IoAvIDTg/vSvy9nPM5ghc18ySGRx/pt
         9EYGbJe+38+aG00I1K68MUbwUpGe+cXzO+v5a5qTtib14uE5YHeRChUc/Bj1PSdC4g9A
         wl6Uftnm7KQMuhzxl9pfnA4KkHvttp2pQDa7Wg4jZWvUey5bTbxWvogR6WIchvYUGM61
         Z0mvFPkfkWewwWylsfef0fqKuYBJ3KH0xq/Re2YL5YYwSzkC6G77JIIECiFhIAoI3GvK
         980d79UngqLRBnaWT8ACnT2GCy5hPKHqC5n6//AvawOKEnfla2+k2AZj2qzdqlrx0jDN
         HP0g==
X-Gm-Message-State: APjAAAXCMbzcycxGfc/q3dVHzGFYat+tkSs9YeKFUj7rHQIxJ6nqlEUh
        3Ngr7mfxDVLNQogK9VWxwbqdIe+h
X-Google-Smtp-Source: APXvYqwxBGsC1qZRkDA1OdOINVnfoeJtSYR1LipEseKvh/reYhqAJpHzteVmMltniR0xomtpEAy0Eg==
X-Received: by 2002:a62:4684:: with SMTP id o4mr46348097pfi.254.1552521081918;
        Wed, 13 Mar 2019 16:51:21 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b6sm19843659pfo.27.2019.03.13.16.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 16:51:19 -0700 (PDT)
Message-ID: <1552521077.45180.119.camel@acm.org>
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Yan <yanaijie@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.com,
        dan.j.williams@intel.com, jthumshirn@suse.de,
        Steffen Maier <maier@linux.ibm.com>
Date:   Wed, 13 Mar 2019 16:51:17 -0700
In-Reply-To: <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
References: <20190219072743.13606-1-yanaijie@huawei.com>
         <1550595388.31902.133.camel@acm.org> <20190220151836.GA11695@infradead.org>
         <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 16:53 +-0800, Jason Yan wrote:
+AD4 On 2019/2/20 23:18, Christoph Hellwig wrote:
+AD4 +AD4 +AFs-fullquote removed, please follow proper mail etiquette+AF0
+AD4 +AD4 
+AD4 +AD4 On Tue, Feb 19, 2019 at 08:56:28AM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 regression in the SCSI sd driver due to the switch from the legacy block
+AD4 +AD4 +AD4 layer to scsi-mq. The above patch introduces two atomic operations in the
+AD4 +AD4 +AD4 hot path and hence would introduce a performance regression. I think this
+AD4 +AD4 +AD4 can be avoided by making sure that sd+AF8-uninit+AF8-command() gets called before
+AD4 +AD4 +AD4 the request tag is freed. What changes would be required to make the block
+AD4 +AD4 +AD4 layer core call sd+AF8-uninit+AF8-command() before the request tag is freed? Would
+AD4 +AD4 +AD4 introducing prep+AF8-rq+AF8-fn and unprep+AF8-rq+AF8-fn callbacks in struct blk+AF8-mq+AF8-ops and
+AD4 +AD4 +AD4 making sure that the SCSI core sets these callback function pointers
+AD4 +AD4 +AD4 appropriately be sufficient? Would such a change allow to simplify the NVMe
+AD4 +AD4 +AD4 initiator driver? Are there any alternatives to this approach that are more
+AD4 +AD4 +AD4 elegant?
+AD4 +AD4 
+AD4 +AD4 Additional indirect calls in the I/O fast path is something I'd rather
+AD4 +AD4 avoid.  But I don't fully understand the problem yet - where do
+AD4 +AD4 we release a disk reference from blk+AF8-update+AF8-request?  
+AD4 
+AD4 When userspace close the fd after blk+AF8-update+AF8-request() and before
+AD4 scsi+AF8-mq+AF8-uninit+AF8-cmd(), a disk reference will be released. It is not the
+AD4 blk+AF8-update+AF8-request() directly released it.
+AD4 
+AD4 close
+AD4     -+AD4-sd+AF8-release
+AD4        -+AD4-scsi+AF8-disk+AF8-put
+AD4          -+AD4-scsi+AF8-disk+AF8-release
+AD4            -+AD4-disk-+AD4-private+AF8-data +AD0 NULL+ADs
+AD4 
+AD4 The userspace can close the fd because blk+AF8-update+AF8-request() returned the
+AD4 last IO , the userspace application does not have to stuck on read() or
+AD4 write(). The window is very small, but it can be reproduce every day
+AD4 in our testcases. So I'm very curious why. One possible explanation is
+AD4 that we enabled kernel preempt(CONFIG+AF8-PREEMPT).
+AD4 
+AD4 And why can't we move that release to +AF8AXw-blk+AF8-mq+AF8-end+AF8-request?

Hi Jason,

What is the current status of this issue?

Thanks,

Bart.
