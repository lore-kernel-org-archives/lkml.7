Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACFC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1282177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEAKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:12:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45061 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEAKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:12:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id w12so3382931ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 03:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ioGPC5F7kySeobmuzWBh6iE9/oKQDUZgPGo93PVH0jQ=;
        b=AUHsovfr5E9Ks/GQG54Wm7EanQUxVmPzhuDZy6AK+Rsgyj9l82Km3ZTpZjEWG/sJnk
         tefCH9Dh7770eH2IiEj08peXDchXW8OYvM4LccnDZ65/hoyQd6gnP8W9F5Ds3nxRIGtw
         6/e/c6S8tu89BUvRZTyx5SsFoltQyf7N3Pfj4PtAqT7brYAOn/bj3AylazJWdiF1RnE7
         58G0qw7YQdWsn402vNlg/b6Q2UEm/+62vsgMlAAmxTEFCPoZFCiRz8BZsFzyJtYX5AWE
         MfRAmiFVGxQVZLa74CKi/tWbTo5QFLdYfm/n1aR8Dhb6Kahgbnv6kOzGRU+SnOsye2i7
         RoIw==
X-Gm-Message-State: APjAAAVZoQAK1dAwxVP5Xb5hW7nkBztKLJNmlEfPo1RwS6SQ5SADztYH
        uh+dvODlsaDwPYw6yXWS91h2wA==
X-Google-Smtp-Source: APXvYqzB5hQdBlAoZeR0itfmJnETBTWladOgJ+jZTG7V91oV82uNg5XMqc3KmWikaNDo0zoQ5XUosw==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr38849623ljl.7.1556705572672;
        Wed, 01 May 2019 03:12:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id z17sm7997581lja.26.2019.05.01.03.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 03:12:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 002071804A3; Tue, 30 Apr 2019 09:49:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>,
        johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: Re: [PATCH] mac80211: fix possible deadlock in TX path
In-Reply-To: <20190427204155.14211-1-erik.stromdahl@gmail.com>
References: <20190427204155.14211-1-erik.stromdahl@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Apr 2019 09:49:29 +0200
Message-ID: <87k1fcnd9y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

> This patch fixes a possible deadlock when updating the TX statistics
> (when calling into ieee80211_tx_stats()) from ieee80211_tx_dequeue().

So is this the fix for the issue with TX scheduling you reported
earlier? :)

-Toke
