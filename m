Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F98D240FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqlMVnHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2T2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:28:18 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34377 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2T2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:28:17 -0400
Received: by mail-it1-f196.google.com with SMTP id g23so6260525iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIRn9ZjK+7v7i28Ava6tGeb+unXhaKu47hvyl94CDxo=;
        b=VqlMVnHDOdOImD0u30QwK/qjrrBVbzTwgs6NDmePKwOeoQW8b6YlNua2HHrWg82oLv
         EK1df5i7oh79IkdtRnJlfcdi1q4n3gyDhwt7k0n8xOoBG1lp7e8XW2G3Rne/deI9SahX
         vWlrrc3hgUzr84RGDNU0BXn4r31xgGud131DrhkqpDwyPdjxjrRdxHbG0wmUPv9okcLy
         tsrEkHnNVihWJG3B7hHQYOiu4VWGgvE5/Qlr0VLpVDFGyq7dh151ZzfVE2BlhAxELlM9
         Ugx2mBsLgjAQ0wVZP56L6XMQ8An1ImlOv2NyVkzgW+yTNqw/oNMsVYEKJKiBWp0ZIATc
         btuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIRn9ZjK+7v7i28Ava6tGeb+unXhaKu47hvyl94CDxo=;
        b=QiEj3V69l26nwArhJzUfMAHjnIZXawp2KYPEnHFdGcbU5U9F8byuepslDrLi4GBMvW
         +gTPHOa02lw9Uz1zL902OsrqfKgg4z2iLGRDSi+Qgsx+HLdpwS/cGJoTQ5+P7uFSxZWU
         yz4ygkco+TuGdJ7j6a2vnD0DXKoTiGYjGzLPw0VyTO8m853dz6IRaW5NXFwAumWyPkya
         x7hYXRQ+TdkNXb36JdaEC5MKJ7kP0XqlOKxsICoFkGrfTGO5Fb1YsAp+TVKX/WR8GbDG
         HXnkdjidpRJeN3APRHWMZrEiUessye9iuZiLK4pNJcDK58gbiK2F9KjPYuamceTKQZn/
         b/ew==
X-Gm-Message-State: APjAAAWg2Tv09HVPlfcnv10Ii6NOYZsibtAfg5QUmvtRocpC9bxXGD6x
        6gnx6tAG4lAQn5qaqX+ekzwqIQT2Y/Rm4pZAY0X5g2Cvd7E=
X-Google-Smtp-Source: APXvYqx+O2zhw9nqX0Tty1pE8nk9mqW7tG4M02tzrHheb4GGaHqrHGBb08mJs1QVYCGzh6Kd7EqRcAOVKWXsuQGBwbo=
X-Received: by 2002:a24:5094:: with SMTP id m142mr8967439itb.96.1559158096656;
 Wed, 29 May 2019 12:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com> <20190529180931.GI18589@dhcp22.suse.cz>
In-Reply-To: <20190529180931.GI18589@dhcp22.suse.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 30 May 2019 00:28:05 +0500
Message-ID: <CABXGCsMTHHfkCaKRcgjAPc2kOpcwi0G=cX8+mf9XoKY1RGTc=Q@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 23:09, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 29-05-19 22:32:08, Mikhail Gavrilov wrote:
> > On Wed, 29 May 2019 at 09:05, Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > Hi folks.
> > > I am observed kernel panic after update to git tag 5.2-rc2.
> > > This crash happens at memory pressing when swap being used.
> > >
> > > Unfortunately in journalctl saved only this:
> > >
> >
> > Now I captured better trace.
> >
> > : page:ffffd6d34dff0000 refcount:1 mapcount:1 mapping:ffff97812323a689
> > index:0xfecec363
> > : anon
> > : flags: 0x17fffe00080034(uptodate|lru|active|swapbacked)
> > : raw: 0017fffe00080034 ffffd6d34c67c508 ffffd6d3504b8d48 ffff97812323a689
> > : raw: 00000000fecec363 0000000000000000 0000000100000000 ffff978433ace000
> > : page dumped because: VM_BUG_ON_PAGE(entry != page)
> > : page->mem_cgroup:ffff978433ace000
> > : ------------[ cut here ]------------
> > : kernel BUG at mm/swap_state.c:170!
>
> Do you see the same with 5.2-rc1 resp. 5.1?

On 5.2-rc1 I has another another issue
https://www.spinics.net/lists/linux-ext4/msg65661.html


--
Best Regards,
Mike Gavrilov.
