Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E06C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B98B20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHsE3pNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKSWPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:15:24 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:44754 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKSWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:15:23 -0500
Received: by mail-io1-f41.google.com with SMTP id j20so14140624ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNq+FxS/ZZbLEoaixalkYRZne7eBiDi2jHdHzkSxO20=;
        b=AHsE3pNL0Gg1DEkNsj/sSPrv6vwIDKdmIINkIPasmG2gnXG74efq4ptiV1lfwK2XsK
         ngKeKQuIaU+WyJqsvBX+RNYlq7LrjfGwWd1jxPeRvK+FcN8D44zBa0PYsYcSVlsdX6kH
         Y9lKeF4fYK5tOXwEtwlcviv0GxRpkTr/fQcDbWOzfM61EJrN3GdJdHKtxlr3E0gPnsGX
         rHLDTJG1diqoy0tIhLhGt3BtYB5zkXtAwLiEQos1N2YB/Pq9/gnXO0SHkAwpttGdjWgy
         22tq8UeL3ksvkO+tXso0lnnjAqS4i3BAhHGArRu4N58Gd04c2JaaZSriXMYxcRX4zDb+
         wn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNq+FxS/ZZbLEoaixalkYRZne7eBiDi2jHdHzkSxO20=;
        b=MZoPRcLqD6M55puxg2nQFsRt2xH+6LZ7j1eZQpiEZ6yqmMH5jrEXQy/m+79hNvVJ5v
         JXFUxmc3ImYY8w/A+8uUe9gv6Al1GDrhexIqqXK7+feUJYBQ0BcxxJxaR31KSG9J2xC0
         RXSB247emS9K3Kckr2UHUWO43bR+n2sj19ulEno+2sLl9egP920qtJ5Dv0F7rEsmMwNC
         VS1jh+0JUuKRzHSrpQt/77u4xJs8NLLEkN3jicqXt6H+VZ2BPcbajCcbv68yh3fgt5YG
         atC9oq/RvHcJYVhyIjPS4nHGE6D5l1EuGSwidLAE49Yc2rUqsA2/XfE1VTytiOtDgeR3
         KnBA==
X-Gm-Message-State: APjAAAXhlLis2Evp6/E7jhIixXVPzDCbJwO+8kohNONK5ReExJNhimS6
        PTTBZTZ15vZqCxFBvus+Aj3nsD7OuzBoB7aTL6w=
X-Google-Smtp-Source: APXvYqzv4cLzlJJjN4hEzAeqVcVtd2JF9QPu/O6QyjpHThyz322rRg+35LYWy7/cHgGu9kGClsS0Zr6ojtPHYRl6Ga8=
X-Received: by 2002:a02:65c7:: with SMTP id u190mr213999jab.142.1574201723096;
 Tue, 19 Nov 2019 14:15:23 -0800 (PST)
MIME-Version: 1.0
References: <5c4f8af1-723b-1b10-5163-f8f8b14b38ca@gmail.com>
In-Reply-To: <5c4f8af1-723b-1b10-5163-f8f8b14b38ca@gmail.com>
From:   Jim Davis <jim.epost@gmail.com>
Date:   Tue, 19 Nov 2019 15:15:11 -0700
Message-ID: <CA+r1ZhjZRED8OCyxMK=71H2obYhccB8q1+nCZ6bnMNQ7SmFkdA@mail.gmail.com>
Subject: Re: man-pages-5.04 is released
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 2:48 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:

> Git repository:
>     https://git.kernel.org/cgit/docs/man-pages/man-pages.git/

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git ?

-- 
Jim
