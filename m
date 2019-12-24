Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1366C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B262D20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="JuSs0+9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLXA0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:26:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45666 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXA0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:26:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so9916431pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 16:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qy1djmafina09Wk+tvxb8eHELyj8veiP7NWYiOp28HE=;
        b=JuSs0+9TTFciYyeSdgEJZmy6i1PQkY8Z7m1fk+cugf1/N5gw+Bqpl10Z8kw28+fHu4
         iGj0HaYc9WlCAs3C3U0dbFh28vFsmj9KWI+M5fo+ZVKhFx3chicHBmnb5yYErxXfgOc/
         6snM0TpoxGIOJBm+27fgKzfacZoXkniAfBy84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qy1djmafina09Wk+tvxb8eHELyj8veiP7NWYiOp28HE=;
        b=RW29OeRKWXDd03fux0SQApJPbcBuWIP1c66DR8uo2VHzSi19PhFHsAMTXEbbUFLFbS
         dgF+y0N2UHSEGWEbpnnmd9qKRn3sx9N52sOEFqZ8LA6V2G1hgySBcR71ugKpG+UQ2Bku
         lVXlKjfxX3rhq4GqMO+S4IaldQVA3PbVRHaSGurybdMuSyFgkDSydesSzz7Ngo59i6iT
         0ePngUcslEHrgO9hMU4VQoN71hkxIj74BdPdRAELmrH3KgzmJfu4sQ9voSUPd47sgwyt
         w3z3cluWLVEGk9RvkTPIRJIkRWQNOFHGL37NcPDDb7GL3/KQiODDIOnrgSpELWkiN5Hx
         lNyA==
X-Gm-Message-State: APjAAAVCL93uRCTcWzZQHZnXt2WDQvCcRgpI7uYj/+WpQRVI2Bm2VTqh
        K04IBNDFOaxTk+8Ay2ibZGQAz4AGILk=
X-Google-Smtp-Source: APXvYqxuLAAFeBAxttugpfL86SnEnhyy6j+VI8Djf9c+j5lCoGXK4k6kRel8bR8UP14ADxXvvm0muA==
X-Received: by 2002:a63:2063:: with SMTP id r35mr33946563pgm.69.1577147174351;
        Mon, 23 Dec 2019 16:26:14 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b05d-cbfe-b2ee-de17.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b05d:cbfe:b2ee:de17])
        by smtp.gmail.com with ESMTPSA id bo19sm655572pjb.25.2019.12.23.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 16:26:13 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akash.goel@intel.com, ajd@linux.ibm.com,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: Re: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
In-Reply-To: <20191223163610.GA32267@roeck-us.net>
References: <20191129013745.7168-1-dja@axtens.net> <20191223163610.GA32267@roeck-us.net>
Date:   Tue, 24 Dec 2019 11:26:09 +1100
Message-ID: <87woamsh5q.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Fri, Nov 29, 2019 at 12:37:45PM +1100, Daniel Axtens wrote:
>> alloc_percpu() may return NULL, which means chan->buf may be set to
>> NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
>> dereference an invalid pointer:
>> 
>> BUG: Unable to handle kernel data access at 0x7dae0000
>> Faulting instruction address: 0xc0000000003f3fec
>> ...
>> NIP [c0000000003f3fec] relay_open+0x29c/0x600
>> LR [c0000000003f3fc0] relay_open+0x270/0x600
>> Call Trace:
>> [c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
>> [c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
>> [c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
>> [c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
>> [c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
>> [c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
>> [c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
>> [c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68
>> 
>> Check if alloc_percpu returns NULL. Because we can readily catch and
>> handle this situation, switch to alloc_cpu_gfp and pass in __GFP_NOWARN.
>> 
>> This was found by syzkaller both on x86 and powerpc, and the reproducer
>> it found on powerpc is capable of hitting the issue as an unprivileged
>> user.
>> 
>> Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
>> Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
>> Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
>> Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
>> Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
>> Cc: Akash Goel <akash.goel@intel.com>
>> Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
>> Cc: stable@vger.kernel.org # v4.10+
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> 
>
> So there is a CVE now, but it appears that the patch went nowhere.
> Are there any plans to actually apply it ?

I sent a v2 that addresses some review comments, I guess if anything is
applied it will be that.

Daniel

>
> Thanks,
> Guenter
>
>> --
>> 
>> There's a syz reproducer on the powerpc syzbot that eventually hits
>> the bug, but it can take up to an hour or so before it keels over on a
>> kernel with all the syzkaller debugging on, and even longer on a
>> production kernel. I have been able to reproduce it once on a stock
>> Ubuntu 5.0 ppc64le kernel.
>> 
>> I will ask MITRE for a CVE - while only the process doing the syscall
>> gets killed, it gets killed while holding the relay_channels_mutex,
>> so it blocks all future relay activity.
>> ---
>>  kernel/relay.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/relay.c b/kernel/relay.c
>> index ade14fb7ce2e..a376cc6b54ec 100644
>> --- a/kernel/relay.c
>> +++ b/kernel/relay.c
>> @@ -580,7 +580,13 @@ struct rchan *relay_open(const char *base_filename,
>>  	if (!chan)
>>  		return NULL;
>>  
>> -	chan->buf = alloc_percpu(struct rchan_buf *);
>> +	chan->buf = alloc_percpu_gfp(struct rchan_buf *,
>> +				     GFP_KERNEL | __GFP_NOWARN);
>> +	if (!chan->buf) {
>> +		kfree(chan);
>> +		return NULL;
>> +	}
>> +
>>  	chan->version = RELAYFS_CHANNEL_VERSION;
>>  	chan->n_subbufs = n_subbufs;
>>  	chan->subbuf_size = subbuf_size;
>> -- 
>> 2.20.1
>> 
