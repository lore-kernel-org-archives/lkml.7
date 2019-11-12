Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A31C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEC121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAr3PctE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLTJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:09:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38699 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfKLTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:09:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so13799863lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FPgM7SKFCN9msWXuyWzvDA0G+gWYRF9TEdVYJj4UX4=;
        b=LAr3PctEvf0Qp97K3E1zPlt4STnZtx88R2lMOGizjf8Qv9n3YYDLOdCeA6Psx+7cKw
         5JREarMdzn92YHkL67Rqpw4BU4RaeAAWEl6NKOMIGvya/yqlPa33AxGrCE9r/JOsXvcf
         2XZUsajCtPg7eoVXew31WlRhJKOw7o705SzR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FPgM7SKFCN9msWXuyWzvDA0G+gWYRF9TEdVYJj4UX4=;
        b=d9ipHEg0GPOrtuvZxpwI+jO/KuPjW2LeGBrwD6lvxBBL2x4kNtVArTEkSSmdp9lgG6
         ktl9g4BjLQDcurGp2DBEzyh3QMoaUnXJwZgLD4++mCDVZ2nJVwVNSKD5qzHxrtMKnOm0
         fEKvCCMgeNw5fypS5q2hHAdzTPiukIOTj+wNI3TtQCx8Iakdk2fa800Zptb9UX2a4eHf
         YKjxznbju//xZLyqbXkKX/1z8bBS8Jd6o53/qE/GVGr6/x3vaK7shukm/7viUIELLDAB
         p2a6BBH5lCRGKZvFJlhMkPpq5aCrR9WHwQOS2hTMUvUSasTEUMwuliMQIMLP1j695Ncf
         louA==
X-Gm-Message-State: APjAAAXrlSYTzbkYcLNN22onFeZD6LP8XwbA6dAd2tywUvPFIU7o2sbS
        P0VuUvE9DF+WM17icqcI3+horW353U4=
X-Google-Smtp-Source: APXvYqysYnHjqCbgGJcsy+hpOee2wmYGTebaXGgMawvPH8arvxzWkI3zAyNCnleBbYo+JvGPeLeeyA==
X-Received: by 2002:ac2:43a3:: with SMTP id t3mr5067651lfl.150.1573585785994;
        Tue, 12 Nov 2019 11:09:45 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n8sm223782lfe.31.2019.11.12.11.09.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:09:45 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id z188so6567578lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:09:44 -0800 (PST)
X-Received: by 2002:a19:40cf:: with SMTP id n198mr20776284lfa.189.1573585784155;
 Tue, 12 Nov 2019 11:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-2-evgreen@chromium.org>
 <20191112083208.GA1848@infradead.org>
In-Reply-To: <20191112083208.GA1848@infradead.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Nov 2019 11:09:07 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
Message-ID: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Nov 11, 2019 at 10:50:29AM -0800, Evan Green wrote:
> > -             if (cmd->ret < 0)
> > +             if (cmd->ret == -EOPNOTSUPP)
> > +                     ret = BLK_STS_NOTSUPP;
> > +             else if (cmd->ret < 0)
> >                       ret = BLK_STS_IOERR;
>
> This really should use errno_to_blk_status.  Same for the other hunk.

Seems reasonable, I can switch to that.
