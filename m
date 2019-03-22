Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D0B213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ljh4YxD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfCVSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:05:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46204 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfCVSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:05:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so2008293pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgFsaOMgPWUKk0QZ7iC2FEXZkkJ1+qewYl5UYMgL+9k=;
        b=Ljh4YxD6aJXdaAKm9ORHCj2iXoUD6ZbnkbsD1NKUXqdVPxR1Q/QmjcRI7T9TGxcuos
         PaVEN3fVHr9ubRNvt0ckocLzascixbCMbz+DHG5HicEWMQNoyOYTgYSMmfmMkv4RMw7B
         qRgJJgscbHBQs8i2UIJXmghFmvunl791ofbVKLF0eaiFpRVCIqGezyiwJ+FupfE0k+fz
         NT8r8UIGY29gxhaCal+h3p8es9eiv/fSz5FOr6MDf38tkz7EeemWBcDv2zApULGEz8An
         85bDB1f5WHnSbGIR3M0WsKx0XuNnoHnFvcge2JQqzBJXZ7AVfLLR120oh2a7d9qTCj7P
         BCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgFsaOMgPWUKk0QZ7iC2FEXZkkJ1+qewYl5UYMgL+9k=;
        b=jPVk7OHbUsFvr6UbiKVLeiVJMC8SlAOPloBa2nJ4GjwkFSv9WDAOSBlTKPHFwPASNZ
         WSeogWO6NO1ZejRm5YMftB3XaBhQGP+XxHrV70LGeMTrBczzId+11IRl2n7b7Fuc4eCj
         vNVubOvtDBmWvffiGmEZQb75p08foCTP5Q9W/zMvA+TKNi3oGvDxh9PYH3HNO8UPyrdX
         qrQTnHbc4dsEkoiayHit64OHDspIvEM6og98jAE1FVMqT9nn8rzzdQULyI8kvY0C6NUX
         4JGimU3GOpapFVNswV/vG/2LMcEN1J2ViqeqfHHKxh6Ro2EhleRtV2IqpRdc86Jp1AxI
         ObdQ==
X-Gm-Message-State: APjAAAXSP9AD1l0PXPlLZaUhE1irgrXPm4cKFfsecf0KQA/cI9WJF8vy
        bbi/UO6SQ8J/RZ6c2FSYnf+SvcOpmJc8OcFPkJaouA==
X-Google-Smtp-Source: APXvYqxb/FL177ZLBcDAK3EeE/49YFAP6X+RXeiPhzeb2PMjdZZFhk0N0WsvpNeE76CRUmC6e3UYcwpwZ9flFqEnQ6g=
X-Received: by 2002:a63:c511:: with SMTP id f17mr10111997pgd.202.1553277903685;
 Fri, 22 Mar 2019 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190308084022.GA31474@kroah.com> <20190308183743.11145-1-natechancellor@gmail.com>
 <CAK8P3a38rvqVhgVGx36Rii0BaBskAnxsfHYye=8pi9n_hKNrbg@mail.gmail.com>
In-Reply-To: <CAK8P3a38rvqVhgVGx36Rii0BaBskAnxsfHYye=8pi9n_hKNrbg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 22 Mar 2019 11:04:52 -0700
Message-ID: <CAKwvOdnDHr8VVd3qxxXE18_KOhSb1M7D0GQ77Y0xiqJyBtXRPA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 7:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 8, 2019 at 7:38 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
> > is used uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > It's not wrong; when options is NULL, baud has no default value. Use
> > 9600 as that is a sane default.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/395
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 3bcec1c20219..35e5f9c5d5be 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -1050,7 +1050,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
> >  {
> >         struct uart_port *uport;
> >         struct qcom_geni_serial_port *port;
> > -       int baud;
> > +       int baud = 9600;
> >         int bits = 8;
> >         int parity = 'n';
> >         int flow = 'n';
>
> I made a similar patch here, but after looking at the driver concluded
> that the bitrate had to be 115200, since that is used as the default
> value otherwise.

Good point, we use this driver for Pixel, and I usually connect with a
baud rate of 115200.

-- 
Thanks,
~Nick Desaulniers
