Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3552568D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfE3Hov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:44:51 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:37104 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfE3Hou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:44:50 -0400
Subject: Re: [PATCH] vmalloc: Don't use flush flag when no exec perm
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@arm.com" <ard.biesheuvel@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
References: <20190529055104.6822-1-rick.p.edgecombe@intel.com>
 <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <67241836-621c-6933-1278-f04aedcefcb3@linux.ee>
Date:   Thu, 30 May 2019 10:44:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The addition of VM_FLUSH_RESET_PERMS for BPF JIT allocations was
>> bisected to prevent boot on an UltraSparc III machine. It was found
>> that
>> sometime shortly after the TLB flush this flag does on vfree of the
>> BPF
>> program, the machine hung. Further investigation showed that before
>> any of
>> the changes for this flag were introduced, with
>> CONFIG_DEBUG_PAGEALLOC
>> configured (which does a similar TLB flush of the vmalloc range on
>> every vfree), this machine also hung shortly after the first vmalloc
>> unmap/free.
>>
>> So the evidence points to there being some existing issue with the
>> vmalloc TLB flushes, but it's still unknown exactly why these hangs
>> are
>> happening on sparc. It is also unknown when someone with this
>> hardware
>> could resolve this, and in the meantime using this flag on it turns a
>> lurking behavior into something that prevents boot.
> 
> The sparc TLB flush issue has been bisected and is being worked on now,
> so hopefully we won't need this patch:
> https://marc.info/?l=linux-sparc&m=155915694304118&w=2

And the sparc64 patch that fixes CONFIG_DEBUG_PAGEALLOC also fixes booting
of the latest git kernel on Sun V445 where my problem initially happened.

-- 
Meelis Roos <mroos@linux.ee>
