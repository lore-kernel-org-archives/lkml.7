Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6717C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F452070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/RL7Y2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfG2VsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:48:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42851 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG2VsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:48:08 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so93051985iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piQh2aqA30RCLiw+cIf1d6IHR82wSEf3qDisOX1wwys=;
        b=l/RL7Y2Kyz2I8kqXJkJw/9E/ltkRzEbVMXQD38G56U8PUZAmwtnkKyk1cYdnW4RkE/
         BRx+ImBhz8Kd0e72PSmi6DzIFPzZz64kGMHUiXYdecWyOMNgVaC54BmGAJFKRoNTuut8
         PZd4JDjulvHHx4sqTgtjDyqilDAzhxkxGuPCGpSJoxbcIGu7fdFKOObX4H8TdzQlWyCM
         G23CxF+/n1MtU/bkyCuBe7R2qSG66UQrAnRhW82VgKpIhP1sJHF6XJdewBfIXFoJb6tR
         EDp+Xzcfwt3MI6laa6/wlpnuRJwSVMA/8v0UeVucDpQ8IOX0/R1elEKP78IJ2z5WBQ0k
         ESlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piQh2aqA30RCLiw+cIf1d6IHR82wSEf3qDisOX1wwys=;
        b=D5tBuOygr6npUVpukKcDstFKooVQyvtK6jCdTDN2u1aP/ioHLL0iIxWd6QnrSc/UEZ
         +h1ehcfqu97yHHy0NFLOKj136EvNz4qsiQOBuQRICPgezGupmEzhH/TX4X7daxD/8zcX
         xHRyMHD0fLNLT5KptnW77pE3mBXldPXz4pUkUe8slPov0S5HnEsUt7Wp54+1wrdvZStZ
         kaRIgZhe8A5hIGvc1d00ZBz24k5giXsCjCfNNHaZwExFkijo4/3eyUUerzKD4sDS3+jS
         Yqc3B4xwpvQpGQr/FeCNi9I8qNqlH4caDbnwhLI0YeYipjA1kmaWmObAh68KfXZwOzlO
         rzMw==
X-Gm-Message-State: APjAAAUKMRH7d71z5CLTmu3WlmJza0wwBnZbzzHu4A/m01NmqaykITrr
        LBbseOQe2/HfqWitI58TIcKGUj+MIDQC35CmE6SGeYCqVbk=
X-Google-Smtp-Source: APXvYqxS/upLfLcv1Opnwp9lYxlnoZ2TkKlbL41OpS0AiGsoLM5gWBwfxkyYcoAUnk0nANWmnZfxFJngb/NBSwuBQkk=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr42722436ioj.46.1564436887846;
 Mon, 29 Jul 2019 14:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com> <20190718194415.108476-20-matthewgarrett@google.com>
In-Reply-To: <20190718194415.108476-20-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Jul 2019 14:47:56 -0700
Message-ID: <CACdnJute8aakro+Cb7oNrxgCiZTYj2BOt2WMc1dYF-xktxBucQ@mail.gmail.com>
Subject: Re: [PATCH V36 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:45 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).
>
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Jessica Yu <jeyu@kernel.org>

Jessica, any feedback on this?
