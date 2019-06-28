Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06FDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8F214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lh/PXUfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF1FrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:47:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44738 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:47:09 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so9944857iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fvuYML5uzQgIUwNz7fCS/6vO91+ePnv6G7iaXOVewbE=;
        b=Lh/PXUfNzB9+Yc3PqmnULJsPt2VQgNpCN5/zylaX+Hmw9OmqW6glMZiI3omQZX96Fc
         nCBpzg8MUVLXTC+3j7tC4tgeXYCZRZWJE/eUPLQwk46X7HbLafSb3pVCBoJyA/mSANfq
         /tb0Vv6rv6sERdmMPDB8fMeo7dUe+noq9BDGDjJfW4BEHMIy+d8lgrO7SgWFQUPtARLC
         Z+GWSFmkad/CsxXWM1JNvClu1KF/qEUBefedqYubAQ9icruKIkzRehlNlZNMbX5Njaif
         PVdGoXQaCWlxSwnkNwT0Vznkmj93gOQUcTNGkDEvbiTpDOjoo3rZ2mS+1SEUJkW/JNZS
         p3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fvuYML5uzQgIUwNz7fCS/6vO91+ePnv6G7iaXOVewbE=;
        b=TQDCUT4CmZIRbo0JA95I/FikuV79GMZFu0aVp2BUJ65Ar5d993BkStijBrd09CCPFN
         DE3M0N+tlAl+e9ekt/I98d0ZGmq1KLYYM8l8GxmsP3vCNlvfp1K9GYVkYLDyfZ4/Lk0R
         fa6XcKoFE2Q9d4H9FHJbNgpYWmeJgegE1u/AqWGL5lMWpkibgUmbU/WJ7+PZFHAYihWo
         D78ZYQzbhAVOE7j63OXJ4upgIpg5xKoqKhFjc+5SHVAKaKJCAs4/y5DcMAkHygEFJHwW
         qDlf2fy4zAmxwDBRHyjZYGkTX7tvj/5UtEnrwuAkKZEFWxgJommY7/33gnVfAezPLaZi
         Orug==
X-Gm-Message-State: APjAAAUAwjHvYwpzo1yZnWUqYMbBXjNK1kg90hk7kF7BcVVNts7ga1WO
        xSEJmWM9Q1qyc54TNHlyYIpBsA==
X-Google-Smtp-Source: APXvYqyMCUI3j/PylnvKJ/FaopK/bHzh4vEpw/kHIraAfhhNgKnEs1KXhjU6FRT2a0v5mz1ckRca9w==
X-Received: by 2002:a5d:81c6:: with SMTP id t6mr8927688iol.86.1561700828423;
        Thu, 27 Jun 2019 22:47:08 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r5sm1049107iom.42.2019.06.27.22.47.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 22:47:07 -0700 (PDT)
Date:   Thu, 27 Jun 2019 22:47:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Changbin Du <changbin.du@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 3/3] RISC-V: Update tlb flush counters
In-Reply-To: <20190429212750.26165-4-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906272243530.3867@viisi.sifive.com>
References: <20190429212750.26165-1-atish.patra@wdc.com> <20190429212750.26165-4-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019, Atish Patra wrote:

> The TLB flush counters under vmstat seems to be very helpful while
> debugging TLB flush performance in RISC-V.
> 
> Update the counters in every TLB flush methods respectively.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

This one doesn't apply any longer.  Care to update and repost?


- Paul
