Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6151F2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCLRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:05:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCLRFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:05:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4382180D;
        Tue, 12 Mar 2019 10:05:43 -0700 (PDT)
Received: from [10.37.10.23] (unknown [10.37.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D532B3F59C;
        Tue, 12 Mar 2019 10:05:40 -0700 (PDT)
Subject: xen: Can't insert balloon page into VM userspace (WAS Re: [Xen-devel]
 [linux-linus bisection] complete test-arm64-arm64-xl-xsm)
From:   Julien Grall <julien.grall@arm.com>
To:     osstest service owner <osstest-admin@xenproject.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        willy@infradead.org, Kees Cook <keescook@chromium.org>,
        david@redhat.com
References: <E1h3Uiq-0002L6-Ij@osstest.test-lab.xenproject.org>
 <80211e70-5f54-9421-8e8f-2a4fc758ce39@arm.com>
Message-ID: <46118631-61d4-adb6-6ffc-4e7c62ea3da9@arm.com>
Date:   Tue, 12 Mar 2019 17:05:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <80211e70-5f54-9421-8e8f-2a4fc758ce39@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding more people in the thread)

Hi,

On 3/12/19 3:59 PM, Julien Grall wrote:
> Hi all,
> 
> It looks like all the arm test for linus [1] and next [2] tree
> are now failing. x86 seems to be mostly ok.
> 
> The bisector fingered the following commit:
> 
> commit 0ee930e6cafa048c1925893d0ca89918b2814f2c
> Author: Matthew Wilcox <willy@infradead.org>
> Date:   Tue Mar 5 15:46:06 2019 -0800
> 
>      mm/memory.c: prevent mapping typed pages to userspace
>      
>      Pages which use page_type must never be mapped to userspace as it would
>      destroy their page type.  Add an explicit check for this instead of
>      assuming that kernel drivers always get this right.
>      
>      Link: http://lkml.kernel.org/r/20190129053830.3749-1-willy@infradead.org
>      Signed-off-by: Matthew Wilcox <willy@infradead.org>
>      Reviewed-by: Kees Cook <keescook@chromium.org>
>      Reviewed-by: David Hildenbrand <david@redhat.com>
>      Cc: Michael Ellerman <mpe@ellerman.id.au>
>      Cc: Will Deacon <will.deacon@arm.com>
>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> I have tried the latest linus mater as Dom0 and see some issue to get the
> console guest:
> 
> 42sh> sudo xl create -c ~/works/guest/guest.cfg
> Parsing config from /home/julien/works/guest/guest.cfg
> xenconsole: Could not read tty from store: Success
> 
> I have added a print in the error path added by the commit above to see
> what and where it happens:
> 
> [  182.366372] PageAnon 0 PageSlab 0 page_has_type 1
> [  182.371076] WARNING: CPU: 2 PID: 2210 at mm/memory.c:1459 vm_insert_page+0x3e
> 0/0x430
> [  182.378837] Modules linked in:
> [  182.381974] CPU: 2 PID: 2210 Comm: xenstored Not tainted 5.0.0-10742-gea29548
> 1b6e3-dirty #1310
> [  182.390672] Hardware name: ARM Juno development board (r2) (DT)
> [  182.396678] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  182.401553] pc : vm_insert_page+0x3e0/0x430
> [  182.405816] lr : vm_insert_page+0x3e0/0x430
> [  182.410077] sp : ffff000012773bc0
> [  182.413471] x29: ffff000012773bc0 x28: 0000ffff8d3fa000
> [  182.418866] x27: 0000000000000008 x26: 0000000000000001
> [  182.424261] x25: 0000000000000008 x24: 0000ffff8d3fa000
> [  182.429656] x23: 0068000000000f53 x22: ffff8008ab520a00
> [  182.435052] x21: ffff000011644a88 x20: 0000000000000000
> [  182.440454] x19: ffff7e00229b0e80 x18: 0000000000000000
> [  182.445841] x17: 0000000000000000 x16: 0000000000000000
> [  182.451245] x15: 00000000fffffff0 x14: 0000000000000000
> [  182.456631] x13: ffff000012339ff0 x12: 0000000000000006
> [  182.462027] x11: ffff000010ec4980 x10: ffff0000107d01f8
> [  182.467422] x9 : 00000000fffb9fff x8 : ffff8008ab55a0a0
> [  182.472817] x7 : 0000000000000001 x6 : ffff8008bb02a220
> [  182.478212] x5 : ffff8008bb02a220 x4 : 0000000000000000
> [  182.483607] x3 : ffff8008bb032708 x2 : b98ad6a7b7eb2900
> [  182.489002] x1 : 0000000000000000 x0 : 0000000000000025
> [  182.494397] Call trace:
> [  182.496924]  vm_insert_page+0x3e0/0x430
> [  182.500853]  gntdev_mmap+0x188/0x288
> [  182.504495]  mmap_region+0x3dc/0x578
> [  182.508149]  do_mmap+0x2d4/0x478
> [  182.511457]  vm_mmap_pgoff+0xe0/0x108
> [  182.515198]  ksys_mmap_pgoff+0xac/0x308
> [  182.519116]  __arm64_sys_mmap+0x28/0x38
> [  182.523029]  el0_svc_handler+0x88/0x100
> [  182.526943]  el0_svc+0x8/0xc
> [  182.529901] ---[ end trace cf738ac71bfed946 ]---
> 
> Does it ring any bell?

