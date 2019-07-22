Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EBFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7D21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzCdxag7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfGVWV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:21:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44950 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfGVWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:21:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so18327506pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMQ+NveQ/ffg6xcp4P3hf9iSW66IH5EX0pdfXhzwwLY=;
        b=rzCdxag7Cmu6nXPYRTg1BJjEuk5JP/um7nIKD9tmmv5ekmhzlT5eswNHegS2FLCFUx
         vCRc3JCIQWwP5JAuZLa7w/5OZTAVX3lucRqO7MuKnu0skU4jjbUEAGLz8bZF2nqlxf5S
         or+WjwQC2udxYfaWDr9PMCupCULxYPtVBPwoV1aL/JNqIzqZ335l014IN7d8hkO/IhN7
         fhlB9o/rZwyu8Y0g2imZUT8m8Zb4enYbCEusNzJxkKbZ89kHnq6M8Xmz1dl24f4YNXOK
         U2XqTIFoAUlhN6CoQTxa7nFl7eOxZ3onGcHf9PcgBSL60ukw+hZq0oSywCcCdn3mYnOi
         L/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMQ+NveQ/ffg6xcp4P3hf9iSW66IH5EX0pdfXhzwwLY=;
        b=qmSlPrnRAgJEzIfFVh2i5vWmfucijx+L6nQ1xSBFEvf38fPemQJnrrGgGCUY1JznRj
         nMQWGng1u6J0cqOsr7x2+9k0Ufs4Qgc3L/8/khFuuo6FXY6OC5pJySoJ9k0H4ABZAl3M
         ijittgvYWMYvBe2IFV7fbmHo3wkGLYBtq74BBiFBn9dasxplIUa60ofAWD62TEUmoNR3
         0eEeme8zcopXaCZmJXdBcne/L/Tc1fAtIaaQV68VHRTXi/YxegeiXTEU4UDl1XM7BVx1
         ytPgH9BgNOs2Wpa6AxRnSjyIXoGLkdvBH2DCdfHU+o2OC4vSGj+pVv1a5ZnWhQwulq5v
         ii3w==
X-Gm-Message-State: APjAAAXOORTu0e6i9835XmW8IIz5KJ97/QwNHw0iag6HXpfzyzBXO6V+
        Ya4UMrrpK9gtSW5z7kQcExE=
X-Google-Smtp-Source: APXvYqyDHLqKFKggGUE5YtLMLUmkJ5qJGAjoqn2uTr2xm1NerLBMxb7Snss+VNLFnG2q0A8z9PvZQA==
X-Received: by 2002:aa7:8201:: with SMTP id k1mr2344347pfi.97.1563834088087;
        Mon, 22 Jul 2019 15:21:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r7sm45762652pfl.134.2019.07.22.15.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 15:21:27 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:21:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190722222126.GA27291@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 02:33:38PM -0700, Linus Torvalds wrote:

[ ... ]
> 
> Go test,
> 

Things looked pretty good until a few days ago. Unfortunately,
the last few days brought in a couple of issues.

riscv:virt:defconfig:scsi[virtio]
riscv:virt:defconfig:scsi[virtio-pci]

Boot tests crash with no useful backtrace. Bisect points to
merge ac60602a6d8f ("Merge tag 'dma-mapping-5.3-1'"). Log is at
https://kerneltests.org/builders/qemu-riscv64-master/builds/238/steps/qemubuildcommand_1/logs/stdio

ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112
ppc64:pseries:pseries_defconfig:sata-sii3112
ppc64:pseries:pseries_defconfig:little:sata-sii3112
ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112

ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: READ DMA

and many similar errors. Boot ultimately times out. Bisect points to merge
f65420df914a ("Merge tag 'scsi-fixes'").

Logs:
https://kerneltests.org/builders/qemu-ppc64-master/builds/1212/steps/qemubuildcommand/logs/stdio
https://kerneltests.org/builders/qemu-ppc-master/builds/1255/steps/qemubuildcommand/logs/stdio

Guenter

---
riscv bisect log

# bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
# good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take the DMA max mapping size into account
git bisect start 'HEAD' 'bdd17bdef7d8'
# good: [237f83dfbe668443b5e31c3c7576125871cca674] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 237f83dfbe668443b5e31c3c7576125871cca674
# good: [be8454afc50f43016ca8b6130d9673bdd0bd56ec] Merge tag 'drm-next-2019-07-16' of git://anongit.freedesktop.org/drm/drm
git bisect good be8454afc50f43016ca8b6130d9673bdd0bd56ec
# good: [d4df33b0e9925c158b313a586fb1557cf29cfdf4] Merge branch 'for-linus-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb
git bisect good d4df33b0e9925c158b313a586fb1557cf29cfdf4
# good: [f90b8fda3a9d72a9422ea80ae95843697f94ea4a] ARM: dts: gemini: Set DIR-685 SPI CS as active low
git bisect good f90b8fda3a9d72a9422ea80ae95843697f94ea4a
# good: [31cc088a4f5d83481c6f5041bd6eb06115b974af] Merge tag 'drm-next-2019-07-19' of git://anongit.freedesktop.org/drm/drm
git bisect good 31cc088a4f5d83481c6f5041bd6eb06115b974af
# good: [ad21a4ce040cc41b4a085417169b558e86af56b7] dt-bindings: pinctrl: aspeed: Fix 'compatible' schema errors
git bisect good ad21a4ce040cc41b4a085417169b558e86af56b7
# good: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch 'core-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good e6023adc5c6af79ac8ac5b17939f58091fa0d870
# bad: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge tag 'dma-mapping-5.3-1' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad ac60602a6d8f6830dee89f4b87ee005f62eb7171
# good: [6e67d77d673d785631b0c52314b60d3c68ebe809] perf vendor events s390: Add JSON files for machine type 8561
git bisect good 6e67d77d673d785631b0c52314b60d3c68ebe809
# good: [a0d14b8909de55139b8702fe0c7e80b69763dcfb] x86/mm, tracing: Fix CR2 corruption
git bisect good a0d14b8909de55139b8702fe0c7e80b69763dcfb
# good: [6879298bd0673840cadd1fb36d7225485504ceb4] x86/entry/64: Prevent clobbering of saved CR2 value
git bisect good 6879298bd0673840cadd1fb36d7225485504ceb4
# good: [449fa54d6815be8c2c1f68fa9dbbae9384a7c03e] dma-direct: correct the physical addr in dma_direct_sync_sg_for_cpu/device
git bisect good 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e
# good: [e0c5c5e308ee9b3548844f0d88da937782b895ef] Merge tag 'perf-core-for-mingo-5.3-20190715' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent
git bisect good e0c5c5e308ee9b3548844f0d88da937782b895ef
# good: [c6dd78fcb8eefa15dd861889e0f59d301cb5230c] Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good c6dd78fcb8eefa15dd861889e0f59d301cb5230c
# first bad commit: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge tag 'dma-mapping-5.3-1' of git://git.infradead.org/users/hch/dma-mapping

---------
ppc/ppc64 bisect log

# bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
# good: [abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe] Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect start 'HEAD' 'abdfd52a295f'
# bad: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch 'core-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad e6023adc5c6af79ac8ac5b17939f58091fa0d870
# bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad f65420df914a85e33b2c8b1cab310858b2abb7c0
# good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-v5.3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect good 168c79971b4a7be7011e73bf488b740a8e1135c8
# good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix request object use-after-free in send path causing wrong traces
git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
# good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take the DMA max mapping size into account
git bisect good bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
# good: [09a4460ba4434ef0327cd26bf25f2d7afb973251] scsi: IB/iser: set virt_boundary_mask in the scsi host
git bisect good 09a4460ba4434ef0327cd26bf25f2d7afb973251
# good: [ce0ad853109733d772d26224297fda0de313bf13] scsi: mpt3sas: set an unlimited max_segment_size for SAS 3.0 HBAs
git bisect good ce0ad853109733d772d26224297fda0de313bf13
# good: [07d9aa14346489d6facae5777ceb267a1dcadbc5] scsi: megaraid_sas: set an unlimited max_segment_size
git bisect good 07d9aa14346489d6facae5777ceb267a1dcadbc5
# first bad commit: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
