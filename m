Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA72C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732020675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EXIOMxrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCGBsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:48:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33121 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCGBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:48:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so15362315qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/Apnqz7DLqTUitNTAxiKQCKqDbPIHIPtddeTjcAk2Y=;
        b=EXIOMxrLnBTcRm6axwswa4vB8+zW7ASLRuK4Xh5wO9FJNbbgE47TC79HQ9EEETuRJI
         cF72aC/1MIeLatIinOFG2PfQkC3Ee/nJeAzRLB3HxEl/I5L4pYF9KMPnFSoNC2NYhqEc
         OSdij1FdP6zShXD1EdLboNVObVtBp2JtU1Nvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/Apnqz7DLqTUitNTAxiKQCKqDbPIHIPtddeTjcAk2Y=;
        b=FjlWDduhygtMwD6pCvwJU+9stT28wCW3RFY+BoOvadAr5hOFNAMnCUq1UjIlbFqYNz
         C0M7OyJwvTTQE1mCqhC+2bzjflKUOiNmqbWLeF2tRTuJfevn5mI8D2XV0jNn9xupjf+3
         lXBBtTeRgRt2SSeyNCR74ZSsvEiZJe0bRhdcU+8GGxm80eEeuVJtla4e5TB52KWv3+wu
         UvHVBGbywcKOiXwwjxqZOF33tSIgRNZJwQh97THFpkz+mYOQEkpHhhj8+/z9I8Txf7HZ
         qyWGcHvBxxxs3P7SK6uL+JZdcIeH11aluJ9ER4loTpb4aG5oFF70r3nbU5udxqoMyZTl
         cHqA==
X-Gm-Message-State: APjAAAVcMz+uHIUlb4BUBYFH2/cNrtIo6IcfA+wQwwJx/YRRpjiKqODc
        SbJyeSfjYuH/HCmC4wu3bqnjlA==
X-Google-Smtp-Source: APXvYqzvU2u/YgDyb+PbNK+eWVkI1Z6Q2JvwleK5BmuubLvxO06sQF5GnXJB2pujITLvliUCzGqFMw==
X-Received: by 2002:a0c:d90b:: with SMTP id p11mr8697755qvj.140.1551923283886;
        Wed, 06 Mar 2019 17:48:03 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id h58sm2008673qtb.89.2019.03.06.17.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 17:48:03 -0800 (PST)
Date:   Wed, 6 Mar 2019 20:48:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Pavel Machek <pavel@ucw.cz>, hpa@zytor.com,
        Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190307014802.GA193359@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
 <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com>
 <20190306230944.GB7915@amd>
 <742b4797-9954-fb54-cce8-47fcad750c69@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742b4797-9954-fb54-cce8-47fcad750c69@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:42:45AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 07.03.19 00:09, Pavel Machek wrote:
> 
> > So your licensing requirements prevent you from having headers in the
> > filesystem, but allow module with the headers hidden inside on the
> > filesystem?
> 
> Maybe it's just because I've missed most of the thread, but which
> license requirements exactly could that be ?
> 
> The kernel still is GPL, isn't it ? So, any device vendor needs to hand
> out the exact kernel source he hat built the image from, anyways.
> (by the way: we should start a flash mob action of demanding sources
> from the pocket-computers-with-3g vendors, but that's another story ;-))
> 
> So, what kind of license issue could it be, which prevents putting the
> files (that you'd have to hand out anyways) directly into filesystem,
> while allowing them in a .ko in the same filesystem ?
> 
> I'm confused.

Take a look at this thread: https://lkml.org/lkml/2019/2/28/634

thanks,

 - Joel
