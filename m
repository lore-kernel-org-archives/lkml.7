Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF1C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094A920815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLMGJ2BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfEZURZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:17:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41030 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfEZURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:17:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so10528937oia.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3uf9cufEGhDoTEnfE1h9K1llyrP8ckDtJqezj61tU2A=;
        b=nLMGJ2BF8srHOOyJh/mHZ+qgHENvX00rMwG1YC5XDW+oB79h7ArHJXQb8We3lHho4h
         d12+FULqFsV9zjbIaxsTd4lGID9t8s6c9vKIlCg/NH99awYHv7oqKPTIX3jCfYSpr71J
         x/Qj+tJfy2B52URYJMaGyvZhsgVKaUruiccUSA7a8509NFBUryqERZo25UjLYReosVhQ
         xPIKQ5xv6d0+5Lv7/eFpMvXoM57SubmnNNg2SnMbvAHtz1M335o9QczoN26rxjal9+Vb
         q6YXLyNgAaKWB+c2TEAZwBRNFhk3xupR1pH6HgI0or9vFTa414LPRQjE7FfTJEHZm4pl
         Tx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3uf9cufEGhDoTEnfE1h9K1llyrP8ckDtJqezj61tU2A=;
        b=JuZdNPeMASocKVXiPLhMq6xtsVCnAMGrYH8ViIxTXM4FmsOcihdfG0OBmPMfWUrupp
         hjEAnBlYaLqsHvWS9O0iDzAi8GJoDnl8c89umPvp5T5vPn+cGPHHEXwOJ2oKSDExpH6y
         UALnscTy7nW8yqGDgaaNz2GesoMXpU7dp7zAj8aSsFlo1P0iWr+tX7755ox5BZibaMiD
         bDYJAFDkQtCyA8cgM7BrKm0dTKSXr/45ifJtR+4PKB8yZ6pmXJzTlYRHqyDncxwI6SgY
         J2VAlQC3mtJAWW6/it28g6M5kN1xF3NGnGGqTDvXQBtVPbKMhRvy7us9tJWW8zCxpN2+
         h5Rg==
X-Gm-Message-State: APjAAAVI8I5Q0mn6Flcpymzxw8ogf1HJYqO3PJmykqz/XH6LMsTm22sy
        cHQtwzt7SNw9m9T/aPSHtA8VDg==
X-Google-Smtp-Source: APXvYqy4mE9GkvIYIH0dQKiRyKKl0V5oqT23k8QaDoMApbh2MokN1Ee0p6duj/olz9iuQdHSNYBk4w==
X-Received: by 2002:a05:6808:603:: with SMTP id y3mr394497oih.74.1558901843688;
        Sun, 26 May 2019 13:17:23 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e4sm3189630oti.64.2019.05.26.13.17.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 13:17:22 -0700 (PDT)
Date:   Sun, 26 May 2019 13:17:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
In-Reply-To: <20190526193651.spvm2vtrwxlhsjrv@linutronix.de>
Message-ID: <alpine.LSU.2.11.1905261250590.2394@eggly.anvils>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com> <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org> <20190522194322.5k52docwgp5zkdcj@linutronix.de> <alpine.LSU.2.11.1905241429460.1141@eggly.anvils> <20190525084546.fap2wkefepeia22f@linutronix.de>
 <alpine.LSU.2.11.1905251033230.1112@eggly.anvils> <20190526193651.spvm2vtrwxlhsjrv@linutronix.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2019, Sebastian Andrzej Siewior wrote:
> 
> Okay. The GUP functions are not properly documented for my taste. There
> is no indication whether or not the mm_sem has to be acquired prior
> invoking it. Following the call chain of get_user_pages() I ended up in
> __get_user_pages_locked() `locked = NULL' indicated that mm_sem is no
> acquired and then I saw this:
> |                 if (!locked)
> |                         /* VM_FAULT_RETRY couldn't trigger, bypass */
> |                         return ret;
> 
> kind of suggesting that it is okay to invoke it without holding the
> mm_sem prefault. It passed a few tests and then
> 	https://lkml.kernel.org/r/1556657902.6132.13.camel@lca.pw
> 
> happened. After that, I switched to the locked variant and the problem
> disappeared (also I noticed that MPX code is invoked within ->mmap()).

Ah, I wasn't following what happened here while it was in linux-next.

I certainly agree that all the variants are very confusing, and the
matter of mmap_sem particularly so. Because it used to be a simple
rule that you needed to hold mmap_sem to call get_user_pages(); but
that can be so contended that get_user_pages_fast(), and VM_FAULT_RETRY,
optimizations came in, then interfaces like get_user_pages_locked() and
get_user_pages_unlocked().

I think when you say that you "switched to the locked variant", you're
writing of when you switched to using get_user_pages_unlocked(), which
takes and releases the mmap_sem itself: yes, using get_user_pages()
without holding mmap_sem would have been open to serious errors.

The documentation in comments above get_user_pages_locked() and
get_user_pages_unlocked() looks rather good to me, actually.

But this is all good reason to use the less challenging
fault_in_pages_writable() instead. (And also saves all those GUP
developers, who from time to time have to search through all users
of GUP in one form or another, to make this or that improvement,
from having to visit arch/x86/kernel/fpu/signal.c: they will
quietly thank you.)

Hugh
