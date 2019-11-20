Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF14C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249EA2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4dx6smJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbfKTQTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:19:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40856 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbfKTQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:19:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so6189219pgd.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu2jR/6Mmwd09bHtXEWD+IrFeBmmq1D1s96is5WFkyM=;
        b=C4dx6smJC7FVaMVL53K9ToTHJOjVnVW+3k6p5/wVoZi4VkpJqpUpNeKfEjspLIhf71
         siCnCNi9Pq0+q118/G9NC2TByQBD0NgrAHbtmSMqLBbCoUK1Jo/UV1GVTxRk/uM+tzls
         Cl0BmlkLH6dEWrQQDXtwE3JxIHxb5yhJw7CX+at4ozNwb71cH5XGgiU6/bBxCjwC0UCZ
         is8vsRRK93C1ihpR7uWGdxjtTNV7NMA9fhYk2FhE/JBZ7veqvhRaj0g67lo04rrijzD3
         PhXat0cjQ2uBWiCMVrcQ+BvTkJDKbs/rfzK924pIOmeWaNRUANNBk2zxYGTEiTs3A0LJ
         x3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu2jR/6Mmwd09bHtXEWD+IrFeBmmq1D1s96is5WFkyM=;
        b=NL0mEAcqdX1Tm4I5VWmuwdnGcuILo1HB8raMQ59BKCUjgkVyrhgiTnP+idPifrhu0U
         +5SgNEvvlFzonVaZu/s16EVj1M0301eO4Qw0AgAkF0hXQBWnbPcKKVaKmLZVlpVMm777
         rkEI1+XMt0ihLNzytF+FOdqIpNSw8lQkGYkzCoeeF5P3VlldxW3/7H/54n1wRH8uzVd2
         50iqfM/Ki6sEt9MfJMRxdA46CVGWYb7H/Tu3XQVVBlP7Oa6eOQfWk7gjw44tF3+kA3XV
         GeWgaJpnbYNjs0vdg8UlKvPD3PKhaZr2odJgr1aRX4KUnrN5Sn78yiCUHX51BXjRlcRG
         LQUQ==
X-Gm-Message-State: APjAAAVw57fZfnz+uqWzdzqvy5F5va46yiRMcsosBqMXNFxYZXevB5JB
        +Hi5vkChFKsG4cCzRlSUTJ7BEEA0sWHyJcqo1NiOVg==
X-Google-Smtp-Source: APXvYqxFCcYOvyOCvYHJRYXo5Y7pCm2L3aDRnwdFGjxGdni0IKYysa4KhYOihEy20zkzk2bnsTIonVkA23WjphDi3CY=
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr5018029pfr.23.1574266786126;
 Wed, 20 Nov 2019 08:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20191119003120.154041-1-brendanhiggins@google.com>
 <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org> <CAFd5g47+3TN4pOdeM0YmJpMP2uKnpJYUY_OXmqmZEn8OcVz6ow@mail.gmail.com>
 <20191120063219.1ad15b68@lwn.net> <2ba78e72-22e8-1c5e-103e-78eb892fb2cd@infradead.org>
In-Reply-To: <2ba78e72-22e8-1c5e-103e-78eb892fb2cd@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 20 Nov 2019 08:19:33 -0800
Message-ID: <CAFd5g46JjeoaDTRbNMzUkmtODkK0QX_3tiEbo1GA0KR_f7w9fQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v3] Documentation: kunit: add
 documentation for kunit_tool
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
        David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/20/19 5:32 AM, Jonathan Corbet wrote:
> > On Tue, 19 Nov 2019 17:14:20 -0800
> > Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> >> On Tue, Nov 19, 2019 at 4:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>
> >>> On 11/18/19 4:31 PM, Brendan Higgins wrote:
> >>>> +How do I use kunit_tool?
> >>>> +=================================
> >>>
> >>> Hi,
> >>> I haven't tested this, but Sphinx (or some doc tool) usually complains if the
> >>> underline length is not the same as the header text length.  (I.e., use fewer
> >>> = signs above.)
> >>
> >> Hmmm...Sphinx and checkpatch didn't complain. I wonder if it is a
> >> different script, or maybe I have to use a particular option with
> >> Sphinx.
> >
> > Sphinx wants the underline to be at least as long as the subheading text
> > above; it's entirely happy if it's longer, though.
>
> oh. thanks for the info.

Hmmm...maybe somebody should add this rule to checkpatch? I have
already made this mistake at least twice. :-)
