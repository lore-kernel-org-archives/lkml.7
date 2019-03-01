Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC726C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92207206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CxXHYL1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfCAP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:27:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36873 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfCAP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:27:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so11605796pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ewhqZBqZKb2keIFuJydHYmzXxccmZRmEXtk1Z2AZe6I=;
        b=CxXHYL1biGxp6BoWUVyOG5oO2xGoOAi75YvcTa3x2c32CIW2pLTA0cCOpAMJGZe8X3
         bw3swtAWMyMYLRTmEG9TynvplP3Afvm2DYz/8UyT23v1hfEyrbFZX04LqUu0h7a00847
         XpsUaaJ9afYyn2kwHwFkIa4mj5pSZtxSS3s/Fv1sdysqOXN2xx0LhAY0bjOWNrIg2R8D
         yQxq6hLiww5+HqFkeejtiml34yp68gV2Bm+y1DS+S7pz+Ww9iK1G6XjzcZLZDMlNDSUP
         FpK0dKGztryNV3Ssv+BK7rpsMTcv6d1G2cP0qTnBnASeA+14s5Py8OKVl7SYYPcMpf6o
         2hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ewhqZBqZKb2keIFuJydHYmzXxccmZRmEXtk1Z2AZe6I=;
        b=ZIa79epOklpGeJD8ZXdxGZsla9yIX7IczgEBmR0hbwMA7hwFLchNVaBWYVavTsiYRh
         WyqomsvuUnlD9s0Ddrh3+61Swve5eB1O6k/7Qd9OlAh3YZD8PKNpBoFdg7DBIgprqRK0
         eFSbhwspQ19tpP3HbAQYozAmq6OPUBwohkc9aDtCSMUIq+kEjFaGUk0/wg9aufSZ3a5X
         /nip8RsNul82ipC5IQMSaJiGdxnRtnKbhtRmCvsX1JF2gHEu3rDLbazlE8+M17eMRTPq
         M8QITJwHSHe1+CQFLD+YpPhBHk1d48zmhWFfevbgS0mKrotVEoh5oTU5WBg+mjQjYwUP
         oP6A==
X-Gm-Message-State: APjAAAVnegNzI5JIIpAScdcuP96E5wTR6HBpMlWrp0s73OA8V8S5gp7u
        4sCUw8WDJCwBRi2FCrC+2JIqWw==
X-Google-Smtp-Source: APXvYqyDgi1IyNyikcNERo7AcZ5CQQ04qMA/MdZoeeScp4sNY7uuOBv7+rc9+WNPxqABEqdQzNgZog==
X-Received: by 2002:a63:4346:: with SMTP id q67mr5233625pga.92.1551454069779;
        Fri, 01 Mar 2019 07:27:49 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:ed98:8570:b6d3:9084? ([2601:646:c200:7429:ed98:8570:b6d3:9084])
        by smtp.gmail.com with ESMTPSA id k27sm20604898pgb.70.2019.03.01.07.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 07:27:48 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190301143800.GT32534@hirez.programming.kicks-ass.net>
Date:   Fri, 1 Mar 2019 07:27:47 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D332336-71DF-463A-B07A-5D91087F133A@amacapital.net>
References: <20190228145450.289603901@infradead.org> <20190228150152.540038736@infradead.org> <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com> <20190228175114.GG32494@hirez.programming.kicks-ass.net> <20190228180154.GO32534@hirez.programming.kicks-ass.net> <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com> <20190228190111.GI32494@hirez.programming.kicks-ass.net> <20190301103452.GQ32534@hirez.programming.kicks-ass.net> <20190301122745.GR32534@hirez.programming.kicks-ass.net> <20190301125718.GS32534@hirez.programming.kicks-ass.net> <20190301143800.GT32534@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2019, at 6:38 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Mar 01, 2019 at 01:57:18PM +0100, Peter Zijlstra wrote:
>>> On Fri, Mar 01, 2019 at 01:27:45PM +0100, Peter Zijlstra wrote:
>>> arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x30=
: redundant UACCESS disable
>>=20
>>> The usercopy one is difficult, that's copy_user_handle_tail(), it is
>>> buggered though, because that lacks notrace and thus has a __fentry__
>>> call in.
>>>=20
>>> Also, afaict all exception jumps into copy_user_handle_tail() will have
>>> AC=3D1, but the __{get,put}_user_nocheck() things do STAC/CLAC all over
>>> again.
>>>=20
>>> So what do we do? Annotate that we start with AC=3D1 and then immediatel=
y
>>> do the clac, and then let __{get,put}_user_nocheck() do their own thing?=

>>> or make it use the unsafe stuff?
>>=20
>> Or.. we move the thing to assembly. Of course, I suck at (writing) asm,
>> so the below is probably broken in various ways.
>=20
> The advantage is that it now all lives in the same .o file and objtool
> can actually follow and find the complete control flow.
>=20
> I've made it ENDPROC() such that it becomes STT_FUNC and objtool does
> all the normal things. I've also moved the ALIGN_DESTINATION macro into
> the .S file.
>=20
> Andy, do we have a sensible self-test for this path?

Not that I know of. Something like my (rejected) strncpy_from_user test coul=
d probably be added fairly easily.=
