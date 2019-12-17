Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B924672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfLQQnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:43:09 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57552 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQQnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:43:09 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ihFw1-0003ae-Q9; Tue, 17 Dec 2019 09:42:58 -0700
To:     Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc:     allenbh@gmail.com, dave.jiang@intel.com, sanju.mehta@amd.com
References: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
Date:   Tue, 17 Dec 2019 09:42:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sanju.mehta@amd.com, dave.jiang@intel.com, allenbh@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linjiasen@hygon.cn
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-12-16 7:42 p.m., Jiasen Lin wrote:
> Currently, read input and output buffer is not supported yet in
> debugfs of ntb_perf. We can not confirm whether the output data is
> transmitted to the input buffer at peer memory through NTB.
> 
> This patch add new entries in debugfs which implement interface to read
> a part of input and out buffer. User can dump output and input data at
> local and peer system by hexdump command, and then compare them manually.

Do we even initialize inbuf and outbuf? Probably not a good idea to
expose them to userspace if it's not initialized.

Really, ntb_tool should be used to check if memory windows work,
ntb_perf is just to see the maximum transfer rate.

Logan
