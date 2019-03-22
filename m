Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E52C218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCVOUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:20:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43733 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCVOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:20:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so2628454qtc.10;
        Fri, 22 Mar 2019 07:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieLjJiETmCMy9sw+ZOyvWB/rv2az0OBC7jSssIyFhP8=;
        b=dfOfV7TIRq/wo42GdwmCZUaBjHS5F6DnMo7l5kTGOJlEDia9E1GE3PM8vD5ozHvtQf
         Redts6HTA8nmT9KuJ4EwFQXUTorHBCthuUBXQjP4dsZi6stht8qj+ONj+WLHA2pSAuqe
         5L3lKEzIsyXf7mdF+2Sa+FnOpIEAyi31PIw/DVfwdwVU21VeB/oEJ41atQjx8oAqLBg1
         t8O3Z5lw9iKlnHYbfsUYw52/zNk7AZCKdwd8Qub43DRr5PWPXCNN6l0RtNoyNrvIttCB
         PakYqpWtsY111UMahF7CjtK3zJAf7SvCJ3oKxfswFpldm7mXe9fcALGZ0jIz13q+BPyw
         hkVg==
X-Gm-Message-State: APjAAAWdeB9JKGRMbXBKukggz039xtlSZA8Q8LcHw1iSNChG2w3/2CXk
        gHn0lryYJoJawZvTsmrwI4wCExY06lh0HBNKHnw=
X-Google-Smtp-Source: APXvYqyl308DtLbVFWFhslrldRvn0oIZm+VYHDe3zGb/lbsVFBUK1YXjmAEvEfKdLtOnbWZFEyumTeb6iIQnLxREErg=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr7997258qvj.180.1553264445708;
 Fri, 22 Mar 2019 07:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190308084022.GA31474@kroah.com> <20190308183743.11145-1-natechancellor@gmail.com>
In-Reply-To: <20190308183743.11145-1-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:20:28 +0100
Message-ID: <CAK8P3a38rvqVhgVGx36Rii0BaBskAnxsfHYye=8pi9n_hKNrbg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 7:38 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
> is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> It's not wrong; when options is NULL, baud has no default value. Use
> 9600 as that is a sane default.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/395
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3bcec1c20219..35e5f9c5d5be 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1050,7 +1050,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
>  {
>         struct uart_port *uport;
>         struct qcom_geni_serial_port *port;
> -       int baud;
> +       int baud = 9600;
>         int bits = 8;
>         int parity = 'n';
>         int flow = 'n';

I made a similar patch here, but after looking at the driver concluded
that the bitrate had to be 115200, since that is used as the default
value otherwise.

        Arnd
