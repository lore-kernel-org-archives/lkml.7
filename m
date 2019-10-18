Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA6CCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFCA222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HWO1Og9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441992AbfJRFAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:00:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfJRFAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:37 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so5885829ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ar03SN8ojdCPgdDDnhBr1SKZnLdM9cLb9Yk7E1pUhvA=;
        b=HWO1Og9hde/TMA3RyAXmPzOZqdhjb5gLcg2VdZkxBTWSAXVnVEHtmfUEZ9Bdly/5Pj
         zUkp/siL3Z0sOwANXcY9TGdwcTIzYUymEUTEU5H0I1Am5BoqlQo0OLsDJGzB77MM8N8C
         Hmhp9f2ap3GaScWS15oXAGTsnLgOK1ldfs73dPBEWXcUdizem3nAcwjd5oJfiNgygKQG
         iCwbs/OLUDnLvmaDsIp0/+OXeV1rAq+wHHvKKm8qhbNm+O996t7m7xzDEgBHD4e//0LM
         5v5kEu60irubA+e/vdEIosEV4qfWiihBbyd1ClO2GgDjBojWmczJzJHzjx1OPqxvtykj
         rNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ar03SN8ojdCPgdDDnhBr1SKZnLdM9cLb9Yk7E1pUhvA=;
        b=Bl8PHzaSAVTHxjTTT+xyPH5rVmopCQD2oWBi3nEZhmD6y2QlImNyxnH7apTOE+Ev4O
         XYVkIb2QH0NANGU/cCeeaGbOuCBX0bNhr1jnJ7kEFq51gFGWCLK4irPN3ahpPX1Dn9cc
         CsX5DJtqSs6VRylwFcoHNfH2YB0llFJRGHDMo54PFyDs8L3bvpSZcuoLyLL1Lf1FwUQw
         Byz1fc/HAvLvqaOw179KZX4pzPKXfRX7BqlWf490XpisqR++em2ZWVTb7Ro9ebmYN9IS
         wLmabZDtCy0RDeQ/PJbEU3JvYD+ukcebNGf/IXc4ubVMf6iFTzmvRtvZqjq/DyHb6H3F
         K4wg==
X-Gm-Message-State: APjAAAWG81OWEl1kYT9RAm/k07eGIlajMfmKVD7xZnBszF0rurmUTyXn
        g34lcD1juFbdWQP1WYVZ5Rn5dorL/tE=
X-Google-Smtp-Source: APXvYqySaMUMX6+h6cD/AKKX0qnuUY0VtV4hMOq6tJB5V4tLWwii7PNoFEbMhirlF6g4QwMw2BBzzA==
X-Received: by 2002:a5e:da45:: with SMTP id o5mr3854840iop.177.1571373500501;
        Thu, 17 Oct 2019 21:38:20 -0700 (PDT)
Received: from localhost (67-0-11-246.albq.qwest.net. [67.0.11.246])
        by smtp.gmail.com with ESMTPSA id y23sm1544228iob.28.2019.10.17.21.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:38:19 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:38:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: init: merge split string literals in preprocessor
 directive
In-Reply-To: <20191018040237.3eyrfrty72r63pkz@ltop.local>
Message-ID: <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com> <20191018004929.3445-4-paul.walmsley@sifive.com> <20191018040237.3eyrfrty72r63pkz@ltop.local>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:

> On Thu, Oct 17, 2019 at 05:49:24PM -0700, Paul Walmsley wrote:
> > sparse complains loudly when string literals associated with
> > preprocessor directives are split into multiple, separately quoted
> > strings across different lines:
> 
> ...
>  
> >  #ifndef __riscv_cmodel_medany
> > -#error "setup_vm() is called from head.S before relocate so it should "
> > -	"not use absolute addressing."
> > +#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
> >  #endif
> 
> Using a blacslash should do the trick :
> 	#error "blablablablablablablablablablablabla" \
> 			"and blablabla again"
> Or if need I cn fix Sparse if needed and desiable.

Thanks for the kind offer!

The backslashless syntax is pretty horrible to my eyes.  As far as I can 
tell from a brief glance, the instance fixed by this patch was the only 
instance of its kind in the kernel.  The existing kernel precedents appear 
to be to simply use a single long line.  Example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler-gcc.h#n3

So, from a kernel point of view, we should just fix this specific 
instance.  It doesn't seem worth changing sparse for such a rare case.

On the other hand, gcc seems to support the non-backslashed syntax.  So if 
the intention is for sparse to follow the gcc practice, and to be used 
beyond the kernel, maybe it's worth aligning sparse to gcc?  Only if 
you're bored, I suppose...


- Paul
