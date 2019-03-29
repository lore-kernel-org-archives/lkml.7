Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B676C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B632082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfC2JVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:21:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48680 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728676AbfC2JVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:21:00 -0400
X-IronPort-AV: E=Sophos;i="5.60,283,1549900800"; 
   d="scan'208";a="57995378"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Mar 2019 17:20:59 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B9F774CD615E;
        Fri, 29 Mar 2019 17:20:55 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 29 Mar 2019 17:20:55 +0800
Date:   Fri, 29 Mar 2019 17:20:01 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
CC:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190329092001.GK4234@localhost.localdomain>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
 <20190329082929.GH4234@localhost.localdomain>
 <20190329091655.GE7627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190329091655.GE7627@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: B9F774CD615E.AC7C4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 05:16:55PM +0800, bhe@redhat.com wrote:
>On 03/29/19 at 04:29pm, Chao Fan wrote:
>> On Fri, Mar 29, 2019 at 07:20:38AM +0000, Junichi Nomura wrote:
>> >Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
>> >boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
>> >in the early parsing code tries to search RSDP from EFI table but
>> >that will crash because the table address is virtual when the kernel
>> >was booted by kexec.
>> [...]
>> >-			guid  = tbl->guid;
>> >-			table = tbl->table;
>> >-		}
>> >-
>> >-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>> >-			rsdp_addr = table;
>> >-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>> >-			return table;
>> >-	}
>> >+	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
>> >+#else
>> >+	return 0;
>> > #endif
>> >-	return rsdp_addr;
>> 
>> I remeber the rsdp_addr is defined before #ifdef CONFIG_EFI
>> If so, you don't need
>> #else
>> 	return 0;
>
>it doesn't change the old logic. Junichi moved rsdp_addr definition inside
>the CONFIG_EFI iedeffery block.

Yes, got it. Thanks for your explain.

Thanks,
Chao Fan
>> 
>> BY the way, what's your patch based on? I like add patch on my local
>> branch and then review code, but failed.
>> I try to use 'patch -p1 <' your patch to the latest tip master branch,
>> but failed.
>> 
>> Thanks,
>> Chao Fan
>> 
>> > }
>> > 
>> > static u8 compute_checksum(u8 *buffer, u32 length)
>> >@@ -221,6 +284,9 @@ acpi_physical_address get_rsdp_addr(void)
>> > 		pa = boot_params->acpi_rsdp_addr;
>> > 
>> > 	if (!pa)
>> >+		pa = kexec_get_rsdp_addr();
>> >+
>> >+	if (!pa)
>> > 		pa = efi_get_rsdp_addr();
>> > 
>> > 	if (!pa)
>> >
>> >
>> 
>> 
>
>


