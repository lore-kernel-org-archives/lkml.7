Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC33C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3DF2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDw8REuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZVoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:44:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37095 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:44:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so5116589wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3TCvikHiROllDrcma+CvPeIZvgOAa0DLqL9aOfiW+v0=;
        b=eDw8REuPwOPqWU2sJ0BdoRVPWKUzTj0YbRhRQicf7aRtg+PGgtxw8sQrt+ehKPldab
         5Dwy2fhc9u1vkpmctrriVLMl8oM14lEykl7FUpFaq7z8DZyPiTAQ15aQY/539wKteIsr
         PisqlDWBEUmELtSDpWswAvRPvWzb8PxcFGyB2YSldaUc/KJNZJ5xSrFXBExtlQZTtnbi
         yVA2wl3bFw8rtMJHYIgKpbAr6viP0/SLeXLVyjJVpba+oUcFvxhU8axe3RmrwZPRAH1E
         jeSYxPlmbTqb3sH23BN2jiUb/FCQyeEIIuvJJsNlYeo/G+mKIf/K+yryI7MdWHcPfB6w
         86kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TCvikHiROllDrcma+CvPeIZvgOAa0DLqL9aOfiW+v0=;
        b=B7GGt5F3u/y8OwECpQyMtirTtI2+4YeLtRUxfWCUFrb4FbDMHMM+n6xR1AT73+fioA
         DtFNevpPZIfsbjJ8sJZX5hZXXTbdFqfd+CllIGfJk76APWbe3P+H4zjwU8fCV9IYPDWl
         UTl6IMBntlgg39HFxGQQ+CxeY3fMWLAWKy7GwChxytl8wte6uiVzS4aXdNx4af6aR7qO
         5Ebopkd11QpWlNOf0nfadRNl+R21lTDg+uCeCAnQ90TvLD8AbcpHguYgy8Hn1/QUC3Jm
         oKi1r8rzBzT/wQE/++qeiF5ZkY4ZIjl5rN8Q96hssgT6JmCLXHSZl57NqzPWVEW8A3Hs
         73fw==
X-Gm-Message-State: APjAAAUInRJHWj68kSf1quQa6e25GWLonF7u71KxhIw+XZqjrWf/P1Kp
        JmVgkxfJzLiekQXZSdMWXWY=
X-Google-Smtp-Source: APXvYqzKuSB3cAu0EuiMT+9vrB+n7dd0HVpAtyzd2Elni0TH64QZnLUu2tuPSqhTHT8AOVtai1OAWg==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr999955wmc.37.1574804683968;
        Tue, 26 Nov 2019 13:44:43 -0800 (PST)
Received: from ltop.local ([2a02:a03f:404e:f500:ac14:4c10:6104:457f])
        by smtp.gmail.com with ESMTPSA id x10sm16353061wrp.58.2019.11.26.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 13:44:43 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:44:41 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 26/35] powerpc/64: system call: Fix sparse warning
 about missing declaration
Message-ID: <20191126214441.4wziibsax2mvpl3p@ltop.local>
References: <cover.1574798487.git.msuchanek@suse.de>
 <d0a6b5235c4e1544f4c253724a5b8f2106cc43bd.1574798487.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a6b5235c4e1544f4c253724a5b8f2106cc43bd.1574798487.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:13:40PM +0100, Michal Suchanek wrote:
> Sparse warns about missing declarations for these functions:
> 
> +arch/powerpc/kernel/syscall_64.c:108:23: warning: symbol 'syscall_exit_prepare' was not declared. Should it be static?
> +arch/powerpc/kernel/syscall_64.c:18:6: warning: symbol 'system_call_exception' was not declared. Should it be static?
> +arch/powerpc/kernel/syscall_64.c:200:23: warning: symbol 'interrupt_exit_user_prepare' was not declared. Should it be static?
> +arch/powerpc/kernel/syscall_64.c:288:23: warning: symbol 'interrupt_exit_kernel_prepare' was not declared. Should it be static?
> 
> Add declaration for them.

I'm fine with this patch but, just FYI, lately people seems to
prefer to add '__visible' to the function definition instead
of creating such header files.

Best regards,
-- Luc Van Oostenryck
