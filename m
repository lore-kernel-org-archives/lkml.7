Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15073C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D309E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Osdp7qNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfCYWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:18:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36811 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:18:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so9628829ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIDuBKQhrX8CNm0rk6CtfcFt47/7qFT9CI+zmQE4OPQ=;
        b=Osdp7qNiv2WML2RXcv+X0eoE7EPBC4nEJJQSqDUVCn/9Uv8U2Wd24yslSzrU4wSy00
         jMcMtIGDcN1e+RmWycrGNM7Xtsdlp5It12ZtLSNK+P+XfSvyKeuhjLgh/wkSwdDc9VN/
         snGuj7W2NqAbxti6oLKR6xIU2OgYhuzz/VZhCr4NNHnc7v74adlZXN+CZpGcshWGksXk
         Gx82ZPShjt0g9Cr5H0M4NvGAI+WEB5eFP6CRKVdYpTU3YaqA+n9YGNcINd5ZYH5H4Ywa
         R6g7CKLhcBIDvBRLJY+v72yBxZarE/O0jy+2yDZMg1p3SJiZ6JMFxeMowIQ2rr57kRbF
         kngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIDuBKQhrX8CNm0rk6CtfcFt47/7qFT9CI+zmQE4OPQ=;
        b=FfUgeWFbvd+8XNqAzHTgUJ6MuEcposo1xWZtFMKCgHb6FjtRtN2nk05WKQ/QDBlELh
         6N6pD7Q04Gfu5aWq86jCKG7f1vbonbLiS32mtnFbFOzIqoXJqHq9B2g8cKFF2IX6DmXF
         yHVQ7Gl/SYnmqOuCMLDbL3B9MbLYSpad6lvYLdpuvQXPkS4yzLD16xrIJZxvtxwzEp5r
         er4qTAtM3w2UO6RVp8chLO8k0RuMWAEh/TksH5+jfXlvaGGhxv7PB2EZqrHVHVspNzCS
         Xd8/+ilB70/EdisuNvWf5p3Yzea021nyiPQKD1c62EKRFZWmuhxLlPRo3xOiqv9aRPNC
         gwqA==
X-Gm-Message-State: APjAAAUw4NBazeEugC0aZ6dmuKeO6aDnw0r9KwgkNzlcEa/cgKjMbKrY
        XtwDK4gU3D0BJYTQAk8bNpSNESTeMzq8mZ6tJXAK6A==
X-Google-Smtp-Source: APXvYqxa/ErOFPgdiwguebYf4dyvrorp9xbPz9nAxpMnGD+hBiMZb9TC6RjG+8ik4Ltyn7Y9zF4L5KNAYurUAM+IvGE=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr18889188oth.83.1553552303701;
 Mon, 25 Mar 2019 15:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com> <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
 <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com> <CAFd5g44NTZoSAJPMvXP2xvJgn7m5QoV-KJu2AMrr67+eL+CKrQ@mail.gmail.com>
 <d9f7e000-4cac-a35a-3ff9-60130e12ebea@gmail.com> <72cd1c5b-6f68-73ad-c8fd-f3a3268a0529@gmail.com>
 <CAFd5g46UU9wk+F6A5wnKYYtYKmmtv__SaY8eg6v-T9xUjsoxhA@mail.gmail.com>
 <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com> <767d14bf-3429-58b7-dcbf-c8ef86133265@gmail.com>
In-Reply-To: <767d14bf-3429-58b7-dcbf-c8ef86133265@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:18:12 -0700
Message-ID: <CAFd5g45yNw5VA5teZ0fBzqND47yfGZyFJiEfNqZfvNYJqiG78Q@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:34 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/21/19 5:22 PM, Frank Rowand wrote:
> > On 2/27/19 7:52 PM, Brendan Higgins wrote:
>
> < snip >
>
> >> Now I know that, hermeticity especially, but other features as well
> >> (test suite summary, error on unused test case function, etc) are not
> >> actually in KUnit as it is under consideration here. Maybe it would be
> >> best to save these last two patches (18/19, and 19/19) until I have
> >> these other features checked in and reconsider them then?
> >
> > Thanks for leaving 18/19 and 19/19 off in v4.
>
> Oops, they got into v4 but as 16/17 and 17/17, I think.  But it sounds
> like you are planning to leave them out of v5.

Oh, I thought you meant v5 when you were thanking me. In any case, to
confirm, I will be leaving off 16/17, and 17/17 in the next version.
