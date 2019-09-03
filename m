Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F00C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B023401
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gUPSUA95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfICQ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:56:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:36172 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfICQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:56:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 26F0C2AE1FB;
        Tue,  3 Sep 2019 12:56:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EMmwsNPx3v05; Tue,  3 Sep 2019 12:56:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B265D2AE1EB;
        Tue,  3 Sep 2019 12:56:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B265D2AE1EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567529794;
        bh=q4PGouw16hhSu7I/frW19gghTxY/q8K3hdomrMUzH7I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gUPSUA95XcSCRCEmqkhHbq9Hq7YgJE2rOQISpXXdECzkTZerDfhjt3VlDTdpgzANu
         4u5rRK8/dLSbbvH2lgs9610QmWgSbdi5YnZV82Is39OG6ivrRc6ZLSxoIO4HBYFA4O
         HNDn9HpGKOdGJUV4xpsnuSTIUG1hYlLSdJ89MSY4EPA3+0TruPJf16p39x+Uu+iTJU
         LYT6Htq4/UptSRtSwo0jlTmzuGLmTDcHUrSDwgbSnSWJnpx7fWhMOk9eO8aju957Zm
         D6CoppR3yZQIvhjeOJLet1sGgd7VGBHCNH9Uw0d5+03T0DPSGc8q5nY8P7okO5Qil6
         IO8zabiJvITqg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4zrkHpGSwRVp; Tue,  3 Sep 2019 12:56:34 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8D8D02AE1D4;
        Tue,  3 Sep 2019 12:56:34 -0400 (EDT)
Date:   Tue, 3 Sep 2019 12:56:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1188636562.23.1567529794307.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com> <20190903160036.2400-2-mathieu.desnoyers@efficios.com> <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Fix: sched: task_rcu_dereference: check
 probe_kernel_address return value
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched: task_rcu_dereference: check probe_kernel_address return value
Thread-Index: fw8xZfbsOKtEim6qT9Y34lt2RA8vfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 12:12 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 3, 2019 at 9:00 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> probe_kernel_address can return -EFAULT on error, which leads to use of
>> an uninitialized or partially initialized sighand variable.
> 
> I think this comment and this code is actively misleading.
> 
> There is no "uninitialized or partially initialized sighand variable".
> That's completely wrong.
> 
> The sighand variable is always completely initialized. It's just that
> the check for "is it initialized" is _not_ the return value from
> probe_kernel_address(), because that return value is simply not
> sufficient.
> 
> So this is just wrong. Don't do it. You're just confusing the issue,
> and you're making statments that aren't true in the commit message,
> and making the code do a pointless and odd check.
> 
> If you want to change this code for legibility, you should just add a
> comment above the probe_kernel_address() about why the return value is
> ignored, and why the check _below_ that code verifies the value of
> sighand with a different check.

Then I must be misunderstanding something.

probe_kernel_address() is a macro wrapping probe_kernel_read().
mm/maccess.c:probe_kernel_read() calls probe_read_common()
mm/maccess.c:probe_read_common() calls __copy_from_user_inatomic()

include/linux/uaccess.h:__copy_from_user_inatomic() documents:

 * NOTE: only copy_from_user() zero-pads the destination in case of short copy.
 * Neither __copy_from_user() nor __copy_from_user_inatomic() zero anything
 * at all; their callers absolutely must check the return value.

So considering that comment, I suspect the on-stack sighand variable
within task_rcu_dereference() can be left either uninitialized or
(less likely) partially initialized if probe_kernel_address() returns
-EFAULT.

Is there anything else that prevents probe_kernel_address from failing ?
If so, why use probe_kernel_address in the first place ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
