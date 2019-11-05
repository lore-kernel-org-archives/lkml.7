Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E3C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A93D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOCgUUXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfKEJs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:48:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730454AbfKEJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572947337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxcBTuOQXgV8IWG3xDCzQCJYjVAbNsGn9NLxV+2WyKQ=;
        b=TOCgUUXlZ6psnwlj8pwJ60GaakV1YbwKE0jtaeXAQPHnmYIkQ7K7tCu7LHxBUkQ1Uget0W
        obZYuwOKCDQQDUrv0zAsR1Aqpw+nQtZZ33W0uEO1xmnphmWGvc9lKnNlEWFvho0x1963np
        dvRCGTjRn27XMaHm8PG83ip9B7zfbso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Nr_8VIYqPUeKkUO1uvSAbg-1; Tue, 05 Nov 2019 04:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B661107ACC2;
        Tue,  5 Nov 2019 09:48:47 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-86.ams2.redhat.com [10.36.117.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4541600C6;
        Tue,  5 Nov 2019 09:48:41 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Shawn Landden <shawn@git.icu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking ABIs at the same time.
References: <20191104002909.25783-1-shawn@git.icu>
Date:   Tue, 05 Nov 2019 10:48:39 +0100
In-Reply-To: <20191104002909.25783-1-shawn@git.icu> (Shawn Landden's message
        of "Sun, 3 Nov 2019 16:29:09 -0800")
Message-ID: <87woceslfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Nr_8VIYqPUeKkUO1uvSAbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Shawn Landden:

> If this new ABI is used, then bit 1 of the *next pointer of the
> user-space robust_list indicates that the futex_offset2 value should
> be used in place of the existing futex_offset.

The futex interface currently has some races which can only be fixed by
API changes.  I'm concerned that we sacrifice the last bit for some
rather obscure feature.  What if we need that bit for fixing the
correctness issues?

Thanks,
Florian

