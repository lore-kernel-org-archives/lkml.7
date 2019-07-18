Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6BC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABC52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aCFO5/rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbfGRUMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:12:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39073 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:11:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so21509859qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RJr+FUACmvGnv70xM30hcDVcxcPaOtNXnJEGvTwNgC8=;
        b=aCFO5/rQmqZ8l3TFWL9gh3TZFK5gwpB3ptJxKx0yChFW3uEmA9xh5q55h//8d7Lcmx
         gXkKQBkO8vkEP/NkUl8dopY3lP5ZXeASvwLHOhPp+Ni2vr+87gJAZz38liUBXnjbCDT/
         wb6X4Yh4U5JGEc6SX0bsXoSQp8xx3AfPdkYaMnst4ZWv0nSSt5sX708JQ0+7ZSA6E8Td
         IvTMHXLtL0SPOACrcDBlkMKuvBSAZmK5xgSmjjv5hOLQpceCsihjZnRG/Pna+oG6CG2s
         /3fq4WrSGzPAFTxSw2taUafUmcpul90yDFG/O8ejY3gAH3dHuKsdvwblGvKxhmypbWjQ
         qFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RJr+FUACmvGnv70xM30hcDVcxcPaOtNXnJEGvTwNgC8=;
        b=WwYVAIXxKkmMZ08cWxIuLPu6eKrLsUvLuDSwSrMls28OKt13LwSvq8frDcjT1D2SUa
         NCLYMgbwdpzKQ1uGZuPDnMJHNhi2ae1AqTnsjR62LdAjXdsdKuyXg/SYie9iBsncratU
         dKM1Y2MvLCWm6jY6QkfLFVIskTYZND6/cMrxmbK3rN0LdKkcUgcGffVPQK/cj3NwX4G0
         1pNHA6zM/LScNQIsCqZFrqwMJKk2Ujw/yO3+VwU2fdj57C5NewU26Q0pXil2uzVUBTzt
         TP3L77hmwEYL2mcAp+gKOy40KWvRdq2F2d8c7zdIuDOlTTKRbywlPVhSK4Os+4xkWytW
         gygw==
X-Gm-Message-State: APjAAAUcvzzYuEnIsb7heWLS6UVhKYQ8c34PQDz7W9CGPuN57G9dN25E
        r4YrvfTqasn5ojHFYVavowHB1g==
X-Google-Smtp-Source: APXvYqwNk05YWCeJ0LeQ38H+Q7a85yPjvTJ/MwbmJQDAQ+waRj9BY1mffisw3n6k81ifHI7+8RGLSA==
X-Received: by 2002:a37:bc84:: with SMTP id m126mr29582858qkf.303.1563480718412;
        Thu, 18 Jul 2019 13:11:58 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j2sm13664211qtb.89.2019.07.18.13.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 13:11:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] trace/writeback: fix Wstringop-truncation warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190716170339.1c44719d@gandalf.local.home>
Date:   Thu, 18 Jul 2019 16:11:56 -0400
Cc:     mingo@redhat.com, tj@kernel.org, dchinner@redhat.com,
        fengguang.wu@intel.com, jack@suse.cz,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB46F336-8127-4512-A6BF-C0EA7AF78CAE@lca.pw>
References: <1562948087-5374-1-git-send-email-cai@lca.pw>
 <20190716170339.1c44719d@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 16, 2019, at 5:03 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Fri, 12 Jul 2019 12:14:47 -0400
> Qian Cai <cai@lca.pw> wrote:
>=20
>> There are many of those warnings.
>>=20
>> In file included from ./arch/powerpc/include/asm/paca.h:15,
>>                 from ./arch/powerpc/include/asm/current.h:13,
>>                 from ./include/linux/thread_info.h:21,
>>                 from ./include/asm-generic/preempt.h:5,
>>                 from =
./arch/powerpc/include/generated/asm/preempt.h:1,
>>                 from ./include/linux/preempt.h:78,
>>                 from ./include/linux/spinlock.h:51,
>>                 from fs/fs-writeback.c:19:
>> In function 'strncpy',
>>    inlined from 'perf_trace_writeback_page_template' at
>> ./include/trace/events/writeback.h:56:1:
>> ./include/linux/string.h:260:9: warning: '__builtin_strncpy' =
specified
>> bound 32 equals destination size [-Wstringop-truncation]
>>  return __builtin_strncpy(p, q, size);
>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>> Fix it by using strlcpy() which will always be NUL-terminated instead =
of
>> strncpy(). strlcpy() has already been used at some places in this =
file.
>>=20
>> Fixes: 455b2864686d ("writeback: Initial tracing support")
>> Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
>> Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
>> Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
>> Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to =
writeback_sb_inodes()")
>> Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> include/trace/events/writeback.h | 20 ++++++++++----------
>> 1 file changed, 10 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/include/trace/events/writeback.h =
b/include/trace/events/writeback.h
>> index aa7f3aeac740..8e3b3c4fd964 100644
>> --- a/include/trace/events/writeback.h
>> +++ b/include/trace/events/writeback.h
>> @@ -66,7 +66,7 @@
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 			mapping ? =
dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
>=20
>=20
> Not sure this is an issue or not, but although the fix looks legit (in
> case a string is more that 31 bytes), strlcpy() does not pad the rest
> of the string like strncpy() does. This means we can possibly leak =
data
> through the ring buffer.
>=20
> This may not be an issue as ftrace can only be used by a super user
> account, but this code can also be used by perf. If it is possible for
> a non admin account to enable these events through perf, then there is
> a case of data leak.
>=20
> Again, it may not be a big issue, but I'm just letting people know.
>=20
> Note, this needs to go through the maintainer of the writeback.h, who
> are those that created it, not the tracing maintainers.

