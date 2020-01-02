Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B3C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBF21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q15Fp3sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgABRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:16:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41465 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgABRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:16:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so35106339qtk.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kAQJ38i09v+amShK5qBU7ZxzERB9iZK7X0VJJQXO1pg=;
        b=Q15Fp3sZh1kg8N0IVHw9ikL56635h8bswHZ2x6XjfR/BSZnwsOzAgLtXnm2d7Dg7dZ
         bMeW/7mkX53lSUV/K1ss+mCX+VOaMu2ECxzXppX5Ms+99ZYEYLAJWSxNuIB0Ri8K6hfX
         sKyySuuY4n/KjuL8AbnYomGeKvf6T0kG/Sri042sL7f456qFWyvmDo0aPZbzyr0wkUTm
         Pfj4pDVpM1lpQUmzIucs1dVdc2LCtncu4V6/1h6GPFDid/oJmDab4VyY1vJ98FrRRzOJ
         2T5gnqKsHfg18X5kRdxWRIZmxjn1u5voiXAAT8UURcECLMFjsneP9spdTBvaYjFPnQwA
         vjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kAQJ38i09v+amShK5qBU7ZxzERB9iZK7X0VJJQXO1pg=;
        b=fJ3JqMl0tAOYJDH70k9bkj3yi0GPGicC3lcQrlvjIRJ/ijrrtWCRfYR9lW83yC8Rc7
         T+UlZVXdIn3gaVrMUxoj+osdDPEMirRs0tCk73fZEBBC+5AWaIJtlTqjLgqJ5uiNwxZh
         GBHYDTTSTvGnbu0mUF5ODJszcefSwugZbsl3Li/5jX9a7HaToWmsoi4QLmvbc6LRl8VQ
         Mn02OwGrhNoT9yF6vACJCmReUgdrbLUtKkME/Rv5zRUYyp0ocV8gZzY30/rN/SkQjw9G
         KoNW7oma6M8qx7IDwFYlcLdt/RXjYAnd3PiFQEbvdPdWSbiwPYwLtyXbGUcLjUHh+bYN
         UNlg==
X-Gm-Message-State: APjAAAUQppGY9FJNr+ina/tGB+3H79iw/BuQF7N4EVDjvBOgM8WF4o4R
        KV/o6INW1DCUq/3GuIhF4AiKZ1s8IBU=
X-Google-Smtp-Source: APXvYqx2n+XHSH8XLpr4h7ciLtNAaJg762Gum669jBlOte1uvG5D9FGqgFfW3TyrJUpxF28qlAc4dg==
X-Received: by 2002:aed:3e83:: with SMTP id n3mr59731182qtf.322.1577985390236;
        Thu, 02 Jan 2020 09:16:30 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v7sm17304099qtk.89.2020.01.02.09.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 09:16:29 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Date:   Thu, 2 Jan 2020 12:16:28 -0500
Message-Id: <00116950-7DFB-4F93-959A-06D63E8FF51E@lca.pw>
References: <20200102120752.7b893b1e@gandalf.local.home>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        pmladek@suse.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        Peter Zijlstra <peterz@infradead.org>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20200102120752.7b893b1e@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 2, 2020, at 12:07 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> How would this disable lockdep early in the process? The patch is just
> changing pr_notice() to printk_deferred() correct?

Yes, I meant without this patch. Lockdep will easily generate this potential=
 deadlock warning early after boot and then disable itself.=
