Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B545AC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B4721848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn7NkKA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGQRGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:06:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:06:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so26625920eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqRiai2NJzbl478864ihbvO7mDzvRYyxi6L9Xd1nSoU=;
        b=cn7NkKA3TYW3chAN01hNTYlkhLMoS+Ytj/wl7TOUnm0KlG4EzrMhSN+wmKSYYDdlP2
         OHyF4Wscjc9VDQ4bhVgnlogOhmb46AXO6/20COw46KcwqlNjvWDLMyNquJyETvoUKeTn
         ebyvnnaUmuJaq4DzQjIhvShc0JDB152VD2JWWjJbwMg8V+dk7LIMLR/S0FW9KyzOy9nJ
         DDOpV4fpD13s56kSSfsuNzGf5K0CMm/l9FryY8bx3WlTuGNeb97xBTUdoPvpqZK9XP64
         YOEDAqynD0o1ohPufEjS6XeqNT1+njqoFnDgFsIG5n4z/Uv9Hr4D4r3y8OQ0L2YiD52A
         ORnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqRiai2NJzbl478864ihbvO7mDzvRYyxi6L9Xd1nSoU=;
        b=ZSz7g+5QZPLLXVfwOQ6Z9/aDbplb0OfA6vBZheaJigFPPXYhlI3s8KtSYQNelwlWhZ
         1AUJlfkKVfPiMUCy/s49IpGkArqAtOwr4TaQ6XMPFNSr0LmIMt85oMbM12UW4GiO2PC8
         3XtH9dMP4OZhqJJmIiqsbtbQeIYQvSBVCTAxifTJ8r7B3ZylfvV6usK33gMLFqshexY/
         HmpF6ZJAT6VqaLJpmDkGbE8DOzG7krwMda6HKaszE+7IStyxyzmhv31Y00JgX/IeN7YA
         D07yubaJ8LNo6G/cxa5a98Ud2SQztO+Ip+TOfoUYWXQdqI2Tgjfwa9EDek4+VJJa+cSK
         rhBA==
X-Gm-Message-State: APjAAAXoiBwQHhiSSJNSYaWLv3R5G6fm222zQOKBIhu4WeDorqEooCmb
        4qKxwFPRFrwR0UPf3kPJj25/YsR5HS/NpTUQ0OASjw==
X-Google-Smtp-Source: APXvYqyuPkk92abvhI53/TOM/mm3ikjhWvXpFz620iJmZad75QkfN5sxOkoYTqcfXhuFY7+wJL5g9tLZdEPlmUSUpgU=
X-Received: by 2002:a50:f4d8:: with SMTP id v24mr36359671edm.166.1563383170245;
 Wed, 17 Jul 2019 10:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
 <5D27FE26.1050002@intel.com> <CAOyeoRV5=6pR7=sFZ+gU68L4rORjRaYDLxQrZb1enaWO=d_zpA@mail.gmail.com>
 <5D2D8FB4.3020505@intel.com> <5580889b-e357-e7bc-88e6-d68c4a23dd64@redhat.com>
In-Reply-To: <5580889b-e357-e7bc-88e6-d68c4a23dd64@redhat.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Wed, 17 Jul 2019 10:05:58 -0700
Message-ID: <CAOyeoRUOqMmG6KkGXUMeK2gz8CmN=TiiuqhtVcM-kekPoHb4wA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's just implement the bitmap of fixed counters (it's okay to follow
> the same action as gp counters), and add it to struct
> kvm_pmu_event_filter.  While at it, we can add a bunch of padding u32s
> and a flags field that can come in handy later (it would fail the ioctl
> if nonzero).
>
> Wei, Eric, who's going to do it? :)

I'm happy to do it - I'll send out a v3.

Eric
