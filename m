Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B5EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A3020645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfDSTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfDSTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8088B3003737;
        Fri, 19 Apr 2019 10:50:20 +0000 (UTC)
Received: from localhost (ovpn-12-186.pek2.redhat.com [10.72.12.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6875D9C5;
        Fri, 19 Apr 2019 10:50:17 +0000 (UTC)
Date:   Fri, 19 Apr 2019 18:50:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419105014.GE11060@MiWiFi-R3L-srv>
References: <20190419101733.GA10324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419101733.GA10324@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 19 Apr 2019 10:50:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/19 at 12:17pm, Borislav Petkov wrote:
> Breaking thread because this one got too big.
> 
> On Fri, Apr 19, 2019 at 04:34:58PM +0800, Kairui Song wrote:
> > There are two approach to fix it, detect if the systab is mapped, and
> > avoid reading it if not.
> 
> Ok, so tglx and I discussed this situation which is slowly getting out
> of hand with all the tinkering.
> 
> So, here's what we should do - scream loudly now if some of this doesn't
> make any sense.
> 
> 1. Junichi's patch should get the systab check above added and sent to
> 5.1 so that at least some EFI kexecing can work with 5.1

Talked with Kairui privately just now. Seems Junichi's patch need add
this systab mapping. Since the systab region is not mapped on some
machines. Those machine don't have this issue because they got systab
region luckily coverred by 1 GB page mapping in 1st kernel before
kexec jumping. 

This issue should happen whether it is KASLR kernel or not KASLR kernel.

> 
> 2. Then, the fact whether the kernel has been kexec'ed and which
> addresses it should use early, should all be passed through boot_params
> which is either setup by kexec(1) or by the first kernel itself, in the
> kexec_file_load() case.

Seems no better way to check if it's kexec-ed kernel, except of the
setup data checking of kexec-ed kernel.

It may happen in both kexec_load or kexec_file_load, since we build
ident mapping of kexec for RAM in 1st kernel.

> 
> > the systab region is not mapped by the identity mapping provided by
> > kexec.
> 
> 3. Then that needs to be fixed in the first kernel as it is a
> shortcoming of us starting to parse systab very early. It is the kexec
> setup code's problem not the early compressed stage's problem that the
> EFI systab is not mapped.

Yeah, adding the systab mapping looks good. Kairui put it in
decompressing stage just because he wants to cover the case in which the
old kernel kexec jumping to 2nd kernel. Now it seems not very
reasonable, we also have the new kernel kexec jumping to old 2nd kernel.

Thanks
Baoquan
