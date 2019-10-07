Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B7D218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+Y5I+rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfJGNl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:41:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37674 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfJGNl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:41:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so12397322wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1DymUfYCUkBtLvKqZBG2BDJK0pFyy+uWvMSL42B6Ss=;
        b=W+Y5I+rbCETeTd3zSOtYINoNLECYEKqOmhtqTDAd1Oki295s5IQtHYwqbc3NbI4nf3
         BcOnfzMjw31CCtBohix4nCsX/ovthQRffdaTxLQFYkZ6C0w34Hb8p3Kw/vcwipt7qf/H
         gn85JdL4z303jrta9oDlhYG+mfWQb8MpxLAS+EknwKnuh2lT0FMQehMwpPl1ygXKCkVl
         0IUxjvmC6557Jw9u3Aa6kay/D+E7sphEIwo88kx6zdhRCFwHBCdotdIqTlJgoKRKQvnR
         bAj+c922mMlcWjczESBx31xUbX0rdz/Zg97eo+F2TyyWtFe7mT2PVD5I5bmxWKR/iPTo
         o0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1DymUfYCUkBtLvKqZBG2BDJK0pFyy+uWvMSL42B6Ss=;
        b=O2n4k1VG8qRXL5ZIRy+142b/66ahL3dFsrRis+Hh17EGW0g5r0M7Jem/ciw6XWo6CF
         nJWIvCND2VQcTMk0rz/JlxuVFfb41YajDhqXktkwp0Xab/UuO17FHLCpL4AenWjmo9/I
         xuWzm6Lfh3nQgp5rCcO+8Y+33rQbczxccWSoDP4nuKSYE2T0pnQAteYBLccnXOh9qv7V
         RpTwjyYKD+iO9EeMxwTfAHurhAE14BrU4XFXKRTyRGf+Q0jCNsxoYQEh1n/IeJTh2noh
         7HTDGFp9XebtEuKN7XHA3fN31kRSJwFCMTju96cXdqqhl4cCE0I0cGmzj7iDFjxXwxbO
         YrWA==
X-Gm-Message-State: APjAAAVlQimoMcXMfL1GZMLrENMvwpM9vdfgR6HeI/ITE3frIPumWi+y
        6WJhfndvCeRNlwG1qH7jBKRj/A==
X-Google-Smtp-Source: APXvYqwgPFTmDn3M4fzkA7mrblggHx7Q7ntMyvm4KAu41hDTlk9sb7yTHRIPd7komTwCEFCCQJnQ2Q==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr21937845wmc.0.1570455686279;
        Mon, 07 Oct 2019 06:41:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id z189sm15872884wmc.25.2019.10.07.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:41:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:41:24 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: move namespaces.rst out of kbuild directory
Message-ID: <20191007134124.GC23938@google.com>
References: <20191007043611.31036-1-yamada.masahiro@socionext.com>
 <20191007060614.GA142813@google.com>
 <20191007081241.GA8279@linux-8ccs>
 <20191007072930.07b1e90a@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007072930.07b1e90a@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:29:30AM -0600, Jonathan Corbet wrote:
>On Mon, 7 Oct 2019 10:12:42 +0200
>Jessica Yu <jeyu@kernel.org> wrote:
>
>> This was my line of thought as well, since the audience of
>> admin-guide/ is sysadmins and users. Namespaces are mostly relevant to
>> module authors and kernel developers. Currently, I don't think there
>> is an existing good place in Documentation/ for this topic :-/
>> I suppose kernel-hacking/ might be the closest fit, as Adam suggested.
>
>I didn't see this thread before responding in the first, naturally...
>
>I think the core-api manual is probably as good a place as any for this.
>Changing the name to something like symbol-namespaces.rst is probably a
>good idea, since most people think of other things when they see
>"namespaces".  Or perhaps that mythical Somebody could expand it into a
>proper description of symbol exports in general...:)

As I said in the other thread, I am happy for it to be moved to a better
location. core-api/ as well as kernel-hacking/ seem to be good
locations.

I could imagine expanding the documentation, but would not like to
commit to it right now. (Even though I feel very encouraged by your talk
in Paris, Jon. Thanks for that!)

Cheers,
Matthias

>
>Thanks,
>
>jon
