Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FFC47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8802133F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FPJb5Ts+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfJHAOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 20:14:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46662 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:14:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so22088620qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwpM8H3Kl+cJemfHW/m+4vr117WhQgW7a+c+wjSzzUg=;
        b=FPJb5Ts+77eCWzrJlMAnTVzfuZ4L/kA/kxEkPQ2BpAeaKKjV6Kk4hiNHfgygdASBGK
         O3wZUl2Id4FC/E4896l2aGU0awsWEqXHs6U/O8g4QwhDaTnKNs3hbckbzOiByYn+XQlF
         YxkuHAwLPQL9GOWkDlabcI+wpr85ghTHUN0nzEZ1hBsay1xexD5tVwlkBJHo0ulCQc5s
         1jxFglCC65STrPI0kklzXaGml7Rt/TSh6w2/S3ecoRMPM3fCqhSemfXirvnIIDYpAXoo
         lW8PoQDB3ty9muyNUpYEMrxLf/NtsM6AYABJrwu1B9obuNLNkyB5ntSfTYyfdLFygu/r
         1O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwpM8H3Kl+cJemfHW/m+4vr117WhQgW7a+c+wjSzzUg=;
        b=UKrZLtDK9ntheyHiGRYAx5dwnOouEy4icPlORWcM4/PcX274/DmNn8nykVjLlkYejE
         KZUMkdGtUWVHTejlFFoPqrb1nLTNCsEZuDSM/5Ev93zsAmCVFtw7IKZPb7SS4oe3CvcB
         OVfJbVh1sBzKsCNOGz7xPg/BAmhaz5qN5qJm7NHLs61UlRpDKabKphhfdyWh5Gif4JVf
         mFSM/rmtHtoNcLKSz0R02V6bALIaqpsOtuOwfA5RtJigAgi1n2Pkl1tzefM8dN76h4ZX
         MIH45SgmpkHxidw6P+umwUB5HhRGeM8WBL2gZT+dg3vMELrF2f+dWCfTIS9bXck3eSWm
         DF7w==
X-Gm-Message-State: APjAAAWgMZrD4pHEib7b+A0AYjjzqpI4UYrRzbIA2QNjwbWBemWlQrUV
        JDi7+SHlYa1s5olt+sfMY8//ANr+DrNALu6GKRfqtQ==
X-Google-Smtp-Source: APXvYqwsH2zdf2taNwDiz2CNOAgmmiyiIrI+62A5GpN27uuj8bCp1QzW2t6+ikyd6gFkYj2hh7xeEcrFCZPXV5qKMbY=
X-Received: by 2002:ac8:2bca:: with SMTP id n10mr33477517qtn.242.1570493688925;
 Mon, 07 Oct 2019 17:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-5-git-send-email-vincent.chen@sifive.com>
 <20190927224711.GI4700@infradead.org> <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
 <20191007161050.GA20596@infradead.org> <alpine.DEB.2.21.9999.1910070930270.10936@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910070930270.10936@viisi.sifive.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Tue, 8 Oct 2019 08:14:37 +0800
Message-ID: <CABvJ_xiHJSB7P5QekuLRP=LBPzXXghAfuUpPUYb=a_HbnOQ6BA@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in do_trap_break()
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,  I missed the comment. Christoph's suggestion is also good to me.
I will modify it as you suggested.
Thanks

On Tue, Oct 8, 2019 at 12:31 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Mon, 7 Oct 2019, Christoph Hellwig wrote:
>
> > On Mon, Oct 07, 2019 at 09:08:23AM -0700, Paul Walmsley wrote:
> > >             force_sig_fault(SIGTRAP, TRAP_BRKPT,
> > >                             (void __user *)(regs->sepc));
> >
> > No nee for the extra braces, which also means it all fits onto a single
> > line.
>
> Good point, will drop the extra parens and remove the braces.
>
>
> - Paul
