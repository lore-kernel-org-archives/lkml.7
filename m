Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9006C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1920731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czrQ/W3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFNe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:34:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34474 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgAFNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578317667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Dkkujyfe/gezec8u0wxy79DdORx+9S3fm+dMwU0Eyc=;
        b=czrQ/W3Qg6A+M+4fflyh18n8Dtsai8RfrUAuQdiDS1TQpn6TpqQCm5JYCbjkKC2D/QjYnR
        0vrulv6BggK0T340kmevRMSeF2hrsqUnk0bSqM1OqPepRZLxupcq8Qd2D36yFKLN2LHSf8
        8dNeJeAZcYrsiBce4tOVTqrP74r9uK8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-6B7EebG_OYWyI2HqRcZnvw-1; Mon, 06 Jan 2020 08:34:25 -0500
X-MC-Unique: 6B7EebG_OYWyI2HqRcZnvw-1
Received: by mail-wm1-f70.google.com with SMTP id s25so1356882wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 05:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+Dkkujyfe/gezec8u0wxy79DdORx+9S3fm+dMwU0Eyc=;
        b=p1HvpXN80qGmSmqjqvJat2oGm378/eBbcVDsPIdTT25yPXU6VjDDOibZsHTiYEmLrb
         6pBnMPHoWvLi34lQI0D9FV7B2vIowQ5ffv//orN9Ps0YvlhkJbwMOyzCi22x9glrQVKO
         JqOJBtoYUwGmuVAAytKaXI34F9BURp4kOfOwzul08mBgNgyn3n7u9X6HLtQeitB+SunS
         3kGRhBJrbQHRDzpFvx02QeavZ4luEsjuN7UGo5BmwfGylCh+EER5dDKWw09LoCWARj2d
         Hu8iTv76TD+j8+k5b4OOMglWz+w00yyG12oTV5Qfu9gRX32DkFN/swjYbyX54dJtBrmm
         FToQ==
X-Gm-Message-State: APjAAAUH9zchQtKyCLcTio0012g8+nkuIMiBQQuZIZnE4EdXFDvLJ3Jx
        HRxioD51icX/FhSG9cOjaPrFnrwQhge763cdbmwxYvd/UVA9poCFeC5lqIE98s9ZEqtWWpxflLJ
        vMAMfGePNZ3AQ4OzVOfHVHJJt
X-Received: by 2002:adf:f508:: with SMTP id q8mr27908550wro.334.1578317663890;
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm40NiLw1TYjidTWCotGayLqivBaOTg5hEb2NN8tw0Sw35bt3Zm76Owu+8ubw6JUQgXScAiA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr27908539wro.334.1578317663728;
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q68sm24387041wme.14.2020.01.06.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A0E54180ADA; Mon,  6 Jan 2020 14:34:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, Justin Capella <justincapella@gmail.com>
Cc:     Stephen Oberholtzer <stevie@qrpff.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Wireless networking goes down on Acer C720P Chromebook (bisected)
In-Reply-To: <CA+iem5uPaYmZr=+kdHopm1Yo9dgyL98k7KfV6uYx_yH22FSGag@mail.gmail.com>
References: <CAD_xR9eDL+9jzjYxPXJjS7U58ypCPWHYzrk0C3_vt-w26FZeAQ@mail.gmail.com> <1762437703fd150bb535ee488c78c830f107a531.camel@sipsolutions.net> <CAD_xR9eh=CAYeQZ3Vp9Yj9h3ifMu2exy0ihaXyE+736tJrPVLA@mail.gmail.com> <CAMrEMU-QF8HCTMFhzHd0w2f132iA4GLUXHmBPGnuetPqkz=U7A@mail.gmail.com> <CA+iem5uPaYmZr=+kdHopm1Yo9dgyL98k7KfV6uYx_yH22FSGag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 14:34:22 +0100
Message-ID: <87tv58k8td.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> I ran a ping, and saw this:
>>
>> - pings coming back in <5ms
>> - re-enable AQL (echo 7 | tee airtime_flags)
>> - pings stop coming back immediately
>> - some seconds later, disable AQL again (echo 3 | tee airtime_flags)
>> - immediate *flood* of ping replies registered, with times 16000ms,
>> 15000ms, 14000ms, .. down to 1000ms, 15ms, then stabilizing sub-5ms
>> - According to the icmp_seq values, all 28 requests were replied to,
>> and their replies were delivered in-order
>>
>> This certainly looks like a missing TX queue restart to me?
> I don't think TX queue restart is "missing", the TX queue should get
> restarted when the pending frames is completed and returned to the
> host driver. However, It looks like there is some issue with the
> deficit refill logic in ath9k, and the TX queue got blocked due to the
> negative deficit.

s/deficit refill/packet freeing/. I.e., there's an issue with the ath9k
driver either stomping on the tx_time_est field in the cb, or it's not
reporting back all freed TX skbs properly, so the AQL Q depth doesn't go
back down.

The large negative deficit is just because the queue is being blocked by
AQL, so it won't get its deficit refilled (and it keeps decreasing as RX
packets are being accounted).

All this being said, given the fact that ath9k definitely doesn't need
AQL, I think it's probably not worth it to try to find out exactly what
is causing this, and instead just leave AQL off for that driver?

(As an aside, this definitely disproves my initial "AQL should be benign
for drivers that don't need it" hypothesis. Guess that was way too
optimistic anyway ;))

-Toke

