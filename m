Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7231C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852F271ED
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjoKGRLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFAKlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 06:41:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42005 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFAKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:41:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so837605lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfG8SFYlwhX2T6RV6yxB9+NDJcpkM3O1MaSrYiv8LPo=;
        b=rjoKGRLLtJKt2NLllelbm573MDL2ykr+faYahdLKjSY7Y5bcl9oOcfgIPjxjLRT8Rg
         mveZbNR6/4PcibX5IGuiP2ht/kulnh3WcI4MaWK2Y1A0DXjutsYEwD3qTftFhiv8GqfK
         7+qaDof1ZYd3doX7X1h+7WeRcfHVpsj0pwMdcoQ9xEdSqbExbR0q5XsGZkhOjNfO0bju
         T5gSSanCNIC12PTxtOjXIjZmgaW8TSijlkhgbcIQjczBFFhQDLrsYZl8VwB/3MG1Gh3c
         8YfiZYGEuJBRTypFu7XSl1WsefQ2ppNKSDi5woINqma62CXA6zpRINHHLvZ5yGrTw5X8
         DUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfG8SFYlwhX2T6RV6yxB9+NDJcpkM3O1MaSrYiv8LPo=;
        b=ESFbTMWKWNsQZtw8LzlXnfkJeb311AJdEHRp+7wQkvvSm9JrZYa3RfDgMf1LexO4Mk
         6Pb6Zj+joCRrCSK+OHtIrz4cNKwiOianfVjLkfnNogSM3no5PT3zLEiNdn/tR0OiZiBg
         9vvq0gKM0HFnR9oJ7KleKsCmsHhwRlzhcW4Ys7vj8ppJNsOcoj1jN/NGvobD5aAs1MDL
         IOKVcUtaCnFmyeBRUA0vMjsVoBRfSE/XmfHuutjNr3ayOA0Iz5SHZLh2ELgwhW1GJWnp
         tXYXB9eUoZCLEnvK/kuvH1zmRAk5d1Pw1b0WFzYUts4S+JiUi9UCQPHlzYVNdj1chfCk
         CkfQ==
X-Gm-Message-State: APjAAAUDJJiQzyM7V0fQ9ORjw11KTVz8d9QuQyPR3WDE5dphuSIf31rW
        eQQSQfsM62PwIXsCXmRh3/7OyArGWUazOo3r8To=
X-Google-Smtp-Source: APXvYqwo+hRPRQiNwv/GCJLziYFhPRmDBka35PISCOCnRhr43lAq1JZzc9/8GlGwArLsGmyrafsMQ15XfcxCKdwIxNE=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr8892650ljg.188.1559385671552;
 Sat, 01 Jun 2019 03:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190528193004.GA7744@gmail.com> <CAFqt6zZ0SHXddLoQMoO3LHT=50Br0x4r3Wn4XviypRxRUtn9zQ@mail.gmail.com>
In-Reply-To: <CAFqt6zZ0SHXddLoQMoO3LHT=50Br0x4r3Wn4XviypRxRUtn9zQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Jun 2019 12:41:00 +0200
Message-ID: <CANiq72m7YURu2XiKHQ+F8sxitVecZyrCPFBw=wGr2CddEv3khg@mail.gmail.com>
Subject: Re: [PATCH] mm: Fail when offset == num in first check of vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 9:09 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 1:38 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > If the user asks us for offset == num, we should already fail in the
> > first check, i.e. the one testing for offsets beyond the object.
> >
> > At the moment, we are failing on the second test anyway,
> > since count cannot be 0. Still, to agree with the comment of the first
> > test, we should first there.
>
> I think, we need to cc linux-mm.

Cc'ing Andrew as well as Souptick suggested me.

Cheers,
Miguel
