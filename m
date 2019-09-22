Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E14EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA272070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569176680;
	bh=SC+4JmpvkcCRN5UD4A0vbPx5V59YHre4Q76emoB1AhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kzVqGruaNSYEXTDPgJ6yyhTp7G7bxeAhHaqLoXSGOn9TE7I9KgbA0mrtsX0ArEy8n
	 AJOLygLBSWks5ntpPTU13eDzL+0FA3D3a9XHJJFpdfLHNyY5HS/DInknDzDwMQtAOp
	 wHikfW1aSjOI5nTemEeatfYGPszAThSv00iQjtFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfIVSYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:24:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40688 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbfIVSYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:24:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so11526841ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCaniXiQG6Rf5PSnFKP6/rRWss/Ze+zbdtLs92wKBHI=;
        b=YXjTzvIjcre1wO3unIiG+6x4LsJhfBlbPF7k3LeHzyl6u5yZol3KpxHb4DRI+miaBB
         nBwB3DUgq8gtpHh/CIgt9VfIJIi8uYcDZeslJXbAoWx1iZGWd7j7FwIV0y/FRUX8fOYE
         XFKupDRYi7UvTnnFW1H7PtrQ5vcUkXRxBW0b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCaniXiQG6Rf5PSnFKP6/rRWss/Ze+zbdtLs92wKBHI=;
        b=Mfa3laiOcLzqnXkTkTkoO2Y6uMs53+fk6Y3v0ofQ2HXSN2z7z6y88nAxZRTSui8G4V
         +K7P6DBT6WPqz3teQH54IuQxgjPnkoNeAY/FQwL4SFhno0yfVYwEdYJqL9EO2sVk2dJS
         qFfL+ZHfXcSOQhKK/qLHpO8l/Px81zoxT/QCz4O6e1lxtvgFDLHcIXv7LoD+v4ksowXm
         RSNWHsETiDjLothtY8gVVUrL/ZwIQQi0E2/EYCxm+fYJFHrShDr22aXOa9mf0VAKQwk6
         x+1zRpR4vzygwNqb8DHbbXcBgF12QpSYBEB8SwTAzLoc1EIPGH4rRNWXywRCIiFBGvsg
         mA/w==
X-Gm-Message-State: APjAAAXNA+vPHjI6Y10G5AqsZsTH5fkFX7s7lcuiaQdrv+rt+Hp2ZcM7
        gzx4ztB6fzwEO/Pfp2RWvZxW/vGruWM=
X-Google-Smtp-Source: APXvYqwOgwSjbMZMI/OxSAvK/dHPTF7pRklHnNyyz48rUdPkncR/3sPbeDvx0kCX31gM2tWa0FKAJg==
X-Received: by 2002:a2e:5418:: with SMTP id i24mr15185018ljb.126.1569176674622;
        Sun, 22 Sep 2019 11:24:34 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o15sm1715052lff.22.2019.09.22.11.24.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 11:24:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y3so10118355ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 11:24:32 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr15722836ljj.72.1569176671894;
 Sun, 22 Sep 2019 11:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190922152809.GA27554@linux-8ccs>
In-Reply-To: <20190922152809.GA27554@linux-8ccs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Sep 2019 11:24:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBYuEf8XCBCNvf0vHf0RatNR308k+CO05UbwYnyTEL=w@mail.gmail.com>
Message-ID: <CAHk-=wjBYuEf8XCBCNvf0vHf0RatNR308k+CO05UbwYnyTEL=w@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.4
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 8:28 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> The main bulk of this pull request introduces a new exported symbol
> namespaces feature.

Hmm.

So I merged this, and felt that I tested my merge resolution fairly
well, and then pushed it out.

But during more extensive testing for special cases, I notice that
MODULE_IMPORT_NS() does not work at all when modules are disabled.

In particular, it causes errors like this:

  drivers/usb/storage/uas.c:1222:1: warning: data definition has no
type or storage class
   1222 | MODULE_IMPORT_NS(USB_STORAGE);
        | ^~~~~~~~~~~~~~~~

because without modules, MODULE_IMPORT_NS() doesn't get #define'd at all.

This is not a merge error - it's an error in the original.

Tssk. I hate finding stupid bugs like this myself. Particularly when I
find them quickly from a simple "what if" test.

Yes, some of it goes to just bad luck with linux-next, but some of
this is simply people not thinking about different cases.

Tssk tssk.

                   Linus
