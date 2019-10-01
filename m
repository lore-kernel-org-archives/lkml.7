Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF60ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FDD2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFUkDlFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfJARfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:35:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44408 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfJARfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:35:12 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so21997727iol.11;
        Tue, 01 Oct 2019 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=whCgXamHjLa77I09nl1deijXX7dIhsW9Skf9Y8knCmo=;
        b=aFUkDlFNN2vPPPa80DmYalj2bWE1zHHIJgL12YyUXrMNE3d9vGFXI4xhWP7rFAAFdO
         hVyNYXMtR+qDuMcMM3A7/VQIj3tZoBRknyKMaFFGCNVywIE7VBKr4zQC/IB9+tZUMQV5
         UNgOr6iIK7JIX1H1ucGSgIQiqEyFfegJ2B/7MAoaqU4WQYZD/F+XtTg5V+sX5SGfPMfW
         hKqT1lTxvHCbLW5VIRnI92mt40V9fetLD2NvQekDAILhzDVDJKanNjk1ZzJFPbwK4WnI
         fntKR7V8AQZhtBqPCz0MboL8EwfZvK51RvZMDXCwUZzzkl0Yv9YzZA/B6LUVwv1NTnyu
         Z+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=whCgXamHjLa77I09nl1deijXX7dIhsW9Skf9Y8knCmo=;
        b=HlLcMBQ0TNXhMRkMslpKQ2x4znG9oGxC/GSpZI4hFSyc7bwA8tx97WvonIeL50mbzb
         XjQM9WFk4DQm2SvUGewSPZ6Vm5NIIshXvweoKByPBlTbsHTynTtPil76R6kWWsYUqy8G
         dLdqcKH5hjjzCD5RAcNB3oDoJl2Vsz6T3wmUcBJSDMO8t/+we2hzMY3HmffW2DMqdsuJ
         o19HUGjXguO6wy5McFUnMcl2QWxTzmeHIbGgE2nw9vA+pZRUAkp17a+5PN+6AC379qy3
         EFxjSPCIzKFxh/b3vhMqM4xkZ+om4ss8euoLxSiC+kYtOuViRgtclPbtH75YAhFuesz5
         9Vlg==
X-Gm-Message-State: APjAAAWzZsEiTcI7q3U/M9ODH7IOzWKJsLP+ItOkRfZ85RLjvfSLbvQl
        XstYoYYjkrZgIJRIGC7sXnC7cUKxrjMMT0rn5WU=
X-Google-Smtp-Source: APXvYqyF+hCI/7qokfvgtd0R4EhKYcuwhAnJLTud34PPq8G0hFBvmlE46T8Dg1hgZFjibidTkFZWg7EaTovnocy6GPo=
X-Received: by 2002:a92:8702:: with SMTP id m2mr23259951ild.294.1569951310606;
 Tue, 01 Oct 2019 10:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de> <20190930210114.6557-1-navid.emamdoost@gmail.com>
 <44ad775e-3b6f-4cbc-ba6f-455ff7191c58@web.de>
In-Reply-To: <44ad775e-3b6f-4cbc-ba6f-455ff7191c58@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 1 Oct 2019 12:34:59 -0500
Message-ID: <CAEkB2ERMqs=xbt4H-1ro0zAQryoQUH=N5iJop-CKbSOo_mTk3w@mail.gmail.com>
Subject: Re: [PATCH v2] fs: affs: fix a memory leak in affs_remount
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus, thanks for your suggestions for improving the quality of
the patch. At the moment I prefer first get a confirmation from
contributors about the leak and then work on any possible improvements
for the patch.

Thanks,
Navid.

On Tue, Oct 1, 2019 at 3:31 AM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> > The allocated memory for new_opts is only released if pare_options fail=
.
>
> Can the following wording be nicer?
>
>   The allocated memory for the buffer =E2=80=9Cnew_opts=E2=80=9D will be =
released
>   only if a call of the function =E2=80=9Cparse_options=E2=80=9D failed.
>
>
> > The release for new_opts is added.
>
> * How do you think about the change possibility to delete questionable
>   source code here?
>
> * Would you like to complete the data processing for corresponding option=
s
>   any more?
>
>
> >       -- fix a type in title, =E2=80=A6
>
> Please avoid typos also in your version comments.
>
>
> > ---
>
> I suggest to replace this second delimiter by a blank line.
>
> Regards,
> Markus



--=20
Navid.
