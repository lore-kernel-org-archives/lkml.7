Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D6620652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552248193;
	bh=IPjWXHu28vDMQa+swho0159XmNN3IoTuEQIXJluLquo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TTMhM3avUNAyo7AK5tLWrWtQvqHH0f2uZelQICweeYxBfDgDFAGxhj1PG9YYs1O9c
	 zkfTKBRmUDWaFAwdKkVzBEoJac/8BsLt2rBSRAyokuk+aHotlSbel5NdFE+5g9/aR8
	 jZOHmTSzN8JaoPg6Njxdlji96cZ1I38mh651yldU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCJUCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:02:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44811 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCJUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:02:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id u9so1836502lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwbjVaBjZI45PpSmnw9Xlin3P9fcUPM1xOoSmpv1WFs=;
        b=ewyfIUGwAK2fYQ0/fgJSxZvDXnRz/KigyMZQj+N5yGgaFqZxUL+cfJsHlOyxSc+d8w
         r5M7lHrUm9YEBxmcstuML6Xz/zsJYfmknk2kx+lyrYsY/LWN1M/PoNRgKYFkKXTbLwuQ
         e3tfBZKnQNUPLaadV6RptIF3zc1xiEs0OaTQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwbjVaBjZI45PpSmnw9Xlin3P9fcUPM1xOoSmpv1WFs=;
        b=EE5amlTdwT2e5VBMnc9baOsy4gpxJmwYo3RDBpIqoS3eayTwJMzEjXHZHiIsrM0L6H
         VIW4KAH9/y19wMCzk/Zsl2tDetfjj1gfqMzPYLjRP8frh0WjAhJ2oqgJG4z6Z6MkRFzh
         ofMTFbnWr145qdzilqHSrj74CEAc4XG5aiMFFO2up78MKdevh+4t+lbeC8hCvUg+gOMV
         x/rx4Fcame6DUUWcZWPNC1eMa8aj5zpX9x80+rH9sMOkr4Z2nuIyUjXwZeNIdK3f+Ea6
         dFWo25By6pcNeYtR4XZY4yDHwBJBmnhLoFoPlp7VrJuyHVAOcBOs5CDsTKRn0HlbkaTT
         pfvA==
X-Gm-Message-State: APjAAAWOWrtavTcHvyfGULLVmYgIUGdqqFXtfwwLMlWmf7uH1KmR8lmv
        O+Ao1pJubHP+dlA7nVFS13sQK+4jyF8=
X-Google-Smtp-Source: APXvYqxAJvI8iAG2sc1+yR5CNqIFvaV0gRfiwBQGAIjAQzqxalXNWCiZqHEc7UXYsAa92KXsjtJkqg==
X-Received: by 2002:a19:f017:: with SMTP id p23mr15361730lfc.103.1552248120775;
        Sun, 10 Mar 2019 13:02:00 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f1sm666877ljf.40.2019.03.10.13.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:02:00 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id p1so1840107lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:01:59 -0700 (PDT)
X-Received: by 2002:ac2:5542:: with SMTP id l2mr13312531lfk.136.1552248119399;
 Sun, 10 Mar 2019 13:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
In-Reply-To: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 13:01:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
Message-ID: <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 12:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> tags/devdax-for-5.1
>
> ...to receive new device-dax infrastructure to allow persistent memory
> and other "reserved" / performance differentiated memories, to be
> assigned to the core-mm as "System RAM".

I'm not pulling this until I get official Intel clarification on the
whole "pmem vs rep movs vs machine check" behavior.

Last I saw it was deadly and didn't work, and we have a whole "mc-safe
memory copy" thing for it in the kernel because repeat string
instructions didn't work correctly on nvmem.

No way am I exposing any users to something like that.

We need a way to know when it works and when it doesn't, and only do
it when it's safe.

                    Linus
