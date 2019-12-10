Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC8B20692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N63AOfqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLJC60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:58:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbfLJC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575946705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=y1+ILk6NlZH8+BA8bgtcvaDsBfBSSFplpwqpPup+kUk=;
        b=N63AOfqBS2upbxsiYfD7NU5HIUmDqGe5Yi3ZKUCoq1TqdOAo8uvcV4Qz9iL6XwBjTwqQUb
        BcB2kwJ8LdRKaG6ynLIBxdmOtIRFbqJYjkLqycpRn2xkFXNPe5m/oKCmygtEqyTtRmBvb4
        rf03Td56IQZJijN/K4KaXpHvdNbYS6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-XG8t8oC4PDWzKGC0WYll-w-1; Mon, 09 Dec 2019 21:58:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08227800D4C;
        Tue, 10 Dec 2019 02:58:20 +0000 (UTC)
Received: from greed.delorie.com (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A81960BE0;
        Tue, 10 Dec 2019 02:58:19 +0000 (UTC)
Received: from greed.delorie.com.redhat.com (localhost [127.0.0.1])
        by greed.delorie.com (8.14.7/8.14.7) with ESMTP id xBA2wF55008043;
        Mon, 9 Dec 2019 21:58:16 -0500
From:   DJ Delorie <dj@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     vincent.guittot@linaro.org, dsterba@suse.cz, dhowells@redhat.com,
        ebiggers@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
In-Reply-To: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com> (message from Linus Torvalds on Mon, 9 Dec 2019 09:48:27 -0800)
Date:   Mon, 09 Dec 2019 21:58:15 -0500
Message-ID: <xnsglsubso.fsf@greed.delorie.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XG8t8oC4PDWzKGC0WYll-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> [ Added DJ to the participants, since he seems to be the Fedora make
> maintainer - DJ, any chance that this absolutely horrid 'make' buf can
> be fixed in older versions too, not just rawhide? The bugfix is two
> and a half years old by now, and the bug looks real and very serious ]

I've got builds ready for F30 and F31 but my local testing shows no
difference in kernel build times with/without.  I was hoping someone
would test the rawhide build[*] and say "yup, that fixes it" in case
some other even older patch is also needed.

F29 just went EOL so I can't fix that one.

[*] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1420394

