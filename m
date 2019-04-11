Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5571C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B208D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fR+h70H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDKJy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:54:56 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38538 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKJy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:54:56 -0400
Received: by mail-ua1-f68.google.com with SMTP id t15so1806326uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9281FotlBKIIcHygll/2yc6a7t1TRMLW7wlwSSuq1U8=;
        b=fR+h70H9gGPdBp0i+v8B7N74lIM5T1M9tRA2U1bhEI23PT13aBxFmq+w4BZBnPFc2T
         GA3aoAmcVzJXLUOXJPbzBbbYKmQlZGM3fKaw56SCy4rlR4MT4ZT3bNru85066U+3uy9j
         9kdKRBoq0Rb7uN4ZW8Ppv+9Q2xO0FfUORGKD2fEeXNI08llYsGIA+MkZpr65uFDilhWS
         HnzOp/HG9lUSsUNTmijZqEDUsbAY0Q202WVlDW10Ajlh/PWKYze8/SrH17vbblIS4a5n
         c6NepopRHKGf02U6ynzx4IcmUlntcWUNt01v8BeUjjkXUzO4+/9iwAgEAI0NKzDtg1lW
         XfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9281FotlBKIIcHygll/2yc6a7t1TRMLW7wlwSSuq1U8=;
        b=WlkB/izGEBvbrklTHcHoAS/jTniNm86zQTm0uJNrYvWOeNLlwClbwrOj2GXsfFA2Tq
         8JaqVjeVAY2eDyt+HOA6IHkYlxnzj+pulaWDv2eiSFOp6M8sYbjJGynkwUOBfzaK9n4c
         A1qkaOcV+oiYN4xmfJS/hzLqsvYQLSz063NGIaWuenzdTk5cUCOy3Q+jTP/kk0KrSxeD
         PLA/Lxw/jEyNK2Kpzxx28ie0Vvle+VJRglcG7DTzefpessJKV/CaoyVUwOSMrRDwNdvW
         +qCjR8NaDqmqL7qIs4k8sTG8ax1nyxmKaY6aURMJAPrJp7Ax90ZZTCiLBs1fteGWIBwD
         H/HQ==
X-Gm-Message-State: APjAAAUijgItXO9EQyposEMCUq7jg19Cbvhfsa3LQicDD7Io5/vldW7A
        T3QMu8gPAFYHmS9dWmbg/z6V3rtbuKAbruAp1GoFQw==
X-Google-Smtp-Source: APXvYqzwn6c2xpH44rS11xAtmBW5ufqMX8J2tHvd0hJlRqCjuqB9TlKW50TyE8LYh2dov3RkPRrRiWEWgouNKuM5Q3E=
X-Received: by 2002:ab0:6947:: with SMTP id c7mr2972554uas.51.1554976494989;
 Thu, 11 Apr 2019 02:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190322114345.26532-1-ulf.hansson@linaro.org> <CACAwPwY=rhfyoLvkPNB4Pdagv_wjKgnybeW1Az1gd3vAF_0exg@mail.gmail.com>
In-Reply-To: <CACAwPwY=rhfyoLvkPNB4Pdagv_wjKgnybeW1Az1gd3vAF_0exg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 11:54:19 +0200
Message-ID: <CAPDyKFrJeV4bFSuhx8aO8108WqJ9k_X3igzQ75_B93XLUrmPVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add Ulf Hansson to the MEMORYSTICK section
To:     Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Dubov <oakad@yahoo.com>,
        Alex Dubov <alex.dubov@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rui Feng <rui_feng@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 18:03, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>
> Thanks!
> I also expect to start contributing again to maintain the code I have
> in the kernel, after I done with upsteaming the nvme-mdev driver I
> have just sent for initial review.
> I work for Red Hat now, so I hope I'll find some time for that in the
> future (still on a hobby basis of course).

Thanks Maxim, I consider this as an ack from you.

>
> Best regards,
>      Maxim Levitsky
>
> PS: my work email is mlevitsk@redhat.com

If you want to change/add your email to the section in the
MAINTAINERS, please just send a patch. I think otherwise people will
continue to send to your gmail address.

[...]

Kind regards
Uffe
