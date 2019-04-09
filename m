Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C5920833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGzeATXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDIJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:29:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35260 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:29:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so9067767plp.2;
        Tue, 09 Apr 2019 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uz/VlezM1F/whqslASz2+vc6bdT5jIpSqLI+shePWjE=;
        b=lGzeATXUcuz1REth//QzC6QQK7gnTIqEElIOzpj0qPWpDIHjLJ4nHnj9y8BbHJkeiW
         fshhy2gk/nw0yP/HOt3YfE+iPr6LhQADXbj0HJj+PSzpdxXZ746VKFoU+dlPmZQsE7kQ
         UipwR9qDkHlFQvASWgyhEwV3MgakU+4cEyp7OI3ChSlSZbxHQHVXe7zR7mIARm4Tpr6X
         8qt89GOdp4jGitM1h5EGupWjUkrd9aWBr8qhLyLoJLn0PcJwKaONoK0WbcV67l8Ri7Js
         XbILueCyfJRQMbvDe2xmuEPc6e0SNYkGbXYznPQLnxq79x3Odp8thOKPtZAZsf8HC5AE
         Ns7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uz/VlezM1F/whqslASz2+vc6bdT5jIpSqLI+shePWjE=;
        b=YmuK6Wwo3lLMgAm5suve0Os11V3vPF5N+y9lMrtPDQmiRsifLvEsTj47+0e8CW7Esq
         ZJnlhzoY+iQovS5uFTb5Wr1vDSj5xD7ygB6s/8SXah7w+6OSF1hGRqAJjoJslIWHvLuz
         Kv/fVd1XC0Oik7FjH2NKCn7R7cFoaggpPDyFL39A8+W2wydrK99ZRt6sed13csz4nimE
         LEEp/MbMImt/PUt6kb3U1Krx+K4dXahy6lnZ8UOT4PJ9D6Ij8R9Yi5D0GKS9hZ7HBc/j
         pR0EMskD0BYDo+joXAr97SV9q5c2Zq0x1xvUQxL6x8E/G4aj1KpXmXZx8kYbp0WEwf29
         KhNw==
X-Gm-Message-State: APjAAAUgipibidMjKgrz2zjNwrdtlvYVmyEBNXV3vohH70Gik3PVdZfq
        FSATysrVh7pOh0KpwD0SO6o=
X-Google-Smtp-Source: APXvYqx+5RfUIVQJZtIZpCy1Wv4ObL9JHfsp/q3PIDtl6+n0cuP5wiGWO5qhTCHp+Q6Uxkt4Xzu6bA==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr30888324plr.84.1554802193226;
        Tue, 09 Apr 2019 02:29:53 -0700 (PDT)
Received: from bubble.grove.modra.org (15.193.233.220.static.exetel.com.au. [220.233.193.15])
        by smtp.gmail.com with ESMTPSA id f7sm59853420pga.56.2019.04.09.02.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:29:52 -0700 (PDT)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id 940A580586; Tue,  9 Apr 2019 18:59:48 +0930 (ACST)
Date:   Tue, 9 Apr 2019 18:59:48 +0930
From:   Alan Modra <amodra@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Carlos O'Donell <codonell@redhat.com>,
        Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
Message-ID: <20190409092948.GA14424@bubble.grove.modra.org>
References: <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <87lg0tosfz.fsf@concordia.ellerman.id.au>
 <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
 <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
 <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
 <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
 <877ec4pam2.fsf@linux.ibm.com>
 <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com>
 <877ec3yffq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ec3yffq.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:23:53PM +1000, Michael Ellerman wrote:
> I'd much rather we use a trap with a specific immediate value. Otherwise
> someone's going to waste time one day puzzling over why userspace is
> doing mtmsr.

It's data.  We have other data in executable sections.  Anyone who
wonders about odd disassembly just hasn't realized they are
disassembling data.

> It would also complicate things if we ever wanted to emulate mtmsr.

No, because it won't be executed.  If I understand correctly, the only
reason to choose an illegal, trap or privileged insn is to halt
execution earlier rather than later when a program goes off in the
weeds.

> If we want something that is a trap rather than a nop then use 0x0fe50553.
> 
> That's "compare the value in r5 with 0x553 and then trap unconditionally".
> 
> It shows up in objdump as:
> 
>     10000000:	53 05 e5 0f 	twui    r5,1363
> 
> 
> The immediate can be anything, I chose that value to mimic the x86 value
> Mathieu mentioned.
> 
> There's no reason that instruction would ever be generated because the
> immediate value serves no purpose. So it satisfies the "very unlikely
> to appear" criteria AFAICS.

Yes, looks fine to me, except that in VLE mode (do we care?)
".long 0x0fe50553" disassembles as
   0:	0f e5       	se_cmphl r5,r30
   2:	05 53       	se_mullw r3,r5
No illegal/trap/privileged insn there.

".long 0x0fe5000b" might be better to cover VLE.

-- 
Alan Modra
Australia Development Lab, IBM
