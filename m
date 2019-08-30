Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282C4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2802186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwn0RWHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfH3QYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:24:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38008 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3QYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:24:49 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so15216742iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHySHF2uwEhmKQaEHe0OPL8GmZZ5+dREwVbeFYlqd3c=;
        b=dwn0RWHZ+Um+l/0l8KxAVtK9/XCUY5drIfMskunEhTk7upC2I0w2tmibG77Ds/21/4
         JJoGM8HWSM3DCAtH8AYBZ/LmZvoJJq0x1jKREkrFnk7jfkKC2BJRP3GFMnR6ic9Jffd0
         sVC0h7v9o6ui5kdqEwP0wwyIEkuJIVTh0SNgDPCZEdEajFrRJZ4SXg8ivCSGaTHeVhYn
         wm3/6YbtHhrI9Gq5JRL9k0wJZSUi7JTiSLGn5xb+NLTOkKT9BS73IUko0kK/Fd71nOj1
         joRjzfXCPtV8W9B/esh4Ea2p3xu9AEEt2gvLMkGyYH6BCRhnEKilZRSt3SHab1J21YR3
         8ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHySHF2uwEhmKQaEHe0OPL8GmZZ5+dREwVbeFYlqd3c=;
        b=fucCNJtar0ewbZYeMWbcqJ9vj5hS5wBai81c1jDXZpH1mhjZFdfebJ8MNNrkfZ1BW+
         VXjMtw0iuTvsN6Nou24pQv0OmdxmZPJR5IbmXenoBbC1SJvKbiLdC/4DpESMfjw3h/0p
         8Vm1V7KD/0x3LBvzhQbAko31DrXTw+82NW7mXjuIoTnRVSi2egxX+JFkMn3WvsE5RnRl
         vqjAzcvGsmW32syYvRKOIZw8PHQQRjdy1N7okprabU9CTa8zVDdIkQkkbdhGzR6u9vc3
         0LjEYA6zNdnlFNzLIr+A9rf4ZGCG2YWnj9rGNEs8lkhv34Q7YVe0pXCpy6oKuboLJtQO
         SGfQ==
X-Gm-Message-State: APjAAAW/meAiuFj8KliWf/VNTDpIVwN4RKPWtYkilthjUwyRBc9KDWEK
        5KEeb1MJxtp2ugAJRKpTPVjyL/6UMErBJ16BdTafnoHN
X-Google-Smtp-Source: APXvYqwdBntb7kZCrsB+QQ9/2O7jjxtojMf474NZbsTPQdQ/YH+u5yW+U8plZem5ml3b+bETz1LpbVWveMMm96zRFJg=
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr19355270iol.200.1567182288772;
 Fri, 30 Aug 2019 09:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org> <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
 <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
In-Reply-To: <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 30 Aug 2019 09:24:37 -0700
Message-ID: <CAPaKu7QeYDqek7pBSHmg1E5A9h9E=njrvLxBMnkCtqeb3s77Cg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Riley <davidriley@chromium.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > -     kfree(vbuf->data_buf);
> > > > +     kvfree(vbuf->data_buf);
> > >
> > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > >
> > > needed here I gues?
> > >
> >
> > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
>
> Ok.
>
> > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > assumes contiguous array of scatterlist and that the buffer being converted
> > is page aligned
>
> Well, vmalloc memory _is_ page aligned.
>
> sg_alloc_table_from_pages() does alot of what you need, you just need a
> small loop around vmalloc_to_page() create a struct page array
> beforehand.
>
> Completely different approach: use get_user_pages() and don't copy the
> execbuffer at all.
It would be really nice if execbuffer does not copy.

The user space owns the buffer and may overwrite the contents
immediately after the ioctl.  We also need a flag to indicate that the
ownership of the buffer is transferred to the kernel.




>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