It turns out the problem is because the balloon driver will call 
__SetPageOffline() on allocated page. Therefore the page has a type and 
vm_insert_pages will deny the insertion.

My knowledge is quite limited in this area. So I am not sure how we can 
solve the problem.

I would appreciate if someone could provide input of to fix the mapping.

Cheers,

> 
> Cheers,
> 
> [1] http://logs.test-lab.xenproject.org/osstest/logs/133695/
> [2] http://logs.test-lab.xenproject.org/osstest/logs/133655/
> 
> On 3/11/19 11:52 PM, osstest service owner wrote:
>> branch xen-unstable
>> xenbranch xen-unstable
>> job test-arm64-arm64-xl-xsm
>> testid guest-start
>>
>> Tree: linux git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Tree: linuxfirmware git://xenbits.xen.org/osstest/linux-firmware.git
>> Tree: qemuu git://xenbits.xen.org/qemu-xen.git
>> Tree: xen git://xenbits.xen.org/xen.git
>>
>> *** Found and reproduced problem changeset ***
>>
>>     Bug is in tree:  linux git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>     Bug introduced:  0ee930e6cafa048c1925893d0ca89918b2814f2c
>>     Bug not present: 2d432cb7091e99881af803cdd67a31969b863005
>>     Last fail repro: http://logs.test-lab.xenproject.org/osstest/logs/133723/
>>
>>
>>     commit
> 
> 
>>     Author: Matthew Wilcox <willy@infradead.org>
>>     Date:   Tue Mar 5 15:46:06 2019 -0800
>>     
>>         mm/memory.c: prevent mapping typed pages to userspace
>>         
>>         Pages which use page_type must never be mapped to userspace as it would
>>         destroy their page type.  Add an explicit check for this instead of
>>         assuming that kernel drivers always get this right.
>>         
>>         Link: http://lkml.kernel.org/r/20190129053830.3749-1-willy@infradead.org
>>         Signed-off-by: Matthew Wilcox <willy@infradead.org>
>>         Reviewed-by: Kees Cook <keescook@chromium.org>
>>         Reviewed-by: David Hildenbrand <david@redhat.com>
>>         Cc: Michael Ellerman <mpe@ellerman.id.au>
>>         Cc: Will Deacon <will.deacon@arm.com>
>>         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>
>>
>> For bisection revision-tuple graph see:
>>      http://logs.test-lab.xenproject.org/osstest/results/bisect/linux-linus/test-arm64-arm64-xl-xsm.guest-start.html
>> Revision IDs in each graph node refer, respectively, to the Trees above.
>>
>> ----------------------------------------
>> Running cs-bisection-step --graph-out=/home/logs/results/bisect/linux-linus/test-arm64-arm64-xl-xsm.guest-start --summary-out=tmp/133723.bisection-summary --basis-template=133580 --blessings=real,real-bisect linux-linus test-arm64-arm64-xl-xsm guest-start
>> Searching for failure / basis pass:
>>    133673 fail [host=laxton0] / 133605 [host=laxton1] 133580 ok.
>> Failure / basis pass flights: 133673 / 133580
>> Tree: linux git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Tree: linuxfirmware git://xenbits.xen.org/osstest/linux-firmware.git
>> Tree: qemuu git://xenbits.xen.org/qemu-xen.git
>> Tree: xen git://xenbits.xen.org/xen.git
>> Latest 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>> Basis pass 736706bee3298208343a76096370e4f6a5c55915 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 f393b82fe5ba3ed9cfe2b306ffa53368e55b75af
>> Generating revisions with ./adhoc-revtuple-generator  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git#736706bee3298208343a76096370e4f6a5c55915-38e7571c07be01f9f19b355a9306a4e3d5cb0f5b git://xenbits.xen.org/osstest/linux-firmware.git#c530a75c1e6a472b0eb9558310b518f0dfcd8860-c530a75c1e6a472b0eb9558310b518f0dfcd8860 git://xenbits.xen.org/qemu-xen.git#de5b678ca4dcdfa83e322491d478d66df56c1986-de5b678ca4dcdfa83e322491d478d66df56c1986 git://xenbits.xen.org/xen.git#f393b82fe5ba3ed9c\
>>    fe2b306ffa53368e55b75af-eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>> Loaded 149180 nodes in revision graph
>> Searching for test results:
>>    133581 blocked irrelevant
>>    133585 blocked irrelevant
>>    133605 [host=laxton1]
>>    133580 pass 736706bee3298208343a76096370e4f6a5c55915 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 f393b82fe5ba3ed9cfe2b306ffa53368e55b75af
>>    133679 fail irrelevant
>>    133689 pass irrelevant
>>    133674 pass 736706bee3298208343a76096370e4f6a5c55915 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 f393b82fe5ba3ed9cfe2b306ffa53368e55b75af
>>    133631 fail irrelevant
>>    133686 fail irrelevant
>>    133678 fail irrelevant
>>    133681 pass irrelevant
>>    133683 pass irrelevant
>>    133685 pass irrelevant
>>    133687 fail irrelevant
>>    133688 fail irrelevant
>>    133673 fail 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133690 fail irrelevant
>>    133720 fail 0ee930e6cafa048c1925893d0ca89918b2814f2c c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133691 fail irrelevant
>>    133692 fail irrelevant
>>    133694 fail 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133721 pass 2d432cb7091e99881af803cdd67a31969b863005 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133723 fail 0ee930e6cafa048c1925893d0ca89918b2814f2c c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133697 fail e5eed351fd5eb73eecc1407cf00309e868379253 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133700 fail f900482da560941f978b0d36660e96f48ea78752 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133701 pass c52e75935f8ded2bd4a75eb08e914bd96802725b c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133702 fail 8bb4e7a2ee26c05a94ae6cb0aec2f82a3523cf35 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133704 pass 9bebefd59084af7c75b66eeee241bf0777f39b88 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133705 pass dc50537bdd1a0804fa2cbc990565ee9a944e66fa c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133709 fail 0ee930e6cafa048c1925893d0ca89918b2814f2c c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133710 pass 677dc9731b54dccaaadbdcea18f8eecc95cee832 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133711 pass afd07389d3f4933c7f7817a92fb5e053d59a3182 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133713 pass 2d432cb7091e99881af803cdd67a31969b863005 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133715 fail 0ee930e6cafa048c1925893d0ca89918b2814f2c c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133718 blocked 2d432cb7091e99881af803cdd67a31969b863005 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>>    133719 pass 2d432cb7091e99881af803cdd67a31969b863005 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>> Searching for interesting versions
>>    Result found: flight 133580 (pass), for basis pass
>>    Result found: flight 133673 (fail), for basis failure
>>    Repro found: flight 133674 (pass), for basis pass
>>    Repro found: flight 133694 (fail), for basis failure
>>    0 revisions at 2d432cb7091e99881af803cdd67a31969b863005 c530a75c1e6a472b0eb9558310b518f0dfcd8860 de5b678ca4dcdfa83e322491d478d66df56c1986 eeb31ee522c7bb8541eb4c037be2c42bfcf0a3c3
>> No revisions left to test, checking graph state.
>>    Result found: flight 133713 (pass), for last pass
>>    Result found: flight 133715 (fail), for first failure
>>    Repro found: flight 133719 (pass), for last pass
>>    Repro found: flight 133720 (fail), for first failure
>>    Repro found: flight 133721 (pass), for last pass
>>    Repro found: flight 133723 (fail), for first failure
>>
>> *** Found and reproduced problem changeset ***
>>
>>     Bug is in tree:  linux git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>     Bug introduced:  0ee930e6cafa048c1925893d0ca89918b2814f2c
>>     Bug not present: 2d432cb7091e99881af803cdd67a31969b863005
>>     Last fail repro: http://logs.test-lab.xenproject.org/osstest/logs/133723/
>>
>>
>>     commit 0ee930e6cafa048c1925893d0ca89918b2814f2c
>>     Author: Matthew Wilcox <willy@infradead.org>
>>     Date:   Tue Mar 5 15:46:06 2019 -0800
>>     
>>         mm/memory.c: prevent mapping typed pages to userspace
>>         
>>         Pages which use page_type must never be mapped to userspace as it would
>>         destroy their page type.  Add an explicit check for this instead of
>>         assuming that kernel drivers always get this right.
>>         
>>         Link: http://lkml.kernel.org/r/20190129053830.3749-1-willy@infradead.org
>>         Signed-off-by: Matthew Wilcox <willy@infradead.org>
>>         Reviewed-by: Kees Cook <keescook@chromium.org>
>>         Reviewed-by: David Hildenbrand <david@redhat.com>
>>         Cc: Michael Ellerman <mpe@ellerman.id.au>
>>         Cc: Will Deacon <will.deacon@arm.com>
>>         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> pnmtopng: 189 colors found
>> Revision graph left in /home/logs/results/bisect/linux-linus/test-arm64-arm64-xl-xsm.guest-start.{dot,ps,png,html,svg}.
>> ----------------------------------------
>> 133723: tolerable ALL FAIL
>>
>> flight 133723 linux-linus real-bisect [real]
>> http://logs.test-lab.xenproject.org/osstest/logs/133723/
>>
>> Failures :-/ but no regressions.
>>
>> Tests which did not succeed,
>> including tests which could not be run:
>>    test-arm64-arm64-xl-xsm      12 guest-start             fail baseline untested
>>
>>
>> jobs:
>>    test-arm64-arm64-xl-xsm                                      fail
>>
>>
>> ------------------------------------------------------------
>> sg-report-flight on osstest.test-lab.xenproject.org
>> logs: /home/logs/logs
>> images: /home/logs/images
>>
>> Logs, config files, etc. are available at
>>       http://logs.test-lab.xenproject.org/osstest/logs
>>
>> Explanation of these reports, and of osstest in general, is at
>>       http://xenbits.xen.org/gitweb/?p=osstest.git;a=blob;f=README.email;hb=master
>>       http://xenbits.xen.org/gitweb/?p=osstest.git;a=blob;f=README;hb=master
>>
>> Test harness code can be found at
>>       http://xenbits.xen.org/gitweb?p=osstest.git;a=summary
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xenproject.org
>> https://lists.xenproject.org/mailman/listinfo/xen-devel
>>
> 

-- 
Julien Grall
