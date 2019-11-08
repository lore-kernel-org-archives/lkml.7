Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1192215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWD4v22O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKHPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:15:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42007 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKHPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:15:15 -0500
Received: by mail-io1-f68.google.com with SMTP id g15so6719211iob.9;
        Fri, 08 Nov 2019 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOrCgpvdg/KvlO/h5Wd7G5wPvTtcd3OWqo9gJ0rgrlo=;
        b=dWD4v22OkhbbvMSwYUZ95Ok4srdhWnRsopBViIewC4JmRXRvOygT1/st1DPNL/km0a
         4Qh7mw7c1/p9vTWr9caM7ju13HrbpcIoVQkwMyAfL/4369W722zY8lGpL1B2QXTT+3LT
         sX2CkMi9IH0pqzWqbL0+WiNyPQ761G4VtIBuoUH2dTEuNW4wLXkFIgT2/V133bdOW/GG
         7KjOO3LrGgjISU35uVmmUYQnZbns+V0hH02lTWY2b8mGGB6CppsZYGHc9T3cfiK/22nM
         jVEit7LL33l8rThG0som+WHYLoAUvrS43aRSEjI+ZC4iSeSYdldAiswtdzA/I19jFv0s
         6lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOrCgpvdg/KvlO/h5Wd7G5wPvTtcd3OWqo9gJ0rgrlo=;
        b=axB++Qh90eLd+x98FKnTvDaA8RZvZuGPIzyeXBcjEq7YNlOaAq9xThOSMY1M3MfJaY
         HdWmHVuCxsg8hg6rAxRCmxQu0ET1tNVV8jmK9wVWAbBA5jUmWhvRErVKSxS8F34tP8Hj
         vtqdHV4f6iF4N6NCIcMUPK07NHCJfQ7WPskzFefM2AYvl/jOw+InsuTNMVoX5DWVCE69
         1+iWjpVDgRfEkSgbES8iWuiyHrrqECCrk9QkorUHt87YobpNwLIZfIygJNgLbcBp2+Y2
         5Z29kLjbSiBKZfqKj8vW2RXu7WsWSJix0CmJ2q9udgFYeIkWujNPLl+9abMfcX8gjOHR
         wWlQ==
X-Gm-Message-State: APjAAAWHJZVQ86cEgh4TLexiXY++AHoGlU2Siz3qzRyrfElFouyp3cSi
        DRXqHFNU482D38XM5B4bVHx9Ce2ATu0T4i/nRj4=
X-Google-Smtp-Source: APXvYqxP2aQUBKViEIx5O56eV6Vn7vzymNBSZ5tThWTlQR6H1FW1tTABHAooQOoLLS1Me/daB472OZSuhF0bLyc8UKI=
X-Received: by 2002:a5d:94d8:: with SMTP id y24mr11174566ior.131.1573226112847;
 Fri, 08 Nov 2019 07:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20191108141555.31176-1-lhenriques@suse.com>
In-Reply-To: <20191108141555.31176-1-lhenriques@suse.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 8 Nov 2019 16:15:35 +0100
Message-ID: <CAOi1vP-sVQKvpiPLoZ=9s7Hy=c2eQRocxSs1nPrXAUCbbZUZ-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] ceph: safely use 'copy-from' Op on Octopus OSDs
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        "Yan, Zheng" <ukernel@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 3:15 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Hi!
>
> (Sorry for the long cover letter!)

This is exactly what cover letters are for!

>
> Since the fix for [1] has finally been merged and should be available in
> the next (Octopus) ceph release, I'm trying to clean-up my kernel client
> patch that tries to find out whether or not it's safe to use the
> 'copy-from' RADOS operation for copy_file_range.
>
> So, the fix for [1] was to modify the 'copy-from' operation to allow
> clients to optionally (using the CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ
> flag) send the extra truncate_seq and truncate_size parameters.  Since
> only Octopus will have this fix (no backports planned), the client
> simply needs to ensure the OSDs being used have SERVER_OCTOPUS in their
> features.
>
> My initial solution was to add an extra test in __submit_request,
> looping all the request ops and checking if the connection has the
> required features for that operation.  Obviously, at the moment only the
> copy-from operation has a restriction but I guess others may be added in
> the future.  I believe that doing this at this point (__submit_request)
> allows to cover cases where a cluster is being upgraded to Octopus and
> we have different OSDs running with different feature bits.
>
> Unfortunately, this solution is racy because the connection state
> machine may be changing and the peer_features field isn't yet set.  For
> example: if the connection to an OSD is being re-open when we're about
> to check the features, the con->state will be CON_STATE_PREOPEN and the
> con->peer_features will be 0.  I tried to find ways to move the feature
> check further down in the stack, but that can't be easily done without
> adding more infrastructure.  A solution that came to my mind was to add
> a new con->ops, invoked in the context of ceph_con_workfn, under the
> con->mutex.  This callback could then verify the available features,
> aborting the operation if needed.
>
> Note that the race in this patchset doesn't seem to be a huge problem,
> other than occasionally reverting to a VFS generic copy_file_range, as
> -EOPNOTSUPP will be returned here.  But it's still a race, and there are
> probably other cases that I'm missing.
>
> Anyway, maybe I'm missing an obvious solution for checking these OSD
> features, but I'm open to any suggestions on other options (or some
> feedback on the new callback in ceph_connection_operations option).
>
> [1] https://tracker.ceph.com/issues/37378

If the OSD checked for unknown flags, like newer syscalls do, it would
be super easy, but it looks like it doesn't.

An obvious solution is to look at require_osd_release in osdmap, but we
don't decode that in the kernel because it lives the OSD portion of the
osdmap.  We could add that and consider the fact that the client now
needs to decode more than just the client portion a design mistake.
I'm not sure what can of worms does that open and if copy-from alone is
worth it though.  Perhaps that field could be moved to (or a copy of it
be replicated in) the client portion of the osdmap starting with
octopus?  We seem to be running into it on the client side more and
more...

Given the track record of this feature (the fix for the most recently
discovered data corrupting bug hasn't even merged yet), I would be very
hesitant to turn it back on by default even if we figure out a good
solution for the feature check.  In my opinion, it should stay opt-in.

Thanks,

                Ilya
