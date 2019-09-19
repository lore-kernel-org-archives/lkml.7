Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BFC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF920644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568912706;
	bh=l7pePM/NQUavY6rzQA3tJA6iXW69IP+oxvh/NwcCrmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d7Tk53y2aBswMjb/mIj2eqq/f4DqNtAjX0yxZPPJLnzIEpCjcn1QnozFrGu2Z7KRM
	 w8L7W5R2IZYsNHcPIwE6CwZqW4HmqO3HquQNsdDhmohmB+TZvtavAz1DHfHTfXR0AZ
	 7t356tNXIPWt/RPZ8vbBP1sXNo/FjCRTy+e7H2NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391358AbfISRFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:05:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43779 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfISRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:05:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id k21so28506ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cG/q3cFRYsyXfs7WGIDIqxPhNH59Y8kVxp4a4QrtYec=;
        b=E2cDdbP2/fhgtUxeWn9F/GPtmg03tInrSSBmBjgzSx2QzM61s/GaEXUloJz81ijobL
         PDNb7lDrr/uWOWaQGMcZ/bzgSkg2A+IktHmv0xZxrybAdkgVOGCSAErBYug47C0mIo+0
         3rMkP4xNaakXDWOWhasJcY2phrxijQ6+lzNPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cG/q3cFRYsyXfs7WGIDIqxPhNH59Y8kVxp4a4QrtYec=;
        b=Z6RM2hpj23z0LNtlCXp5jJaZKEsLof88iFn++LPJocq/OkSDzSy2WzUfViXOtuuGd4
         7Py0TMR8oDraEt9bLoFLRnvJcLJDnYBQywm3MVDMUAcNj1OLoqVkc/29HFrk8WaGxLdG
         LLBxC+qfuody420R75o3eBlDGLR1G34UT8lhc9Nmp2fPAmkC2PzYRlPhbp2oNz4TCFJt
         ihoHyp4m2h7WiTPSq8hAlXqRdghELCZwti/z9B97vUMAo/exsi95fy1HwTsKXhKdKOY0
         81AhGWEA6L57UycQfggV4yKVcGtc3GmlKlgnGTljzgQPO/i4NOywkxw7keCgvlBnfGpM
         FDgQ==
X-Gm-Message-State: APjAAAWkoZZf2PErh/i34ifU7LsvoTwRxicRPhmq8Rj3o30VdKkmyeHe
        +j75r7V0aNUajSi3RBlNU6IKyzEh5i8=
X-Google-Smtp-Source: APXvYqzqNMEdAEBjloYneMkENy+gngdTmv1zW8cmBcPHU9Rl9jp0MITvpKH4K4D3h4waUT2eNc/edQ==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr6271284ljh.49.1568912702553;
        Thu, 19 Sep 2019 10:05:02 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m17sm2057054lje.0.2019.09.19.10.05.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y127so2949891lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr5615990lfp.134.1568912700141;
 Thu, 19 Sep 2019 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
 <20190919034502.GJ2229799@magnolia> <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 10:04:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS25dNe=zj8s8w0ppGoL33JQczQWdF406ubnkJHQ9izg@mail.gmail.com>
Message-ID: <CAHk-=wjS25dNe=zj8s8w0ppGoL33JQczQWdF406ubnkJHQ9izg@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So inside of xfs, that "pop ioend from the list" model really may make
> perfect sense, and you could just do
>
>     static inline struct xfs_ioend *xfs_pop_ioend(struct list_head *head)

Note that as usual, my code in emails is written in the MUA, entirely
untested, and may be completely broken.

So take it just as a "maybe something like this works for you".

             Linus
