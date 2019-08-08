Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF1EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D3B2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565286051;
	bh=e/8nLuBj+e/I/UqTgJEPnnzAHFu+1jupmUTNKzWAabQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bTpTG9ilfn8r8I3Z+1HjRujetuOj72qKA9dRb9dnfiNDC9ALpXlD3GTVBen6pKvgq
	 NlY8FhpZ5INqNXeAoFPOLJENNk3xL/w0ir0Fc/4AIsw290eNatO2kvxbtk650RhP21
	 im27Rwsgre4I8mpwQHzRYc7uR/IZus1vAYs944RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbfHHRku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:40:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39541 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:40:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so89605498ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkt+lgTcRQkmSxLmFiGRLV1e/Czil9zvKfrfyoehvrk=;
        b=CtiKszUhPw7CM6bkf7cDm5JvKT+tQOxUqgCRqHWCbysQd/lrscToLDfvNokY+sgADz
         O33XNu27xYMhy1j6ZE1c0RCpmUEj0yxeIEyySDDyy5gAr/er2H2Yhx/T087GdgxZDnhH
         FVV0UnkKErs5BI76pHKBvHTCr4KnGxvWhXXyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkt+lgTcRQkmSxLmFiGRLV1e/Czil9zvKfrfyoehvrk=;
        b=rRyzHx8lSyTqXZ37CCmhRBAnh6d7Y0dHYJuclYqm1Itjs6Y8SiGv+G8IXQw4v5n225
         kjFyf67OP7gzB7yZoubGs9FA1zm9KmJCLf4Gd0spgh6KH1itqZ3ajvqXjUVOiMvigPng
         u6PP219KfAX00MFM+LGQn6cL7oFzpcp58wUABqqLzQz96Za8XJDjQebxV8ZphDrDWWkI
         AKeCsvM1ehk8CHvygJi2IjXQUQpUvjMk2Mxs5PkZ4CmiX9ctuhW0VIfe7hlG3av79kdu
         1N9iLTD8kNpW+bwOha/k3rHpQZEoKK3QelmQVk2AtscFdqvcUZmsmLzpHD78tNNh1Lau
         Hvfw==
X-Gm-Message-State: APjAAAUv29Jiqe7osWtYiUYUOseCx3YHky8xFvU6jkkyakDNOkRT+qdg
        ZZ+aj0JiDAnXXHIoujWK75BxZA2VGGg=
X-Google-Smtp-Source: APXvYqzAt10DH6cHFnoY+76umJAU9R+6LU8neBdXs09+SdhdNiVl4PtCQW0h/k4M4gU3XuQta0dT8w==
X-Received: by 2002:a2e:7604:: with SMTP id r4mr9014730ljc.225.1565286047455;
        Thu, 08 Aug 2019 10:40:47 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a15sm3073551lfj.58.2019.08.08.10.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 10:40:46 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id y17so65116319ljk.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:40:46 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr9102579ljj.156.1565286046249;
 Thu, 08 Aug 2019 10:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190808123943.1551193d@coco.lan>
In-Reply-To: <20190808123943.1551193d@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 10:40:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYYTiBOtzh2qh5KO7Mwh5cXkQEXnhD0b+zJ4J-WmEVDw@mail.gmail.com>
Message-ID: <CAHk-=whYYTiBOtzh2qh5KO7Mwh5cXkQEXnhD0b+zJ4J-WmEVDw@mail.gmail.com>
Subject: Re: [GIT PULL for v5.3-rc4] media fixes
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 8:39 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Please pull from:
>   git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media media/v5.3-2
>
> For a fix at the vivid CEC support.

There's no vivid CEC fix there, and you already asked me to pull that
tag two weeks ago, and it was merged in Jul 22 (merge commit
c92f0380673b).

I _suspect_ that you meant for me to pull a media/v5.3-3 tag, but no
such tag exists. There is a v4l_for_linus branch that has the commit
you point to, but no actual signed tag anywhere.

Normally I'd think you forgot to push out, but with the wrong
tag-name, there's something else going on too.

                 Linus
