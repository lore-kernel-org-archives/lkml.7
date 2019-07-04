Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485B218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562277334;
	bh=UPTxVNPgLE7Dg+v4vbdt7pjYfg3G0fYHNbLUFJOJsAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lwBa1YA64rxSCkrXit8qe8wpb1vxgeUEVK+J+v+I+xiQngazYm4ugjDfwxnzdzden
	 B8f+5ScAKRzUDJ2jEKmputf27hFtlhRhDZoYxU9grH+9dQrc00syT7d9O4Q2U1zJT4
	 NVUXHmL6ZqHa/SKo1PL39QFn/j0eD5nxmVXFyBgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfGDVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfGDVzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:55:32 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E4E218C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2019 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562277331;
        bh=UPTxVNPgLE7Dg+v4vbdt7pjYfg3G0fYHNbLUFJOJsAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=htaEIL3e3mj7eLuVxA9vniy5FxObCL+0EBZf9DhGVjuxAorXHzCax7IzNSJ2rHFC6
         8H8l3FfZf131KRyoYNMvMU+38ulo/yEhBDRz7AlBeXVQ5lq0kjPYND1AEyMvRcOqib
         xqk+s4cqW6x6gZ32ASpnH3Fe9b3Vx/G3irLc1JlY=
Received: by mail-wr1-f54.google.com with SMTP id n9so7933831wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:55:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXTOUUsQiHa5w2AZQ38dsle/X53GT+6LndQ5FiT61PjRW4Hbvpt
        hCdOUForK0Q1M1FLCtxXUn1uqgL1qXx+TGe0g6MhDw==
X-Google-Smtp-Source: APXvYqynsGWfU6tSI1xxFu4PUXLCJzliGJvAE8jO/S7FMZKXbIT6FbKVhPrcIvjN53Yny/EjOhAMFhdH4Wq1fXWcBpI=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr417959wro.343.1562277330223;
 Thu, 04 Jul 2019 14:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.477489028@infradead.org>
In-Reply-To: <20190704200050.477489028@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Jul 2019 14:55:19 -0700
X-Gmail-Original-Message-ID: <CALCETrX_3FvH6rhW08x+=PMGO3HoE0fcp2LRvykyL2604fiS0w@mail.gmail.com>
Message-ID: <CALCETrX_3FvH6rhW08x+=PMGO3HoE0fcp2LRvykyL2604fiS0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] x86/entry/64: Update comments and sanity tests for create_gap
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>

Acked-by: Andy Lutomirski <luto@kernel.org>
