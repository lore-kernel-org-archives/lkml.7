Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF2BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7620898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VIxmx3lB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKUKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:03:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37635 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfKUKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:03:30 -0500
Received: by mail-io1-f67.google.com with SMTP id 1so2722829iou.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azm6258Y/h1Yi1v25/cgX4nZQFn/wXyDk4OUzPAogIw=;
        b=VIxmx3lBXUc/OsjeFNHkalvySAflAWkvsgeR9sJSmDV3UMExPqRNneJibNAVZx0ORP
         TNOoZyXyQ0AHvM5PmbjOyt50zoipblJXoCN9Cp925i1ScOTrpzzHGB9QnW8rvvZR9eVN
         ogW18j8FBdeFL19T3L64w40J70OFSxaWsJUuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azm6258Y/h1Yi1v25/cgX4nZQFn/wXyDk4OUzPAogIw=;
        b=I2hyJQ9soGvvpn27in4gtFDpubCtVk3P66MdA3xvvkymBKduBD6YFnL+eVkJqxa/eJ
         pODhK/wtJ1vkrmTUuUorYjdySFz2msVMlK1lGuMlyFTlBLlKbslKni8E21F49158hGel
         enzSasCLKb2DIITboIqE5Xjp6DGBZGlTZOqPrB9oMNy5HcbzQEWkuEsuf+xxPbrRtxaf
         PMWz3fI2Y50T4bd3yAh5Ny0HZ9varZSppifdWkiuU50TfF5sLmhbW5Q0JW8AyKFuUXOk
         XcRAw4fPUkWNotWqi6kzqrnGdLr29Nyr3P3H/dvGCW7VL4YCag01GYOLjLTS9cp/K93H
         W6bQ==
X-Gm-Message-State: APjAAAXtVTO8Ot5CoLZJove4sjIJuA9lzz8uAmWd4DI/KX1tPsxqmvyu
        mJL5wxO4GNA5nozXcgWt6DTdOCPEWvqSJU6HOqDaZw==
X-Google-Smtp-Source: APXvYqws6nCsGqtiQ5vj9FfGy8eiccfE7OIokaC4SxeEjLC2HogWwLfVUDZczbVj8ubWEH2ncp7v39SVWv6PXJFH4UY=
X-Received: by 2002:a02:c05a:: with SMTP id u26mr8022037jam.58.1574330609772;
 Thu, 21 Nov 2019 02:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191121070613.4286-1-hu1.chen@intel.com>
In-Reply-To: <20191121070613.4286-1-hu1.chen@intel.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Nov 2019 11:03:18 +0100
Message-ID: <CAJfpegtK_S3K0j_qP6x3+qKBPdLag+ayCWHAakJvMtVXMdmXtw@mail.gmail.com>
Subject: Re: [PATCH] proc: align mnt_id in /proc/pid/fdinfo and /proc/pid/mountinfo
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     Andrey Vagin <avagin@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 8:28 AM Chen, Hu <hu1.chen@intel.com> wrote:
>
> For Android application process, we found that the mnt_id read from
> /proc/pid/fdinfo doesn't exist in /proc/pid/mountinfo. Thus CRIU fails
> to dump such process and it complains
>
> "(00.019206) Error (criu/files-reg.c:1299): Can't lookup mount=42 for
> fd=-3 path=/data/dalvik-cache/x86_64/system@framework@boot.art"
>
> This is due to how Android application is launched. In Android, there is
> a special process called Zygote which handles the forking of each new
> application process:
> 0. Zygote opens and maps some files, for example
>    "/data/dalvik-cache/x86_64/system@framework@boot.art" in its current
>    mount namespace, say "old mnt ns".
> 1. Zygote waits for the request to fork a new application.
> 2. Zygote gets a request, it forks and run the new process in a new
>    mount namespace, say "new mnt ns".
>
> The file opened in step 0 ties to the mount point in "old mnt ns". The
> mnt_id of that mount is listed in /proc/pid/fdinfo. However,
> /proc/pid/mountinfo points to current ns, i.e., "new mnt ns".
>
> Althgouh this issue is exposed in Android, we believe it's generic.
> Prcoess may open files and enter new mnt ns.
>
> To address it, this patch searches the mirror mount in current ns with
> MAJOR and MINOR and shows the mirror's mnt_id.

This is a hack.   I suggest instead to add a new line to fdinfo with
the MAJOR:MINOR number of the device.

Thanks,
Miklos
