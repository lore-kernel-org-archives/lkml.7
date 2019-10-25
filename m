Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F7621D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VwfW1KxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395536AbfJYPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:55:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37093 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388846AbfJYPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:55:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so2172872lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sS3PYP7sb7nZeexvyG7CuYvg14FuVX9+0KxUSPIEzcs=;
        b=VwfW1KxAddVtUt5JxxIFhB1j5MYK1n5dRFc4R3VO/CRFd0eDr0VpBkjyzcYr4QYNkj
         LIBNEP/T58NdOhaWBLVpU326qFlLvC+zDFOkhHMb2DUPHmjHoDuMhsm+to9KZ4yL/qbN
         m/Re4JDkfbIXC428QMJ59pVYZgp6SWgCNZvEEWG4xCyUNFXFQ5cIXFMaELnA4Kcqw7Bs
         36lycD+7NVwtHBR/Pb+Q4JYWGJEBwFUpJEmfSJ8I3MLZ9YboRfCoYlcFXhv9w3q3swDm
         5vjLhkePVx/QJr+mVONya5OrYUXzfHoB3lWh2Hb8kZ8pzwBNz0PxvsQrBLZFNTJrbFAj
         nodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sS3PYP7sb7nZeexvyG7CuYvg14FuVX9+0KxUSPIEzcs=;
        b=nPUTxEBvl069ssjrmPqyK4SMLzDzKhML7rRxlATGa4JJJ+aHAVxwOJcs+85/bevM4e
         LdBfzs/uoH0BvbHeNadJ3qW1Q/C306UAmNJmLT5vuqAnm0lKftPfqUK1X7WlGCZcGzB+
         DLOUJz1TgX+z278WuLBJ7R8W6ST9xVIJei5BNYQd0obuYLX2YBbK5/vwwtqLhWD5F+2l
         e589Sf06hq6ARlMj16Qru1HilIMvFIptX/quIv1obUjEFAZJB6CakSIooAecgVJH6ZQJ
         FbluryvkbjBwcJLFEi39CwVUbrtMKQSyDpvrc2vxLMdeKQi1bFtbqU241tG3gzXDvOLi
         kOwQ==
X-Gm-Message-State: APjAAAVvO7qGLrm9ePYQhYZ2bwvXZUbEX2pH0in0BONYtZPFg9rljgKR
        3obKtK/gC22wywMJ9ecwcO0vhRaiTq8IKOxooVpT
X-Google-Smtp-Source: APXvYqynWNcfJAV5BSOoIkWNJbu7fzy1hygZ1L6EWTv9teeMfhYOH+6vtS9qysworxUgBfYNGDL9w7vnEaeLXe2Rst8=
X-Received: by 2002:ac2:51b6:: with SMTP id f22mr3196445lfk.175.1572018910101;
 Fri, 25 Oct 2019 08:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
 <16e0170d878.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com> <a700333e-53b8-1a28-b27d-2ba3f612df2a@huawei.com>
In-Reply-To: <a700333e-53b8-1a28-b27d-2ba3f612df2a@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Oct 2019 11:54:58 -0400
Message-ID: <CAHC9VhRfEkPCC-T1W2AOD2FTkUD4Z=BT=R+-kF+=Rejv9fyWOw@mail.gmail.com>
Subject: Re: [PATCH] audit: remove redundant condition check in kauditd_thread()
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:14 AM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> On 2019/10/25 13:43, Paul Moore wrote:
> > On October 23, 2019 3:27:50 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> >> Warning is found by the code analysis tool:
> >>  "the condition 'if(ac && rc < 0)' is redundant: ac"
> >>
> >>
> >> The @ac variable has been checked before. It can't be a null pointer
> >> here, so remove the redundant condition check.
> >>
> >>
> >> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >> ---
> >> kernel/audit.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Hello,
> >
> > Thank you for the patch.  Looking quickly at it, it appears to be correct, unfortunately I'm not in a position to merge non-critical patches, but I expect to merge this next week.
> >
> ok, thanks.

I was able to find some time today to take a closer look and it still
looks good to me so I've merge it into audit/next - thanks!

-- 
paul moore
www.paul-moore.com
