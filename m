Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C6C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E269520644
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ob8Mw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfFQMc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:32:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33354 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:32:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so5758820pga.0;
        Mon, 17 Jun 2019 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETsv5V713PqfBbxptdNaDO/9A5O3HqtK22qegpsPBRM=;
        b=I1ob8Mw2H2thmUye5x2sp6jGFUWg2hZKIUIc/UrJ+3N1DO8dQGyfs5jjf1X8TfiWyF
         GE6xVtsVQKhU4Am+J1AK8bN0EH1spxrKp1IqsjoozcvJj9pJUru0j2GyVnpj79ISMr05
         yNaNPNxyZnJ+7uajXj2oyTsWc+Rmkffu72ZghFlFCNXS9nFeWOyL1orT41z+DvjlYtN3
         Gare/0NStEccjZLKTzGfOk+hUaGAH0UxRpLAuZ0gOLaHUEsMBQDICy6MK3ktHNK1/FCa
         BgoRYJ2B1WM91HdLmOjgImT3TYFTU0ZTxabb5/8WcUuf8IwHscDfL4TkwcS57O0J/ep2
         c6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETsv5V713PqfBbxptdNaDO/9A5O3HqtK22qegpsPBRM=;
        b=LnPYBirZJt0bMUD2DY1+0dKLuffzUBVFJeJFTdANADiPQPTKnKRyEa6Mzn32jF436e
         yJtZPfZi51gOLpC9XWnD3twE6X2r9glDQLaK6cNRmgT02ln37P5AOkVzK0m0iO8kiD4P
         5Gotkp3ry7J/tgy2pHWoE70yg7j99nMM0zr8PtLezbJAH3aLmfWIvQjsSPoP+hFK7/wb
         HH3Bf7er4FzbhQxhx0kTdn9nuEe46aKhC/+Qcw9Z/1gK89DxmNEFHinAbk3vj17cLeT0
         x2xUCyeFT7IT7Gsp5Zc9UhrcS3umoWnPcshKhPdt+eoj+2I4UFoZ2yMWdjf3peP2/5pV
         eKRQ==
X-Gm-Message-State: APjAAAVibtklCNznIdPddahofKbAUrVIHg/5sDEKlYVKgX/ziMlTt8cZ
        g1U3XKiQhCw4XPgzcen2ba1cLTu71zXJkJyuCKQ=
X-Google-Smtp-Source: APXvYqy0mtPFb8J/e+TcLeJbV0prtKSvy/MF15YIH1l6Aq9HxxWDYk6n2e9vLDDfCY9aVzucB9Wm04E2uK0EkphnEW8=
X-Received: by 2002:a63:f346:: with SMTP id t6mr43106755pgj.203.1560774744359;
 Mon, 17 Jun 2019 05:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <CAHp75VeQy9o6tHtqKEE3o9ijBE4c11cWcc00+RqCj+P1FOky1w@mail.gmail.com> <20190614065339.GB21447@kroah.com>
In-Reply-To: <20190614065339.GB21447@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jun 2019 15:32:13 +0300
Message-ID: <CAHp75Vc7HeHgkq6h9TKrNHO-g_5uDtbnD8jY9HpHLuu607AUkA@mail.gmail.com>
Subject: Re: [PATCH 1/8] platform: x86: acer-wmi: no need to check return
 value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 9:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 14, 2019 at 09:48:04AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 12, 2019 at 3:13 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > >
> > > Also, because there is no need to save the file dentry, remove the
> > > variable that was saving it and just recursively delete the whole
> > > directory.
> > >
> >
> > Through which tree you want to proceed this?
>
> What ever is easier for you, I can take it through mine, as I have a lot
> of other patches like this queued up already, or it can go through
> yours.

All 8 pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
