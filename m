Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCB4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B646214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfGXU0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:26:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41335 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389369AbfGXThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:37:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so46612799qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7pnaGuYc9LFLbT5aUxNfUlnE7ek1gcnJ4zW5L3HylM=;
        b=AJa24WOUq6QNmfM7o3lefePyApLJXuhnHzamOGyebk6ymmpiolLwxmEuGo5tezWLSx
         ig6YpsdAxKT6H60lVG9DQ2ec8WehibgI8QLPAa/Y84/QedB5FRiiSUS+5aVEF+MZ1i26
         p14SMIxISzs+2sjoC+OsIYIaLVtmG4isG2H5Is2DAMWtcow4siohVOIPSStq13IyMCQt
         I1ES7Dz/kAtl/GdZcTj/G1mpEssieeywF+NLIWweTl5YxjC28KKVXRDcyIStIWNtiYhP
         NBOXj1zDmtGF/EU8ibDau+HULhL8X1S5oxL0nAZ4YXUKcbWC+9hol9KI2Iczo3tSBrs2
         aG8Q==
X-Gm-Message-State: APjAAAV27pGpphHefrD08+ghm1u/wxw2djID6EtPDXGxHB68VSwbIzZr
        Qc9CEVO3iTlPTtSwdqejOLUolg==
X-Google-Smtp-Source: APXvYqwNTwfZ7UhOrUsmMJREZDSG4r+F8zrpdIk7pUPLDp8e5SLJxmNngfBQGNr0NG9bBAHOHmh5zA==
X-Received: by 2002:ac8:1887:: with SMTP id s7mr59031081qtj.220.1563997018800;
        Wed, 24 Jul 2019 12:36:58 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id q17sm16672031qtl.13.2019.07.24.12.36.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:36:58 -0700 (PDT)
Subject: Re: Limits for ION Memory Allocator
To:     alex.popov@linux.com, Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        arve@android.com, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Riley Andrews <riandrews@android.com>,
        devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        syzkaller@googlegroups.com, John Stultz <john.stultz@linaro.org>
References: <3b922aa4-c6d4-e4a4-766d-f324ff77f7b5@linux.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <40f8b7d8-fafa-ad99-34fb-9c63e34917e2@redhat.com>
Date:   Wed, 24 Jul 2019 15:36:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3b922aa4-c6d4-e4a4-766d-f324ff77f7b5@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/19 12:31 PM, Alexander Popov wrote:
> Hello!
> 
> The syzkaller [1] has a trouble with fuzzing the Linux kernel with ION Memory
> Allocator.
> 
> Syzkaller uses several methods [2] to limit memory consumption of the userspace
> processes calling the syscalls for testing the kernel:
>   - setrlimit(),
>   - cgroups,
>   - various sysctl.
> But these methods don't work for ION Memory Allocator, so any userspace process
> that has access to /dev/ion can bring the system to the out-of-memory state.
> 
> An example of a program doing that:
> 
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <linux/types.h>
> #include <sys/ioctl.h>
> 
> #define ION_IOC_MAGIC		'I'
> #define ION_IOC_ALLOC		_IOWR(ION_IOC_MAGIC, 0, \
> 				      struct ion_allocation_data)
> 
> struct ion_allocation_data {
> 	__u64 len;
> 	__u32 heap_id_mask;
> 	__u32 flags;
> 	__u32 fd;
> 	__u32 unused;
> };
> 
> int main(void)
> {
> 	unsigned long i = 0;
> 	int fd = -1;
> 	struct ion_allocation_data data = {
> 		.len = 0x13f65d8c,
> 		.heap_id_mask = 1,
> 		.flags = 0,
> 		.fd = -1,
> 		.unused = 0
> 	};
> 
> 	fd = open("/dev/ion", 0);
> 	if (fd == -1) {
> 		perror("[-] open /dev/ion");
> 		return 1;
> 	}
> 
> 	while (1) {
> 		printf("iter %lu\n", i);
> 		ioctl(fd, ION_IOC_ALLOC, &data);
> 		i++;
> 	}
> 
> 	return 0;
> }
> 
> 
> I looked through the code of ion_alloc() and didn't find any limit checks.
> Is it currently possible to limit ION kernel allocations for some process?
> 
> If not, is it a right idea to do that?
> Thanks!
> 

Yes, I do think that's the right approach. We're working on moving Ion
out of staging and this is something I mentioned to John Stultz. I don't
think we've thought too hard about how to do the actual limiting so
suggestions are welcome.

Thanks,
Laura

> Best regards,
> Alexander
> 
> 
> [1]: https://github.com/google/syzkaller
> [2]: https://github.com/google/syzkaller/blob/master/executor/common_linux.h
> 

