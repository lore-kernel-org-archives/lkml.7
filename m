Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28854C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50CE217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5DEu5bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfG2UgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:36:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55624 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfG2UgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:36:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so55039662wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FooYDDFf+QXrH1X2HJ27EzsB8p/Ze/1us0sP5MjgLwA=;
        b=A5DEu5buxVLitvWnebvp4Y9lHghguiQVhio58oKGyfjpXmllT17XLj/gRBHD6jusWX
         PAqJiU0rabGc2ISidvuOwYe1ydFs89v5x2DHR62S8dnXoRfOI6OUfY3UhDQl5Yk0nr25
         Q/0HT6zQj0DrgXJ38RaZssWYzu6y3te8m0l9eMAFCe1DIgIgyVm5pN35X0lHzcL+LgA9
         bR2BBO19zYhKGAMx/VMy1BI/sU7HFc+zvNBNek9IA47odqqmYxzD//dJ3JVu24Crb56V
         v8pVRznJOuswwoAP2HXPxr37HtdCAlnrjpx6RTBX4wO9LdlzxeSJg807BFEQk+LaibOA
         Vd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FooYDDFf+QXrH1X2HJ27EzsB8p/Ze/1us0sP5MjgLwA=;
        b=eHByBQ4cUoq7KcOj5BwF7KQbD6MxcEnoWCHRMOEjgWlfG9gBdWQ307yRzRFsn528aM
         w/Lu6mnpcXrIoZWdSFCxKBOK7Aob+Z5u5iAN0WG/b/vOD+DdzxZOWSp58BtLulIt7yzL
         32ehExO69APe69bkbwWrS8LgO/SIFRvLXraSmWpmSJpZNDl/Fhh4B2tqELOJXN+I1bNU
         ZOFv9eJbLxNOxknK5px767EAOpFbIzsm+BnPL+tFT137P+/bjkbn8Jrwf/2KHxeL6sSx
         15a3J6DaAgeZ8Gort349ciEuO3GeSwbv1XRt50hqQANukUPmzNGCmnmpZZSDuuGpo8XY
         zq+Q==
X-Gm-Message-State: APjAAAWw/DqVu5f/MPjtza6p8/QOfwMViEvyuVNZsGvTZ3ykgXataOuw
        8dS+hZ9ztqr/Yz7c4UqKCsIQGJbxW0JCgS6aWZE=
X-Google-Smtp-Source: APXvYqxObuwqk1KJbtVybQvwbQ+trqPkdgi1+saS04N9RpNZwHQRmCpidlFFShpoGdC098kF0WPndNGSS620tPVY/f0=
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr102828308wmf.176.1564432567191;
 Mon, 29 Jul 2019 13:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com> <CAFLxGvxEAGtQDFm4G3orY+M9yuthDA4j0+u=HbE9DKuo7H8WCg@mail.gmail.com>
In-Reply-To: <CAFLxGvxEAGtQDFm4G3orY+M9yuthDA4j0+u=HbE9DKuo7H8WCg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 29 Jul 2019 22:35:55 +0200
Message-ID: <CAFLxGvy-LL1aHibR73beifVES0_oUB44=j98jRGOaR2ci3V=qw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Artem Bityutskiy <dedekind1@gmail.com>, yi.zhang@huawei.com,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 6:51 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> > -               ubifs_assert(c, p < c->gap_lebs + c->lst.idx_lebs);
> > +               ubifs_assert(c, p < c->lst.idx_lebs);

I wonder, doesn't this assert trigger too?

-- 
Thanks,
//richard
