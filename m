Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0003B222A9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjRNaFMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfKSOdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:33:02 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:46839 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfKSOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:33:01 -0500
Received: by mail-pj1-f52.google.com with SMTP id a16so2719071pjs.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWmqlctb3ZXD7WfpFuk6bq+a9VLtf6IJ8PZ6YsU1YoM=;
        b=tjRNaFMoRrBRw9kvHh1STRh+ec2EbaeYs4lSdlbdbF6xhhBUPny3SlYNdd01TM9voB
         8vmkWae4TqZalSxb1lVl/WqxASoxDRmfflkvdn7az6TlBoiepGiORPyi+8JB5DjS74NH
         8lYVXAaxyobnH5Dc+f24lg9WUz2ecxJ1OAJ9LC3UFjphQKHShmyFB1hkAr7hIptE2QuN
         91+kaFm+pdhG7sRSaLzNxE8e/bw/kF72VjuwuYJh/dIFtf5E4FV0s342iYnHuUYAVhdy
         vjKKOpw++UagcnK0Ej0HqC7MIU/5SWCoXuWZWnMp0tPKp9ue+coc1bcGWocChiX/u34h
         rqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWmqlctb3ZXD7WfpFuk6bq+a9VLtf6IJ8PZ6YsU1YoM=;
        b=mm56K1nFfjt5l8DLf57hNvKmJ0933p5NuXrJoxcM4mqlwpffUHoaqWwuvYQ3RfKsXD
         6Wg7I56rX/bnNWDGdc/B+kYRmMsFcqs9T2yv3r/JNcyExPFe5iXw6RoJART6Gp8+uMnA
         IK4WXmzs6Z+aKjyMcdFC0n9YVYpEomS1/V0INFAbvYRXlZWiZ509SgIDCgx/xammPIxw
         9G8rCv27y5wR2kSPj7PVhQQh5Fnxvq4sD5LTGavUDhkGRNBgYvhF3awe5IqrKMUHP5H6
         VNwOqSMysbbGhcBURynjZDqlu5IhvdyO4f5pfJXj+sCHneD8HrRrenEIoGpozKLNH8dg
         hHMw==
X-Gm-Message-State: APjAAAXaBSBiD7qSD1ADqEmlNlxsVS52RDNSj++fElgJgeORA1PwoUB2
        yBRwJFNApUoEQ8TQROk/Btb556qG26yEBgkxviSPOg==
X-Google-Smtp-Source: APXvYqwvB8z7JKHK0FBF93atWvKuTGWQhtP8yLuQ3OI887t6FDkGv4DBSg8nzPLVPcHXZLb8md4U9G7TfFvupiFlIV8=
X-Received: by 2002:a17:90b:438b:: with SMTP id in11mr6904277pjb.129.1574173978895;
 Tue, 19 Nov 2019 06:32:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dece03058f87bf11@google.com> <00000000000091301a058fabc3f1@google.com>
 <CAAeHK+zV2TXWtdmLj8Fjpfg9DPNNWrZXnbtLJ_bEhMJUjiua9Q@mail.gmail.com> <1574173039.28617.13.camel@suse.com>
In-Reply-To: <1574173039.28617.13.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 15:32:40 +0100
Message-ID: <CAAeHK+yuUyz6P-3kHaJbA-KziwawKKDduz6=5KVgqnFZ_iUONA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in wdm_int_callback
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com>,
        baijiaju1990@gmail.com, bigeasy@linutronix.de,
        Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 3:17 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Dienstag, den 19.11.2019, 14:46 +0100 schrieb Andrey Konovalov:
> >
> > #syz dup: WARNING in wdm_write/usb_submit_urb
> >
> > https://syzkaller.appspot.com/bug?extid=d232cca6ec42c2edb3fc
>
> Hi,
>
> this is a bit odd. A fix for that bug went in quite some time ago.
> Is the kernel tree these tests are running on regularly updated?

Hi Oliver,

The fix went in a while ago indeed, and the original WARNING bug got
closed. But this bug was never marked to be somehow related to the fix
or the WARNING bug and therefore was never closed.

Thanks!