Adding Jens. He handled those patches in the past. The original patch is =
here,

=
https://lkml.kernel.org/lkml/1562948087-5374-1-git-send-email-cai@lca.pw/

>=20
> -- Steve
>=20
>=20
>> 		__entry->ino =3D mapping ? mapping->host->i_ino : 0;
>> 		__entry->index =3D page->index;
>> @@ -110,7 +110,7 @@
>> 		struct backing_dev_info *bdi =3D inode_to_bdi(inode);
>>=20
>> 		/* may be called for files on pseudo FSes w/ =
unregistered bdi */
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 			bdi->dev ? dev_name(bdi->dev) : "(unknown)", =
32);
>> 		__entry->ino		=3D inode->i_ino;
>> 		__entry->state		=3D inode->i_state;
>> @@ -190,7 +190,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 			dev_name(inode_to_bdi(inode)->dev), 32);
>> 		__entry->ino		=3D inode->i_ino;
>> 		__entry->sync_mode	=3D wbc->sync_mode;
>> @@ -234,7 +234,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 		__field(unsigned int, cgroup_ino)
>> 	),
>> 	TP_fast_assign(
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 			wb->bdi->dev ? dev_name(wb->bdi->dev) : =
"(unknown)", 32);
>> 		__entry->nr_pages =3D work->nr_pages;
>> 		__entry->sb_dev =3D work->sb ? work->sb->s_dev : 0;
>> @@ -288,7 +288,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 		__field(unsigned int, cgroup_ino)
>> 	),
>> 	TP_fast_assign(
>> -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
>> +		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
>> 		__entry->cgroup_ino =3D __trace_wb_assign_cgroup(wb);
>> 	),
>> 	TP_printk("bdi %s: cgroup_ino=3D%u",
>> @@ -310,7 +310,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 		__array(char, name, 32)
>> 	),
>> 	TP_fast_assign(
>> -		strncpy(__entry->name, dev_name(bdi->dev), 32);
>> +		strlcpy(__entry->name, dev_name(bdi->dev), 32);
>> 	),
>> 	TP_printk("bdi %s",
>> 		__entry->name
>> @@ -335,7 +335,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		strncpy(__entry->name, dev_name(bdi->dev), 32);
>> +		strlcpy(__entry->name, dev_name(bdi->dev), 32);
>> 		__entry->nr_to_write	=3D wbc->nr_to_write;
>> 		__entry->pages_skipped	=3D wbc->pages_skipped;
>> 		__entry->sync_mode	=3D wbc->sync_mode;
>> @@ -386,7 +386,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 	),
>> 	TP_fast_assign(
>> 		unsigned long *older_than_this =3D =
work->older_than_this;
>> -		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
>> +		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
>> 		__entry->older	=3D older_than_this ?  *older_than_this =
: 0;
>> 		__entry->age	=3D older_than_this ?
>> 				  (jiffies - *older_than_this) * 1000 / =
HZ : -1;
>> @@ -597,7 +597,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 		        dev_name(inode_to_bdi(inode)->dev), 32);
>> 		__entry->ino		=3D inode->i_ino;
>> 		__entry->state		=3D inode->i_state;
>> @@ -671,7 +671,7 @@ static inline unsigned int =
__trace_wbc_assign_cgroup(struct writeback_control *w
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		strncpy(__entry->name,
>> +		strlcpy(__entry->name,
>> 			dev_name(inode_to_bdi(inode)->dev), 32);
>> 		__entry->ino		=3D inode->i_ino;
>> 		__entry->state		=3D inode->i_state;

