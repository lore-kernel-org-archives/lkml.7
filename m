Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC220854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pYDrscMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfDJP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:57:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:34642 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfDJP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:57:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C765D1D6AB0;
        Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Q3U9ymiH4emo; Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 68CDC1D6AA6;
        Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 68CDC1D6AA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554911856;
        bh=eooEd2YFV4Ree6ttbXZrfHoa9UtzyyCgsvCi6MYBR4Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pYDrscMF9zTX82nng4VARD6zngPz1a4yA7+qRgRwKul4cb/JVNCqfnuw6zQg9AqoW
         7Fmcao/+clUbLCtp70F94INlmdBn60dvGQ0J0jWFn/4uQjJa/M9ORylyJOjOxB6Vzj
         m+grbww5SCc2T7q48zTs7L8Nub+QqGnptb4b3pdIG8IoIooKnNXvCqyEvBffZ0drXf
         zS0yAleG5Gx3OPe2/ikZYK1fCK+LKWJ4pg3W4pLON7oTaTFek+gnFzzlxzprrFu/Qc
         A2pZ+RdK3vxjbcGA4AfEtU/nAcpTNigeTiw49eLL36O90um4Ek9gXec0p48wZmNE2R
         y7dpjKHHO7/pQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7tN82RfdZUQH; Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 487FC1D6A9F;
        Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
Date:   Wed, 10 Apr 2019 11:57:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     schwidefsky <schwidefsky@de.ibm.com>
Cc:     heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Message-ID: <2074744632.3167.1554911856144.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190410175243.6fc3d16a@mschwideX1>
References: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com> <20190410123258.37f182cf@mschwideX1> <514609006.3159.1554911439933.JavaMail.zimbra@efficios.com> <20190410175243.6fc3d16a@mschwideX1>
Subject: Re: rseq/s390: choosing code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/s390: choosing code signature
Thread-Index: FchZvN71t7Ya0jaB9dCfvqo7rusmCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2019, at 11:52 AM, schwidefsky schwidefsky@de.ibm.com wrote:

> On Wed, 10 Apr 2019 11:50:39 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Apr 10, 2019, at 6:32 AM, schwidefsky schwidefsky@de.ibm.com wrote:
>> 
>> > On Tue, 9 Apr 2019 15:32:22 -0400 (EDT)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> >> Hi,
>> >> 
>> >> We are about to include the code signature required prior to restartable
>> >> sequences abort handlers into glibc, which will make this ABI choice final.
>> >> We need architecture maintainer input on that signature value.
>> >> 
>> >> That code signature is placed before each abort handler, so the kernel can
>> >> validate that it is indeed jumping to an abort handler (and not some
>> >> arbitrary attacker-chosen code). The signature is never executed.
>> >> 
>> >> The current discussion thread on the glibc mailing list leads us towards
>> >> using a trap with uncommon immediate operand, which simplifies integration
>> >> with disassemblers, emulators, makes it easier to debug if the control
>> >> flow gets redirected there by mistake, and is nicer for some architecture's
>> >> speculative execution.
>> >> 
>> >> We can have different signatures for each sub-architecture, as long as they
>> >> don't have to co-exist within the same process. We can special-case with
>> >> #ifdef for each sub-architecture and endianness if need be. If the architecture
>> >> has instruction set extensions that can co-exist with the architecture
>> >> instruction set within the same process, we need to take into account to which
>> >> instruction the chosen signature value would map (and possibly decide if we
>> >> need to extend rseq to support many signatures).
>> >> 
>> >> Here is an example of rseq signature definition template:
>> >> 
>> >> /*
>> >>  * TODO: document trap instruction objdump output on each sub-architecture
>> >>  * instruction sets, as well as instruction set extensions.
>> >>  */
>> >> #define RSEQ_SIG 0x########
>> >> 
>> >> Ideally we'd need a patch on top of the Linux kernel
>> >> tools/testing/selftests/rseq/rseq-s390.h file that updates
>> >> the signature value, so I can then pick it up for the glibc
>> >> patchset.
>> > 
>> > The trap4 instruction is a suitable one. The patch would look like this
>> 
>> Great! I'm picking it up into my rseq tree if that's OK with you.
> 
> Just added the patch to s390/linux:features for the next merge window as well.

Sounds good! I'll carry it in my tree to have a comprehensive up-to-date list of
rseq signatures for all architectures in a single tree. Worse-case the exact same
change will be pulled from both architecture and rseq trees, which I don't think
should be an issue, right ?

Thanks,

Mathieu

> 
> --
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
