Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA92C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13A20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554844210;
	bh=1tsuJvnKTXfrqz8sSJQwsVTickHMT5Mc9M+11az52Wk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dA5ZeYJvLTE0iHYJn7+/96cGgycBwAy9+WAyhP7HzFS1SVj7slcEynE6UMcQAHjdW
	 FJLzzvYFfh3QP7t8d4EWIsioWfvDMu1F6jadMQM6ae2ZC70CHIReNbBBZxKzJG+Kjq
	 tM7v+3ACX7jviGvpgS/UQSv+/8QfbtHURFZBjQJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDIVKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfDIVKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:10:08 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CD020857;
        Tue,  9 Apr 2019 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554844208;
        bh=1tsuJvnKTXfrqz8sSJQwsVTickHMT5Mc9M+11az52Wk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RwW4BapeLKspn7750o+P8xxep60sGvNx8ksOtZvE4Ag69kulOXwVEIWRlLNOU7s62
         3etr5EIfq4hyBEFhptZ1VqiNMLqsdwAqR/G/iMvzbIRkwveKSUyizJlCGgqmUsZmNN
         /RqCnuTBztsMkpwlU+GDBAhubhhyOd66Q2a54YUI=
Received: by mail-qk1-f180.google.com with SMTP id g1so11228423qki.5;
        Tue, 09 Apr 2019 14:10:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVSEb0PmfjolpfT2i7hgvvTB8AFyGG1kGv4/yngaYYlSqffUKFm
        B+ILWQn0DtylmzazGc3sXqH8e6cNPYRQOmH0Ag==
X-Google-Smtp-Source: APXvYqwE1DN2D/a4442lvpp5swyvq7UeA+qb1C7nhNJb/VX1p0gM91HRF7ibs7jJDurwWOaQrgqbSlarv4h+2bvmuvw=
X-Received: by 2002:a37:5805:: with SMTP id m5mr30018011qkb.136.1554844207093;
 Tue, 09 Apr 2019 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <20190409144250.7237-5-TheSven73@gmail.com>
 <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
 <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com> <CAGngYiX+53Rk2gTJ7G0QhQvEL-fF=Zan5jW9h7cR3gV1-J9xCg@mail.gmail.com>
In-Reply-To: <CAGngYiX+53Rk2gTJ7G0QhQvEL-fF=Zan5jW9h7cR3gV1-J9xCg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 16:09:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLx1a+rENo7QvF-ZXmpLG9Bf2-AGkTPP7hx+Nr_Uh+NvQ@mail.gmail.com>
Message-ID: <CAL_JsqLx1a+rENo7QvF-ZXmpLG9Bf2-AGkTPP7hx+Nr_Uh+NvQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 12:32 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Tue, Apr 9, 2019 at 1:16 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >
> > My apologies for the confusion. You already offered your tag to an
> > identical commit in v3:
> > https://lkml.org/lkml/2018/11/6/66
> >
> > Am I ok to add it, given that nothing has changed in this particular commit?
>
> I added a link to the wrong version. The current patch is identical to
> v5, where you
> said it looks fine, but the series itself still has discussion.
> https://lkml.org/lkml/2018/12/7/600
>
> Should I re-post to the DT list?

No. If you send again, then add my R-by if it hasn't changed.
