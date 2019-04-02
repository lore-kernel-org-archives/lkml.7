Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E382064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP/AHzRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDBVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:03:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46566 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:03:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so13340294otk.13;
        Tue, 02 Apr 2019 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8wBbaXXqf5NZlfcrqpb5dNxJRGhM1Moj/A1hNeK+Gs=;
        b=UP/AHzRztmqkCEuzUprtXykRnSQotDhprx5z1jQVr8ZB0iprN9u3hUcW4Kv1qicNhQ
         03fobEOGUz15L5fupJiuj621XKM+NqoZ0PhVMDNkFZJp0CqMVwmx9xwBpurv1+qH1K17
         Md9tpallpU1s91TZ0YU/Luvf8QuAm2PHVtkzl+ljdU8UnElcUPzJnkdlTrHf7VYj7ui+
         6RELkiUm/MDy/DFNfnoLDVQjui/EljE7hSDVcCb8ekNn8KcZxPGKYckN7nNFwTDn/IPM
         9q9rvGuHE6RvTiRDaPfr7qRsgdsPPN3JmnsVhj+BtjutVec1rVHn9rMwj4Af0QEJ4Pkc
         2adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8wBbaXXqf5NZlfcrqpb5dNxJRGhM1Moj/A1hNeK+Gs=;
        b=sZu2EfD3YIU8HvL3en5sscqrvuy26t9LvXdCD/okOfdpjpObJanFRpwV9PLyebGblV
         394hywDWCB/dbhmaFQnCXvN/+0XCUwxkCG9wwmEGpV7iIc7Q3bvEKDs7nPuu0cJrq6b2
         TTUYQQORUSvFsdJmZMh7V9TwwurCdAw6PdIf364ShJgJrBl7Cbi6xKU2zfnM7cdy8w+R
         wOnnLx5uRAcD4mopii0iyR7yUgVJog8End1v3Ga7UkxfsLeieDCQNFRP0kqv12nHn9j0
         AjTKtKmt1FDRt5I1GKIt0Vp4YyAGfQSEmJq4E6VkGG/muRs8NFJhP51qc/WridXnmEIG
         MhWQ==
X-Gm-Message-State: APjAAAWGuuTiOpojFDAsVR0tzNsSj7npMKIuM6qwIZ3DjsI1zAx0X0Cp
        JaEugZoJxhO7sh0HPzgl4/FIDT9wzPOhuBJnw8knCw==
X-Google-Smtp-Source: APXvYqxfgysZHLd+KNTzPm5Wm8kRT4mvtuhnsjAiHR58SOo97YDI9eCeHMVpR7VOU4XoRC0ssBDLiT0kHaaT4WOobd8=
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr43363011otp.89.1554239037125;
 Tue, 02 Apr 2019 14:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-6-tomli@tomli.me>
 <20190331185428.mpqbaq32cmm7izfv@debian> <20190401172959.GD15736@localhost.localdomain>
In-Reply-To: <20190401172959.GD15736@localhost.localdomain>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 2 Apr 2019 22:03:21 +0100
Message-ID: <CADVatmMgZJ-SFBzA5g7wXPRwgcWS0HqkHYbQNJDDTCj5zhy93w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Documentation: fb: sm712fb: add information mainly
 about 2D.
To:     Tom Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 6:30 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 07:54:28PM +0100, Sudip Mukherjee wrote:
> > On Fri, Mar 22, 2019 at 01:17:57PM +0800, Yifeng Li wrote:
> > > +video controllers. This series of video controller is a legacy from ~1998,
> > > +and was used on many classic, "prehistoric" laptops from 1998-2004, such as
> > > +IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
> > > +computers, x86 and non-x86 embedded devices where only basic graphics was
> > > +needed.
<snip>
>
> BTW, most Loongson 3A notebooks don't use SM712. I don't know that there are
> Loongson 3A notebooks that are still using SM712 graphics chip, do you have one?
> Could you tell me its model number?

No, I donot have them. I only have SM712 based PCI card which I
purchased from Silicon Motion.


-- 
Regards
Sudip
