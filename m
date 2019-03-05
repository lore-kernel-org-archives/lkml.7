Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A6F2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3xcaZd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfCEUsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:48:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33457 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfCEUsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:48:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so10978522wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qtWM3PyxYb8hekHksmJraQElkp12aeq/Jq00Qr3I7k=;
        b=Z3xcaZd0YXSoDBc9Mu30SL/MO5m1MOfTwFbi/UAb8FjDH45DOBT5g1PlB7+P1D/5oR
         wcdSXU9+5p4PzT+Xw9y5C5XNA7w2JSav1xzoGdZsqy2uh5CYJhEzeecU+lOH+jefHRyZ
         zMs7398TLkQKC+/DTbmG7GE/x/5U/aIpjB+LByGz0JAEYHtfpnUh7ifnWwzM6O6hVyM1
         aX3lpOprsf6jph4ezIo7ZPIFow8mpx28fHZzMqZHGcjwB4EElu8wNfYaS8JCGL6cB2Tf
         jO7bz6CmMIcOccrPD6dbYGXMVA4OsJf8QQqQdDr4WshzUWxggvrFiQZLjxmj5ZUeFm5r
         dNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qtWM3PyxYb8hekHksmJraQElkp12aeq/Jq00Qr3I7k=;
        b=uNE1+mVOYvzO5Nn/jEEHEHkbxvskpYFd/msdC5YDwqPArmuteXN6EgBX64lF4VlqFo
         E9zQjGSLjZW4+6GbDwyRQJ2Qu+A/1MLXrTu0IA+LYFezRT6Ktg2m+95VRno5UiXym41d
         E5qUUx3Abq2jm3Ll4QjOYmbqJ6Xl7njiCD6LLYLpdjFp+KeU+fjL0O1+LXyBbxitwxRs
         qB86b2aB1OJauoUcOxS2Te9NHR/WT48K69barCcHnn0ZLd+H1rqesU5lAiFeVVP+tiTu
         5iggyp7LKuNceWawwLkiLdzh++55h9r/WbhpVe8HkmYYeuKhfxA5usqgjc6sQcYhmjUv
         U7GQ==
X-Gm-Message-State: APjAAAWa+5lalrrponlS5xxOozwT1nh+tJNQF4ikZh9AfDwcX46Ao7Q5
        PgEbx6+iSdJyGYVvPKODzDqvsonkJAWOm7bapzK76A+o3g==
X-Google-Smtp-Source: APXvYqwXepBe7TkobAZWxRoAwVra+2L9qSZEX+7bDa1nsKQsnBdW/Q7wNVEiw91K0VrfV7GiuBgHObfWYyn37zawDhw=
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr570107wrn.130.1551818928517;
 Tue, 05 Mar 2019 12:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20181216190639.6safwjqwdphkce67@gmail.com> <20181216194649.GA7732@pure.paranoia.local>
 <20181216195343.idnt2y5y5wjky5gu@gmail.com> <20190104013522.stng6gwauwnr6wbi@starla>
In-Reply-To: <20190104013522.stng6gwauwnr6wbi@starla>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 5 Mar 2019 14:48:36 -0600
Message-ID: <CAErSpo5a2oO=5byEuA5AouS=kBmj7ihw2EVYAvJcdti29Tf1HQ@mail.gmail.com>
Subject: Re: [RFC] LKML Archive in Maildir Format
To:     Eric Wong <e@80x24.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jasper Spaans <j@jasper.es>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I understand how to clone archives from lore.kernel.org and how
to convert a git archive to a maildir (thanks, Konstantin!)

What I *don't* understand is how to effectively read this locally.
Ideally I'd like to run mutt, possibly with notmuch for indexing.  But
a maildir with 3M files seems impractical.  I did actually try it
(without notmuch), but it takes mutt about 5 minutes to start up.  And
the maildir is about 23G, compared with 7.5G for the git archive.

Any pointers?  I guess there's no mutt backend that can read a
public-inbox archive directly?
