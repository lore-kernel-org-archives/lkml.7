Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928BC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671D20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556739255;
	bh=5tReOUrzelLvjTkSMgmzvRRS2VMTSjQ5NiM0PedyA3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g7j2pjByvoQG3ugY2XVVLfc3p74DJKXd4buIrVt55Ied7kqeLnPlYx5IuNEGVcoPj
	 hvmu3HfMmJl2STq0aq2P7KrYm0GCArpdUyeS8cZMpXnfeEU4VDqBel2JuyGG0DLCYW
	 wiexPQOm8HZG2GnjNcTfDRdiORMbEgKcaUTuHroo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEATeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfEATeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:34:13 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925CD20866;
        Wed,  1 May 2019 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556739252;
        bh=5tReOUrzelLvjTkSMgmzvRRS2VMTSjQ5NiM0PedyA3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VQ8vNckuqkP5Od8simNBGaCzSDjX6bWqtWHd3m5CZwQJuzCoptt54ZEzHZwh9fZzq
         RdVWKSdw1HjlL5GhKu8fxXy3npawfWhosE3nmO5SIC8aKTzoEtS6GzgpaEVy5blgm0
         1FF27FKOc5llD+l0jTswBCW6xbTnuLygy8BPWfo8=
Received: by mail-qt1-f173.google.com with SMTP id d13so21127333qth.5;
        Wed, 01 May 2019 12:34:12 -0700 (PDT)
X-Gm-Message-State: APjAAAUp8K9y9hPBNsIE8Y9DWEcOAKz2JI3CB3Il4IAyhicvlQe0RYqd
        5rZ/fBmzbJ3MtBcwieJ4BgRLYeOHWZSUCk5fUQ==
X-Google-Smtp-Source: APXvYqwj7cm64cRUu/TNF3jBs52acOh6qkilwYM9ncBzFKLhl2x45yV+ow/pJQPGRAZgDV2XxY57xF3xZfOA5rCD+XI=
X-Received: by 2002:ac8:610f:: with SMTP id a15mr51938538qtm.257.1556739251849;
 Wed, 01 May 2019 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
 <20190430145624.30470-1-tranmanphong@gmail.com> <CAKwvOdmvA4sO7UsXW4DapO_HKodeWFwA_5FsNe_wVjneZBYYdg@mail.gmail.com>
 <CAKwvOdntTmHBinCK0T_8OZ-2ksUHkQBvDyR8WrxZdW=+yu25dw@mail.gmail.com> <CAKwvOdnVrm9MyBkWL=yykX0td-c6uB3=Ymo0hr8wMQG1QESreg@mail.gmail.com>
In-Reply-To: <CAKwvOdnVrm9MyBkWL=yykX0td-c6uB3=Ymo0hr8wMQG1QESreg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 1 May 2019 14:33:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHBZ7AmyfU0Qu-Sc2EbYc+4t=Y-jqApf=D9psC7xmO5Q@mail.gmail.com>
Message-ID: <CAL_JsqJHBZ7AmyfU0Qu-Sc2EbYc+4t=Y-jqApf=D9psC7xmO5Q@mail.gmail.com>
Subject: Re: [PATCH V2] of: fix clang -Wunsequenced for be32_to_cpu()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Phong Tran <tranmanphong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 1:13 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Apr 30, 2019 at 9:29 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Apr 30, 2019 at 9:28 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > Thanks for the patch.
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/460
> > > Suggested-by: David Laight <David.Laight@ACULAB.COM>
> >
> > sent too soon...
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> We'll also need this for stable, can the maintainers please add the
> following tag if it's not too late:
>
> Cc: stable@vger.kernel.org

Applied with a whitespace fixup and stable tag.

Rob
