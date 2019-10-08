Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B04C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0C218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hsox7f1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfJHVd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:33:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34047 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfJHVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:33:57 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so351156ion.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZuBgbJzoXltmhH0lNq67zyda70EYzZtMbVg27O16d4E=;
        b=hsox7f1O1JhOkCIRKYbrxjgajBPsOSDqi7B1Lgvugxaamtq9i8nHkkuJBUx+fuqpmy
         BAak+i52MGnX+KzvK730xUE8OgRGhRjWhnGkFA0okRMkJZ8lV6Q62WhiPg+6n0vFgHbL
         VCEAwKUPWz0rPth4e7crkTcSlit2voXqJ0ejpl9sJAU7dNLLjT4gqcHH0rIgjJllHUEy
         PhH3RYFcBRHAIgaKfDAF6XcaX/IvuwtFwRKYJ3kZi33kqKQ1pMfAy1jUs6Wj0FZ/F1G3
         kGyRJLvuLqMwxBTP7vx/7G4QtZd9roGDtY1NKikyRwzKqH8JMU5sTbhDnrBfv3XSNB4G
         +aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZuBgbJzoXltmhH0lNq67zyda70EYzZtMbVg27O16d4E=;
        b=hn2fE4ryMfoLy65aGX3OBkA/+BFDZbFfEehy1nFiLOLE84o2peK5Y/HELFCI7ciG0E
         fnCETtU/h/yzfLsp35LY6CkSPQ2LbFKHQvvL03jwl6on388hWU6DrwCOlTjCnKqq8kzu
         tcc6Voqa3c3jMKWJI/b5Stk/F48fpPZF0eaTExGzHEBWUjoEM0zTdeoHZ2znN2w8TYlb
         lizOHT4k9O3OKBztC413oSNGGGyeoBIOwyB7oKcC4rig+hAFoB4+f71JmNSDs8zMO1nN
         vx0EHwkdTJRzgZ7zmRLUO9b9bbYDeNfugmoSeSGfgaGal6eds5ueYJh2WyN1lDtVmXsQ
         WLzw==
X-Gm-Message-State: APjAAAWqOCalDKFHSPNkAwoip8db6DU6m8q6fpELhAKUKPYdbgaeRRDF
        +00gsjThPJUf/JzeOLd5s6Xp+Q==
X-Google-Smtp-Source: APXvYqzsdLumb009bSD2b+NTzNpdbo2nocSDdqyWA/rpF/UqKzncKB6JaSotk0ttAt3W1vuG0mXL5Q==
X-Received: by 2002:a6b:c701:: with SMTP id x1mr331218iof.162.1570570436145;
        Tue, 08 Oct 2019 14:33:56 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id c8sm107904iol.57.2019.10.08.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:33:55 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:33:48 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Steven Price <steven.price@arm.com>, alex@ghiti.fr
cc:     linux-mm@kvack.org, Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 07/22] riscv: mm: Add p?d_leaf() definitions
In-Reply-To: <20191007153822.16518-8-steven.price@arm.com>
Message-ID: <alpine.DEB.2.21.9999.1910081431310.11044@viisi.sifive.com>
References: <20191007153822.16518-1-steven.price@arm.com> <20191007153822.16518-8-steven.price@arm.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Steven Price wrote:

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_leaf() functions/macros.
> 
> For riscv a page is a leaf page when it has a read, write or execute bit
> set on it.
> 
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv  

Alex has a good point, but probably the right thing to do is to replace 
the contents of the arch/riscv/mm/hugetlbpage.c p{u,m}d_huge() functions 
with calls to Steven's new static inline functions.


- Paul
