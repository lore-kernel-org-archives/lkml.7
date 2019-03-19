Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCSUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:50:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60272 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCSUu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:50:56 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6Lgr-0004hj-5s; Tue, 19 Mar 2019 14:50:30 -0600
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
References: <20190319181357.9305-1-logang@deltatee.com>
 <20190319204253.GB17966@rapoport-lnx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a9b528f1-0c4b-3894-18e1-a4999c18f4a4@deltatee.com>
Date:   Tue, 19 Mar 2019 14:50:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319204253.GB17966@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: nicolas.pitre@linaro.org, rostedt@goodmis.org, philip@cog.systems, keescook@chromium.org, linux@armlinux.org.uk, robh@kernel.org, f.fainelli@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rppt@linux.ibm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ARM: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-19 2:42 p.m., Mike Rapoport wrote:
> On Tue, Mar 19, 2019 at 12:13:57PM -0600, Logan Gunthorpe wrote:
>> Cleanup the arm_memory_present() function seeing it's very
>> similar to other arches.
>>
>> The new memblocks_present() helper checks for node ids which the
>> arm version did not. However, this is equivalent seeing
>> HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
>> memblock_get_region_node() should return 0.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Philip Derrin <philip@cog.systems>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Strangely, I've got a feeling I've already reviewed such patch from a
> different person...

You're probably referring to [1] which was for arm64 and was redundant
as my patch for that architecture was already picked up by Catalin.

I was the person who originally introduced memblocks_present() and I'm
still hoping to get the cleanup patches for the arm and sh arches to be
picked up.

Thanks,

Logan

[1]
https://lore.kernel.org/lkml/20190210093738.30923-1-peng.fan@nxp.com/T/#u
