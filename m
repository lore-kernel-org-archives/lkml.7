Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0CDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0722CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnxCtdGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfICSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:07:41 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:33397 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfICSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:07:40 -0400
Received: by mail-io1-f42.google.com with SMTP id m11so6066893ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcmXmd5Tfs0vBsqNXpDm8UPfgj5wJscuQmw+59dosH8=;
        b=nnxCtdGDmSh7HnVfjv/Sf5nVb8EsLVKdfjCPLtFq3uxS7xRyZC4Luv8mJQgswc7lus
         vxGYwN5dM9cAdla+qmT/VFpfF2UxeDPE/Kvt3sOBOmIwwj9PjoDbWhInSu6TVEthLFyC
         8AgImbcfAcGUGccZE2iXGUn4bJoYwi1p54Ttthkjypvx+Am0+hMvwhVAp8TrLBSvVg93
         4XMOtOSvaruK+yh8WWjm1tD/hRej78q4im3qr9ZF9day4IHirWBX91Ab5njhkVklMAIZ
         zt0GMGCEShUFQgJrmaHT7bckUmqG0bdBAlVL5AyhrDTuDmMksqeET7jbLPnrmpHrfSvo
         V+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcmXmd5Tfs0vBsqNXpDm8UPfgj5wJscuQmw+59dosH8=;
        b=jMa5d4Jo+Lz1+d0DgZ64x174N5iyjdna1i88/ww/5iYy7ahyyQTzOBPpS88RxncFGg
         4W6UW9OfAGSGnM4TCWN3NUt/FDqjftlP3I8FvThMVuTS9Pp7jC4poXrSG3AodoyEZJJT
         9y7pI9dTfpngPq9ZPkFN/uwLXrzxAVK/lSfSIl97Bd4PGBC1tCySWxNwTWZsbxx3QC7u
         9Y5W3ljdIw2mMrTfNBvWjIP0co3x1AAb/uyeyLGHT2Pzwu3ytjci0LE76BLvaCeWI/Lr
         ULDhLRVz5FuEra4EPIQBazmxcomDYeDDzoeeN3V6a5d5lDSSb3w0uDFC6sb2FkxBDVa2
         EObA==
X-Gm-Message-State: APjAAAVKx0M9z1vatYy36Z34i3ACsL4LQZqYv7tdDhZgz16ajB21zYjy
        T94p7Jj79z6S1kPnPn3z38LvfsNwzhwHvJCZwdv4ua/Ag2w16g==
X-Google-Smtp-Source: APXvYqzrgEDJrjqTyVcrN04Q8gMvQVvTsdZ5FNhcMXQJaBZr+Y5s3gdS8unWAP+73zmomEtVo7gvjlaXGIfvU0EkO5M=
X-Received: by 2002:a05:6602:2508:: with SMTP id i8mr30933307ioe.91.1567534059092;
 Tue, 03 Sep 2019 11:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190830032948.13516-1-hdanton@sina.com> <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 3 Sep 2019 23:07:28 +0500
Message-ID: <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     Hillf Danton <hdanton@sina.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 at 13:21, Hillf Danton <hdanton@sina.com> wrote:
>
> Describe the problems you are experiencing please.
> Say is the screen locked up? Machine lockedup?
> Anything unnormal after you see the warning?
>

According to my observations, all "gnome shell stuck warning" happened
when me not sitting on the computer and the computer was locked.

I did not notice any problems at the morning (I did not even look at
the kernel logs), I found that the problem happened when I remotely
connected to my computer via ssh from work and accidently look dmesg
output.

At the evening after work, I even played in the "Division", and still
not noted any problems.

Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
looks like issue happens only when computer blocked and monitor in
power save mode.


$ dmesg -T | grep gnome

