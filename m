Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C75C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6892075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="K4cmJ8+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDBTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:11:25 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:41671 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:11:25 -0400
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id B44261E80271;
        Tue,  2 Apr 2019 22:11:21 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hJLkrDDClS-BJU4Mjb7;
        Tue, 02 Apr 2019 22:11:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1554232281;
        bh=ujdYPjeV/k1ZxMLKlIqsUF9I3AeNKWX+BJCImrB51nY=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=K4cmJ8+FtC23oBXGjXYJouLDsm4nEfPnj+IoYBgQuS2+aLqI0UVdVQE9274xtQHPO
         tJffbZxdbE9Bm+SvFBl78GU2s7fVxFtuglDyhBqc5P+dwmBzBxtZZT8DVKvyCoXOlu
         rrcLYUL629dwyUGATiaUcAgo5JxMqYs9MGjO+29w=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-633109cb7707.qloud-c.yandex.net with HTTP;
        Tue, 02 Apr 2019 22:11:19 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <87zhpaox14.fsf@concordia.ellerman.id.au>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net> <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net> <87zhpaox14.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH 2/5] powerpc: module_[32|64].c: replace swap function with built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 02 Apr 2019 22:11:19 +0300
Message-Id: <673731554232279@sas1-633109cb7707.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.04.2019, 13:11, "Michael Ellerman" <mpe@ellerman.id.au>:
> This looks OK. It's a bit of a pity to replace the 8-byte-at-a-time copy
> with a byte-at-a-time copy, but I suspect it's insignificant compared to
> the overhead of calling the comparison and swap functions.
>
> And we could always add a generic 8-byte-at-a-time swap function if it's
> a bottleneck.

I am sorry, I forgot to quickly comment on your letter.
Now (after George Spelvin's patches) the generic swap is able
to use u64 or u32 if the alignment and size are divisible
by 4 or 8, so we lose nothing here.
