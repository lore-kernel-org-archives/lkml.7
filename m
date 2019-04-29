Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E268C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0323A21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEWCWWgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfD2UyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:54:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45939 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfD2UyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:54:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id d5so6826558qko.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmD2zJl9VRTqeF0c7qjkyD1kuxGLq7RXf7ct1/Sfp0g=;
        b=nEWCWWgqr3dLu4hMH3GH3xyuV9uXoHR9dL/NljrkX5dApsytLKGZz4iAQ2+aia6w3r
         5Hoz6d/wYp563bSj7Uftp5ampIVFHNijv7eEQqmR8MUBBqTrFIV9tQ6LPQcjB42lEbzF
         VhAsyzPzdd1cw5bQY+SRP1MtuzvXExFAsfLW3mLAncIrF9GB5+Vxs3X/h+KKue716FaL
         rIv4LbeEPAejkEMMFC31GHrx+HlUfxQRfHDHcSqpeT3eo8wTNg1NpB81EAgU9IWyUibs
         hnfUyuAXCZx5TiO6ezYVi/ThrdTSYmJn3WlU83sP0i5r67Kx5jk/kWZkLX/kEOg1NtZj
         ZFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmD2zJl9VRTqeF0c7qjkyD1kuxGLq7RXf7ct1/Sfp0g=;
        b=N881L4B36Y5F0Yy/oHvenJDQ2yuTHNwNaiL2Q7TwH9KnGXGbZmmBVzdyPnlw02JdR3
         b1fQxv8FQkggoSItIs2UbhkI800Z7U4L/NzIa/k8Ec2Zo5gqgIaNV5CZ15yBQeD3GQ3U
         UyGgUKOd9om3Vd46YB/yQ6/kt8ODDZFLFPrXPUOsHFBtYBUd9Ow7yipcey8JSJEBXzfU
         DDr4tnA8rI0620BLFV5a131gsktopJmSwH1ZOmaKLWFHv8H2BKEFOS2k7s7IzWhC7XWC
         +CVCYzZTWnUJ/Z0ImLv/KuPyVOEJg0Sxoj2bIHXleh+sqqHjQQAER9inm51116Mrvp9G
         Y8gA==
X-Gm-Message-State: APjAAAXKiN4IxemY32YyHZA0SMbYJn95gwc8P3+yEtVHbYVvsTopWddV
        qmClRd/wmXUKQmswVwmDi+bx/3BlWdM2f8zcraNnhqSYyfk=
X-Google-Smtp-Source: APXvYqwB9iCqmHYftTmnPK7+1Yso8Nu4yexXC1GgQKS+8CohPGVhTWiUZcRBB7yu+kToAD+J7g3yo5gkqQlm2R0VTd8=
X-Received: by 2002:a05:620a:1018:: with SMTP id z24mr34385210qkj.3.1556571253224;
 Mon, 29 Apr 2019 13:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190424094850.118323-1-yuchao0@huawei.com>
In-Reply-To: <20190424094850.118323-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 30 Apr 2019 05:54:02 +0900
Message-ID: <CAD14+f2nDurQ2mTp-temk92zhWQkKNaBA8CwpWJhOZEmzLw=VA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity with enabled features
 in image
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao and Jaegeuk,

On Wed, Apr 24, 2019 at 6:49 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> This patch fixes to do sanity with enabled features in image, if
> there are features kernel can not recognize, just fail the mount.
>

Surprised to see that this wasn't implemented yet.
I was actually about to suggest this method to prevent mounting of the
new extended bitmap layout images altogether for older kernels(by
renaming the new, fixed layout to v2 or something), but looks like
that isn't an option. :(

Also, something similar should be also done with fsck, if not already.
The results from using older fsck with images with newer features
would be disastrous.

I'm still very busy currently with my other projects.
Sorry for the delays in testing new patchsets for layout fixes.

And I apologize in advance in case I miss the Linux 5.2 merge window
deadline, but I'd like to see it being fixed properly before shipping
those patches to production.

> +       /* check whether kernel supports all features */
> +       if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
> +               f2fs_msg(sb, KERN_INFO,
> +                       "Unsupported feature:%u: supported:%u",
> +                       le32_to_cpu(raw_super->feature),
> +                       F2FS_ALL_FEATURES);
> +               return 1;
> +       }

This should probably be a KERN_ERR instead of KERN_INFO.

Thanks.
