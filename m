Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F401221738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="K2TjjzNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfDDUJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:09:50 -0400
Received: from mail.rptsys.com ([23.155.224.45]:4802 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfDDUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:09:49 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2019 16:09:49 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id BC34FE64BF8;
        Thu,  4 Apr 2019 15:01:06 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aZDxJ46WG23u; Thu,  4 Apr 2019 15:01:05 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 28A2DE634F7;
        Thu,  4 Apr 2019 15:01:05 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 28A2DE634F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1554408065; bh=UOXZistDtfIVLs1k2qCBucJryKN2lZmP/gp8TjK5bx0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=K2TjjzNm46u1tmFyW8wBZvXL/9qrV060qp0bmdAUszA/AfzFhFHMozT/+CQLJ6tEX
         ub93M5n+xF5CvGrHtMQMHqbWWHxUnisL589Y8qRBBKqV76ZmcQYXzPqWciCP/Bi1pe
         qPtvm5GnL3UD24XrVS6pKAWky+XoQ8sXaxTusuu0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 96swXYcdsRvL; Thu,  4 Apr 2019 15:01:04 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id B798DE6505A;
        Thu,  4 Apr 2019 15:01:04 -0500 (CDT)
Date:   Thu, 4 Apr 2019 15:01:04 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
        Jon Masters <jcm@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Message-ID: <401506569.4710878.1554408064001.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
References: <cover.1554396090.git.jpoimboe@redhat.com> <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com> <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline options
Thread-Index: dinaMtutIL4nwvFGZxvsYJw0doq+RA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will be joining in ~ 5 mins.  Getting Chromium set up here.

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Josh Poimboeuf" <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra" <peterz@infradead.org>, "Heiko Carstens" <heiko.carstens@de.ibm.com>, "Paul Mackerras"
> <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>, "Andrea Arcangeli"
> <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, "Will Deacon" <will.deacon@arm.com>, "Linus
> Torvalds" <torvalds@linux-foundation.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Waiman Long"
> <longman@redhat.com>, linux-arch@vger.kernel.org, "Jon Masters" <jcm@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
> "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, "Tyler Hicks" <tyhicks@canonical.com>,
> "Martin Schwidefsky" <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
> Sent: Thursday, April 4, 2019 2:49:05 PM
> Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline options

> On Thu, 4 Apr 2019, Josh Poimboeuf wrote:
> 
>> Configure powerpc CPU runtime speculation bug mitigations in accordance
>> with the 'cpu_spec_mitigations=' cmdline options.  This affects
>> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
> [ ... snip ... ]
>> -	if (!no_nospec)
>> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
> 
> '!no_nospec' is something that I am sure will come back to hunt me in my
> bad dreams.
> 
> But that's been there already, and fixing it is out of scope of this
> patch. Other than that, as discussed previously -- I really like this new
> global option. Feel free to add
> 
>	Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> 
> for the whole set.
> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs
