Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A399C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D10F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1DRnInwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfENNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:55:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfENNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G0/DILI4wkOiw0LuliWfazXXTvrDz4ftCgzuBreF1sQ=; b=1DRnInwgvj+iNHw6Gr88x+s4w
        82Pc8nh6RGS9QpdafhL5U+kM2/CccUeFd8pX4JQpTGMg3RQ+qBJRmTHisTHwQW1r0sV8qhr+9OX/D
        20tjKVQTxzOnRQT+V3XPU01UwGDrdBZjEykkX4gdGNVXjBdaaNLpl8rmM4gB8Kqs9BlXBhhhT4V67
        Trp7Wy2L9AKmKlu659n6NZXqzXMTeB9MNbfzAVhy8ioJlDkfL27nvJPzfbskhIuXwHMqLnDKYK8io
        rbyh8SgUxefff4kBgBOZJjvj9zw47SP2Hf3pn9b4uaY5w+PiajAGrcWUACcr6oS+jZrSvehx48gnv
        nysTih1Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQXtS-0008AG-4C; Tue, 14 May 2019 13:54:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E3722029FD7A; Tue, 14 May 2019 15:54:56 +0200 (CEST)
Date:   Tue, 14 May 2019 15:54:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        j-nomura@ce.jp.nec.com, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514135456.GS2589@hirez.programming.kicks-ass.net>
References: <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 08:58:35PM +0800, Dave Young wrote:

> Hmm, it seems caused by some WIP branch patches, I suspect below:

Grmbl.. Ingo, can you zap all those WIP branches, please? They mostly
just get in the way of things. If you want to run them, merge them in a
private branch or something.

> commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
> x86/paravirt: Standardize 'insn_buff' variable names
> 
> The suspicious line is "per_cpu(insn_buff, cpu) = insn_buff;"

Yah, unfortunatly per-cpu variables live in the same namespace as normal
variables and so the above is incorrect, because the local @insn_buffer
variable shadows the global per-cpu symbol and very weird things will
happen.

This is of course consistent with C rules, where everything lives in the
same namespace...
