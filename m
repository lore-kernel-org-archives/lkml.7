Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C6206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKMVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfKMVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BA0206ED;
        Wed, 13 Nov 2019 21:02:39 +0000 (UTC)
Date:   Wed, 13 Nov 2019 16:02:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH v2 1/2] seq_buf: Add printing formatted hex dumps
Message-ID: <20191113160237.6b8efe12@gandalf.local.home>
In-Reply-To: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 13:45:37 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> Provided function is an analogue of print_hex_dump().
> 
> Implementing this function in seq_buf allows using for multiple
> purposes (e.g. for tracing) and therefore prevents from code duplication
> in every layer that uses seq_buf.
> 
> print_hex_dump() is an essential part of logging data to dmesg. Adding
> similar capability for other purposes is beneficial to all users.
> 
> Example usage:
> seq_buf_hex_dump(seq, "", DUMP_PREFIX_OFFSET, 16, 4, buf,
> 		 ARRAY_SIZE(buf), true);
> Example output:
> 00000000: 00000000 ffffff10 ffffff32 ffff3210  ........2....2..
> 00000010: ffff3210 83d00437 c0700000 00000000  .2..7.....p.....
> 00000020: 02010004 0000000f 0000000f 00004002  .............@..
> 00000030: 00000fff 00000000                    ........
> 
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

I'm curious about the two signed off bys? Was Cezary a co-author?


> ---
> v2
> Add kernel doc header
> Explain linebuf magic number size
> 
> Decided not to change declaration order or remaining -= rowsize to
> remaining -= linelen in order to stay aligned with base print_hex_dump
> function. However I can change it if requested.

I don't care as much to make the change. Perhaps we can clean that up
in the future.

-- Steve

> 
>  include/linux/seq_buf.h |  3 +++
>  lib/seq_buf.c           | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
>
