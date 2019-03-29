Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93DB218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microway.com header.i=@microway.com header.b="HzF+lC2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfC2VDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:03:13 -0400
Received: from mail1.microway.com ([50.245.10.177]:44094 "EHLO microway.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730190AbfC2VDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:03:13 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 17:03:12 EDT
Received: from [10.200.120.6] (openvpn.microway.com [192.168.200.4])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by microway.com (Postfix) with ESMTPSA id 026CA9F9F6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:55:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=microway.com;
        s=verified; t=1553892946;
        bh=QCQzVG2sUntXA8MXNP3KqZ89g49LV/B5QQI/rW0v9T4=;
        h=To:From:Subject:Date;
        b=HzF+lC2VRVv1aqeohpnunofkZBsu0+Y40Lyyn8To8oBmt/4VsNh0CrLAG6BYO6MJQ
         PPd4Deg7Kai4UPYXJ6CjsrHjHnxvHUiWLlQvkvspuzzUEnNtnz8R/piJiBeRg248zq
         jANbdu0/Lxoi30yDZup3h4KjmAcFaFnCzNSfYU9c=
To:     linux-kernel@vger.kernel.org
From:   Rick Warner <rick@microway.com>
Subject: slow write performance with software RAID on nvme storage
Message-ID: <0a6373c6-817f-6ead-2a71-7c83c03406be@microway.com>
Date:   Fri, 29 Mar 2019 16:55:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We've been testing a 24 drive NVME software RAID and getting far lower
write speeds than expected.  The drives are connected with PLX chips
such that 12 drives are on 1 x16 connection and the other 12 drives use
another x16 link  The system is a Supermicro 2029U-TN24R4T.  The drives
are Intel DC P4500 1TB.

We're testing with fio using 8 jobs.

Using all defaults with RAID0 I can only get 4 or 5 GB/s write speeds
but can hit ~24GB/s read speeds.  The drives have over 1GB/s write speed
each, so we should be able to hit at least 20GB/s write speed.

Testing with RAID6 and defaults got significantly lower (down around
1.5GB/s).  Using a 64k chunk and increasing the group_thread_cnt
increased the results to ~4GB/s.

dmesg shows the RAID parity calc speed being ~40GB/s:
[    4.215386] raid6: using algorithm avx512x2 gen() 41397 MB/s


I've played around with filesystem queue choices and tuning but haven't
seen any significant improvements.

What is the bottleneck here? If it's not known, what should I do to
determine it?

I've done a variety of other tests with this system and am happy to
elaborate further if any other information is needed.

Thanks,
Rick Warner
