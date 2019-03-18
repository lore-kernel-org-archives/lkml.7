Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CFF20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552928322;
	bh=pp3L1mqJSAO26WJTjD5NycTcH+F2wYSwDuLnMo5egG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ATRi2pNzBeqyGhr+aylD44vGL9AtVePTg991LjveyyTmnWuvtCeuBNSWbJLKBmSCO
	 maz/BBxzcgjfTMyXmY209YFDwIwlwO73bsOUw9C8N7nKT88IlqAVMqTKnUW3cFowZy
	 A7o4otz1rQtYO7QqeG+6dYh0owJQkoe5TePSZ1YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCRQ6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:58:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40807 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCRQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:58:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so1085410ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5geA5GEp8sppnFehn7T/T7ViLAZrvnUrHvXZB+77d4=;
        b=LIDvpVZkjnZ6HL6Ii1hhwT3dGdqLVfA3UKLbMG/fmgXugEcF/XnZGDqulZYS4klWO1
         vuKPCE3PfP9AzNw/U6/ibMzuddDQwuDsyPFlDaXdPdNFnGKumfI8fzjWZFAFjYx5VF75
         oO0iAFYN7lrJhbxTtSKmuvUwoQfvd836KHjKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5geA5GEp8sppnFehn7T/T7ViLAZrvnUrHvXZB+77d4=;
        b=HpnseHD+tmOO5kOV9w/rL371YYn86NhS79/vlZ1i46jwQEF9ZtH0WOJLUrhU3RCKWF
         Y3PkmwpYCrxSDv92uaxKBG3gRAfC56HUORr2GVisPlH/BjzknZy+GyZanJXWQR8QJJdW
         CsgVAZcpjlwLuQAX7tWmh9ltn5AJwaQQ8vWMsG/fNd0Era9XBXvN8hjaRcqXDtZVZ42E
         ENxGd6S9kRFpyxdIsNOPavdhNs4NDr8bMwYJp21FdBqgOBqfNSsfbScIDHk2iq8RlkQp
         LUyMpdT8JpEeXgsojw3R14EMUADNYN0hv/Ec983dEwpo9ZwbbI972rLEDwpjHxNPEMcg
         XV6g==
X-Gm-Message-State: APjAAAVro2l7UGgsauJxMWng8KlwWD/EU+OD9TTBWYxCPar9HtvVjNFw
        KRN3ResGXdNBYWxGmCF0JU1xQ0NFc1s=
X-Google-Smtp-Source: APXvYqzqsvJUjrzjFlHqxfHmTNXBQBGCnZDwQMOK+nXpTP9O2+vGlx7bGD39U244KcbW9Z32odhh4w==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr11617838ljh.91.1552928318392;
        Mon, 18 Mar 2019 09:58:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 84sm1126365ljs.10.2019.03.18.09.58.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:58:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z26so14486827lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:58:36 -0700 (PDT)
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr53335ljh.118.1552928316397;
 Mon, 18 Mar 2019 09:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155139.963285969@infradead.org>
In-Reply-To: <20190318155139.963285969@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Mar 2019 09:58:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
Message-ID: <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 8:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> We rely on objtool to verify AC=1 doesn't escape. However there is no
> objtool support for x86_32, and thus we cannot guarantee the
> correctness of the 32bit code.

Absolutely not.

This is just crazy. We had working SMAP long before objtool, and we
will have it regardless of objtool.

This is like saying "ok, I don't have an oxygen sensor, so I don't
know that the air I'm breathing is sufficient to maintain life, so
I'll just stop breathing".

So no way in hell do we make SMAP go away on 32-bit for no sane reason
what-so-ever.

Besides, the x86-64 objtool coverage will cover 99% of all 32-bit code
too, simply because we share it. In fact, it will cover most of the
code for other architectures too.

                  Linus
