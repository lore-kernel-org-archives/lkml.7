Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44074C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1656E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569274550;
	bh=diYMA/O6NLFOVNj4TPX/3etTJQHQdavAYL2sljSgdDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1rxC+KjBYG8C/DEL3FNDrlWVtVDjKjEdON9+yzNO4NPBd2VwWwjZuwQdt6yXvVIu1
	 nCL3h3DNVYqXrrXlF+6/ZWtwKLpVYYDqP26c3ohz3s+UsFZqDD09XKMY62fd6A8fQp
	 gmb9MDbh+UAt2OBcFBYTKMLIWJCWk8MSIgQ3C87o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502974AbfIWVft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:35:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbfIWVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:35:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so15205022ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rPInDrQugcHITDKVlAr25OdVNJWqsDyo3I0eQIcB8s=;
        b=QRQw9OiPKf3NL4+42cCQt9hdrKOKSwqrn7y+nD4tFRTZhdtc1rRPQE3KLj7T0ud8Nb
         O4lyuCLSC6h7R9V0+6rlQYTgkDuHSM2x3HgaHrXIDvJa8n/IcSMtLHWVemU5M7jQVfQ1
         K7zBB1/KHELfhnbpTOVxgWweyzfVmmjNrhRtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rPInDrQugcHITDKVlAr25OdVNJWqsDyo3I0eQIcB8s=;
        b=mTrVzjak7RxGJTr8L+OSvmkyzwyPdEwdd2+fw75GMmyz5o2AeUeEthx7UbHhXc6/J8
         W7Va+bcCCj0MLS25d+s9dFJlmUwDNGakq+eLxVh/civ9Oerz99KSkBfkCq0EsVVUXI7s
         dF4IYjl/KMAQAbtov6vdKQXE4LN7fxtdq4d7HI41P8ZxiY3XRv2ytaPLcpVVfWBgX3el
         2aTpJ3MyZSYDp+j4nJr1ODAg79wNFPTyby5Un6gvPMoCl/LL16WP3ujHRLKX4Dc1xIsu
         zwTuISSsCL/8g3HVluhSFdI71QGw/GCH7OKbfn6TWsBKV/+WPZwhtn+aT2GekL/Pga8f
         eu+A==
X-Gm-Message-State: APjAAAWOSo3QATPpX51KOTkVwSVPYYhEv5liY9a7excQ0GwqvgC7FGSo
        qRrA+Qly5mURuvJzToSiLfawwyXSvr4=
X-Google-Smtp-Source: APXvYqxSijKXcREWKI6/CL5PK06Tm2CO2zZtFL2NF1dBayqxyJ0ka8iwx6/pJ+Dmqzuh6VKlUEa9CQ==
X-Received: by 2002:a2e:761a:: with SMTP id r26mr824152ljc.137.1569274546195;
        Mon, 23 Sep 2019 14:35:46 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c4sm2472738lfm.4.2019.09.23.14.35.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:35:45 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m13so15138887ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:35:45 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr814171ljw.165.1569274544776;
 Mon, 23 Sep 2019 14:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com>
In-Reply-To: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 14:35:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
Message-ID: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4 - retry
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 1:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Thank for the instruction. I think this is correct.

Looks fine, pulled.

That said, when I look closer:

> Jia-Ju Bai (1):
>       security: smack: Fix possible null-pointer dereferences in smack_socket_sock_rcv_skb()

This one seems wrong.

Not seriously so, but the quoting the logic from the commit:

    In smack_socket_sock_rcv_skb(), there is an if statement
    on line 3920 to check whether skb is NULL:

        if (skb && skb->secmark != 0)

    This check indicates skb can be NULL in some cases.

and the fact is, skb _cannot_ be NULL, because when you test the
security of receiving an skb, you by definition always have an skb.

There is one single place that calls security_sock_rcv_skb(), and it
very much has a real skb.

So instead of adding a _new_ test for skb being NULL, the old test for
a NULL skb should just have been removed. It really doesn't make any
sense to have a NULL skb in that path - if some memory allocation had
failed on the receive path, that just means that the receive is never
done, it doesn't mean that you'd test a NULL skb for security policy
violations.

Anyway, it's pulled, but I think somebody should have checked and
thought about the automated tool reports a bit more..

               Linus
