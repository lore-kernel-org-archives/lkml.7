Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABAC206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfC2FRm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:17:42 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:40475 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfC2FRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:17:41 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T5Gvd0016662
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 14:16:57 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T5GvXV019155;
        Fri, 29 Mar 2019 14:16:57 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T5EJHc009525;
        Fri, 29 Mar 2019 14:16:57 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3798555; Fri, 29 Mar 2019 14:16:44 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 14:16:43 +0900
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
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXaYgAhGAgAAQvICAAQMcAIAASZeAgAAFLACAABdqAA==
Date:   Fri, 29 Mar 2019 05:16:42 +0000
Message-ID: <470e9a92-8433-f2a3-be0a-8306dcf50a73@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328231100.GC1877@MiWiFi-R3L-srv>
 <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
 <20190329035254.GD1877@MiWiFi-R3L-srv>
In-Reply-To: <20190329035254.GD1877@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6DD88A3FFA7E5049ACA55F86D24F606B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 12:52 PM, bhe@redhat.com wrote:
> 2)
>  __efi_get_rsdp_addr() {
>          for (i = 0; i < nr_tables; i++) {
>                  if (efi_64) {
> 			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
>                          // get guid and table
>                  } else {
> 			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
>                          // get guid and table
>                  }
>                  // check guid and return table if it's valid
>          }
>  }

Thanks. This looks nice and doesn't conflict the direction of refactoring, I think.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
