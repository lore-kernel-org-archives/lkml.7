Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3964C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1192054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yYh/eTur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfDCPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:40:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40390 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfDCPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:39:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so5251334plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6NFYgu8LYAIEMT2NkIHo6xQunCeTdqwADUvaKw9GfVk=;
        b=yYh/eTur7DnMoVUVTSWQfaSeue1eEXSo/n7C2icw4HxjDhi+HHbAsz1NzhY/6S43pW
         uvz+olJ3ULS9b4pRtf90ExpxLmmfuxFGHT7xSbYtW9eweV9fM1eg6mmgdVY/hpY6IFBX
         9jUw7pKvw0/982EixG07i8NGFfUIQMuaX0lAlZKrLlcjvbEISfJ0NdI94cP3XSBPUScS
         QLXbTrriXFmfdRttmFTpJJGdO9bkM8pgIAVmsKKQ4DHXCRwaZQYLU7qO3GQOi/589HwF
         5kpIXUlhuL8SU6MVkxLS4/OX0DfQ8SEmxBfiNRTr234UTITD+0gpetb350R52ZSYvo4S
         3LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NFYgu8LYAIEMT2NkIHo6xQunCeTdqwADUvaKw9GfVk=;
        b=Sv4S/AUE3RILEOJp0e4ngcy9mwATaD+sEtxrl5ugnPXrHACxrIBBjz8UO0XvKV5R3J
         hsg5//ZselPnc9eozZ4lcVgvmBUaQLHePiges5GVKeUg6F3gQ9JDClMviu3i9xkMmQgE
         oDgAIdTRmwSyegNWNj7BSloB2x0Abo5OlnO911RtCOKpBo4GGywbxOW27qFv/vOCnLi8
         KuaidW1xSNS3a/U+RKJiENGWxMfxMDzoaj2fI9KEe4SDicFOLXjcUx2Hcz6nj2a0Y7Py
         HukVHPFEZkJkcegF1cRdbugVojdIdaduItpr9I/twALrV1gCDhLBLQuGQ9U+hBFLh4rT
         D1jw==
X-Gm-Message-State: APjAAAVR2BslIfKGnVbdgqGekm52R92OYX2Ijvk+tq7BZXwZNz57bZza
        r12iTCeNn1BgG/Gps858msA0rA==
X-Google-Smtp-Source: APXvYqzycRW2VojtP5LF1yvo3lG3IC+xbeykL2TsFBA8Q8gIGqsWRIRitt07fuIUhTAnfK053d9mSQ==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr565590plb.143.1554305997967;
        Wed, 03 Apr 2019 08:39:57 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j14sm12974386pfa.57.2019.04.03.08.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:39:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To:     Will Deacon <will.deacon@arm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
 <20190403151932.GA16866@fuggles.cambridge.arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
Date:   Wed, 3 Apr 2019 09:39:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403151932.GA16866@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 9:19 AM, Will Deacon wrote:
> Hi Jens,
> 
> On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
>> On 4/3/19 5:11 AM, Will Deacon wrote:
>>> will@autoplooker:~/liburing/test$ ./io_uring_register 
>>> RELIMIT_MEMLOCK: 67108864 (67108864)
>>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>>> [   35.478969] Mem abort info:
>>> [   35.479296]   ESR = 0x96000004
>>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
>>> [   35.480528]   SET = 0, FnV = 0
>>> [   35.480980]   EA = 0, S1PTW = 0
>>> [   35.481345] Data abort info:
>>> [   35.481680]   ISV = 0, ISS = 0x00000004
>>> [   35.482267]   CM = 0, WnR = 0
>>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>>> [   35.483486] [0000000000000070] pgd=0000000000000000
>>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [   35.484788] Modules linked in:
>>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
>>> [   35.486712] Hardware name: linux,dummy-virt (DT)
>>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
>>> [   35.488228] pc : link_pwq+0x10/0x60
>>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
>>> [   35.489550] sp : ffff000017e2bbc0
>>
>> Huh, this looks odd, it's crashing inside the wq setup.
> 
> Enabling KASAN seems to indicate a double-free, which may well be related.

Does this help?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index bbdbd56cf2ac..07d6ef195d05 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2215,6 +2215,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			fput(ctx->user_files[i]);
 
 		kfree(ctx->user_files);
+		ctx->user_files = NULL;
 		ctx->nr_user_files = 0;
 		return ret;
 	}

-- 
Jens Axboe

