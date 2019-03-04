Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F45C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4420836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="HZsUcGJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDHmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:42:16 -0500
Received: from www.scalemp.com ([169.44.78.149]:36232 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfCDHmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/4dc4k/j2mMqz51OSsTsAvlGPXV+6mw3Om6kcPwBrbg=; b=HZsUcGJXpfFZWjybMxH+F2GGgI
        vIve8pxzRO0roSZNeNLHC2kSlpAxbAFHV5BTczMIGkOkKGqi1aJWBHsuZ0o7dHz83urxuAU5ph+df
        3wobY/guLEUZD+XDjAAeP966dcPPpRWLgrzo7BogaQ+ZPK3hrf2V+QU3wTvmkcjvX3vY=;
Received: from bzq-80-45-146.red.bezeqint.net ([82.80.45.146]:16972 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1h0iEo-001U7e-Gw; Mon, 04 Mar 2019 02:42:14 -0500
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     Barret Rhoden <brho@google.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <cfc1d13e-ce6a-b7f3-c129-886104b0ca2a@scalemp.com>
Date:   Mon, 4 Mar 2019 09:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Barret,

On 3/1/19 8:30 PM, Barret Rhoden wrote:
> Hi -
> 
> On 01/21/2019 06:47 AM, Eial Czerwacki wrote:
>>
> 
> Your main issue was that you only sent this patch to LKML, but not the
> maintainers of the file.  If you don't, your patch might get lost.  To
> get the appropriate people and lists, run:
> 
>     scripts/get_maintainer.pl YOUR_PATCH.patch.
> 
> For this patch, you'll get this:
> 
> Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
> linux-kernel@vger.kernel.org (open list)
> 
> I added the three maintainers to this email.
> 
> I have a few minor comments below.
> 
thanks, I did not knew that, I'll use it next time.

>> [PATCH] percpu/module resevation: change resevation size iff X86_VSMP
> is set
> 
> You misspelled 'reservation'.  Also, I'd just say: "percpu: increase
> module reservation size if X86_VSMP is set".  ('change' -> 'increase'),
> only says 'reservation' once.)
> 
>> as reported in bug #201339
>> (https://bugzilla.kernel.org/show_bug.cgi?id=201339)
> 
> I think you can add a tag for this right above your Signed-off-by tags.
> e.g.:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201339
> 
>> by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from
>> the default one
>> causing the struct size to exceed the size ok 8KB.
>                                             ^of
> 
will fix, thanks.

> Which struct are you talking about?  I have one in mind, but others
> might not know from reading the commit message.
> 
> I ran into this on https://bugzilla.kernel.org/show_bug.cgi?id=202511.
> In that case, it was because modules (drm and amdkfd) were using
> DEFINE_SRCU, which does a DEFINE_PER_CPU on struct srcu_data, and that
> used ____cacheline_internodealigned_in_smp.
you are correct, the structure in question is struct srcu_data.

> 
>>
>> in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if
>> CONFIG_X86_VSMP is set.
>                                ^increase
> 
>>
>> the value was caculated on linux 4.20.3, make allmodconfig all and the
>> following oneliner:
>                ^calculated
> 
will fix, thanks.

>> for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc;
>> done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r:
>> "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk
>> '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END
>> {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column
>> -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc
> 
> Not sure how useful the one-liner is, versus a description of what
> you're doing.  i.e. "the size of all module percpu data sections, or
> something."
I thought an easy reproducing will suffice, I'll take that into account.

> 
> Also, how close was that calculated value to 64K?  If more modules start
> using DEFINE_SRCU, each of which uses 8K, then that 64K might run out.
the biggest module was 12472 bytes in size, as multiple modules uses the
same percpu, more is needed, the only way I was able to make it fit was 64K.

of course there is a possibility that at a specific scenario 64K will
not be enough but we have yet to encounter such scenario.

> 
> Thanks,
> Barret
> 
>> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
>> Signed-off-by: Shai Fultheim <shai@scalemp.com>
>> Signed-off-by: Oren Twaig <oren@scalemp.com>
>> ---
>>   include/linux/percpu.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
>> index 70b7123..6b79693 100644
>> --- a/include/linux/percpu.h
>> +++ b/include/linux/percpu.h
>> @@ -14,7 +14,11 @@
>>     /* enough to cover all DEFINE_PER_CPUs in modules */
>>   #ifdef CONFIG_MODULES
>> +#ifdef X86_VSMP
>> +#define PERCPU_MODULE_RESERVE        (1 << 16)
>> +#else
>>   #define PERCPU_MODULE_RESERVE        (8 << 10)
>> +#endif
>>   #else
>>   #define PERCPU_MODULE_RESERVE        0
>>   #endif
>>
> 
> 

