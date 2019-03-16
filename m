Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2155C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 06:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9999E218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 06:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/QbUTis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCPGTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 02:19:05 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38450 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfCPGTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 02:19:04 -0400
Received: by mail-ed1-f51.google.com with SMTP id e10so5465401edy.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYt6rYiM8FyvPUuKmusdU7RA43Ry0AHXuGrmQTUPX1A=;
        b=q/QbUTisttcibBMLQN3AuB4fdMe7E++qPcpCfgbWfeED7v4F8EfbwQUKKG01bgU8B5
         BTyfG798rTb3t6OzlDptj04D2M8Mu7Vxoyy4XdGImdCVLNyAsK+7EBG7DjPE3jjv47bL
         GksDLTsQ3EP7RSJA4m5vo+OAy1BwlM4TjMTWl6nCfKgWXo7TduKv09nPh7qr8E7K/GOR
         gIZ5bPpZOg9CUBWS9+C2d+Rzz4Sa5dgJRSjY4/kt2hvff0IaAnOeNGellyG32Ry9AGr2
         J3Ec09JNmDukug8E2yjzjzPTyzghSzFlN3AMEoYPI4NMBmMvkgkn7TUDOOI6Es5MTd7C
         3CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYt6rYiM8FyvPUuKmusdU7RA43Ry0AHXuGrmQTUPX1A=;
        b=oHSTsEffZMMpJSVm4o37zfMJyG65szucnf2gA94dSsUEZu6yya0QA02yt8ab82wSrR
         epT/gU4Xwtw9LhsFznLO6KuNj+NGyH5bIVY+1h5ayuh7Js1PKJFszqlXvKZKYGqM75Ii
         zm+wfB3Af2KY2kwV6jFdup8juGuqMwJ+DdEq8BzilyukHEzybc3nFDuTxTcFnTWa6Nex
         9CUWI89HQOqxgka2ZicK8NMIRgYdn11DOrpIesaNUjGMjWnQY7yiPPYI0aEH2zGLmNsJ
         niV4J+WS6fWq2lLFDejsbmYCPeFh6HljNwa2dTejMgLyUqeEmlTrHVwgAw2cx9Y18yIw
         /i7w==
X-Gm-Message-State: APjAAAVO8IsKbFNXCVy2m6zSEM7sfBC3sKMrJLbBsaREY9ERmBQmnEWi
        LPPvvza6uiQ9NCSAR0FSZqKKfh32IX0XDX/O7EQ=
X-Google-Smtp-Source: APXvYqxSinLB1hE/qHklaVQ9EaZiTW19Wc3Rr37AY9wK0AUUkzdIEMOU/yKpCkaCFfG3iGmlimMOqHCb9ExOtVgqHKc=
X-Received: by 2002:a50:d4ca:: with SMTP id e10mr5381431edj.162.1552717143048;
 Fri, 15 Mar 2019 23:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190312210640.2175-1-arshad.super@gmail.com> <dbe33412-b801-bb46-c51f-eaada4a0fb77@huawei.com>
In-Reply-To: <dbe33412-b801-bb46-c51f-eaada4a0fb77@huawei.com>
From:   arshad hussain <arshad.super@gmail.com>
Date:   Sat, 16 Mar 2019 11:48:49 +0530
Message-ID: <CAKsu7qywwXiKyQT1RH+22OFHLdPwUyCr8=bLxccJLT9OwNjUDA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH 1/1] staging: erofs: Add function comment for erofs/super.c
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        yuchao0@huawei.com, Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gao Xiang,

On Wed, Mar 13, 2019 at 12:23 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Arshad,
>
<snip>
> I think this patch is good, and could you revise your patch
> as I pointed out in the previous email?
>
> BTW, no need to duplicate [PATCH] [PATCH 1/1], the subject line can just be
> [PATCH] staging: erofs: Add function comment for erofs/super.c
>
The updated patch is coming soon.

Thanks
Arshad
