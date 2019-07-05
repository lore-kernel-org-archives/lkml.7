Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E528C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4420B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562293154;
	bh=HXGvk3ymjZK3GXUnn1uwqPFa3TptHRDVzu8WpSDdLlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hjR7I6wuu2vYYCbxFJpPHoO2JgwMURILE/9/sE2sufWuSt5q6YHqoh94a3vHd8dD4
	 fkIXtGWe4pSK1O9BuDusz7qVlXi7S9tTxkr1SSNFeBDEj8qJ/1qkqnV22VQwL+gjl7
	 7qKMGeme7fPvPskAdgPtHboLee9rsIldXQAcU4m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfGECTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:19:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39068 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGECTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:19:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so7685554ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppmsU326jmCnGQtsgUl4Jwt/AQfrJLsdjvPTYcPdT6A=;
        b=Ijb3DsNqgNxMoBeF35blgNhG6L2yH/ppmCbwH3OrkeOuBkfG1xcIkS7V3Myi5KcuJs
         1pJvWkzbxNxPjvI6fcnJu6l+8yGGpxehHYOlVZ3t9Mfp7poM1moTYV3BRlqn6zawnJTU
         vw+aijKTsdX5MdAJQjyZS1iXr9dMGupP5HYUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppmsU326jmCnGQtsgUl4Jwt/AQfrJLsdjvPTYcPdT6A=;
        b=F10MUDuVXkFT04SyCUpxbeFZWJpo2hAPs7dLA7cMFRBMqlZES45RzFbO8LbQwZdx/a
         RlEKZ+oT7Jc3enVeomjR00MnbAxQAJLlf05MPaV7RJ+2ai4s+7agbFwRdkpAlvonc+w4
         qWRgKUg+W9XhN36x/TR4iZKLpgmNpLLgs9bs3iWox1R2n9Y7aKI+sf5MBmC5REg72D8Z
         vI8CnQuqGxtsQrckhrdmzekRUuo2vvtd5K4ToagWaIZA/LR+PH4awArMpXHwpHq8J/tG
         U6yLwkVUbhHYdLKsVUWyzvJCbj03HedvexmEDbWJFneegKWsp6U7Ys2XloZDOIhtQ/27
         1kiw==
X-Gm-Message-State: APjAAAVQU5LbrJrJXs2MlfTs44+vQcwtQ1qpoX9iQD1dPcf10MYdKQCB
        sif5tiNMbK1RKhRdgFkXG62Uunk9Oix9RQ==
X-Google-Smtp-Source: APXvYqwY+lr3/SqjOF7mvfWy5qTzPVzOxAZKbopb+PyAyP1oawTc/7B7l3x2yoIemsyT4F6YzuDH/Q==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr576894ljg.194.1562293149337;
        Thu, 04 Jul 2019 19:19:09 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id l24sm1472496lji.78.2019.07.04.19.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 19:19:08 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id s19so4543729lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 19:19:07 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr663528lfn.52.1562293147609;
 Thu, 04 Jul 2019 19:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
In-Reply-To: <20190704200050.534802824@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jul 2019 11:18:51 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
Message-ID: <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Despire the current efforts to read CR2 before tracing happens there
> still exist a number of possible holes:

So this whole series disturbs me for the simple reason that I thought
tracing was supposed to save/restore cr2 and make it unnecessary to
worry about this in non-tracing code.

That is very much what the NMI code explicitly does. Why shouldn't all
the other tracing code do the same thing in case they can take page
faults?

So I don't think the patches are wrong per se, but this seems to solve
it at the wrong level.

                 Linus