---> I am goto sleep
[Tue Sep  3 01:00:10 2019] gnome shell stuck warning
[Tue Sep  3 01:00:55 2019] gnome shell stuck warning
[Tue Sep  3 06:54:50 2019] gnome shell stuck warning
<--- I am wake up at 8:00 am and sitting again on the computer
---> I am went to work at 9:30
[Tue Sep  3 10:00:05 2019] gnome shell stuck warning
[Tue Sep  3 10:10:01 2019] gnome shell stuck warning
[Tue Sep  3 10:13:43 2019] gnome shell stuck warning
[Tue Sep  3 10:23:37 2019] gnome shell stuck warning
[Tue Sep  3 10:42:07 2019] gnome shell stuck warning
[Tue Sep  3 10:42:57 2019] gnome shell stuck warning
[Tue Sep  3 10:59:25 2019] gnome shell stuck warning
[Tue Sep  3 11:08:35 2019] gnome shell stuck warning
[Tue Sep  3 11:13:19 2019] gnome shell stuck warning
[Tue Sep  3 11:15:20 2019] gnome shell stuck warning
[Tue Sep  3 11:26:20 2019] gnome shell stuck warning
[Tue Sep  3 11:26:20 2019] gnome shell stuck warning
[Tue Sep  3 11:36:30 2019] gnome shell stuck warning
[Tue Sep  3 11:46:08 2019] gnome shell stuck warning
[Tue Sep  3 11:53:52 2019] gnome shell stuck warning
[Tue Sep  3 11:56:36 2019] gnome shell stuck warning
[Tue Sep  3 12:17:10 2019] gnome shell stuck warning
[Tue Sep  3 12:20:20 2019] gnome shell stuck warning
[Tue Sep  3 12:20:20 2019] gnome shell stuck warning
[Tue Sep  3 12:30:46 2019] gnome shell stuck warning
[Tue Sep  3 12:40:52 2019] gnome shell stuck warning
[Tue Sep  3 12:55:30 2019] gnome shell stuck warning
[Tue Sep  3 12:57:52 2019] gnome shell stuck warning
[Tue Sep  3 13:04:00 2019] gnome shell stuck warning
[Tue Sep  3 13:12:38 2019] gnome shell stuck warning
[Tue Sep  3 13:14:32 2019] gnome shell stuck warning
[Tue Sep  3 13:53:12 2019] gnome shell stuck warning
[Tue Sep  3 14:12:52 2019] gnome shell stuck warning
[Tue Sep  3 14:15:54 2019] gnome shell stuck warning
[Tue Sep  3 14:17:04 2019] gnome shell stuck warning
[Tue Sep  3 14:21:57 2019] gnome shell stuck warning
[Tue Sep  3 14:22:10 2019] gnome shell stuck warning
[Tue Sep  3 14:37:42 2019] gnome shell stuck warning
[Tue Sep  3 14:41:51 2019] gnome shell stuck warning
[Tue Sep  3 14:42:52 2019] gnome shell stuck warning
[Tue Sep  3 14:46:35 2019] gnome shell stuck warning
[Tue Sep  3 15:03:18 2019] gnome shell stuck warning
[Tue Sep  3 15:16:50 2019] gnome shell stuck warning
[Tue Sep  3 15:27:30 2019] gnome shell stuck warning
[Tue Sep  3 15:27:41 2019] gnome shell stuck warning
[Tue Sep  3 16:08:06 2019] gnome shell stuck warning
[Tue Sep  3 16:24:16 2019] gnome shell stuck warning
[Tue Sep  3 16:33:04 2019] gnome shell stuck warning
[Tue Sep  3 16:52:10 2019] gnome shell stuck warning
[Tue Sep  3 17:18:27 2019] gnome shell stuck warning
[Tue Sep  3 17:25:30 2019] gnome shell stuck warning
[Tue Sep  3 17:41:16 2019] gnome shell stuck warning
[Tue Sep  3 17:43:32 2019] gnome shell stuck warning
[Tue Sep  3 17:51:10 2019] gnome shell stuck warning
[Tue Sep  3 18:41:44 2019] gnome shell stuck warning
[Tue Sep  3 18:44:18 2019] gnome shell stuck warning
[Tue Sep  3 19:03:07 2019] gnome shell stuck warning
[Tue Sep  3 19:17:58 2019] gnome shell stuck warning
<--- Returned to home and sitting again on the computer

--
Best Regards,
Mike Gavrilov.
