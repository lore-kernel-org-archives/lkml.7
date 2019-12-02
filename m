Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C210C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4FD20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg5dpbmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfLBT7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:59:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39763 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfLBT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:59:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so661406oty.6;
        Mon, 02 Dec 2019 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7jfpF5EjP9+/bmFBnU6GGWa3nlxlWS/1/GfDBTRGdM=;
        b=Dg5dpbmCUL5SrXdkfhx33mCy83248kmMvbj99odnFKFsBlsFYDdNzMlXZyrQDeA7G6
         ocpTjuKAAziMDV5bFfB/eikLzpjThVey1b+S6CKbCiFNPFV+xA2BuTzk09FqQMzFpmVa
         q0TjUMw989mbHbc/7o1geqNUfFGAjb70u+SFrqHuiWQTpUI0VD8TpyBuO/K/630UiuGu
         +jPp3Wfxmj4gI6lucZVgHoFhdb10gQPl6yDkna996dipZWlCzcQzT32PlJXaG1u7UspA
         JFzAA6o/OjylQ4RzoNquyMBbFmgMgGq2gSbNdTJL6SGxpNM0z2FwqQtYsHiqZ1ZMP318
         0TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7jfpF5EjP9+/bmFBnU6GGWa3nlxlWS/1/GfDBTRGdM=;
        b=QtbLqmufyfBAR2CzYc8uiKdoyufaQ/DOIjKojBVTx9pyVGiQDs8bfOfcW7c1x0DC7r
         M9yI2qeK7fE1XYj7Ym0oUMNBr15RXYj2jtNgzepNfl8VgiNaONhbiSd/ig1qTGARYVQI
         aZdyCal42Q1vYRPrrcbeya1X/c9py/B+EGzTJZp2dGsNEerLgZpVRw65ca5+8XZgss7l
         WGdN9uWufuXrjjLY8hVWv1e39JHaJeZ38aGaBj9X0kTDubbQI+rQQG3WCm30Gt4z7+u6
         4hrG7X7r2egrmJd/fPkDLppsxZqmAWbgI0WEo026nZ4AkaWr5afVjHtXg5UGWCaLWC4B
         B55Q==
X-Gm-Message-State: APjAAAXGuk5MSif6ibc69/MGdX4SYf6M7TK5NAG73PDxzd5QnFYtUTjc
        4gJWBjdRb9tEj3bdwy4eaIS4VZ952nqdqArsoV2r5KMh
X-Google-Smtp-Source: APXvYqwzj89Wpxotdt42O6ehJgO4oZi9x4+OkqAxj/3FyDXsWuTEi9VbUfbRPUnrjJStqrGlo10wYBfGOADza89y8vA=
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr648274otc.0.1575316778439;
 Mon, 02 Dec 2019 11:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20190919151137.9960-1-TheSven73@gmail.com> <20190919190208.13648-1-TheSven73@gmail.com>
 <20191202184349.GC734264@kroah.com>
In-Reply-To: <20191202184349.GC734264@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 2 Dec 2019 14:59:26 -0500
Message-ID: <CAGngYiVPbS9zNXPLGqWSs_=b6QbsX97u5bd=5GUMwtGedZ=fqQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 v1] power: supply: ltc2941-battery-gauge: fix use-after-free
To:     Greg KH <greg@kroah.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 1:43 PM Greg KH <greg@kroah.com> wrote:
>
> What is the git commit id of this patch in Linus's tree?

As far as I know, the mainline version of this patch is still queued up
in Sebastian's 'fixes' branch, and has not made it out to Linus's
tree yet.

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=fixes
