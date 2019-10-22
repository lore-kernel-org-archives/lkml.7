Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FCCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492822184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="waU2hphe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfJVOfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:35:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34851 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfJVOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:35:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so17482272lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYDYFcrmZnPsA3wNhTxT7xGFYYOAAOh9Vy6atnzjLi0=;
        b=waU2hpheX/TrBzV4vEgbgCSQZavQHRKBJyf3We9Oa6EO8pqIzKn/x0RR8yVxAJtXif
         o5wV6xEZj6OmkN+gsNlUIE3SlrYWpP6FnQR91Mkel7Yc31DCKJCqxLVac9zBJWfrqAig
         AnSHfrBGwdsobSt4I2ex8H13Pw5VSILZpZP+0W9/3gOphmAg2NFATMuQ5R5i0fTwxMHa
         mhvxoAYbxgHGF854kilNFHJ9Ees7EW7wGZpA08bLcn+TV5//6T+8yvwOpxDYnmTocS9P
         uzp8bmCNZ414ELtk0X90GazUNbo+1P3jEAIUYD/1uT+dLLXF/88QLkWvgCN4cSI9DcT+
         xtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYDYFcrmZnPsA3wNhTxT7xGFYYOAAOh9Vy6atnzjLi0=;
        b=GxKCRKRpk8iyFKB1ml9Th2EzWi0yMzMuX4nJ8enkDouyA9QNQKZNMxNzoHoSRRe8R8
         d7tFh6WuSGHrnfNvKcmZBnKYBrK7aGOysOZRERZYlK5XZX7qc1b8Gidr+xGlItuoAlQV
         mCjfd0Mc1wOuz3Nrib+t8WenV8e/VIcY+l2U8WZ2GJ+TrYJaYPa0g9p7ZYK07/znlgU1
         wz7Lqnwz7HHoh+70Ot8+6qsMbJVsCya9zYSqD0O7HdwNhSWXpiEoaD2iVlo03mToTCXz
         kGzT9lHLb7CwtCiO4uYoWrNdtxWWn1r5GNWKeCgjrG5MFPKGlDo+HqQbBfccRDPd4cQP
         jgEw==
X-Gm-Message-State: APjAAAWWhZrnfjS24Xw9i6bp0Qm6JVY6CtF2NMKfJPb20TqiTkwgkByH
        LLaPlqy2Rv+lYoKEF7I4U7AxDztabSqaOXOPYn7S
X-Google-Smtp-Source: APXvYqxWl+VJRD6qwDm3xnMIjUjL7khHepxMxomEkV8ULQEiUK2eWkxiHdieTFB5R0wrN5wi4Wq/lLVlZuZfm59x+Po=
X-Received: by 2002:a2e:3505:: with SMTP id z5mr11579413ljz.126.1571754905226;
 Tue, 22 Oct 2019 07:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <214163d11a75126f610bcedfad67a4d89575dc77.1568834525.git.rgb@redhat.com>
 <20191019013904.uevmrzbmztsbhpnh@madcap2.tricolour.ca> <CAHC9VhRPygA=LsHLUqv+K=ouAiPFJ6fb2_As=OT-_zB7kGc_aQ@mail.gmail.com>
 <20191021213824.6zti5ndxu7sqs772@madcap2.tricolour.ca> <CAHC9VhRdNXsY4neJpSoNyJoAVEoiEc2oW5kSscF99tjmoQAxFA@mail.gmail.com>
 <20191021235734.mgcjotdqoe73e4ha@madcap2.tricolour.ca> <CAHC9VhSiwnY-+2awxvGeO4a0NgfVkOPd8fzzBVujp=HtjskTuQ@mail.gmail.com>
 <20191022142716.sgxcmc27w4uaqh3u@madcap2.tricolour.ca>
In-Reply-To: <20191022142716.sgxcmc27w4uaqh3u@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Oct 2019 10:34:54 -0400
Message-ID: <CAHC9VhQwXzyZzrN3fcc=OOqJPu+=CrkWUWGWjKNzP5OPVT_0_g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 20/21] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:27 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I'd like your perspective on how the capcontid feature was implemented
> (aside from the proc/netlink api issue which was intended to be
> consistent across loginuid/sessionid/contid/capcontid).  Do you see this
> feature as potentially solving the nested container issue in child user
> namespaces?

The patchset is a bit messy at this point in the stack due to the
"fixup!" confusion and a few other things which I already mentioned so
I don't really want to comment too much on that until I can see
everything in a reasonable patch stack.  Let's leave that for the next
draft.

-- 
paul moore
www.paul-moore.com
