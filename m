Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF72084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555176442;
	bh=odEDfKmCuvbqb4UffPq5Est8Ku9j2n5BAZ9La/6SFCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NWBJ3eON8GCfpz1ZcFWVnYDJptiAdgwVbnSrp6hs4ezVHeUBR4XN9DGOeZ9Ust1LH
	 OyhOLTcobB1c0dtowUhHq9hCLTOAjuVw0m9rDHhdjSY5z3hwwapDB+YGwC8nxJH3KY
	 4PMJr9SB9tpK0/D6vkthWn4sBQZ/+Wz9fqjR5WAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfDMR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:27:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36830 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDMR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:27:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so9905431lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfXSxxnbMYMRpZrYSj0Na23gan717ekTmGp7T4mx7XE=;
        b=UjtmxBbuSMpSoy+6D5j81zzZz+dLVgRThblAFzd6MqOQFQ5rDyLLBWx/5BGeyPzvPr
         ATPzfN9wpmM2RhiU4wbHuR4zx+dVucuJ9EYYoOcYEw1VdcDIX6wX6Ojt/dmueXenNn6m
         Zpx8BSieu94g/DvOMaVEWYt2payaGHO/9OdGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfXSxxnbMYMRpZrYSj0Na23gan717ekTmGp7T4mx7XE=;
        b=Mi3xs6cN3l8iIQMjOcrUQWfebUV61Va4CWAhm/LSLgGE3+yy4C7i3gj+0DQUspAhiF
         Uin/vNV2KXMDOfy8oecnSAN2DT4QDO8W7v01BWNVAZJ4q6NyMQp8By4bgwkNbW4oOdMe
         bCPdj45623UQWZpTm+zHQtDvibQfjqpuswPb6gJZmZrWxtQZ/JrydRwtsnMZHzXV4DAX
         T2GrMygclsJrLLEWPt35XQSM9PRjJ6eEq7AdAG7t70l+hiIVdzWk7fZNn+gW3p5l4/vU
         WUx/13ctpXTC9hzoC+0h/UrQZDmUrvhPozSYuI/ZUM2rRYm2zXrN/vrZLFzk8c3TzL5y
         RIOA==
X-Gm-Message-State: APjAAAUrMG/8vV71mOTq4LlrcCi9q7itzwHwOPPflzG7P0Kt/Alvoyrl
        4ZQiCH63r6YSmd5iAibFHQLV1Vok5Eo=
X-Google-Smtp-Source: APXvYqwZ0Zp5QmtSyr2mrPt8nBvdCGiUawrIJ6dXWXib1SX6SrDvsq/Fv2uGvHYsesipfYSs2rS6Kw==
X-Received: by 2002:a19:761a:: with SMTP id c26mr16581432lff.8.1555176438105;
        Sat, 13 Apr 2019 10:27:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h14sm8864245ljg.10.2019.04.13.10.27.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 10:27:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r24so11749356ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:27:17 -0700 (PDT)
X-Received: by 2002:a2e:8316:: with SMTP id a22mr33734693ljh.171.1555176436599;
 Sat, 13 Apr 2019 10:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190413165116.GB10314@deco.navytux.spb.ru> <20190413165449.11168-1-kirr@nexedi.com>
In-Reply-To: <20190413165449.11168-1-kirr@nexedi.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Apr 2019 10:27:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
Message-ID: <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: pass ppos=NULL to .read()/.write() of
 FMODE_STREAM files
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 9:55 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -371,7 +371,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
>         inode = file_inode(file);
>         if (unlikely((ssize_t) count < 0))
>                 return retval;
> -       pos = *ppos;
> +       pos = (ppos ? *ppos : 0);
>         if (unlikely(pos < 0)) {
>                 if (!unsigned_offsets(file))
>                         return retval;

This part looks silly. We should just avoid all the position overflow
games when we don't have a position at all (ie streaming). You can't
overflow what you don't use.

Similarly, you can't use ranged mandatory locking on a stream, so the
mandatory locking thing seems dependent on pos too.

So I think that with a NULL ppos being possible, we should just change
the code to just do all of that conditionally on having a position,
rather than saying that the position of a stream is always 0.

That said, this whole "let's make it possible to not have a position
at all" is a big change, and there's no way I'll apply these before
the 5.2 merge window.

And I'd really like to have people (Al?) look at this and go "yeah,
makes sense". I do think that moving to a model where we wither have a
(properly locked) file position or no pos pointer at all is the right
model (ie I'd really like to get rid of the mixed case), but there
might be some practical problem that makes it impractical.

Because the *real* problem with the mixed case is not "insane people
who do bad things might get odd results". No, the real problem with
the mixed case is that it could be a security issue (ie: one process
intentionally changes the file position just as another process is
going a 'read' and then avoids some limit test because the limit test
was done using the old 'pos' value but the actual IO was done using
the new one).

So I suspect that we will have to either

 - get rid of the mixed case entirely (and do only properly locked
f_pos accesses or pass is a NULL f_pos)

 - continue to support the mixed case, but also continue to support
the nasty temporary 'pos' value with that file_pos_{read,write}()
thing.

IOW, I would not be ok with passing in a shared - and unlocked -
&file->f_pos value to random drivers that *might* do odd things when a
race happens.

                   Linus
