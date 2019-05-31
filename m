Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6CD26E24
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfEaS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:57:20 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:49419 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbfEaS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:57:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 12990181D3377;
        Fri, 31 May 2019 18:57:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sugar66_548a73896a2d
X-Filterd-Recvd-Size: 2569
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 18:57:16 +0000 (UTC)
Message-ID: <53e1591ef288135f1dd803c15e971c96d06f54ba.camel@perches.com>
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: remove the trailing newline used in
 the fmt parameter of TP_printk
From:   Joe Perches <joe@perches.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri, 31 May 2019 11:57:04 -0700
In-Reply-To: <1559284814-20378-2-git-send-email-wanpengli@tencent.com>
References: <1559284814-20378-1-git-send-email-wanpengli@tencent.com>
         <1559284814-20378-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 14:40 +0800, Wanpeng Li wrote:
> The trailing newlines will lead to extra newlines in the trace file
[]
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
[]
> @@ -1365,7 +1365,7 @@ TRACE_EVENT(kvm_hv_timer_state,
>  			__entry->vcpu_id = vcpu_id;
>  			__entry->hv_timer_in_use = hv_timer_in_use;
>  			),
> -		TP_printk("vcpu_id %x hv_timer %x\n",
> +		TP_printk("vcpu_id %x hv_timer %x",
>  			__entry->vcpu_id,
>  			__entry->hv_timer_in_use)
>  );

Not about the kvm subsystem, but generically there are
many of these that could be removed.

$ git grep -w TP_printk | grep '\\n' | wc -l
45

Also, aren't all TP_printk formats supposed to be single line?

If not, these are odd as well.

$ git grep -w TP_printk | grep '\\n[^"]'
include/trace/events/9p.h:	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
net/tipc/trace.h:	TP_printk("%s\n%s", __get_str(header), __get_str(buf))
net/tipc/trace.h:	TP_printk("%s\n%s", __get_str(header), __get_str(buf))
net/tipc/trace.h:	TP_printk("<%u> %s\n%s%s", __entry->portid, __get_str(header),
net/tipc/trace.h:	TP_printk("<%s> %s\n%s", __entry->name, __get_str(header),
net/tipc/trace.h:	TP_printk("<%x> %s\n%s", __entry->addr, __get_str(header),

Perhaps the documentation files around these formats
	Documentation/trace/events.rst
	Documentation/trace/tracepoints.rst
could be improved as well.


