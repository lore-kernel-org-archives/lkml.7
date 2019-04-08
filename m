Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC6C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B069520818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqXoDnxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDHOf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:35:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39554 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDHOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:35:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id z9so1122201lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vJJdncPS/fbDD3g3BxkMZoOWsWQ0Y/n0jjwJo4sSka4=;
        b=BqXoDnxMeqtJ4JEPGdLqFfB4KXY0b38QBQFBWbCHW3RTGT9NxY8FqJXk5YLiupZKBw
         UUs+pf2wrCs8K43/q9J/tpJtXF/pZUlVuv6LkKiG4WY2+UZak5oHEHmnNImssOdCCx4o
         GQPrg/08TAMUdcFqkbjUxHT/zUVDXmikQ57bcZuOax/vRVfqZhAw+48OacX8EiLnayPN
         u9QrfZDRdY7rO/omd90f21n6nYJ1hOrvNqGu+N2ony/S6Fe28sntZ+0KHeFDuxwPbEKY
         Yhhln56jrKnGqxD20WPFwTF2hmwxnAkByQlvgpFqb+MMio++Owon2BPJFKqyEx5a7mKX
         hR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vJJdncPS/fbDD3g3BxkMZoOWsWQ0Y/n0jjwJo4sSka4=;
        b=ckCDEPRM7QdpCxwqLjyLF5TBn6AfsxMzolINKHmJCJCFyKy7H3b3/QmkY+vWxwZp8G
         w/xvOvziADRN+gSHTYR9FxkscbRYgj6KGFxprCY/T4i2UX4xV1n7f3vEf9gzT583YcJN
         TtLz4B2Uu4eQ0FAdfXd0ZAjA74B6GaV0eYueZ3RoLlq8PaY46i5fRh+jwjhOutm0/a/U
         9Wxtwz9QubpQE/KsPbghPqB5gYIOBgGa4mjr+CmTedWOxmBvSTIbkktyfmv3WF55n70L
         cRniCvBgX30bF9I7M0RYBTkLvTDkc6bicLF09JvGUoutUnaNDKuqMaE0lR7LH9vCw4Uq
         dd9A==
X-Gm-Message-State: APjAAAVOhEALTksTWrziwn7sJRYPqmewJHT115AMXfR36f9B8ECDJBkx
        u45c15DyQdvebv8sy+alJ28ztrUrljw=
X-Google-Smtp-Source: APXvYqxRK9FEMnNsxQnQkJE279IHQHK6uywmuZMynkoK0hOwqUSKAZMXbz6tqKrKz9fro3ZRRo/+5A==
X-Received: by 2002:ac2:561c:: with SMTP id v28mr3872799lfd.125.1554734156131;
        Mon, 08 Apr 2019 07:35:56 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id c17sm1389028lfj.58.2019.04.08.07.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:35:55 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C066A46090D; Mon,  8 Apr 2019 17:35:54 +0300 (MSK)
Date:   Mon, 8 Apr 2019 17:35:54 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: [PATCH -next] prctl: Fix false positive in validate_prctl_map
Message-ID: <20190408143554.GY1421@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While validating new map we require the @start_data to be strictly less
than @end_data, which is fine for regular applications (this is why this
nit didn't trigger for that long). These members are set from executable
loaders such as elf halders, still it is pretty valid to have a loadable
data section with zero size in file, in such case the start_data is equal
to end_data once kernel loader finishes.

In result when we'are trying to restore such program the procedure fails
and kernel returns -EINVAL. From the image dump of a program:

 | "mm_start_code": "0x400000",
 | "mm_end_code": "0x8f5fb4",
 | "mm_start_data": "0xf1bfb0",
 | "mm_end_data": "0xf1bfb0",

Thus we need to change validate_prctl_map from strictly less to less or
equal operator use.

Fixes: f606b77f1a9e362451aca8f81d8f36a3a112139e
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Andrey Vagin <avagin@gmail.com>
CC: Dmitry Safonov <0x7f454c46@gmail.com>
CC: Pavel Emelyanov <xemul@virtuozzo.com>
CC: Andrew Morton <akpm@linuxfoundation.org>
---
I don't consider this issue as a critical one, since it triggered first
time for in more than 4 years period (and report came from a proprietary
program).

 kernel/sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next.git/kernel/sys.c
===================================================================
--- linux-next.git.orig/kernel/sys.c
+++ linux-next.git/kernel/sys.c
@@ -1924,7 +1924,7 @@ static int validate_prctl_map(struct prc
 	((unsigned long)prctl_map->__m1 __op				\
 	 (unsigned long)prctl_map->__m2) ? 0 : -EINVAL
 	error  = __prctl_check_order(start_code, <, end_code);
-	error |= __prctl_check_order(start_data, <, end_data);
+	error |= __prctl_check_order(start_data,<=, end_data);
 	error |= __prctl_check_order(start_brk, <=, brk);
 	error |= __prctl_check_order(arg_start, <=, arg_end);
 	error |= __prctl_check_order(env_start, <=, env_end);
