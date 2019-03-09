Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEFEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB0D2064A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552150455;
	bh=80dXcCEq0zA84w0FbRo4dlLAnEMrJuRx6BxPJzg+gsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z1Ok7PANxY1fzH+7JtcMW2A6RA5bjXK3kIiLFUovFQmes35Jnvte1Tyc1FTM2Sgxv
	 BU3cCB2j9xKeOHM7dHZdu85nWYkaud5vmXo4kpJGRjQ2zqRAuizUaosNLX/cRyCZA2
	 oMvib5lj+8p1P8ZWejguB//GBIL7UbN0kHGBIRJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCIQyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:54:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44135 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCIQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:54:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id u9so516066lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nS/lk8A81pkD+2fljOTlYL+nQ4SnSSZkiN26ES9CJs=;
        b=CZ3rOn3GPwFOfxnLDMNaGjr8n5f1YrWoh1zA962LIUR9OBeJasmMnAl4pi8BlgnXzp
         4kIiTQ0obTUZ2heVpdvDrw59sf8p9Ym0wW3ErL+G0dFZE4bwIhys+QTuhFJh0whsyKBG
         976yXRGJiqF0Hbdf7sbBXP9V67fQSGk719sI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nS/lk8A81pkD+2fljOTlYL+nQ4SnSSZkiN26ES9CJs=;
        b=T8KKIqQJx/b6rV++5zOt2xcCP1NlFOkcGIeQzwJlOefUB2QzAFkzugILbhrpL7MIcQ
         JosWI9u2w+/haLsm6Z55mOTOZuF31ES/dQhKkjfBX9oJqi45qbTV9oLQN+b3wab+XyB6
         NECrzdZ4Lq29iwvCdIlvnuQsGgmZhgl0+lQXOOXbIoGTkfW4D2gWqzRNVCCVwao5lJj5
         /45985crWzos7e6t3Qh0i6+vfruwfq5WtLwvv8TtkgZ1dpm+o48inmHRtvdwV0P2gbgi
         La+z5g7rFMvM1oQbS7b1ysL+uYzotwiIMXyIGu+R96osu73iTz2zpYIarEn0YjqzNV9D
         OWdQ==
X-Gm-Message-State: APjAAAVNJZyE+sVHMX6I309atC74kGYVnb39GhZ0QSmjj0WQnw14yMA3
        eotdYN6Rog1c2KMTPRCSkUnmHwCflmQ=
X-Google-Smtp-Source: APXvYqxPqCR9wOHXSp+8lK/UhTZTHElYgHlZ4gv66fPXCqlpCTR2Ki3xwiFHmFZpdHE68UP7G7WDJA==
X-Received: by 2002:ac2:5325:: with SMTP id f5mr1243413lfh.77.1552150450617;
        Sat, 09 Mar 2019 08:54:10 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r124sm194077lfr.93.2019.03.09.08.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 08:54:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id k136so527611lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 08:54:08 -0800 (PST)
X-Received: by 2002:a19:48cb:: with SMTP id v194mr13725272lfa.166.1552150448462;
 Sat, 09 Mar 2019 08:54:08 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <nycvar.YFH.7.76.1903061310170.19912@cbobk.fhfr.pm>
 <20190306143547.c686225447822beaf3b6e139@linux-foundation.org>
 <nycvar.YFH.7.76.1903062342020.19912@cbobk.fhfr.pm> <20190306152337.e06cbc530fbfbcfcfe0dc37c@linux-foundation.org>
 <20190306233209.GA7753@nautica> <20190306153819.3510a19ffe510b674a7890ce@linux-foundation.org>
In-Reply-To: <20190306153819.3510a19ffe510b674a7890ce@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Mar 2019 08:53:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFY+yu=mQU=WqAC-_2aU+A6dFcY3D-Um-Q3hXobB8JfA@mail.gmail.com>
Message-ID: <CAHk-=wgFY+yu=mQU=WqAC-_2aU+A6dFcY3D-Um-Q3hXobB8JfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mincore() and IOCB_NOWAIT adjustments
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Linus, do you have thoughts on
> http://lkml.kernel.org/r/20190130124420.1834-4-vbabka@suse.cz ?

I think that's fine, and probably the right thing to do, but I also
suspect that nobody actually cares ;(

                 Linus
