Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65719C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AF020850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555022486;
	bh=ooB3PnrS5VvajFcIpDaJnvbW4cNczAlh+NPHXZlKPTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VtWY8txGagAfNU+0pfQy3vyGkntQb1CyL2XQeHFslE8KYnWKRzJO01wsttx7jPOZD
	 stlwVUUB8AchB/sJ5N/PoI/OMMoQELYqHiorjbMVtZc77Wv/SFLTLfxH51Ft/NvpYh
	 bB/ntDbnIRr9FeuDFW0/zJiI633qSrGZy0uTV82Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDKWlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:41:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46469 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfDKWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:41:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so5917253lfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9OJAyp4t4u1wo3/3RTNXRJniW0m65CwIzaYDMrQl84=;
        b=YaH7qNTPbP0oCjTv0isUhACSq/xmrG9WGYHvpwxxchWYWC7uXi28tc9JU4IyPJaNc9
         /QXcVIPtPD4BeRkGRSKd4YiJ3lk+08c+Kpuz/g8iHv4WxrF4mniHJRSCnvKGkic1bRC1
         iATUogiupKt/WwE2tJ3Fx+YQzal9KGVSm1xNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9OJAyp4t4u1wo3/3RTNXRJniW0m65CwIzaYDMrQl84=;
        b=OgZl65xc0TULNTdztSXpBOH+/p3QRWJXVX+lkwWMjCM0lTxiqXlfxmQQXS7sbQHtbg
         9JR6JBhlqUpmCpKHjxrJKkfEuvAZpTjuNW6fgBJaW9DlTaMi4gTt4yy5FLTJxbXlScmW
         kMxKDwQLxcLcKRluG77uow5Udyvdnx+hVB1hNbe/iVLAuuFEuNmmyq5cXZKg4kmcycvB
         AJfYaxih0IbiNQI0wjhOT5NRpBMHjEiCQ/4pn8eI3tf8tfhpFxq6O3YK6NJ80K3SmMWH
         h1woEVszO4DnYaCaqghrggBJomEbzEqaDIno7/supHM8m24VVAX12Msp2J7RmGeYGNTm
         3dRw==
X-Gm-Message-State: APjAAAUuP9j1kI48le0da0W5WFIW5GUQD21TY5gDwDVf+Jk+J60hGdJz
        Dng5YJzmKrpMVIdXjkx3+30o+7KvmHc=
X-Google-Smtp-Source: APXvYqy3DtHGt62YpSQ0KIOelOXB0J9XX3YsNWDqVRSOUPfVzdrKnlLDhlTV3ZwfZeibDa/j06v5tg==
X-Received: by 2002:ac2:44a9:: with SMTP id c9mr9176036lfm.68.1555022482166;
        Thu, 11 Apr 2019 15:41:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v28sm1155214lfi.33.2019.04.11.15.41.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:41:21 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u21so5962862lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:41:21 -0700 (PDT)
X-Received: by 2002:ac2:485a:: with SMTP id 26mr2324008lfy.128.1555022089231;
 Thu, 11 Apr 2019 15:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-2-will.deacon@arm.com>
 <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
In-Reply-To: <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Apr 2019 15:34:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
Message-ID: <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:13 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Minor nit... I would have said "All readX() and writeX() accesses _from
> the same CPU_ to the same peripheral... and then s/the CPU/this CPU.

Maybe talk about "same thread" rather than "same cpu", with the
understanding that scheduling/preemption has to include the
appropriate cross-CPU IO barrier?

                   Linus
