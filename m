Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD20C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCAF2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Ap8ulpNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfC3Nuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:50:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37904 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3Nut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 09:50:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so4382889edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/WXmLWYiqtpQtd5tkDTMKB0ZrUY4M1ldhuHrQpY1DQ=;
        b=Ap8ulpNXKJGWUUwV1GlcxOwdlhVSRMREXuzdxsxQWLicH0fE4dHYsh4uxMDILWsYir
         24E0eb4XoLxW9qQ6JlCh89kb/pbQAEiCh0PIFDRb3o8mfxTFCkPEMMnCQT7/RNyRaqgq
         jBTBxn8v310vog0fMRRXduaTVxfgS/28x1Qk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/WXmLWYiqtpQtd5tkDTMKB0ZrUY4M1ldhuHrQpY1DQ=;
        b=ZQ7NVNOFf5l4vWgmRlRR5DgYJObxN5wm51GgULoOey1weL56ZKl6rJAfmvt5EogyDO
         1AuHbypOU56otj9Fnqf9tp6ETIj8HLov/mnmqtzyTvhb46QXb4l8pRHUfgcqhjwIObUo
         R3K9UMsN+dIEBkoCsRS7y0dSPRVNqUSwaeAwBealEOSjiirQd4Po/D2dhQdBvzCxkFOC
         c2zmkXfV18G/7GSnRxvB7Y5etZXQNpwI9x6lBY+t+ASQY4RleumnN6yzryQV+CLuptMh
         4w6KPNVqqL/QYnxF7SetmoUcTlF6ZtEmn5JKBa/2wHySSN71qiRxV5jNcT4kzUFd3ovY
         slmg==
X-Gm-Message-State: APjAAAUP3aoAEHdUDaUnmlPZpUppnFSaJRgDTZrSeBKAyDyxcuoyHLFP
        bZYwayTAg80+41BOmo3si/3y+i8oPex7AiQ83Xeb1w==
X-Google-Smtp-Source: APXvYqylR3cK3ryhqBvCdj46lijoIBCyzaDb5ALCwhN6r79K9ts8c4AGL6pwlOK2KWxbcuKxn0NW8nhKDQzb8qoyfYE=
X-Received: by 2002:a17:906:15db:: with SMTP id l27mr29098591ejd.242.1553953848133;
 Sat, 30 Mar 2019 06:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190325195303.GA20629@hari-Inspiron-1545> <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
 <20190330110747.GA3461@hari-Inspiron-1545> <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
 <20190330084016.24f8ad46@gandalf.local.home>
In-Reply-To: <20190330084016.24f8ad46@gandalf.local.home>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Sat, 30 Mar 2019 06:50:38 -0700
Message-ID: <CAJieiUgLUV=z-OSJdevVpKsdUB3PvWRtwueqf0o7oGMX2VLMiw@mail.gmail.com>
Subject: Re: [PATCH] trace: events: fix error directive in argument list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        mingo@redhat.com, David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 5:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 30 Mar 2019 13:01:41 +0100
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>
> > OK, I see. IMO, it would be better to have 2 patches for this:
> > one for the redundant assignment to pin6 and anotther one for
> > the IS_ENABLED() change but feel free, if needed, to add my
>
> I agree with it being separate patches. I'm big on the "one patch
> accomplishes one task" ideology.
>

yes, I will take care of the pin6 assignment separately. This patch
can only address the sparse error.
