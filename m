Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A6620896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408545AbfFLC44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:56:56 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:32942 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406516AbfFLC4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:56:55 -0400
Received: by mail-qk1-f170.google.com with SMTP id r6so9091509qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Qi48oLh9iihq2LkIgrDslGg/Vx8JGXFp2UzVtaaTY=;
        b=GrS5VQHHEPqZSj0SSqWX+li2jU9LgQ/XmJrzBwJgBXd308sYmDYSLhN7BlIJ+pWUt6
         1LijH6Xf62AENQPgWYxgqRvsEz3CKDdvi3ko+tiKHYmMjwnjXiQEDJRnNIFCHL0cm1WW
         F8aADtDa8UDYiT88ZkkXLiy9HqrXbIYDTgzXI0vsl70VbFNVHMPKVf4EDDDoK8lmYEuN
         MJ2zngmTA9m2bh5osbmY/MObMZeqsgbZTsxFd7GtgRJAtqpE2x7NPFElscOL48Thkleu
         NTXmi3Jj7IbFMWb+LvihMeP1BQvezJ5xEENmTeqBJ6jI1ZwaHs6aeL6O0M1VjkciZn8k
         /fsQ==
X-Gm-Message-State: APjAAAXaCrtQCnQd/iAXZ8noGhu6pBJg3yH03uIJTdBr3fMXfVdZsOeA
        GJOdv0jcBaYw/rR8+Hm5zjWJRGnnly/DtBUOOQfdqQ==
X-Google-Smtp-Source: APXvYqxctTUcbUUwKEwCDb+kAVsNlcPeMauTITiiVl5q4wHU5Gq3T5KxTJd5OAfYva1ulpddSUg3/ykgbXPYx9uR294=
X-Received: by 2002:a37:6708:: with SMTP id b8mr61258505qkc.141.1560308214695;
 Tue, 11 Jun 2019 19:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk> <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
 <20190223024402.GA12407@redhat.com> <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
In-Reply-To: <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Tue, 11 Jun 2019 22:56:42 -0400
Message-ID: <CAMeeMh-6KMLgriX_7KT52ynjBMyT9yDWSMKv6YXW+yDpvv0=wA@mail.gmail.com>
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having studied the code in question more thoroughly, my first email's
scenario can't occur, I believe. bio_put() contains a
atomic_dec_and_test(), which (according to
Documentation/atomic_t.txt), having a return value, are fully ordered
and therefore impose a general memory barrier. A general memory
barrier means that no value set before bio_put() may be observed
afterwards, if I accurately understand
Documentation/memory_barriers.txt. Thus, the scenario I imagined, with
a load from inside __bio_chain_endio() being visible in bi_end_io(),
cannot occur.

However, the second email's scenario, of a compiler making two stores
out of a conditional store, is still accurate according to my
understanding. I continue to believe setting parent->bi_status needs
to be a WRITE_ONCE() and any reading of parent->bi_status before
bio_put() needs to be at least a READ_ONCE(). The last thing in that
email is wrong for the same reason that the first email couldn't
happen: the bio_put() general barrier means later accesses to the
field from a single thread will freshly read the field and thereby not
get an incorrectly cached value.

As a concrete proposal, I believe either of the following work and fix
the race NeilB described, as well as the compiler (or CPU) race I
described:

 -     if (!parent->bi_status)
 -               parent->bi_status = bio->bi_status;
 +     if (bio->bi_status)
 +               WRITE_ONCE(parent->bi_status, bio->bi_status);

--or--

 -     if (!parent->bi_status)
 -               parent->bi_status = bio->bi_status;
 +     if (!READ_ONCE(parent->bi_status) && bio->bi_status)
 +               WRITE_ONCE(parent->bi_status, bio->bi_status);

I believe the second of these might, but is not guaranteed to,
preserve the first error observed in a child; I believe if you want to
definitely save the first error you need an atomic.
