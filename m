Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC97C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7296620872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfDPPdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfDPPdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:33:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FB57307DAC4;
        Tue, 16 Apr 2019 15:32:55 +0000 (UTC)
Received: from treble (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 788FF5D9CA;
        Tue, 16 Apr 2019 15:32:41 +0000 (UTC)
Date:   Tue, 16 Apr 2019 10:32:37 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 1/5] cpu/speculation: Add 'mitigations=' cmdline option
Message-ID: <20190416153237.ici3ezhy5h5fji22@treble>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
 <20190416141335.GH31772@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416141335.GH31772@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 16 Apr 2019 15:33:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:13:35PM +0200, Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 03:39:28PM -0500, Josh Poimboeuf wrote:
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 38890f62f9a8..aed9083f8eac 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2320,3 +2320,18 @@ void __init boot_cpu_hotplug_init(void)
> >  #endif
> >  	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
> >  }
> > +
> > +enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
> > +
> > +static int __init mitigations_cmdline(char *arg)
> 
> Forgot the verb: "mitigations_parse_cmdline".

Sure.

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aed9083f8eac..cf9fea42d8fc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2323,7 +2323,7 @@ void __init boot_cpu_hotplug_init(void)
 
 enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
-static int __init mitigations_cmdline(char *arg)
+static int __init mitigations_parse_cmdline(char *arg)
 {
 	if (!strcmp(arg, "off"))
 		cpu_mitigations = CPU_MITIGATIONS_OFF;
@@ -2334,4 +2334,4 @@ static int __init mitigations_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_cmdline);
+early_param("mitigations", mitigations_parse_cmdline);
