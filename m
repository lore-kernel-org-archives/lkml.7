Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9472D20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552065294;
	bh=C1g7iI9AJ1G7ZXDznNnEvdzQVIxmPQ1LPSAvLYf2qOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O20q4ZrbLQ2ODMy4JDJNKBA0Uud0ZwFmMoczmHEot+uFJDb67tVsFi+EjzEKejC+i
	 aAeWo+KFLlBG4KOK1A5FEkhtUPoOQWwiS4GKTzw7hzRGRkP/H8rlTEnkim9jJfuD3q
	 x8YXfZXZ6hENvc1NJXQHM7oPnieHVtFhOFGR0wtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCHROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:14:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32801 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCHROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:14:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id z23so14804933lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKdq4NhhNanoF1azIJovbOYf6T8dVd50RHDblR3XyrA=;
        b=iEQMXqrL4xqr/uuglNC/x/bZZpvoYc7iLw1lyaL4Y/G8q9fCO14odGJHgXFVxw4K0U
         eujg8MQ9YEN2KhaJa24aTz6Dz4IO8Osw8PGL3RKiAEdGvTt3lI8uiR/6JUuoRum0Q9Gh
         I6yQJQPz25u8suXbTBw/SuH3BCxC5HoduKaH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKdq4NhhNanoF1azIJovbOYf6T8dVd50RHDblR3XyrA=;
        b=WkM/WAIDVVnbKz+GuP1Ikd9RzVOzQ9mnF/ydOOPDxdMl98CaBPzUoN4QWzN6QUdxRZ
         EW5hyn855oAalbEFf0+/SiExcLPagspypce8ZFLrKHdFsj4fR8qX/VhuqHxB8bgVc3qV
         1XVINcgJcVFrvYDFznmHtKq4QsHDExwP8BSBCl2fY0MmkPNKRlyMl6RbB9EqB4H1Gs29
         PremVArNffI/72iYOWffz82UqBu85nMSfOKGZWoDgygn/qDRQwYKdAvfbCuaisEjLG/d
         /1goYsOevjTaiCH8763B6lbSp14VV1td6b4y3JgfAuJbe+S1Hq+/NuxknpSZFRxIOhQQ
         pjsA==
X-Gm-Message-State: APjAAAVRDZRxspuAKvIY/6O8DWvP28a0HdOoQrS3TogLl7b7OZYG/Irj
        QwPp022Gal2y2s4Q0U7xiKXu7ANC2CI=
X-Google-Smtp-Source: APXvYqwZBDos5kVQmqHedgkvd+hzzCRbEWq+rLyLAkF0+2f2RwH8SC/opYS3/O1GRgcnrWUm6I9TGQ==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr9847829lfi.133.1552065289935;
        Fri, 08 Mar 2019 09:14:49 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v13sm1515785ljd.31.2019.03.08.09.14.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 09:14:49 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v16so17983195ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:14:48 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr8734315lji.79.1552065288638;
 Fri, 08 Mar 2019 09:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20190305141645.GF9073@zn.tnic>
In-Reply-To: <20190305141645.GF9073@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 09:14:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjESdzE5YRYny25yhMvKP24omiRAJ2PMbqOdh7HwjKJAg@mail.gmail.com>
Message-ID: <CAHk-=wjESdzE5YRYny25yhMvKP24omiRAJ2PMbqOdh7HwjKJAg@mail.gmail.com>
Subject: Re: [GIT PULL] RAS updates for 5.1
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 6:16 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull the latest ras-core-for-linus tree from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

Hmm. You use signed tags for the EDAC tree, but not the RAS one. Is
there a reason for that oddity?

Not a big deal for a kernel.org tree, but I do prefer them signed even there.

Regardless - pulled, just wondering,

               Linus
