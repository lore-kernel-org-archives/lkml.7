Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F434C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68F020714
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jsczJLCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKWC5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:57:30 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46406 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWC5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:57:30 -0500
Received: by mail-il1-f196.google.com with SMTP id q1so9038827ile.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yH4Y/VZBJNypI69fryRWHnM3YvLC5pprHhmD6xuLHHY=;
        b=jsczJLCKJeiUOE0FeT5APJ0lVv+av3CejiFSaMmNxx+LsgmHoO3KGk4ReoBi5gyl1f
         NQXxiuZVmj4UqhFzKKS8zkE4oDEQ4bKuw/qjCAstpPS1Y60GYq7O8yQRsxherm5aS3Gm
         8Co9yLzOIXPfHsmC9e5D8WiXqxIwLMhTsyRRagWS+lujAlCV9WBed8XLTgtGaqcsmoZW
         yIg63k1GCH+D3BdqUhhNWKbY0fmYFTAKfm9TTDzCDKeN5yPXHIQOhqQWo3Vn03zWcYff
         4gokQnx5rHFCIt0ldEW3XxWB/UsVDV1T/lYI0ts/r8SiwP8ElnolFikRqtJUQkGTyCFq
         NuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yH4Y/VZBJNypI69fryRWHnM3YvLC5pprHhmD6xuLHHY=;
        b=eo9BnVHgMA5b65KoKZwbfhIKHkDYpehHam+bl3i2APZrN5OkuLVm+LNC3Jl7SD8DVJ
         adwfMgrAl0yVchZxuW6Eg6UBTu2vSF6l+EhC0Ex3D+aIgJFascY1TL96pYXBCxkNtGm4
         wYhQ2MnMtjQZtHesckGpi+NUEi3RyhL8h/9PcrmZToqNm39v7Q5qOSNnLquno+PGZBw9
         uipkqyadG/CpgmtnMljE+CFCw/LOnYE96HewjoBZ0dlNm/pSemVVAm0yiQCV6TZLZdB7
         Q99q7nqzt+w7wsi8cuzYzhl7flVsSdqhS40ChtcYDXJ0sVjwd0pOFNacIdslmQG5xJmG
         IRyQ==
X-Gm-Message-State: APjAAAUPqMthuJAAN+Ii1zA5AK5F3Z74tYR+rI2B41fqOvBpu21FvA1h
        2lWPmdSMnKzXTlx9s0xLMGx5Bw==
X-Google-Smtp-Source: APXvYqyUPZmbBKkTYRnzFl7gku7LXrzHzXLv8sJNM2GLB9CL9PL9p/dGxPHeK++UIo0GACZBjpuKVQ==
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr3671456ilq.282.1574477849400;
        Fri, 22 Nov 2019 18:57:29 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d23sm2823667iom.55.2019.11.22.18.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 18:57:28 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:57:27 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH v2] RISC-V: Add address map dumper
In-Reply-To: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911221855090.14532@viisi.sifive.com>
References: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yash,

On Mon, 18 Nov 2019, Yash Shah wrote:

> Add support for dumping the kernel address space layout to the console.
> User can enable CONFIG_DEBUG_VM to dump the virtual memory region into
> dmesg buffer during boot-up.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, I've queued up the following patch.  I added the PCI I/O region,
and also dropped some of the .init/.text/etc. prints since they duplicate 
the output from mem_init_print_info().


- Paul

From: Yash Shah <yash.shah@sifive.com>
Date: Mon, 18 Nov 2019 05:58:34 +0000
Subject: [PATCH] RISC-V: Add address map dumper

Add support for dumping the kernel address space layout to the console.
User can enable CONFIG_DEBUG_VM to dump the virtual memory region into
dmesg buffer during boot-up.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
[paul.walmsley@sifive.com: dropped .init/.text/.data/.bss prints;
 added PCI legacy I/O region display]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/mm/init.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 573463d1c799..c2c0e244555f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -45,6 +45,37 @@ void setup_zero_page(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
 
+#ifdef CONFIG_DEBUG_VM
+static inline void print_mlk(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
+		  (((t) - (b)) >> 10));
+}
+
+static inline void print_mlm(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
+		  (((t) - (b)) >> 20));
+}
+
+static void print_vm_layout(void)
+{
+	pr_notice("Virtual kernel memory layout:\n");
+	print_mlk("fixmap", (unsigned long)FIXADDR_START,
+		  (unsigned long)FIXADDR_TOP);
+	print_mlm("pci io", (unsigned long)PCI_IO_START,
+		  (unsigned long)PCI_IO_END);
+	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
+		  (unsigned long)VMEMMAP_END);
+	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
+		  (unsigned long)VMALLOC_END);
+	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
+		  (unsigned long)high_memory);
+}
+#else
+static void print_vm_layout(void) { }
+#endif /* CONFIG_DEBUG_VM */
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_FLATMEM
@@ -55,6 +86,7 @@ void __init mem_init(void)
 	memblock_free_all();
 
 	mem_init_print_info(NULL);
+	print_vm_layout();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
2.24.0.rc0

