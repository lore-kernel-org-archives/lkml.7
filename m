Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED167C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4B121883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SQfrkEOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfICUTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:19:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43736 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:19:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 90so14317511otg.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQDe8GS2DK5QAF5G4mPztvXfIYARywD4cCZcsg+EDeg=;
        b=SQfrkEOLJ2NtiynlPnRv5C/m4DqjwHs6SF78jB00qsHzfW34cQ/rqafSCO2w6xEpEH
         +btn5MG5Cfm7e6Wagu0HtR+CZ8fstG7p3HnqvoFT/g0d+H919b+MOw5HOHFIiIb27l5L
         D5s6hnSGvzxqC5LgqfJFcNx5KvHy675fn8xnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQDe8GS2DK5QAF5G4mPztvXfIYARywD4cCZcsg+EDeg=;
        b=Pc1FwGQvZSZX8NkfCf4S58dmPgqTGdbc4XOHyVPMkGHuHav5PbzqLT5zfrmEZ5Kjpc
         hjeJZDiQMh351PKF5MVwZtWRAPY73z7t8iIadXzvkGonKCP3qF/MlT5QePlXVWEVZ1nS
         155BvTMtZWIiJAK4y6NT7SiOr6MEMJTTYFHVc9Ju2VT0nwOCCybyG3IKUYqGZ4XTya5G
         yD8547Snf7lHYkjlgkUHRhbnQAR1AhNmKOm5R1id0uClUtFwaTmTRvsYsKACTr5jGpeS
         3UtPPtyNsANyP2nX+kdZqe902kDQSWiG9y0il+5jyW+9ILjiG2xdMkXzBnteN3EbkSKp
         dTWg==
X-Gm-Message-State: APjAAAVzN/8dj2hmc9X2mL+eHjgqYq9UQU7lMKskEcHoz+b4VGjnBpas
        bAoEFYpFXh/9LYgGadM/uzzoehKOfBwDwfw72stXbA==
X-Google-Smtp-Source: APXvYqzxY0YNMGI+0S485LDg8UpxCx09ufZBbGKgZ4ZGR0qDcK8RpGdEXIZejdCmxMxR12RgGhED4XMzbqohDgtomSw=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr26989061otj.303.1567541946232;
 Tue, 03 Sep 2019 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190830032948.13516-1-hdanton@sina.com> <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com> <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
In-Reply-To: <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Sep 2019 22:18:55 +0200
Message-ID: <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 8:07 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, 3 Sep 2019 at 13:21, Hillf Danton <hdanton@sina.com> wrote:
> >
> > Describe the problems you are experiencing please.
> > Say is the screen locked up? Machine lockedup?
> > Anything unnormal after you see the warning?
> >
>
> According to my observations, all "gnome shell stuck warning" happened
> when me not sitting on the computer and the computer was locked.
>
> I did not notice any problems at the morning (I did not even look at
> the kernel logs), I found that the problem happened when I remotely
> connected to my computer via ssh from work and accidently look dmesg
> output.
>
> At the evening after work, I even played in the "Division", and still
> not noted any problems.
>
> Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
> looks like issue happens only when computer blocked and monitor in
> power save mode.

I'd bet on runtime pm or some other power saving feature in amdgpu
shutting the interrupt handling down before we've handled all the
interrupts. That would then result in a stuck fence.

Do we already know which fence is stuck? All the debuggin on the
dma_fence_wait side is just looking at the messenger, this isn't the
source of the problem.
-Daniel

