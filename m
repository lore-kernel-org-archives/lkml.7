Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978822054F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfCZMqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCZMqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB6EC30BC653;
        Tue, 26 Mar 2019 12:46:18 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7195E83879;
        Tue, 26 Mar 2019 12:46:15 +0000 (UTC)
Date:   Tue, 26 Mar 2019 20:46:11 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190326124611.GA8143@dhcp-128-65.nay.redhat.com>
References: <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Mar 2019 12:46:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 11:10pm, Junichi Nomura wrote:
> On 3/25/19 9:32 PM, Borislav Petkov wrote:
> > On Mon, Mar 25, 2019 at 08:23:02PM +0800, Dave Young wrote:
> >> Kexec saved the original physical addresses, and pass them to kexeced
> >> kernel via x86 setup_data, so  both the early parsing or efi init code
> >> need to get those physical values from setup_data.
> > 
> > So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> > least the loop towards the end gets carved out into a separate function
> > - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> > size as arguments and finds the RSDP address in the kexec-ed kernel.
> 
> Since we still need to read systab for nr_tables and do signature
> check to determine if it's 32bit or 64bit for kexec-ed kernel,
> everything except the address of config_tables are common between
> normal boot and kexec boot.

Hmm, the efi/kexec support only added for 64bit, so no need check 32bit for
kexec.

Thanks
Dave
