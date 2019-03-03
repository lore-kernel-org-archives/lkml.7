Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEAAC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326220835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551644035;
	bh=B4PEBAkzx+BT56qVyTWe/iCzZs6ongEGTSFMkUsWq4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tY9lQ6HMew3+JXxZi2PbfIOOJirzyeNY8EpbQs1eLuWOwiDLikZaQ/3bnn2R5oqkE
	 AK6LHgmYEPAHLOz59OZGCJvrsmAaiulEvkrr6lpwzSp9tydEvUQMWRBbhgjcH4AEAT
	 Wk/HnmH8UhGuYX/pYS/POtl2KP+3fcrrsd+9A1VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCCUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:13:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46568 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfCCUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:13:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so2456909ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1iMEQoPgXk1WJSYeb2Z3XqmYDbk/Fcp2JImzIRwCU0=;
        b=e7/nVcpDoI+4NGiOf6LPzCJB5Ze7AbKuNZtJnKQEzPgLhf6oPrhDF3Tn+yYSZe0LMe
         +g2CVcs9oK7MyTPL0HwQawhGLi6lHMvKH1+81RQxKAJuyByy3/hEqw4nm7pxJYdXFUMd
         JdLaF2VbwOfr5PCvA8gEYXG62JzPN/RsRgx7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1iMEQoPgXk1WJSYeb2Z3XqmYDbk/Fcp2JImzIRwCU0=;
        b=BQgT8XF6ET2sbRVvjFqvsJmTzBDY+zsvF1CWOVl2ndy32UqIhYbUBpaE+mAUv9Zvof
         zOieN/6r25rFGMml/EofABLx39b5cKAY/lohCh9+/NT7ThD/ElxdrYzdna23G2kMeL3V
         VAk0EvdnNain09p1H7gA2NjaUviHn2/uWbtF8wra66WM3hcjOYy4oIr9MTkIQueuf+EK
         9xXsQQMkfgbserDBaVcpVRc7lUmjczUt2grkA7QUvV+Tqaxc0qyP/M4Ommh2+hp27uFK
         oTb7idkUGfxWEN/RgjubeFoRCI1logMYYBaFWDimHSRiJ4PPzuoy2DIxT6GyfG/rORQD
         aUlg==
X-Gm-Message-State: APjAAAV9GZoDZU0oPndqkTO/lD4+YOwVwR2asQ89JoaFPDi9RyxK2YWt
        EDtmIWjIBj9h4Z69eb6am5t6dN7HQZ8=
X-Google-Smtp-Source: APXvYqxLuBIMF1ATLD6yKnThS3lRHnycwE7RdIurXAsHNbFqP1EDSwlSnAQdnwNsKxrqdQ+Tg+t1jQ==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr8580629ljh.12.1551644030734;
        Sun, 03 Mar 2019 12:13:50 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x2sm1130845ljd.30.2019.03.03.12.13.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:13:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id g80so2471868ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:13:49 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr8852138ljc.22.1551644029066;
 Sun, 03 Mar 2019 12:13:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f39c7b05832e0219@google.com> <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk> <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 12:13:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wheffK1OpNbBOfpLEvXXGmEu5+K9k5k-h44xw1KBo69Fg@mail.gmail.com>
Message-ID: <CAHk-=wheffK1OpNbBOfpLEvXXGmEu5+K9k5k-h44xw1KBo69Fg@mail.gmail.com>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 11:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But doesn't it look nice to see
>
>  2 files changed, 41 insertions(+), 50 deletions(-)
>
> with actual code reduction, and a fundamental simplification in
> handling of the file pointer?

A coupl,e of the changes are "useless", and do the same thing as not
having them at all:

-               struct inode *inode = file_inode(kiocb->ki_filp);
+               struct inode *inode = file_inode(iocb->ki_filp);

-               file_end_write(kiocb->ki_filp);
+               file_end_write(iocb->ki_filp);

because the "ki_filp" ends up existing in both kiocb and iocb. At one
point of editing that file I decided to try to just remove it from the
sub-structs entirely and only keep it in the top-level structure, but
it needs to be inside the 'struct kiocb' anyway for all the other
users outside of fs/aio.c.

Anyway, I don't think the patch is wrong (although I haven't actually
_tested_ it) but I wanted to point out that those two one-liner
changes are just "noise" that doesn't matter for the working of the
patch.

In the above, we have 'kiocb' being the embedded 'struct kiocb', and
'iocb' is the 'struct aio_kiocb' that contains it. 'ki_filp' is the
exact same field in both cases.

                 Linus

               Linus
