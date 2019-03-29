Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F2EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92200206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfC2DxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfC2DxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8EEDDC905;
        Fri, 29 Mar 2019 03:52:59 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3285C1B466;
        Fri, 29 Mar 2019 03:52:56 +0000 (UTC)
Date:   Fri, 29 Mar 2019 11:52:54 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329035254.GD1877@MiWiFi-R3L-srv>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328231100.GC1877@MiWiFi-R3L-srv>
 <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9b7ab0-c9c4-a0b8-f4b7-709e597c6f0b@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 29 Mar 2019 03:52:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/19 at 03:34am, Junichi Nomura wrote:
> On 3/29/19 8:11 AM, bhe@redhat.com wrote:
> > On 03/28/19 at 07:43am, Junichi Nomura wrote:
> >>  /* Search EFI system tables for RSDP. */
> >> -static acpi_physical_address efi_get_rsdp_addr(void)
> >> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)
> > 
> > Here parameter 'size' and 'efi_64' seems a little duplicated on
> > functionality. Only passing efi_64 can deduce the size? Personal
> > opinion.
> 
> Yes. But I'm not sure which is preferred.
> 
> The current code is:
> 

I would like to change them like below two cases. I personally prefer
the 2nd one. Feel free to take one you like better.

1)
 __efi_get_rsdp_addr() {

	size = efi_64 ? sizeof(efi_config_table_64_t):sizeof(efi_config_table_32_t);;

Or if/else sytle.

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
 
2)
 __efi_get_rsdp_addr() {
         for (i = 0; i < nr_tables; i++) {
                 if (efi_64) {
			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
                         // get guid and table
                 } else {
			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
                         // get guid and table
                 }
                 // check guid and return table if it's valid
         }
 }
> 
> Or we could create 2 functions, __efi_get_rsdp_addr32() and __efi_get_rsdp_addr64(),
> and let efi_get_rsdp_addr() to choose which one to use based on signature.
> 
> > It might be worth adding code comments here to tell why we only care
> > about 64bit kexec booting?
> 
> I think so. I'll add a comment.
> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
