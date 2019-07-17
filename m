Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6523C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814952173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YiDfBjaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGQRJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:09:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:09:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so25615247wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xqEMkscsbY5oL9SftmgUyHWcTOrzBMfKcOHFnSqBMq8=;
        b=YiDfBjaC+cpAv2JoO1VJ8Fmwf6QdIduUTHIC71WXTa68ghZUDgtajXY3RKhEIYP43z
         /IDmQogOEj6OGCmLywjon/V70o+tMzL9CIkwjodHBzM7jomyAXQd+CjaE38O+CWDZ0le
         Ujw3M9dIZviOjT7FJi87ZZjkNa8Ax1I+JBl9FySMQhNzcpnHWjdB63oiuQA15Qe52Y5H
         p4fdmIaIXtFlQKGGyDBfy0xDN+OO+eChSXMTztBlA0o0tJ0qngDkD0JePDkI8dx/mGAZ
         BdtbsH9mrGsaogzhFVEmiSBaVecfNqB1t48hOJwf0XYrJOrBAfWISw4hZVPJPgNN5DBD
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xqEMkscsbY5oL9SftmgUyHWcTOrzBMfKcOHFnSqBMq8=;
        b=ohBONVPr5NBP13ZcpE8ohrSdxb5gaTJWPp7LOZqDEOEvyndCpybQBltiE4uoSvkwKE
         YT0cvi5q2U+hK+CxZJZfklSe1E89QrLe0JYlxRBk7Zsj4iDtvXRE2Fvau4cFmRwRXuJ3
         l/AvbY8Uy5HmeDfZcFCBM3k4Llepr/fytSALfKcnAf9rnCWSIghi0FpdLJDtmnjHvBzQ
         uekUj9eGK4jZYkL0pjq9SqFLFW6w2coJ0wCoWy6yCEcGqRSqmSyCQuX1rZKkg78S/Aft
         Bdq+DKiaBlp6CXZkbMBQ1dtgEpkAnUNA5srQSAfcM+V4/ghOsLduVdEHxsi8spCh9xZp
         HDVA==
X-Gm-Message-State: APjAAAU5m2ghXtYcQ3ReyE7mfmZK2LRs3bVMJGBrbZbThG11x0lga4q8
        VTFSK705UIFLsdMcX32d81cNxlPPBMM=
X-Google-Smtp-Source: APXvYqyAdOzPqW3HWrQP32WOm05reBgOXLygVi3Mj8KLfHriqcIebhnlOhWk1iCOFPhJD+OZKsr6eg==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr7278143wrn.197.1563383380230;
        Wed, 17 Jul 2019 10:09:40 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j6sm34119676wrx.46.2019.07.17.10.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:09:39 -0700 (PDT)
Date:   Wed, 17 Jul 2019 19:09:38 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: incoming
Message-ID: <20190717170937.geeejwiawngmugwb@brauner.io>
References: <20190716162536.bb52b8f34a8ecf5331a86a42@linux-foundation.org>
 <8056ff9c-1ff2-6b6d-67c0-f62e66064428@suse.cz>
 <CAHk-=wg1VK0sCzCf_=KXWufTF1PPLX-kfSbNN0pk+QHzw7=ajw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1VK0sCzCf_=KXWufTF1PPLX-kfSbNN0pk+QHzw7=ajw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:13:26AM -0700, Linus Torvalds wrote:
> On Wed, Jul 17, 2019 at 1:47 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > So I've tried now to provide an example what I had in mind, below.
> 
> I'll take it as a trial. I added one-line notes about coda and the
> PTRACE_GET_SYSCALL_INFO interface too.
> 
> I do hope that eventually I'll just get pull requests, and they'll
> have more of a "theme" than this all (*)
> 
>            Linus
> 
> (*) Although in many ways, the theme for Andrew is "falls through the
> cracks otherwise" so I'm not really complaining. This has been working

I put all pid{fd}/clone{3} which is mostly related to pid.c, exit.c,
fork.c into my tree and try to give it a consistent theme for the prs I
sent. And that at least from my perspective that worked and was pretty
easy to coordinate with Andrew. That should hopefully make it a little
easier to theme the -mm tree overall going forward.
