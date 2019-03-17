Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C3CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027CE21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc9lTn+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfCQHuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:50:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 03:50:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so1500713ljg.6;
        Sun, 17 Mar 2019 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDOiwiwlp9KhcUMPlM9DJKZIn1ynUXVMY87DRA++bjg=;
        b=hc9lTn+REaM0FmzDQiB7Dk4vt3ZbORcN+9o3ywi5pFtO3iQjjd9o3DvMKFxGtUSVmR
         mdYXWXXYXLNYYFFjKedV+BYFUsjYwsIMJapHoj7PBXjSwEX8Q5mWPXkxaIaiFeuwDS19
         ik4eZePzLsL1CD/GAtSaNa4WpIaC92sZWraenKjiUkCGK6UXvk3GBBl62FKm0O1n4Bwl
         AT5nCDpexNYkoSfGeyx7lP4hW3WuG20e5B5lrOBavhj57gIEyZYnn9MdPciaQAY4i3AW
         qoSdjMdm44WQceFkfRmHC8GTT6NzZ/w4OWmkQSGTI8ECfKD9tyJr07h0v4LEu+Fhihhv
         q6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDOiwiwlp9KhcUMPlM9DJKZIn1ynUXVMY87DRA++bjg=;
        b=Bne3mREDXit2/S2wYfSMA/LCJKzqm9rydV3lTl3aFmCPYajWr63NCd7KeVWY5674x+
         FsM0KxIwKp8lCdUhVNc0k1mjv6lGhWWr8eFycKLyglljA0bKEnTL27tzdYMNbaQWhONN
         ImyVwWBfqbU80oXlL+KxFdMT9WO0uzcvesG874TcA2zyJg4iK9c0N7imX3m6VGGd8FId
         ZACMidcu2NeDSfeH2Yf3KmvC3f354K/0v6Hkw291dTkoh9xNZ6Rgya1nbtXHRRcfqIoq
         bqRWfMyJGZn39Aq9J0BkiG2CxKXEONaBUrBHHZLgCbnP1r3vNtQSUNx5Av2S/53lb8Df
         YqVA==
X-Gm-Message-State: APjAAAWZPAtPV6NZujOkhbxv8G2Avqi/ZxqmBYcSMSOm2y3BjB4bgKeA
        hjyqdXjQ7i3OXY72uY1MJ02gF5CqXAbm8SLkGhsuCmlI
X-Google-Smtp-Source: APXvYqyg8zjYvDAgI+dn07Skq7qBwW7UaY6Ai7b8pc/SFfouI74sXbT7iqkCyP4HCThL5Q1ptbrEloW+7iOH6rm7n2o=
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr7144396ljb.182.1552809022131;
 Sun, 17 Mar 2019 00:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <155253979234.5022.1840929790507376038.stgit@noble.brown> <155253992833.5022.6459847129731180970.stgit@noble.brown>
In-Reply-To: <155253992833.5022.6459847129731180970.stgit@noble.brown>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 17 Mar 2019 08:50:11 +0100
Message-ID: <CANiq72ncNHCrE+YRePDCPGgKoKYCSL0mwJXP0jBjYP6W4CVSKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rhashtable: rename rht_for_each*continue as *from.
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Network Development <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:10 AM NeilBrown <neilb@suse.com> wrote:
>
> The pattern set by list.h is that for_each..continue()
> iterators start at the next entry after the given one,
> while for_each..from() iterators start at the given
> entry.
>
> The rht_for_each*continue() iterators are documented as though the
> start at the 'next' entry, but actually start at the given entry,
> and they are used expecting that behaviour.
> So fix the documentation and change the names to *from for consistency
> with list.h

Thank you for taking care of the .clang-format changes!

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
