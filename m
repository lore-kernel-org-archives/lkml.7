Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1C8C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FEA2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mYKuKkPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfKGMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:10:04 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:46877 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:10:04 -0500
Received: by mail-qt1-f178.google.com with SMTP id u22so2060578qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Px7jq47PN+NJZUF/iCpERAU4GBJVfXI5Sh0d+Nt7yk0=;
        b=mYKuKkPxlw+8K6SZEI6m90GVQ5dY5CC8Lwbykz6wr71RGqkG+CGZzUzmFcHAGCkVTp
         PG91yfDmpaqahlBS/FSh5JjS4HgbElm8+fXIdqUjX20E2yf27bBd727ejQcumWIED0W+
         Z+59uW8ivndPgbUb+qhRgAL4Y7Y4yRTwevqXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Px7jq47PN+NJZUF/iCpERAU4GBJVfXI5Sh0d+Nt7yk0=;
        b=DTt2SDg+okoTw/kbsYGM+nfovkIrSt94rUB2KeM8wkicyyQW1+3ACSkDDl4WIB0MAP
         VQfNkK1CenoAd3fKKI9Xg+sdxPgfvQU170DxA7NHSaZ1iswTJhMic3KBVyaORDK8+h7B
         15MddvIPn+AP0cCeU2sI1saxLwXYuLdJzcjPlQQ2PKttDuGOJQcxKxe6Zb4u18n7ycyr
         Gt0C5km5qXXMG8FvCYZluG7SUuqkWavBnaP3cd42LBAYupRpcuv3y0q4e1RDHtIo6Fw4
         Sdwi11ohD6rgOEjIgqgAE8yD19NotPM3E/DcIUf2biHkSnej2wQnZewfcgpLnjjp7+Ru
         MAig==
X-Gm-Message-State: APjAAAUVWvU7VEwZ9YDxeyQs4AQwbf9adYxn1YtmoJMosaKnbk/60dw5
        Jc8Rz3mQmntwebYAHS1JndUlXs2Xazt5BeP/px8=
X-Google-Smtp-Source: APXvYqzs/HG3kvnxQI4L8X/ckfHSXT8QDn4FOfi9LVxTV/al+SBfam1Jehks6q2i6hpXJnjxLODTxfNs/hPZB2aojOo=
X-Received: by 2002:aed:3baf:: with SMTP id r44mr3354784qte.255.1573128602505;
 Thu, 07 Nov 2019 04:10:02 -0800 (PST)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 7 Nov 2019 12:09:50 +0000
Message-ID: <CACPK8XdtyQhK6OHJKbP=Fk50jRQQZeWzxqKDbX6kW0S5=eGuTg@mail.gmail.com>
Subject: [GIT PULL] fsi changes for 5.5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a set of changes I'd like merged for 5.5. They've been well
tested in the openbmc tree over the past month or so as we've done
hardware bring up using them. Aside from the three fixes I applied
today they have seen time in linux-next too.

This is the first time I've sent you a pull request, so please let me
know if you'd prefer it done differently.

The following changes since commit 755b0ef68f1802c786d0a53647145a5a7e46052a:

  fsi: aspeed: Clean up defines and documentation (2019-11-07 22:24:18 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-5.5

for you to fetch changes up to 755b0ef68f1802c786d0a53647145a5a7e46052a:

  fsi: aspeed: Clean up defines and documentation (2019-11-07 22:24:18 +1030)

----------------------------------------------------------------
FSI changes for 5.5

 - New FSI master driver for the AST2600 BMC

 - Add class for FSI masters to provide a consistent sysfs layout
 across master implementations

 - Fixes and cleanups

----------------------------------------------------------------
