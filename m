Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD62C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE75521871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfC2DfM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:35:12 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55886 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfC2DfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:35:12 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T3YfHq003577
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 12:34:41 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T3YfBb004327;
        Fri, 29 Mar 2019 12:34:41 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T3Yedh026395;
        Fri, 29 Mar 2019 12:34:41 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3794402; Fri, 29 Mar 2019 12:34:25 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 12:34:24 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXaYgAhGAgAAQvICAAQMcAIAASZeA
Date:   Fri, 29 Mar 2019 03:34:23 +0000
Message-ID: <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
References: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328231100.GC1877@MiWiFi-R3L-srv>
In-Reply-To: <20190328231100.GC1877@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D3C9A209FE012442A5C6D247E7BC8566@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 8:11 AM, bhe@redhat.com wrote:
> On 03/28/19 at 07:43am, Junichi Nomura wrote:
>>  /* Search EFI system tables for RSDP. */
>> -static acpi_physical_address efi_get_rsdp_addr(void)
>> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)
> 
> Here parameter 'size' and 'efi_64' seems a little duplicated on
> functionality. Only passing efi_64 can deduce the size? Personal
> opinion.

Yes. But I'm not sure which is preferred.

The current code is:

__efi_get_rsdp_addr() {
        for (i = 0; i < nr_tables; i++) {
                config_tables += size;
                if (efi_64) {
                        efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
                        // get guid and table
                } else {
                        efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
                        // get guid and table
                }
                // check guid and return table if it's valid
        }
}

If we remove "size" parameter, that will become:

__efi_get_rsdp_addr() {
        for (i = 0; i < nr_tables; i++) {
                if (efi_64) {
                        efi_config_table_64_t *tbl;
                        config_tables += sizeof(efi_config_table_64_t);
                        tbl = (efi_config_table_64_t *)config_tables;
                        // get guid and table
                } else {
                        efi_config_table_32_t *tbl;
                        config_tables += sizeof(efi_config_table_32_t);
                        tbl = (efi_config_table_32_t *)config_tables;
                        // get guid and table
                }
                // check guid and return table if it's valid
        }
}

Or we could create 2 functions, __efi_get_rsdp_addr32() and __efi_get_rsdp_addr64(),
and let efi_get_rsdp_addr() to choose which one to use based on signature.

> It might be worth adding code comments here to tell why we only care
> about 64bit kexec booting?

I think so. I'll add a comment.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
