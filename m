Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635EB20835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZnPIsS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCQQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:42:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43539 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCQQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:42:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id m35so11519919ede.10;
        Sun, 17 Mar 2019 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dYGdMlG4O2mhPCAnYB8e8EqGThCWRzCuWaRCE6jzm0=;
        b=KZnPIsS1ut2NlNpxxptuAFW6IAyIv1fRqZOpPoflpVBT9co5iIODo7DRT2Pw6K74iB
         luTlq7ntFIXj9+hg+MIKpSjb2ZwsZOvCyf5ayA8I0yOqciUGau7cOdXJwJHWchMAKjMJ
         6LmkCmrFH0rvUqZmMTxOL322mtrGfvSNpPYoIE3shMCVuVWPE1x6KULQ+5ea5V7g3NL0
         xcWPOU4aXCd0WX5/AQ7ALgrD9wv0UHBtKDmOnhnPnygNGLy3KCACHbenx1uDi1AUv7RH
         Sp2ZBAXXW6IGbibuGFAmjJkwqf/eTSiMCv8bEkU7qLa80NbmFMCG0lPXgJ0xzC5HfSI9
         F8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dYGdMlG4O2mhPCAnYB8e8EqGThCWRzCuWaRCE6jzm0=;
        b=FcOs4NY36uLEQxyR5pt1qy6TGfNqJBjNw58lv2WMIyZ1G8VAkf3BC7jHSsgJMfuq7Y
         +Dexe8f28Iz57ASHfpEReDkpCrgIj72tKHrP36m7baiTeWMNNpl+zIGKQ4J6oe6g3UWu
         y8dN9NaJT/97ySR7NW1BkPG0YEQNYyJhkcIlF3puRBKWoYaNEVHY4saUja+Y+MC/Kj+j
         4mxg1BElzd+Sy1sO3AbIpLTMoB/RgO+XMx71XW1avbbhbODIKGWp2WrBjbY35Zd26lA3
         4GRayanqYCveFR+tqR1hIEsT4Q9+Y2K6rUpfA6m9qYN5aME0+wQwcIJoB/rI7EYoLawx
         85Uw==
X-Gm-Message-State: APjAAAWRMwN9qpuPSeO8EGLrwzCRX08gp0Tu9j16pnIJ4zg4wYZgLn8y
        5v3uAPJA3jxvHY62P8FQG2UNhWDd5bRTJMUGULc=
X-Google-Smtp-Source: APXvYqz1GlNK9uZ/42382S/PCxG5B9H820dQ6r3R5YncubZTM/ctI49xF1tBTpYkaU3RerKg+dCbH4CQ2REJFO5vzS4=
X-Received: by 2002:a17:906:1dd7:: with SMTP id v23mr8302511ejh.164.1552840957281;
 Sun, 17 Mar 2019 09:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190316134130.28065-1-maxime.chevallier@bootlin.com>
 <CAF=yD-K1imzDHm2K8bvrtYu5j-MNrN_4xH2h2je6ornuqmi_QA@mail.gmail.com> <20190316.182119.1641693988840475497.davem@davemloft.net>
In-Reply-To: <20190316.182119.1641693988840475497.davem@davemloft.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 17 Mar 2019 12:42:01 -0400
Message-ID: <CAF=yD-LAE+mfs0vkSqmmiCxm9RQNkFBCkjDFN7ScRtfw1kGjtg@mail.gmail.com>
Subject: Re: [PATCH net] packets: Always register packet sk in the same order
To:     David Miller <davem@davemloft.net>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 9:21 PM David Miller <davem@davemloft.net> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Sat, 16 Mar 2019 14:09:33 -0400
>
> > Note that another consequence of this patch is that insertion on
> > packet create is now O(N) with the number of active packet sockets,
> > due to sklist being an hlist.
>
> Exploitable...

With root in userns? The running time is limited by open file rlimit.
This pattern is already used in a sk_add_node_rcu in some way, so
important to be sure.

In practice I see no significant wall clock time difference when
inserting to a fairly standard default limit of 16K. Regardless of
insertion order, running time is dominated by cleanup on process exit
(synchronize_net barriers?). At higher rlimit it does become
problematic.

The packet socket sklist is not easily converted from hlist to a
regular list, due to the use of seq_hlist_next_rcu in packet_seq_ops.
There is no equivalent seq_list_next_rcu. One option might be instead
to leave insertion order as is, but traverse the list in reverse in
packet_notifier on NETDEV_DOWN. That would require an
sk_for_each_reverse_rcu and hlist_for_each_entry_reverse_rcu. These do
not exist, but since an hlist_pprev_rcu does exist, it is probably
feasible. Though not a trivial change.

Another more narrow option may be to work around the ordering in
fanout itself, e.g., record in the socket the initially assigned
location in the fanout array and try to reclaim this spot on
re-insertion.
