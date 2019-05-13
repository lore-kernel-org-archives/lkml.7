Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2744C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DA208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557787665;
	bh=6L7KfX8dUY/7hRxDOv8URyoP1PYD4rAOP3+qbgb0Md4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V+MM/I6+fzufn7nbHOQybmzI/mqip0T8Tvb3EczCAfXGuAxuDrbscgIhV9YktEdiS
	 v5Ft4Vo4PLGPjxnTcLE7WIifVxawmQKr3/hlKz4NjN3XzptwR2vE6HUkfFr3qmQAoX
	 AIcHULvIIbJlN2mZYPUWXzc4vCsoOmK5FOZDU9FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEMWrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:47:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEMWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:47:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so12482972ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOjzR5gzdUf/7ChCYCZCTq7x6PiCIoqFFNcqS/TXVfY=;
        b=d/8OvGpKdy+Qzy6ImDfcGAuOZ997gQDh3TiXd97ZsIN2Ic67JkkXPFCPp406jfL4DR
         jDG0hEpEBHVWWfdt6En4IlsM2wEN/2HdVDkCBDwD26a7Sv7D0LOw/8VfEnqTyjPEtGoU
         EgLnDyJ7bnP+aEK9X2wKbf+082qeT2KWlO3d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOjzR5gzdUf/7ChCYCZCTq7x6PiCIoqFFNcqS/TXVfY=;
        b=KsPfOXnqWwv+qPsu8Si04PJuvjInugdvD+7aAoJLADYa6w8XeIVbCZIoqOcxLj7/4T
         Yr9oNOHQvwWNKOBi/fx42MVH2DVxxD/i8uft/b6pvrCIAnt5K2IJ+aoA0aDfoAXxkh/Y
         tJ+VMPHVctugzVdAz+s5WqwFMum+lU1IYOsaQf2D8JiCUcJ/owsEFJ25VKNOBDKmO6oh
         aXOv1VXoM19wreADzevka/NxePI+dCOzEk88T1wR9dvtAdK1jRehfPfIUWodAo1mYPUy
         wLkT8nZhvENgAky/zIWETQiKi34Lbg4fVf5WGy45oncnFI/VoqVAeQhM3GET+o77O6WF
         TAXw==
X-Gm-Message-State: APjAAAXhvWPIM7skulYLtHvuCd0Fh5iLLuhEVUVZdqXis30mvkUOGlQ8
        nNOAfahlOl6mBwXx+4x5NpW97m0X368=
X-Google-Smtp-Source: APXvYqwyr0KjTyMEfvyFdGMPU5TWc32NBe1wQdBCVlwu6jEDsxKUPFSD4ji8J5GOADolfiEWCg9RhQ==
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr14738425ljh.33.1557787660349;
        Mon, 13 May 2019 15:47:40 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v3sm3329529lfi.44.2019.05.13.15.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:47:39 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y19so10286297lfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:47:39 -0700 (PDT)
X-Received: by 2002:a19:5015:: with SMTP id e21mr15292317lfb.62.1557787659075;
 Mon, 13 May 2019 15:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190513195904.15726-1-agruenba@redhat.com> <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
 <CAHc6FU43Fv_b9hMiRscs+cPbwLmcCBM-9R32fSsK9gUtMVMGUQ@mail.gmail.com>
In-Reply-To: <CAHc6FU43Fv_b9hMiRscs+cPbwLmcCBM-9R32fSsK9gUtMVMGUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 May 2019 15:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipiSQ=+dTssFhjYXUS0VgJYRNqy8s_YNTL8HbZ6iKsYg@mail.gmail.com>
Message-ID: <CAHk-=wipiSQ=+dTssFhjYXUS0VgJYRNqy8s_YNTL8HbZ6iKsYg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 3:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Sorry, I should have been more explicit. Would you mind taking this
> patch, please? If it's more convenient or more appropriate, I'll send
> a pull request instead.

Done.

However,I'd like to point out that when I see patches from people who
I normally get a pull request from, I usually ignore them.

Particularly when they are in some thread with discussion, I'll often
just assume that  th epatch is part of the thread, not really meant
for me in particular.

In this case I happened to notice that suddenly my participation
status changed, which is why I asked, but in general I might hav ejust
archived the thread with the assumption that I'll be getting the patch
later as a git pull.

Just so you'll be aware of this in the future, in case I don't react...

               Linus
