Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA34CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B2E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfEPOFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:05:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46916 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfEPOFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:05:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEDAF1715;
        Thu, 16 May 2019 07:05:33 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71163F5AF;
        Thu, 16 May 2019 07:05:32 -0700 (PDT)
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
To:     Mark Rutland <mark.rutland@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e70ead93-2fe9-faf9-9e77-9df15809bad6@arm.com>
Date:   Thu, 16 May 2019 15:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516134105.GB43059@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 14:41, Mark Rutland wrote:
> On Thu, May 16, 2019 at 02:38:20PM +0100, Mark Rutland wrote:
>> Hi,
>>
>> Since commit:
>>
>>   54c7a8916a887f35 ("initramfs: free initrd memory if opening /initrd.image fails")
> 
> Ugh, I dropped a paragarph here.
> 
> Since that commit, I'm seeing a boot-time splat on arm64 when using
> CONFIG_DEBUG_VIRTUAL. I'm running an arm64 syzkaller instance, and this
> kills the VM, preventing further testing, which is unfortunate.
> 
> Mark.
> 
>> IIUC prior to that commit, we'd only attempt to free an intird if we had
>> one, whereas now we do so unconditionally. AFAICT, in this case
>> initrd_start has not been initialized (I'm not using an initrd or
>> initramfs on my system), so we end up trying virt_to_phys() on a bogus
>> VA in free_initrd_mem().
>>
>> Any ideas on the right way to fix this?

Your analysis looks right to me. In my review I'd managed to spot the
change in behaviour when CONFIG_INITRAMFS_FORCE is set (the initrd is
freed), but I'd overlooked what happens if initrd_start == 0 (the
non-existent initrd is attempted to be freed).

I suspect the following is sufficient to fix the problem:

----8<-----
diff --git a/init/initramfs.c b/init/initramfs.c
index 435a428c2af1..178130fd61c2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -669,7 +669,7 @@ static int __init populate_rootfs(void)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && !kexec_free_initrd())
+	if (!do_retain_initrd && initrd_start && !kexec_free_initrd())
 		free_initrd_mem(initrd_start, initrd_end);
 	initrd_start = 0;
 	initrd_end = 0;
