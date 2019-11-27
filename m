Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C34C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379772053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZil/3o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK0LUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:20:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726194AbfK0LUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574853620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b1jwX0+kFyvJLoHZCjhoZfUDuQq3oSl9K34fOPDmtEs=;
        b=TZil/3o0gFVi2NnAg9QKWnYnBj/BlprqgaduqLXtfUUqc04Epfa8EHtWSTiHViHADGuIon
        /btjFx6+PNFvuMjI3evsKOPXYeXP2pEYFEwYe3sJTshFYmfizTo5H6LHN5Ffa/C2CoXGZb
        AXGNnzDHo0ZNWHmrNaatmexdGZlLaNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-E8e9PrJtO5K-UimWlnF5Lg-1; Wed, 27 Nov 2019 06:20:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE19DBA3;
        Wed, 27 Nov 2019 11:20:14 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 460D819486;
        Wed, 27 Nov 2019 11:20:13 +0000 (UTC)
Date:   Wed, 27 Nov 2019 12:20:11 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Unreliable 11-minute RTC sync
Message-ID: <20191127112011.GT2634@localhost>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: E8e9PrJtO5K-UimWlnF5Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system clock is synchronized (i.e. the STA_UNSYNC flag is
cleared by NTP/PTP), the kernel is expected to copy the system time to
the RTC every 11 minutes.

There are reports that it doesn't work. I checked some of my machines
and indeed some have their RTC off by more than a second. IIRC this
worked better few years ago.

In order for the RTC to be set precisely the update needs to happen at
some fraction of the second (e.g. 0.5s on x86_64). Originally, the RTC
was set only if it the update was scheduled correctly to one jiffie.
Later this requirement was relaxed to 5 jiffies. It seems with current
kernels that rarely happens. The update seems to be consistently late
by tens of milliseconds, sometimes by hundreds of milliseconds. This
repeats every second until an update is on time with some luck.
Apparently, this may take days or longer.

I'm not sure if workqueues changed how they behave, or they now have
more work to do, preventing the RTC update to be on time. I tried
switching to the non-power-efficient wq and also the high priority wq.
The former worked best in my tests, taking about 5 attempts on average
to make an update. I suspect that may be specific to this machine and
workload.

I'm not sure what would be the best fix.

Some ideas:
- relax the requirements on accuracy even more (e.g. 0.1 second)
- limit the number of retries (e.g. to 5) and force the update on the
  last one, no matter how inaccurate it is
- measure the scheduling delay and try to compensate for it
- randomize the requested delay
- switch to timer

Suggestions?

--=20
Miroslav Lichvar

