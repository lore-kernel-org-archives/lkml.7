Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04097C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042620659
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BDDC63Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391576AbfGRVxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:53:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38801 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:53:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so20273163lfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhzTrt+KngzjicFbTv3vZ6r7DsUfT24hW3ZTH7kCo04=;
        b=BDDC63AbbksIGaPLCaZ+G2vZ+QlUC0Y4xmaYnnx1w9Sn0c/YSKCOyE3F3bipx/OPNo
         bY+GCUelVN9YgKRNdiGTQc7e9dxHE8srVeTFP4z3kHDTgyTHdIJxEgeYAGwEg5uRlCR4
         SJCBe/KsTQXTy1ZbjaHtMM7hkizkZLcw0c9zfxcr0RvysIbU+uTnupNfETlIA5tdojdb
         eaHLpJsvTbxt6FmfE6Rqf0hRmvzcJp0R71+FTYwBZjMbwYRjqxFe4jlSYdDpAlcz6a+v
         gHInJ6oZUdBaKuk2fyjd8yd5aDlkZ2MjSHc//o4Z3Oextu3SQoPtQvrnS0hkfu0OOV0b
         pBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhzTrt+KngzjicFbTv3vZ6r7DsUfT24hW3ZTH7kCo04=;
        b=ukxzlmXkhb/CllpwSD61nIvdGc9cNy78JoOtvwQSSk1l7PVvG2xs+VC+7yLUEgrK8P
         lFSqXRgmhPPwqbHpn45RgZKi8n/UwzvT79p9yEvkGOQ9nTCvqYgAKIgJIJsAWk86M5uh
         Bxcc+9ZMhd8Ea948jLK7WCv2HNnHiBVNVU9oLk+aSPKcdlAFQveNe+KCNFCKAsYDAHck
         UsQzAORm8Law6shk2Pj5wfuk3QyFrfMcuBIiyTSZaFQq2P9JyyONO6VJVdppYrc3pJlD
         F73d6NIB0gKZRIpufsZu37B1m+RnvuxGbqnFHTo7CMuEDzQ9nKwn5YdI/UUxPMvwigl0
         QYTQ==
X-Gm-Message-State: APjAAAXolm3MDfFmZt98gyCvRtR0W+J5anDxDgq17K875W3aCkToG3i3
        sHqI4wUFuJ3Lpr0lvZ/E2XuT9SjpASTpsRBUBw==
X-Google-Smtp-Source: APXvYqyGCCJtInWCDaYi60JZY3NOkc1TuPq3hehijvo4gTpiQWjSYxIYBAQx3HMzGAWPk3gWvXKxriSLAdaQ7algVzQ=
X-Received: by 2002:a19:8093:: with SMTP id b141mr22767615lfd.137.1563486789899;
 Thu, 18 Jul 2019 14:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190529153427.GB8959@cisco> <CAHC9VhSF3AjErX37+eeusJ7+XRw8yuPsmqBTRwc9EVoRBh_3Tw@mail.gmail.com>
 <20190529222835.GD8959@cisco> <CAHC9VhRS66VGtug3fq3RTGHDvfGmBJG6yRJ+iMxm3cxnNF-zJw@mail.gmail.com>
 <20190530170913.GA16722@mail.hallyn.com> <CAHC9VhThLiQzGYRUWmSuVfOC6QCDmA75BDB7Eg7V8HX4x7ymQg@mail.gmail.com>
 <20190708180558.5bar6ripag3sdadl@madcap2.tricolour.ca> <CAHC9VhRTT7JWqNnynvK04wKerjc-3UJ6R1uPtjCAPVr_tW-7MA@mail.gmail.com>
 <20190716220320.sotbfqplgdructg7@madcap2.tricolour.ca> <CAHC9VhScHizB2r5q3T5s0P3jkYdvzBPPudDksosYFp_TO7W9-Q@mail.gmail.com>
 <20190718005145.eshekqfr3navqqiy@madcap2.tricolour.ca>
In-Reply-To: <20190718005145.eshekqfr3navqqiy@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Jul 2019 17:52:58 -0400
Message-ID: <CAHC9VhTYV02ws3QcezER5cY+Xt+tExcJEO-dumTDx=FXGFh3nw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        ebiederm@xmission.com, nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 8:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-07-16 19:30, Paul Moore wrote:

...

> > We can trust capable(CAP_AUDIT_CONTROL) for enforcing audit container
> > ID policy, we can not trust ns_capable(CAP_AUDIT_CONTROL).
>
> Ok.  So does a process in a non-init user namespace have two (or more)
> sets of capabilities stored in creds, one in the init_user_ns, and one
> in current_user_ns?  Or does it get stripped of all its capabilities in
> init_user_ns once it has its own set in current_user_ns?  If the former,
> then we can use capable().  If the latter, we need another mechanism, as
> you have suggested might be needed.

Unfortunately I think the problem is that ultimately we need to allow
any container orchestrator that has been given privileges to manage
the audit container ID to also grant that privilege to any of the
child process/containers it manages.  I don't believe we can do that
with capabilities based on the code I've looked at, and the
discussions I've had, but if you find a way I would leave to hear it.

> If some random unprivileged user wants to fire up a container
> orchestrator/engine in his own user namespace, then audit needs to be
> namespaced.  Can we safely discard this scenario for now?

I think the only time we want to allow a container orchestrator to
manage the audit container ID is if it has been granted that privilege
by someone who has that privilege already.  In the zero-container, or
single-level of containers, case this is relatively easy, and we can
accomplish it using CAP_AUDIT_CONTROL as the privilege.  If we start
nesting container orchestrators it becomes more complicated as we need
to be able to support granting and inheriting this privilege in a
manner; this is why I suggested a new mechanism *may* be necessary.

--
paul moore
www.paul-moore.com
