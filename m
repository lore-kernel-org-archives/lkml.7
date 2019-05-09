Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD161C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ED521479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ge8R844S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfEIT2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:28:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39839 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfEIT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:28:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so1707001pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mSogdT1b1TrauWJdc0+lW0R8qL7KGKdwvRVPra/F2u4=;
        b=ge8R844S9rhQhPZywYJzkfKzn0+UrddioB1eT3CI+Rxgh7FM5k/Nj631+ajLB5i98z
         qBuIhlAi7+7nh6F7Z1rJckUuSkcwqxtG9sGhGQoT+x1lUg6X3OXiC6ccNVUb1g4+KJ3l
         N1+vO7n2+b3u1X/Did/QTcwhdXYLekpehe87DVnoLH6kY+122yYPr/Ex9cn7pf7BP/W1
         FlrT5uOI64/8jOOZYvR1fypE9LJklRZHypbB9rqVJZx8+MtL+1Nrohw+knyr2bfi5W17
         OI+nfZAAHolUUB31C+q4yU4AmDT6PfWpOuppbMD9XX7P7zp9QAx71kIPMtx5e3xSH1Q5
         tKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mSogdT1b1TrauWJdc0+lW0R8qL7KGKdwvRVPra/F2u4=;
        b=Y5hJFozeBlEeIBkHmyXO2Ot/YWygWvOf+c43/Vupl4Gcu/OAJTx0V73uNYCBdWYHv0
         HS/GMzdx1QDKc//YueXOimLQA59pXBjzhUFEbjGsAdNEO7J6x4Rm6o9c7Mx/Nfp7o3+W
         8T6orvx+cIGgUlS91LZTeF6w276Xlpc+Mzq55OKvjN1OLolzuoqmmgd+VwtFCWkDyQn1
         42HaHj26ZNbwyIjs+foMtSt/oCHbgucH6eqOEShMDIye1TzfrhMNOXPvRCkAF2nHAjLl
         uDGvUWBErkmC+J75FEAMi13RcnR+iZpAYkKgl8VJSZyXvZcHaalOXjxeWobPnmQ1USMH
         Y7Ig==
X-Gm-Message-State: APjAAAXYIi2tfaSvKJ8O1iCk2GZY8avUWU7SuJjBdCRPxgCInC6p7eYV
        y+ZEBpcTYlk37z4v6c4hCddepw==
X-Google-Smtp-Source: APXvYqz/zYt5LNbOUqYwUYqUaZNqn28INg1eTCOj3kgCLcwZ9Gnpmql4xKPflas+TJJo6HIP9ZvJow==
X-Received: by 2002:a62:1897:: with SMTP id 145mr7992573pfy.122.1557430079463;
        Thu, 09 May 2019 12:27:59 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id j12sm3809086pff.148.2019.05.09.12.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 12:27:58 -0700 (PDT)
Date:   Thu, 9 May 2019 12:27:53 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joao Moreira <jmoreira@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3 0/7] crypto: x86: Fix indirect function call casts
Message-ID: <20190509192753.GA233211@google.com>
References: <20190507161321.34611-1-keescook@chromium.org>
 <20190507170039.GB1399@sol.localdomain>
 <CAGXu5jL7pWWXuJMinghn+3GjQLLBYguEtwNdZSQy++XGpGtsHQ@mail.gmail.com>
 <20190507215045.GA7528@sol.localdomain>
 <20190508133606.nsrzthbad5kynavp@gondor.apana.org.au>
 <CAGXu5jKdsuzX6KF74zAYw3PpEf8DExS9P0Y_iJrJVS+goHFbcA@mail.gmail.com>
 <20190509020439.GB693@sol.localdomain>
 <20190509153828.GA261205@google.com>
 <20190509175822.GB12602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509175822.GB12602@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:58:23AM -0700, Eric Biggers wrote:
> Is there any way to annotate assembly functions such that they work
> directly with CFI?

Not to my knowledge.

Sami