>
> $ dmesg -T | grep gnome
>
> ---> I am goto sleep
> [Tue Sep  3 01:00:10 2019] gnome shell stuck warning
> [Tue Sep  3 01:00:55 2019] gnome shell stuck warning
> [Tue Sep  3 06:54:50 2019] gnome shell stuck warning
> <--- I am wake up at 8:00 am and sitting again on the computer
> ---> I am went to work at 9:30
> [Tue Sep  3 10:00:05 2019] gnome shell stuck warning
> [Tue Sep  3 10:10:01 2019] gnome shell stuck warning
> [Tue Sep  3 10:13:43 2019] gnome shell stuck warning
> [Tue Sep  3 10:23:37 2019] gnome shell stuck warning
> [Tue Sep  3 10:42:07 2019] gnome shell stuck warning
> [Tue Sep  3 10:42:57 2019] gnome shell stuck warning
> [Tue Sep  3 10:59:25 2019] gnome shell stuck warning
> [Tue Sep  3 11:08:35 2019] gnome shell stuck warning
> [Tue Sep  3 11:13:19 2019] gnome shell stuck warning
> [Tue Sep  3 11:15:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:26:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:26:20 2019] gnome shell stuck warning
> [Tue Sep  3 11:36:30 2019] gnome shell stuck warning
> [Tue Sep  3 11:46:08 2019] gnome shell stuck warning
> [Tue Sep  3 11:53:52 2019] gnome shell stuck warning
> [Tue Sep  3 11:56:36 2019] gnome shell stuck warning
> [Tue Sep  3 12:17:10 2019] gnome shell stuck warning
> [Tue Sep  3 12:20:20 2019] gnome shell stuck warning
> [Tue Sep  3 12:20:20 2019] gnome shell stuck warning
> [Tue Sep  3 12:30:46 2019] gnome shell stuck warning
> [Tue Sep  3 12:40:52 2019] gnome shell stuck warning
> [Tue Sep  3 12:55:30 2019] gnome shell stuck warning
> [Tue Sep  3 12:57:52 2019] gnome shell stuck warning
> [Tue Sep  3 13:04:00 2019] gnome shell stuck warning
> [Tue Sep  3 13:12:38 2019] gnome shell stuck warning
> [Tue Sep  3 13:14:32 2019] gnome shell stuck warning
> [Tue Sep  3 13:53:12 2019] gnome shell stuck warning
> [Tue Sep  3 14:12:52 2019] gnome shell stuck warning
> [Tue Sep  3 14:15:54 2019] gnome shell stuck warning
> [Tue Sep  3 14:17:04 2019] gnome shell stuck warning
> [Tue Sep  3 14:21:57 2019] gnome shell stuck warning
> [Tue Sep  3 14:22:10 2019] gnome shell stuck warning
> [Tue Sep  3 14:37:42 2019] gnome shell stuck warning
> [Tue Sep  3 14:41:51 2019] gnome shell stuck warning
> [Tue Sep  3 14:42:52 2019] gnome shell stuck warning
> [Tue Sep  3 14:46:35 2019] gnome shell stuck warning
> [Tue Sep  3 15:03:18 2019] gnome shell stuck warning
> [Tue Sep  3 15:16:50 2019] gnome shell stuck warning
> [Tue Sep  3 15:27:30 2019] gnome shell stuck warning
> [Tue Sep  3 15:27:41 2019] gnome shell stuck warning
> [Tue Sep  3 16:08:06 2019] gnome shell stuck warning
> [Tue Sep  3 16:24:16 2019] gnome shell stuck warning
> [Tue Sep  3 16:33:04 2019] gnome shell stuck warning
> [Tue Sep  3 16:52:10 2019] gnome shell stuck warning
> [Tue Sep  3 17:18:27 2019] gnome shell stuck warning
> [Tue Sep  3 17:25:30 2019] gnome shell stuck warning
> [Tue Sep  3 17:41:16 2019] gnome shell stuck warning
> [Tue Sep  3 17:43:32 2019] gnome shell stuck warning
> [Tue Sep  3 17:51:10 2019] gnome shell stuck warning
> [Tue Sep  3 18:41:44 2019] gnome shell stuck warning
> [Tue Sep  3 18:44:18 2019] gnome shell stuck warning
> [Tue Sep  3 19:03:07 2019] gnome shell stuck warning
> [Tue Sep  3 19:17:58 2019] gnome shell stuck warning
> <--- Returned to home and sitting again on the computer
>
> --
> Best Regards,
> Mike Gavrilov.



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
