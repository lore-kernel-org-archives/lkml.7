Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F597206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK0K4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:56:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:13676 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfK0K4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:56:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 02:56:41 -0800
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="206744192"
Received: from pmaziarx-mobl.ger.corp.intel.com (HELO [10.237.142.84]) ([10.237.142.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2019 02:56:39 -0800
Subject: Re: [PATCH v2 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com>
 <20191113160922.1b1f0fc0@gandalf.local.home>
 <61e34d88-bbf7-a2ff-e983-64dc9be1a482@linux.intel.com>
 <20191126145101.1e6c4e43@gandalf.local.home>
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Message-ID: <80820d36-d372-ed46-3c86-9b7e0a722b81@linux.intel.com>
Date:   Wed, 27 Nov 2019 11:56:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126145101.1e6c4e43@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-26 20:51, Steven Rostedt wrote:
> On Tue, 26 Nov 2019 15:53:26 +0100
> Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:
>> Hello Steven,
>>
>> I'm writing handle in event-parse and I came across some technical
>> problems. I have an event which print function looks like that:
>> TP_printk("%s",
>> 	  __print_hex_dump("", DUMP_PREFIX_OFFSET, 16, 4,
>> 			   __get_dynamic_array(buf),
>> 			   __get_dynamic_array_len(buf), false))
>> It works properly when printing events to debugfs.
>> I'm testing my implementation with trace-cmd and it has problem with
>> parsing DUMP_PREFIX_OFFSET and false (I'm using
>> alloc_and_process_delim()). Instead of having numerical values
>> tep_print_args are of type TEP_PRINT_ATOM and have char array
>> "DUMP_PREFIX_OFFSET" or "true".
>> Am I doing something incorrect? Parsing it this way is problematic
>> because instead of false someone may use 0 or logic expression. And
>> writing it to support all possible scenarios may be tedious and prone to
>> errors.
> 
> You can force the enum to be a number by including the following in the
> trace event header:
> 
> TRACE_DEFINE_ENUM(DUMP_PREFIX_OFFSET);
> TRACE_DEFINE_ENUM(DUMP_PREFIX_ADDRESS);
> TRACE_DEFINE_ENUM(DUMP_PREFIX_NONE);
> 
> and the format files will convert these to their actual numbers when
> displaying it to user space.
> 
> -- Steve
> 
Thanks, that's what I was looking for.

Best regards,
Piotr Maziarz
