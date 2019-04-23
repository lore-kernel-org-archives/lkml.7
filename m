Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C2C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2AF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556036415;
	bh=2OT9KGiqC+6zd5kn44Txotwu4I0Uuogn1Ev4NEa7fQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WyeIxTnR8NpLbpEcbGR1mvLYkL647EMPrHp353dXbuFLZPmGctGQsjta1BatoMLQ8
	 fILIF1olObX7lMT1VNjq0WYWmSE4dzhFAptR6AI5/HBJjtbwy7RzVDoWWxlYdPQmtT
	 y/oyc7KK7prwW03wqpVK5ANP07LVKq+WZnpkbf54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfDWQUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:20:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38975 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfDWQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:20:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id d12so12246437lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lZI3PImqx3T4CK/0DFoAjfnTtOk7dOVBphM/XkSKVI=;
        b=U0ZAOGTH5UzOQdSVmsRebl4caZMqgVo2nPoPpTPrrdJ2jTA2RW3NvPCtg1KZ42Zvcn
         G1ZGbbk7dpA34xaZlDxhRhMjPICHO6n25H8k2Y6VQo012xfUtNyPqEP4sg7Co05cV8zT
         6xNAONXbiweJJlYFDC8Lw3jO/2/rX7GIsZO6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lZI3PImqx3T4CK/0DFoAjfnTtOk7dOVBphM/XkSKVI=;
        b=JFJkKJf+sSBiTh4XQekweJFSRSp33/5fQxAsfdF/pjyZiArgYUPMceanVQqJgUWWK5
         0gXS/BS0VN0FtefC7CSNGPPcNuVAt+RDTSZz/OTjmft3BzWDFSgYG9T30YjCTQTNBqi2
         Br1NmX8zYDwJzbie68RgIWtmWetBkmwTMIGr945p82SzbzYSCdn06h0/XYKAgtne2bzS
         UiBFumtIBWu9FnlapX+CEOkr7o0NOA1ByFVWtLyVQ1vC8rItf9m+eOBdQFCCWuIKTvAp
         9fZeGSujETkyeVLdnWF44ILRhiXRLEMFM+purl00cfoh6J3tQEbKwYxazSiGwpQHNSSb
         4Lng==
X-Gm-Message-State: APjAAAXqFtggQ1E3hb1XxCrWEU0nNgwgOunhHBX+XhOoN1p4X4pZXyiC
        IxITLCT+XFqowJMNaB72kfvKwrGMAP8=
X-Google-Smtp-Source: APXvYqxQwHMTOYapFQRB5XrlwIncK+ed5R3s1utwIzQZE96K2oMX9miqmXFZ8gzVeeyoDvSoDiWL+g==
X-Received: by 2002:a19:e619:: with SMTP id d25mr15070229lfh.66.1556036407943;
        Tue, 23 Apr 2019 09:20:07 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n4sm3794079lfe.15.2019.04.23.09.20.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:20:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id k8so1540323lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:20:06 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr14738625lje.22.1556036406473;
 Tue, 23 Apr 2019 09:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org>
 <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org> <20190423082448.GY11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423082448.GY11158@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 09:19:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_yKXPmkTcHWPsf61BXNLzz9bEUDWboN4QfeHKZsCoXA@mail.gmail.com>
Message-ID: <CAHk-=wg_yKXPmkTcHWPsf61BXNLzz9bEUDWboN4QfeHKZsCoXA@mail.gmail.com>
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-next@vger.kernel.org,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Now, we could of course allow this symbol, but I found only the below
> was required to make allyesconfig build without issue.
>
> Andy, Linus?

Ack on that patch. Except I think the uaccess.h part should be a
separate commit: I think it goes along with 2a418cf3f5f1
("x86/uaccess: Don't leak the AC flag into __put_user() value
evaluation") we did earlier. I think the logic is the same - it's not
just the _value_ that can have complex calculations, the address can
too (although admittedly that's really not supposed to be common, but
you clearly found one case where a complier misfeature made it happen,
so...).

I also wonder if we should just make "count" be "unsigned long" in
do_{strncpy_from,strnlen}_user() too, since we've already done

        if (unlikely(count <= 0))
                return 0;

in the caller, so it *is* unsigned by then, and we'd not be mixing
signedness when comparing "max/count/res".

                   Linus
