Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC5C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA590214C6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M6/au7uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfFIAYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 20:24:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38074 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFIAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 20:24:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so4203945lfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+3zcOSI20hWPObsiSF7B1jjBYG49CwgDqF3xGgzIQU=;
        b=M6/au7uo2exz13yab4j92HGMBe2Sel1so7WZYgdfPjfFUlmg4AnsR0s6jvN45DNX58
         xcHY7SoYl0FpT4CkUJ27HpOCH/RJzHMTqJkbyoIVIoibBFPDgsDW5NYnVpcDaY61EdQl
         w3KiH/q4apRfu6r9lvRrR8mMgs51CqSIDZUQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+3zcOSI20hWPObsiSF7B1jjBYG49CwgDqF3xGgzIQU=;
        b=jYqrYTNN1yVtIEZhTYkB9HdjFatIv0nDFNdZp+z8F8SjrIDNkE6vISWJsjKG5sfjpZ
         2uAOjC7iMbaStuwPIPYWYHya79iBHFVQ3mv3KsKD9N3Ob4VjGUxXzHOYpurixmQjKRY+
         3JfPvR1eG5+hGARhF6Nj7Dgx7KucmtfUX657hGHxzOUGTRGit7lWYV2stZ5GnB+Hc3pN
         NGRIKaFHy6TS4kzHbN66rIwCvkdqCpSlrrMu0TL2oa7R/2wA8F5J5xm7HYOBjI7WTbSc
         g+EGHXNA+DBA9mAP/z0D6A5YA9w7wo5rpMXBt2jVXDBS8JAwCcLoburGBbV9yWDmnlIQ
         3Gnw==
X-Gm-Message-State: APjAAAWXolRx9zrdEEW0TgZFpqVVxGh4EIkkWxvlk/sxXcv7eFE7CFwG
        J63WQPgdD/QW5FuEN3wIQLFHjYcTTOZO+/YWkz2eZw==
X-Google-Smtp-Source: APXvYqxU+OT1uWDz7nkETUEqMZYXLiVx/x180wwDd6Ktooa9SgHChUhVWFH1dwj7zzwpu547W9epz4o3kPlTY8SMaog=
X-Received: by 2002:a19:4017:: with SMTP id n23mr33198876lfa.112.1560039888556;
 Sat, 08 Jun 2019 17:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
 <20190531135051.GL28207@linux.ibm.com> <CAEXW_YReo2juN8A3CF+CKv8PcN_cH23gYWkLfkOJQqignyx85g@mail.gmail.com>
In-Reply-To: <CAEXW_YReo2juN8A3CF+CKv8PcN_cH23gYWkLfkOJQqignyx85g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 8 Jun 2019 20:24:36 -0400
Message-ID: <CAEXW_YT93U4OAVUggkR7E3KV2m7pdVwG-r+x6zjtrGzortvc4w@mail.gmail.com>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:43 AM Joel Fernandes <joel@joelfernandes.org> wrote:
[snip]
> >
> > Either way, it would be good for you to just try it.  Create a kernel
> > module or similar than hammers on percpu_down_read() and percpu_up_read(),
> > and empirically check the scalability on a largish system.  Then compare
> > this to down_read() and up_read()
>
> Will do! thanks.

I created a test for this and the results are quite amazing just
stressed read lock/unlock for rwsem vs percpu-rwsem.
The test is conducted on a dual socket Intel x86_64 machine with 14
cores each socket.

Test runs 10,000,000 loops of rwsem vs percpu-rwsem:
https://github.com/joelagnel/linux-kernel/commit/8fe968116bd887592301179a53b7b3200db84424

Graphs/Results here:
https://docs.google.com/spreadsheets/d/1cbVLNK8tzTZNTr-EDGDC0T0cnFCdFK3wg2Foj5-Ll9s/edit?usp=sharing

The completion time of the test goes up somewhat exponentially with
the number of threads, for the rwsem case, where as for percpu-rwsem
it is the same. I could add this data to some of the documentation as
well.

Thanks!

 - Joel
