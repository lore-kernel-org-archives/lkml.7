Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC7C28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 01:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617AD20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfFJBiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 21:38:07 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35854 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729829AbfFJBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 21:38:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TTo5mI4_1560130683;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTo5mI4_1560130683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Jun 2019 09:38:04 +0800
Subject: Re: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
References: <5817eaac-29cc-6331-af3b-b9d85a7c1cd7@linux.alibaba.com>
 <bde5bf17-35d2-45d8-1d1d-59d0f027b9c0@linux.alibaba.com>
 <D0F0870A-B396-4390-B5F1-164B68E13C73@vmware.com>
 <c2411bbb-d0e7-59b2-3418-63650b354544@linux.alibaba.com>
 <20190609145001.GA26365@kroah.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <6331bba5-0c6b-289f-5cc7-7d6099f3e4b1@linux.alibaba.com>
Date:   Mon, 10 Jun 2019 09:38:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609145001.GA26365@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed the following 3 upstream commits can resolve this issue:
d2a68c4effd8 x86/ftrace: Do not call function graph from dynamic trampolines
3c0dab44e227 x86/ftrace: Set trampoline pages as executable
7298e24f9042 x86/kprobes: Set instruction page as executable

And they are all included in stable 4.19.49.

Thanks,
Joseph

On 19/6/9 22:50, Greg KH wrote:
> On Sun, Jun 09, 2019 at 09:10:45PM +0800, Joseph Qi wrote:
>> Hi Nadav,
>> Thanks for the comments.
>> I'll test the 3 patches in the mentioned thread.
> 
> This should all be fixed in the latest release that happened today.  If
> not, please let us know.
> 
> thanks,
> 
> greg k-h
> 
