Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BFEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="semHfxG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEUIQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:16:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44806 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEUIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:16:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so15505670otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/qriHOQGa6rGdckgb+2HJDlYEvPhGrkY4++iU8fZoM=;
        b=semHfxG9pzCXboJoYkh9h8P+S59IQlVNE6n/r5kEdQLi3Usqdz+H3At/2igFhK5UO4
         kEyslWV/j8FUplkjdUy3V21B/nj+ZdUVp3dbY/bWrSS0fM0jen19i+xoRP4W3sJ6OJb7
         5OhfnGEpZfFIsStUP3/ucOGHxxd/iLOYrLUqVgpehAuXEz8Hi4uYi+JwG+n84uw+SKC5
         eiN4BQPuJjq/DEc2UhQRCORHwLI8APRmjRGsgN4+c+bM7LPKQS6ea8GyazPo8WMZ3wFP
         tjs1am6T9heJZPGp1qcankrFAZLQtQX0iIO6pGycHVeMQnsfOqImeFSfOWneGwgh8ZGF
         s86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/qriHOQGa6rGdckgb+2HJDlYEvPhGrkY4++iU8fZoM=;
        b=KYidDkEQh3lX+LZheSLopLLbeEOqv2ajqwh+r4UISIW9dF2e3POSrN3W9SnrDSfs5v
         nkmQoCUUrfyAV0kSpKymOheHZ4t5/e99VsS00wH5dkiHRPFCyOzA9/2eoPi7lyNB2FC+
         Lh8mjMkSU5+7/8pYcaO8sAQsrCefS3mZmGKLCuZajd8yfKcum9aQjbIisw/b/3v/A68F
         kD4J9Q4+uBvdzhww0xOu4T7M2FnTD0fVw11fCXaA+kmjXQHt8Ct1AY+3LZEgPZfU6ecK
         fsVAsm2LfZguHI//FkR1PA6mgCC+TuyS3lvZ638EszTgG7U013yfQNLySZtT9BHYJTd5
         rFDA==
X-Gm-Message-State: APjAAAXxZ7q6XYh7nFLVO3+uxqQOkkOB/PyxN/yi7xlHtF0iRZjflPYi
        TG0qpsbFj9ncUf/40LVTQwppAup74YAXh8Ly/Rs=
X-Google-Smtp-Source: APXvYqxiDb07Niuz9hHWasmKzngXfj4t9fSaa3JSTgj4miomJRif4Pw5Pg7sQYJHxY7Fsp9OyLv6OvI0Ek1vaCfWtMg=
X-Received: by 2002:a9d:65c9:: with SMTP id z9mr16691241oth.218.1558426573396;
 Tue, 21 May 2019 01:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558146549.git.gneukum1@gmail.com> <20190520083026.GA13877@kroah.com>
In-Reply-To: <20190520083026.GA13877@kroah.com>
From:   Geordan Neukum <gneukum1@gmail.com>
Date:   Tue, 21 May 2019 08:15:52 +0000
Message-ID: <CA+T6rvENoDXbUWEi4C5kXxsdamkZKVP19MwzEuxs0qC=ckMyeQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Updates to staging driver: kpc_i2c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:30:26AM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 18, 2019 at 02:29:55AM +0000, Geordan Neukum wrote:
> > Attached are an assortment of updates to the kpc_i2c driver in the
> > staging subtree.
>
> All now queued up.  I'll rebase my patches that move this file on top of
> yours, as kbuild found some problems with mine, and I'll resend them to
> the list.
>
Thanks.

Additionally, I plan on trying to clean up that driver a bit more. Should I
base my future patches off of the staging tree so that I'll have the
"latest" driver as my basepoint? I don't want to cause any headaches
for anyone in the future.

Apologies, if I missed something obvious on the newbies wiki.
Assuming that I did not, I will certainly go ahead and try to document
this case either on or as a link from the "sending your first patch"
page.

Cheers,
Geordan

On Mon, May 20, 2019 at 8:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 18, 2019 at 02:29:55AM +0000, Geordan Neukum wrote:
> > Attached are an assortment of updates to the kpc_i2c driver in the
> > staging subtree.
>
> All now queued up.  I'll rebase my patches that move this file on top of
> yours, as kbuild found some problems with mine, and I'll resend them to
> the list.
>
> thanks,
>
> greg k-h
