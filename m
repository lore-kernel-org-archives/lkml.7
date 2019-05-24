Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15222133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjpqvWwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfEXDpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:45:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42888 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfEXDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:45:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so3577002plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:in-reply-to:user-agent;
        bh=hauV9TUbw5u5o6lbfxr6yYOMnoD47dNbzCMdRzyXMW4=;
        b=JjpqvWwKj85+WeGdh2yxx14jPuEreKgqk/18fF726jZmg/FKSvbtfU2gB4jbgnJOCP
         CQL3GZyd1dE/toTILUG8zIMO4NqOiX7R1kdZjUf8WZ67KgoQkiJ+QNIBRjAZ+6cUtqwe
         +htLSyFAyk/v+eltnGIP7OIPoZhQdp9SDRUmlHIUAI/0QaFiOrJDsgGPoT1Jpl1W65H0
         LIIgKfvtPPSTkACn1rVT8ss+UxDYXKUzotcNdUr4RSBThTxn+KpYRd/aBu+ZT5W0aM3T
         vsIvvrC9i0LHr7EMsQOnsSNh6vpRZTfcfLFKeSjk/nDfaVTqHnL3YmvOVsNVSJN1JKjC
         1OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition:in-reply-to
         :user-agent;
        bh=hauV9TUbw5u5o6lbfxr6yYOMnoD47dNbzCMdRzyXMW4=;
        b=flh6XvVQUWm8H/XIqKs5S2ZPsARHzl0EmuV4A7nz6zKvOS2wzfGAI7XKC4hJ69uciS
         oAn8I+/oLG0sNREZy3ZApBq+KQ/4C+/gcB7K1J1wFBeW0KHVvgYSIuxS0BRhjiMTLSq1
         aEPPx9UJcnDsQpiL+AHCVr+bEYcBqoEgHx/FJlGM9bba6u813jWi5EIEsdvf5xLeog+I
         rVVuB8U78Eq3zCIBljrnDpXQh7EkbO/4+1ddf+XLZ1TQmxi6tReSTUAo9VvywLiMQ+E/
         2XkklzpSJaPp9RtpX3/SGCoEfSJmLULOgrZErJH0yDhCqTXSY1bvddMCmMSx32sHotib
         wzqg==
X-Gm-Message-State: APjAAAXjxvcTeUgagpojv6YdxwDO1HgN5+qg1O5Djqc0W0kySwvXnNMw
        9EqLj06cT3kAIwebsHiNbW0yvTCfrYsxNQ==
X-Google-Smtp-Source: APXvYqwslK8Mbymv2aMlOp+OCVhfblVdg3xp/H9Hjq6FY6b0qjWinz0FZNj5Svxgx4bEK3ZyqSd0cw==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr13257237plc.255.1558669533485;
        Thu, 23 May 2019 20:45:33 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id n12sm770911pgq.54.2019.05.23.20.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 20:45:33 -0700 (PDT)
Date:   Fri, 24 May 2019 11:45:17 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rppt@linux.ibm.com, david.engraf@sysgo.com, steven.price@arm.com,
        osandov@fb.com, luc.vanoostenryck@gmail.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] initramfs: Fix =?utf-8?Q?a_?=
 =?utf-8?Q?missing-chek_bug_in_dir=5Fadd=28=29teven=2Eprice=40arm=2Ecom?=
 =?utf-8?B?44CB?=
Message-ID: <20190524034517.GA6821@zhanggen-UX430UQ>
References: <20190524033045.GA6628@zhanggen-UX430UQ>
 <20190523203523.8f638f378b54df0ef7a18f9d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: =?utf-8?B?YXZpZC5lbmdyYWZAc3lzZ28uY29t44CB?=
Content-Disposition: inline
In-Reply-To: <20190523203523.8f638f378b54df0ef7a18f9d@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:35:23PM -0700, Andrew Morton wrote:
> On Fri, 24 May 2019 11:30:45 +0800 Gen Zhang <blackgod016574@gmail.com> wrote:
> 
> > In dir_add() and do_name(), de->name and vcollected are allocated by
> > kstrdup(). And de->name and vcollected are dereferenced in the following
> > codes. However, memory allocation functions such as kstrdup() may fail. 
> > Dereferencing this null pointer may cause the kernel go wrong. Thus we
> > should check these two kstrdup() operations.
> > Further, if kstrdup() returns NULL, we should free de in dir_add().
> 
> We generally assume that memory allocations within __init code cannot
> fail.  If one does fail, something quite horrid has happened.  The
> resulting oops will provide the same information as the proposed panic()
> anyway.
Thanks for your reply, Andrew.
You mean that it is not necessary to check memory allcoation in __init,
right?
Thanks
Gen
