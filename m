Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF54BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9E520675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551744585;
	bh=zFdIMT0EOfj14zRzlwTV0gekLU/67h6MjaZ6OZJ1qbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OAGQObOpbytv8XG+zpoy6MY3JYeQfLjbWaVGWDqEZRAdec13SAaXsAPSeZ9BW/DBu
	 gyEud0Ie+/1Hzn3dmR4vhLkwQrtRqbRcdBSxfPIiqM9p0r7N9LGSE7VRq+vybFC/cF
	 qhysPOVWxy3qp+7alj0mC99v0/WPbkF6ctpWcZRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCEAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:09:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42929 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfCEAJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:09:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so5950655ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72GWRNqOh5qyyx3euh7itCKu/RscHoI6zso0EM2GEn8=;
        b=UpiJ55Oz84LMiaSa2Cr5VdzTZMwbdFbWYKowWFLKI8VuBoyWpotg3GaNMf/ueBBkWz
         NSwNaWLhYeMRNmHmnzYlSk4TtLhK7WobrAsBtw3VeIQuaQfN1EdiANFusmuIpwHHR6DY
         3LAgr7WocqD0R2V+AFKPFwrpM5oW3970+fEMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72GWRNqOh5qyyx3euh7itCKu/RscHoI6zso0EM2GEn8=;
        b=lOdZtwf63XfNVzXSRU6qUjtTBgfPSgmdMOTuj69GEUwmn4xm0q5CAhIBbnu51d8mfq
         8Qv/MgJvbDcAFUbPnKbLbxRb8yDM4gReLINjLCHGlZfykLdyVWvYCimp8gsdWxJpx5Tk
         2T7dd+aaejiGdJIJKjhMWzoVKrEfASFvaoEAo0qmqrVPPXAu8p7DeWoYAL0k0pzXK7OP
         z6MJd6YAk2Yl8fU3dJ2ZfTo9rY2QapPukG4VXapAyLywTc33t2/eLuybnJ40SyMRNdc7
         RFHuOeruqovd0yKNaNHySel+NPMSHMbRvTJvqFaxGfPz93Q7a3Ydxb2UPWSctXZwk+ls
         dctg==
X-Gm-Message-State: APjAAAUCqr/8+5HQktEXwuuJlLe4uOzafHv59/TehdLaNZbC2/hhFfG4
        iOzs0jJTF3TpbJ6RT/SjqDlCcoADoPo=
X-Google-Smtp-Source: APXvYqygu30PJu/Hg+xwmvLXi4M5GrWNcS6eJzHMjfSeHLLwS0YBo778cT+gz8bdN0BYCgQk6YGjsw==
X-Received: by 2002:a2e:89c1:: with SMTP id c1mr11750651ljk.187.1551744580958;
        Mon, 04 Mar 2019 16:09:40 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b64sm1755435ljf.82.2019.03.04.16.09.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:09:38 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id d14so5950569ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:09:38 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr11899099ljg.94.1551744578190;
 Mon, 04 Mar 2019 16:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20190207154519.8635-1-kaslevs@vmware.com> <20190213094445.1774f959@gandalf.local.home>
 <20190219121212.6c46b979@gandalf.local.home> <20190304105836.33f80dc3@gandalf.local.home>
 <CAHk-=wipy3J4r-dLim3QvNA2jVPi2uPCi=rTDiMYikBi5OiKnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wipy3J4r-dLim3QvNA2jVPi2uPCi=rTDiMYikBi5OiKnQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 16:09:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0ikMcREn-RLh-7TEeL28wj1-bHNTRsqpW_7dPuO7cAA@mail.gmail.com>
Message-ID: <CAHk-=wh0ikMcREn-RLh-7TEeL28wj1-bHNTRsqpW_7dPuO7cAA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Slavomir Kaslev <kaslevs@vmware.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, if it turns out that this breaks something that assumes
> that splice blocks purely based on the SPLICE_F_NONBLOCK flag, we'll
> have to revert it. Looking at the history of splice, it does look like
> it has always ignored O_NONBLOCK.

Note that the "arguably buggy" argument is not an actual real argument
in the presence of regressions. It's more a "I wish reality wasn't
that way" argument, but it doesn't actually _change_ reality.

Of course, in the case of sendfile() (which is where that comment is),
I don't think we ever really even tested it either way.

                 Linus
