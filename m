Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A108CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9AB20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yq7HXJZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404222AbfJYDvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:51:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33155 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392291AbfJYDvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:51:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so571862oic.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=;
        b=Yq7HXJZBl+RA4hgkn6HB0lx+lYHPMmKUAVjvxLn+ZL4KAGdNHXsCfTq6DmV9AGIl+z
         kJjLciMvGivbyOB4ExC7SRjS8/IZwaNeV0r6/HFwY9bQdYGCDfTjDpKxb3SrC0uyw9vG
         zoGfp8OJE3jCJPciSrkAp+je6+CbM6uMfF1gRE3J/3VNsmb0p06VKmHIiIGGRHOImgZI
         D6WEr+riL1TOBpypwSw2J4tHpGeq4+huDYNELUPtQocL71Cjhs0cY01cf/iqyRPvqhem
         khUOjCy0Mp5/7aMXX0oQJ1R3LF5EChHfQVSEU49ZAxFexYR7RR6I+jH6WFm0TsHqzAug
         eQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABWD4JUlwawnG2qiFtveO+db3hIzWEPH+BypeNf0bRY=;
        b=tsbECcKGJkFuUEJu6ByhXTC2aIfRgInpxhmgXwn5CGYfKOZUh9zuF0+ca/ZP4mywcZ
         bwSQTh8iy48Y2UZ+2xR/Ig+yDXaIXbQN3vX5GyStP/T8mqfYhI46SRc8+OZpPpBjNFI+
         BCMNJEzzJ79LH4E9h/q3UUA58vr050cwkunkUVhHSIiG4n59wrHP6HpcFOPQkw5TFtOU
         en0vi+K9Z2Vn0I0e1C65OZZCDg0EV0MvhHpL5AfziPrQPPPa8Y78mUgRFt0OKdAsLqPL
         E5HgIV4EB/ytIgOjEiKva30yKuLthftMNfnljkIlcI7gAu+Mib4RrfPYf1wJ4BIjfudx
         053w==
X-Gm-Message-State: APjAAAXTVvHj2n+jPl/0CBM4tqUsRirUFhKVGvdJxR0yMQl28+VCVxmx
        YRqTMAN3IyDoNW9yM8QQGb+4YVadlhcOs91pgww4xg==
X-Google-Smtp-Source: APXvYqwp9zH01jLrvIbTsVmItix9HesiPp94IEFA7G7RNVJ8AV+W8rh1y9KxtIERGkFBYLMjB+kKorgQ2RgVKNzjic0=
X-Received: by 2002:a05:6808:1d4:: with SMTP id x20mr1174301oic.36.1571975512248;
 Thu, 24 Oct 2019 20:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191023214821.107615-1-hridya@google.com> <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
In-Reply-To: <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Thu, 24 Oct 2019 20:51:16 -0700
Message-ID: <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> > Currently f2fs stats are only available from /d/f2fs/status. This patch
> > adds some of the f2fs stats to sysfs so that they are accessible even
> > when debugfs is not mounted.
>
> Why don't we mount debugfs first?

Thank you for taking a look at the patch Chao. We will not be mounting
debugfs for security reasons.

Regards,
Hridya

>
> Thanks,
