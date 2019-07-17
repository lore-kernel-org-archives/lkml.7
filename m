Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C96C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9521743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z99Wfl0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfGQHuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:50:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfGQHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:49:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H7hwmc119706;
        Wed, 17 Jul 2019 07:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OrJvKxRwwYXFXus0lT1vSh2dbIKM3XOiNJCVKb9uv9o=;
 b=z99Wfl0evKOcLYS4AZ/6O5vSEQBfY+qAxda5oovUKw9P2jjtVuVtcAogTz3+RgSFnYdk
 T09tEccswm8kIILPj4gF28Xyb3YQAo8G2adklHqAHXSY2XMBf6n/q13mnYWk1LNF/2R6
 3Khsz4IX6PvheoFW2PrTQd51Hy8dwOZEWZJ2zZMAm/f9CBGWdteg0YHusu/X3zU3GBSm
 l0vbhkXEwytnpDMCnPT9JGX4iwGYEe8rEzuNMRMJP4NRNUHM3ColDq26XW1NnK5g/nTl
 l7+jJgfEwHXcd+YPdbM8wN6lW2yKvGmBKspd92+sgWjcNf9dR9axbrEWLZjLpEcBqSBn pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xr0txh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 07:48:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H7hRR9036435;
        Wed, 17 Jul 2019 07:48:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tsmcc86wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 07:48:12 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H7mA2p024689;
        Wed, 17 Jul 2019 07:48:10 GMT
Received: from [10.175.27.185] (/10.175.27.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 07:48:09 +0000
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
 <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <c2f775d7-93e5-1109-25f4-2b077d2c70e1@oracle.com>
Date:   Wed, 17 Jul 2019 09:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/19 3:02 AM, Andy Lutomirski wrote:
> On Tue, Jul 16, 2019 at 2:53 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>>
>> On 7/16/19 9:33 PM, Vegard Nossum wrote:
>>>
>>> On 7/11/19 1:40 PM, Peter Zijlstra wrote:
>>>> Hi,
>>>>
>>>> Here's the latest (and hopefully final) set of tracing vs CR2 patches.
>>>>
>>>> They are basically the same as v2, with only minor edits and tags
>>>> collected
>>>> from the last review.
>>>>
>>>> Please consider.
>>>>
>>>
>>> Hi,
>>>
>>> I ran my own battery of tests on your patch set on top of
>>> 5ad18b2e60b75c7297a998dea702451d33a052ed and ran into this:
>>>
> 
> On a different thread, Peter and I decided that the last patch in this
> series (the one that removes the _DEBUG stuff) is wrong.  Can you see
> if these are reproducible with that patch removed?

Yes, without the last patch I still get this:

Run /init as init process
init[711]: segfault at 40000000 ip 000000004000000a sp 0000000040000ff8 
error 7
------------[ cut here ]------------
General protection fault in user access. Non-canonical address?
WARNING: CPU: 0 PID: 711 at arch/x86/mm/extable.c:126 
ex_handler_uaccess+0x5d/0x70
CPU: 0 PID: 711 Comm: init Not tainted 5.2.0+ #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
init[716]: segfault at 40000000 ip 000000004000000a sp 0000000040000ff8 
error 7
RIP: 0010:ex_handler_uaccess+0x5d/0x70
Code: 5d 41 5c c3 e8 c4 8e 0e 00 80 3d e5 74 1e 01 00 75 d3 e8 b6 8e 0e 
00 48 c7 c7 10 a7 fb 81 c6 05 d0 74 1e 01 01 e8 d1 43 01 00 <0f> 0b eb 
b7 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0000:ffffc9000065fa18 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff81c07dac RCX: ffffffff811a887c
init[714]: segfault at 40000000 ip 000000004000000a sp 0000000040000ff8 
error 7
RDX: 0000000000000000 RSI: ffffffff8289f05f RDI: 0000000000000093
RBP: ffffc9000065fa88 R08: 000000002e80b265 R09: 000000000000003f
init[718]: segfault at 40000000 ip 000000004000000a sp 0000000040000ff8 
error 7
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
FS:  00000000006ce880(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000003fffffe0 CR3: 000000003d2f6004 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Code: Bad RIP value.
  fixup_exception+0x50/0x6a
  do_general_protection+0x40/0x160
  general_protection+0x2d/0x40
RIP: 0010:arch_stack_walk_user+0x71/0x100
Code: 00 48 83 e8 10 49 39 c4 77 45 4c 8b 04 24 4c 89 e3 4d 89 fd 4c 89 
fd 41 83 87 98 0a 00 00 01 0f 01 cb 0f ae e8 31 c0 4c 89 e2 <4c> 8b 33 
4d 89 f4 85 c0 75 7a 48 8b 73 08 0f 01 ca 85 c0 74 1f 65
[...]

This is my reproducer (as init):

#include <fcntl.h>
#include <sched.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/user.h>
#include <unistd.h>
#include <wait.h>

struct child_data {
   (*code)();
};

child_fn(void *arg)
{
   child_data *data = arg;
   mprotect(data->code, PAGE_SIZE, PROT_EXEC);
   data->code();
}

int main()
{
   mkdir("/sys", 7);
   mount("nodev", "/sys", "sysfs", 0, "");
   mount("nodev", "/sys/kernel/tracing", "tracefs", 0, "");

   int tracing_options_userstacktrace = 
open("/sys/kernel/tracing/options/userstacktrace", O_RDWR);
   write(tracing_options_userstacktrace, "1\n", 2);

   int tracing_events_preemptirq_irq_disable = 
open("/sys/kernel/tracing/events/preemptirq/irq_disable/enable", O_RDWR);
   write(tracing_events_preemptirq_irq_disable, "1\n", 2);

   void *code = mmap(0, PAGE_SIZE, PROT_WRITE, MAP_PRIVATE | 
MAP_ANONYMOUS | MAP_32BIT, 1, 0);
   {
     unsigned char *output = code;

     *output++ = 72;
     *output++ = 189;
     for (int i = 0; i < 8; ++i)
       *output++ = i;
   }

   void *child_stack = mmap(0, PAGE_SIZE, PROT_WRITE, MAP_PRIVATE | 
MAP_ANONYMOUS | MAP_32BIT, 1, 0);

   while (1) {
     child_data data = { code };
     clone(child_fn, child_stack, SIGCHLD, &data);
   }
}

Compiled with -static and booted with "norandmaps" (for some reason that
makes a difference), this is 100% reproducible for me, although the
reproducer is somewhat sensitive to small changes that I don't quite
understand.


Vegard
