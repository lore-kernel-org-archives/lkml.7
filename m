Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376CC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678662077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jsdx1Trn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfDYUjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:39:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55077 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfDYUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:39:13 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so2320993ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vt2MHREG2YW1b5Y4ynxE1gZ24ZdGV1+JspuK5nI83KY=;
        b=Jsdx1TrnktYnmyKJsMoo7doVO3TxeEBSjygL1I8pQFFrqJHvtTA0+4/DoMGGiJy+GT
         A7sWMEm4PwyOBlSMEEUdsHPzBga0UipypP3GbzjLxYtga9A+g8JkIS3a70LfV/C6L9aG
         TMwa/YU3l0WdUGELor4qWqYgRECWqjTyMNGDdGpHBfJghrWxL7XHM19HYRBU18oOMMS3
         aB8vF4Q6pX7IGeAU65ylVKhmQt/0SVoCqjGpJWBjYUHBfRyD0Nj8Kjgp7x6JE56s+x2R
         XIbINGd4KfGBgzrwtqf0LxgoBKsZ89A/rI4n4oWDjimxd4VjNJBV9uke/xdhZlXWOjeZ
         sMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vt2MHREG2YW1b5Y4ynxE1gZ24ZdGV1+JspuK5nI83KY=;
        b=JaDvwAUiIC7gBRTns9P3/iqYd6c/q1HF4cp1DnfpfnDElInDtvOe+9GdxyXUZo+l95
         6e7Dr7kIBH1Lgui0QiJ7//qzLAEgNf1lce4TV/qr9+3KKmWLzA+LAqP70ziV70yuzZWN
         GLEc919f08QSKre3rbdZaKFbJ72BFb/Ub2bkU0kVrqdQNX9AIcLOQ9P82PMpQy3/x4mj
         nmiHQXCYnqSwBSXh+U+F2RAi4R7MvFLLAR9pcjztmpgAijyknEMBP5okrHWATuU0pslt
         i7U9A5rGbN5yPiEMu2AreVa1PWqvanW9eGMj+Xx5ZcGFqhjsrglr8gWUxXM8+fSg2n36
         9hng==
X-Gm-Message-State: APjAAAUoiy2cHYyLB6D22ZKmnYscKRX08hToDbCUOcFozNppuLKDNV0l
        go49Ahnt7l4bEuexLsnBn1Ed8cSY/23udtxqGJ7S8w==
X-Google-Smtp-Source: APXvYqyb9X1rNLIny8GhZh4mbLQoW30LUgL2p7h5j1bdxa54QREd5fTxckJy1RdiyszL2i5qiQCRVH0oo67LjR2oCp4=
X-Received: by 2002:a02:ad07:: with SMTP id s7mr18510295jan.103.1556224752679;
 Thu, 25 Apr 2019 13:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
 <20190425123755.GX12751@dhcp22.suse.cz>
In-Reply-To: <20190425123755.GX12751@dhcp22.suse.cz>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 13:39:01 -0700
Message-ID: <CACdnJuutwmBn_ASY1N1+ZK8g4MbpjTnUYbarR+CPhC5BAy0oZA@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:37 AM Michal Hocko <mhocko@kernel.org> wrote:
> Besides that you inherently assume that the user would do mlock because
> you do not try to wipe the swap content. Is this intentional?

Yes, given MADV_DONTDUMP doesn't imply mlock I thought it'd be more
consistent to keep those independent.

> Another question would be regarding the targeted user API. There are
> some attempts to make all the freed memory to be zeroed/poisoned. Are
> users who would like to use this feature also be interested in using
> system wide setting as well?

I think that depends on the performance overhead of a global setting,
but it's also influenced by the semantics around when the freeing
occurs, which is something I haven't nailed down yet. If the
expectation is that the page is freed whenever the process exits, even
if the page is in use somewhere else, then we'd still want this to be
separate to poisoning on final page free.
