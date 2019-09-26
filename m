Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF433C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BC120872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZC9kY2bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfIZKXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:23:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36661 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfIZKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:23:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so1481985edn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deEz9tMzonqfhnmc0RaDlD4PfMHCEzCyrmdaULw9mu4=;
        b=ZC9kY2bIAj3PD5PJpJIp+G2bQjXBow7fayeVI60CMCgz84TVlaspcDrzF6FlxEActH
         4+PrlhH1Mo28OkVBrqg7wJoa04qfDdRGX6v4CSAUBCkKBJg7zIQOnBGlhbdv7gVFuDmv
         ckt62sXlHJSr+NLxgH5WQKBRxYVT2TbpPJjXvmiM0X1LpES077b3cmPh6jPKN0zGAfX+
         m1BcPvuaUKqvf5t68rNCkigPqIqsyevgAxWMPOPyGSXHNKQHVesR+1SMh3o48LOJyQTh
         amGxMYHfspXV79URGnAc3XBrLtZdUzvQB+ew5kxUKcbwNVPTpVfFNvHDwDPIeuMSAvV6
         fhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deEz9tMzonqfhnmc0RaDlD4PfMHCEzCyrmdaULw9mu4=;
        b=ZIcs0z6whpGrOwKfEvJE7HfpWEz2V4ySkZZWCxW5iU3XV+pxiityGgaGBcCa/RaH61
         p5J5ssZ7NtIp8nFyz6+Su6IGT/IxfJgt1wDBoU4j2YIzrDn79vqpomVqIyY4qmp5I5Eq
         dgQ6YQY38u5IMcsaqia3CEStQAzooBBGPxh2xK7u3LwBT7DFpBCSgmvI14+nuaDslA58
         TqAc6zda8IX0Q5+EDnpJdhnRg0XZ5OM9Z2ZK42ev6Rk57ZFUAgw4bM4UFbDEtJjIFwDZ
         qAchYwb4LF4p/7goBDmmPr0BKX5jbFIRjbqj88aLWcS8Q8DWlGSGj6kpLHYznknLWgCy
         CUew==
X-Gm-Message-State: APjAAAXL7T5Owc6K8RH+BmjwsMj4tF64eDFRvVnvCh7vUq5MdxBnEwQR
        wIp30QW7Tz49mgNTSJXLBGejG9Ou5vjMIg==
X-Google-Smtp-Source: APXvYqzgrBN9LzGt7OMtWxFWdQ0krLOmmmrWMSfD3BC85BRF3kICNTLqrR4sqvUXoiZEcwE6u6CA1g==
X-Received: by 2002:a50:9a05:: with SMTP id o5mr2737318edb.44.1569493379879;
        Thu, 26 Sep 2019 03:22:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id jp14sm184567ejb.60.2019.09.26.03.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:22:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ED4591004E0; Thu, 26 Sep 2019 13:23:01 +0300 (+03)
Date:   Thu, 26 Sep 2019 13:23:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH v3 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190926102301.u6fn4b7l7aevnlbq@box>
References: <cover.1569358538.git.steve.wahl@hpe.com>
 <9c011ee51b081534a7a15065b1681d200298b530.1569358539.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c011ee51b081534a7a15065b1681d200298b530.1569358539.git.steve.wahl@hpe.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:03:55PM -0500, Steve Wahl wrote:
> Our hardware (UV aka Superdome Flex) has address ranges marked
> reserved by the BIOS. Access to these ranges is caught as an error,
> causing the BIOS to halt the system.
> 
> Initial page tables mapped a large range of physical addresses that
> were not checked against the list of BIOS reserved addresses, and
> sometimes included reserved addresses in part of the mapped range.
> Including the reserved range in the map allowed processor speculative
> accesses to the reserved range, triggering a BIOS halt.
> 
> Used early in booting, the page table level2_kernel_pgt addresses 1
> GiB divided into 2 MiB pages, and it was set up to linearly map a full
> 1 GiB of physical addresses that included the physical address range
> of the kernel image, as chosen by KASLR.  But this also included a
> large range of unused addresses on either side of the kernel image.
> And unlike the kernel image's physical address range, this extra
> mapped space was not checked against the BIOS tables of usable RAM
> addresses.  So there were times when the addresses chosen by KASLR
> would result in processor accessible mappings of BIOS reserved
> physical addresses.
> 
> The kernel code did not directly access any of this extra mapped
> space, but having it mapped allowed the processor to issue speculative
> accesses into reserved memory, causing system halts.
> 
> This was encountered somewhat rarely on a normal system boot, and much
> more often when starting the crash kernel if "crashkernel=512M,high"
> was specified on the command line (this heavily restricts the physical
> address of the crash kernel, in our case usually within 1 GiB of
> reserved space).
> 
> The solution is to invalidate the pages of this table outside the
> kernel image's space before the page table is activated.  This patch
> has been validated to fix this problem on our hardware.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Cc: stable@vger.kernel.org

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
