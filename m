Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BF0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70FC20830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571644563;
	bh=+XQE8A9wIYwpjV4Pzh2sw12sAoRdjp0Ts3qMw90uZvk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=hovezHvakqOP13Xx8lUNwvzPPTnyUJoGx7r1MNgVOjvgcsdIZ79h8oUtVuHSx5fwV
	 T1bjcunk8xsVhXk0NNppvq5OY2tIgyYZZPbSnQsCN+OBc5UBwUM5VQJHpAkAyO1ygz
	 Q7xWNiCjvKEI9jYBYb07xDhGzPqYGfF2v7K8K6n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfJUH4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:56:02 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:47068 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbfJUH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:56:01 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iMSXe-0007gc-Fy; Mon, 21 Oct 2019 09:55:50 +0200
To:     =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
Subject: Re: [PATCH v6 10/10] arm64: Retrieve stolen time as paravirtualized  guest
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 21 Oct 2019 08:55:50 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <237a3457-bcb3-c9b7-11ef-241b7ccc370e@suse.com>
References: <20191011125930.40834-1-steven.price@arm.com>
 <20191011125930.40834-11-steven.price@arm.com>
 <86a79wzdhk.wl-maz@kernel.org>
 <237a3457-bcb3-c9b7-11ef-241b7ccc370e@suse.com>
Message-ID: <e8fa44e1e6bcb58ea07b5064ed40e088@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: jgross@suse.com, steven.price@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, pbonzini@redhat.com, rkrcmar@redhat.com, linux@armlinux.org.uk, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, mark.rutland@arm.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-21 06:01, Jürgen Groß wrote:
> On 19.10.19 22:28, Marc Zyngier wrote:

>> How about something like pv_time_init() instead? In the guest, this 
>> is
>> no way KVM specific, and I still hope for this to work on things 
>> like
>> Xen/HyperV/VMware (yeah, I'm foolishly optimistic). All the 
>> references
>> to KVM should go, and be replaced by something more generic (after
>> all, you're only implementing the spec, so feel free to call it
>> den0057_* if you really want).
>
> Xen guests already have the needed functionality. On ARM this just 
> needs
> to be hooked up.

Yes, Xen offers its own PV interface for that. But this code is about
implementing support for a cross hypervisor functionnality (which 
AFAICT
is not implemented by Xen).

         M.
-- 
Jazz is not dead. It just smells funny...
