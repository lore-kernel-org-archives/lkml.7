Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527DE22519
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574255794;
	bh=i5fOo4y4Pm0C8GaoLuZdchcoGY/EzZ/0SgwAN4yN5Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zf1fx+URBeYbiIjlcWolFqMgTw8K7M1Cw+ZzhiZfq+9R7ksOAvHhOemaareM3V3uL
	 AdB+j3QVvCHdS4hmB2+dE5wF/6xfYis7nKI6fVUwID/RQLUd0m5rxyLHqomRFh9DFY
	 NvUX/EwhxGMISyUJKXk7BL9A69z2jT5HQW34I7qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfKTNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:16:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfKTNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:16:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so28103908wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4yrIyYWfXcBOT1nDN68nB0OKsMqoxxmq3jHpYqJV4Eg=;
        b=vAJwumFFT5T2gWiZdr+84jWOajto2CyKiKNcWFjEBKQe7/draNkapEADukv4JaUIMz
         4dgoyvQy4N3VJYJMMlxvRsNJFY9uTWNXogCz6DU4Ok/GZSqmpEeM+noPIXEZrMj7GJa/
         2/Ci5UDDkPAokY/fcdNKDdx0HII3A/DOlL9btcAiAEi0FgpHmlXWIzu3kqZxtzuG212+
         I+Erj7Yggork5sZrm1VRvzHgNJ/2S0MJ+TQoZLej2zMNu2LFmFhRt2wSQpo/OKNoTSWV
         qgE3KtgF9R6sEiRofGmZOgVIjgaZiZ5ZT38Mgitxqu/+zX+EolsB16CO8Q6BStUoDDbW
         wI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4yrIyYWfXcBOT1nDN68nB0OKsMqoxxmq3jHpYqJV4Eg=;
        b=O/QPEQqWLPmB+OMwop80gkO5sDk0rVP9vE2XnIUaJFOHPP10TybwvRHby+xF0OyTHn
         1mUxApzh+7WdmRR59FIkCrIsgjePHJOo7nvOha4d0iov6Yx4LWqujT3O1zytsTe6C+7w
         HT2TtZ36lOiufJQ1PrvgbG/sv0MhykXckxCaEKr/zvUYhANEDIDAdvu6eIbnYtbG2o/W
         PMKSEEzTF1rqQO6xU2/+lpikZKXlOzOAyRdO/UQizibGhUeAhrnz1v7xzuiDKKRAw0t0
         G+LZFg7mblKD9Wx3FQLxtNWhUqScKv1YhcACdqbxZX9Idm0JPaIJznVlWuJcHEgXzFOl
         VltA==
X-Gm-Message-State: APjAAAWHQaUXmptnRFr+VKG2cULqOn+hE0yBulARE+fbYNWkjkuySY8Y
        tYarA9RCRBn9faZqQhlTy04=
X-Google-Smtp-Source: APXvYqwkTM5SjpmgLvZzULUk63q/pM+Wgrsi8FuGIFiCLuSbm5738o5u9tBPhbJtQmnw69aw9IiS6Q==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr3472304wrp.265.1574255790960;
        Wed, 20 Nov 2019 05:16:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a11sm6912156wmh.40.2019.11.20.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:16:29 -0800 (PST)
Date:   Wed, 20 Nov 2019 14:16:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120131627.GA54414@gmail.com>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <20191120112408.GC2634@zn.tnic>
 <CAG48ez26RGztX7O9Ej5rbz2in0KBAEnj1ic5C-8ie7=hzc+d=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez26RGztX7O9Ej5rbz2in0KBAEnj1ic5C-8ie7=hzc+d=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> On Wed, Nov 20, 2019 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:
> > On Wed, Nov 20, 2019 at 12:18:59PM +0100, Ingo Molnar wrote:
> > > How was this maximum string length of '90' derived? In what way will
> > > that have to change if someone changes the message?
> >
> > That was me counting the string length in a dirty patch in a previous
> > thread. We probably should say why we decided for a certain length and
> > maybe have a define for it.
> 
> Do you think something like this would be better?
> 
> char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;

I'd much prefer this for, because it's a big honking warning for people 
to not just assume things but double check the limits.

I.e. this mild obfuscation of the array size *helps* code quality in the 
long run :-)

Thanks,

	Ingo
