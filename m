Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D682C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CF2217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPNpjVQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfEYI7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:59:32 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46379 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfEYI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:59:32 -0400
Received: by mail-yb1-f193.google.com with SMTP id o81so406785ybc.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=xKKlfF2UNbDVEAghC5Zk8M2SCxRAIex5R2b+OqSnvFU=;
        b=rPNpjVQgDiaZ5xSQtw6BzqhC9XiAbEwoq5ubUuLAzdHg8Q3krPeT2X0WOdLPTT4Aic
         ZsgvEIxpTO9SSzLz57ADUGrbRea2qsE+PtUiSspPV+ZBwBFZcRrafUlt/pC6t4FspyIn
         fV/7Hnbs/VHNwYY33fMmsjOAWKurfbWoxwRpfUQytMCRoZargM3GxoLeweJUQkATIgPw
         X+n9ckN2qrD3tqCoYDdwnbEv9abq5v+SZvbLSqwIcgtLsmY7pAFw5KjPCr3J5jMRV7G7
         VVlUb6Tf/+CBzGO8lWKZu73A9M3DOhqEF9DXMiCk54tf1ShQoR5+Vex1L/m2Vk8dAfBM
         EZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=xKKlfF2UNbDVEAghC5Zk8M2SCxRAIex5R2b+OqSnvFU=;
        b=o3xvzJwVHnnj1oOsczvPDNy8ETe4PghltKRcawf31psGbS9BJk7ClaMI9W+J/qa5P0
         8ETwFfB0Tvdwabk8n0Gcqie0LejKZpqEyvaH+zvM7NzKxcHlS/dbn/uOMqVXjPeHhI7g
         0xu1fdUyS4x1NQ+QtHaOqGtJLBHdpgzmRq9drOZhHl8MbvKpC8JrMPqFFuIsNJKax2av
         TEmDQiib7xOzbz+geENZ4ZkQmFj5sCf8Gwy2NIUke2uS4y2pbDfuU4W8sSqhQJg3PMKn
         CqMRCmnPAzM2sg34r+ot7XD/WoBxDaj42W0awgxJpDGwy16RXST+sSiToKh8ygoAwthP
         DNLA==
X-Gm-Message-State: APjAAAVBDuoole3IHVjEGZDwZ3yl5OLxQjAdh3B5P6gpaNL7qkV3xWVe
        8onvFi1mDLeIsZBiLX/u4pJoqTHx+FOLkGMW0BA275CT
X-Received: by 2002:a25:bcf:: with SMTP id 198mt3315063ybl.34.1558774771441;
 Sat, 25 May 2019 01:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074519.61272b42@canb.auug.org.au> <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
In-Reply-To: <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Sat, 25 May 2019 10:59:27 +0200
Message-ID: <CA+QBN9BPbTHojQcSQZM1KmfsUMkajhLhmJ6jye4PdK8uXO9NcQ@mail.gmail.com>
Subject: Re: C3600, sata controller
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guys?
yahoooooooooooooooo, SYBA-SY-PCX40009 does woooork :D :D

02:03.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial
ATA Controller (rev 01)

10 hours burn-in test passed!!!!

while [ 1 ]
do
for item in `ls *.bin`
    do
        rm -f $copy.out
        echo -n "$item ... "
        time cp_and_check_md5sum $item $copy.out
        echo "done"
    done
done

kernel 5.1, from the git repository, compiled with SMP

dmesg | grep altern
[    2.551002] alternatives: applied 156 out of 175 patches

only applied this patch:

--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -52,7 +52,6 @@ void parisc_setup_cache_timing(void);

 #define asm_io_fdc(addr) asm volatile("fdc %%r0(%0)" \
                        ALTERNATIVE(ALT_COND_NO_DCACHE, INSN_NOP) \
-                       ALTERNATIVE(ALT_COND_NO_IOC_FDC, INSN_NOP) \
                        : : "r" (addr) : "memory")
 #define asm_io_sync()  asm volatile("sync" \
                        ALTERNATIVE(ALT_COND_NO_DCACHE, INSN_NOP) \
