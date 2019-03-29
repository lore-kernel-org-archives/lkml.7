Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7130206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfC2Jo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:44:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47223 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728415AbfC2Jo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:44:59 -0400
X-IronPort-AV: E=Sophos;i="5.60,284,1549900800"; 
   d="scan'208";a="57997071"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Mar 2019 17:44:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0362D4CD6144;
        Fri, 29 Mar 2019 17:44:58 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 29 Mar 2019 17:44:58 +0800
Date:   Fri, 29 Mar 2019 17:44:09 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329094409.GM4234@localhost.localdomain>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
 <20190329090550.GI4234@localhost.localdomain>
 <20190329091605.GB21152@zn.tnic>
 <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0362D4CD6144.AC918
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:37:00AM +0000, Junichi Nomura wrote:
>On 3/29/19 6:16 PM, Borislav Petkov wrote:
>> On Fri, Mar 29, 2019 at 05:05:50PM +0800, Chao Fan wrote:
>>> But in my code, I am not sure which version will be found firstly, so I
>>> write this logical, if ACPI20 found, return directly, then consider ACPI 1.0.
>> 
>> Thanks.
>> 
>> Junichi, please add a shorter version of that as a comment to the code,
>> above the function name so that it is clear why we're preferring the 2.0
>> version.
>
>Sure, I'll add this above __efi_get_rsdp_addr().
>
>/*
> * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> * ACPI_TABLE_GUID are found, take the former, which has more features.
> */
>

I notice in my host machine, the two tables are the same:
[17:38:11] cfan@localhost /home/cfan (0)
> sudo cat /sys/firmware/efi/systab
[sudo] password for cfan:
MPS=0xfd420
ACPI20=0xdb807000
ACPI=0xdb807000
SMBIOS=0xf04c0

But in my qemu guest, they are different and the address of ACPI20 is
higher than ACPI 1.0:
[root@localhost ~]# cat /sys/firmware/efi/systab
ACPI20=0xbfbfa014
ACPI=0xbfbfa000
SMBIOS=0xbfbcc000

In this condition, ACPI 1.0 comes before ACPI 2.0. So I suggested you
to keep this logical.

Thanks,
Chao Fan

>-- 
>Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
>


