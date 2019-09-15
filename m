Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C73C2BA1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9382077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5aA3r6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfIOWA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:00:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54607 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:00:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so7932775wmp.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQdTRLfDQUCYZ+ePsNsrBtHX9iXkkifpvhZzWmMPBiI=;
        b=G5aA3r6TGufs7D9PUrvFhJV77rAX2+dF3xkNzIvlCB8lcuhcCRxFrl8IiCsz5+pCqR
         iGIs76v3Opqsb+jWi23TZVohDPeIxd7DZvJtF0mo/VpQ+PpFdYdsrM69qOaKK15naVBP
         7tKHqHsjSZJEegoIElIXGx71lJpP7YlugQpshwV7RJpUzqdgNQWIgSXotexOWJpwtB/3
         ZFBZ6IpjBj+j/E7IztCJSFI7U1o7aaGMT1nUp7ERh4b7AOWSHqpesjH1GzTvIUYFp91O
         jxeVhPDa75ck8OBZ76QIbjnN5EYf5tdddikeEFumaQifoVFW9NwwRnjxV8/8o/KihONO
         sHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQdTRLfDQUCYZ+ePsNsrBtHX9iXkkifpvhZzWmMPBiI=;
        b=mziA6XPCungoYdIDilq9BcRZbOPcIdRAJrPVdxHGM1IQeEO0SgmIkXS2nodkOBQ34s
         pwqcG/dcn4t+RT6AH9JvfqNoMRMjvecs1Qch7U0SW6I1qdes8Ztbb0QsNeDQUzISRlcL
         qVjJweYbPW0c7EPH8AL9zq61lWpcqQ4yqYn+sURlrwKzL0PNM1wRx3LE605gf1R9o0nU
         8b1L+XLee1tya7gHV8mcNLMZzgdQB1I/ynwGg6ufSjv7Z8bapeb+n9SuvNFGJWEBkCRD
         xgOoCFCVp9rmO5Hbbna+ie5cCEA3g+qmTERZKpdFRt2M7YiRckK6n0eA/K/3V2sdy8X+
         NnMw==
X-Gm-Message-State: APjAAAUvXZTIlivYCIG6zNbuyPo0nuNuECWwp+xDVLXgERX7dFZ2nrPx
        Cyqi8QfAfADYaawPdMrJdZ5FcyOOG+tV8LECLh4=
X-Google-Smtp-Source: APXvYqwM766NmGaQH6bvzzDdlCLOpreegzZP3+wcsPCJHvkAQrHROSzA4YV1Zoh3R6XagU3E9yYZ0Mtq7L5TdR0mGVU=
X-Received: by 2002:a1c:be02:: with SMTP id o2mr10910147wmf.109.1568584822928;
 Sun, 15 Sep 2019 15:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvxEAGtQDFm4G3orY+M9yuthDA4j0+u=HbE9DKuo7H8WCg@mail.gmail.com>
 <0B80F9D4116B2F4484E7279D5A66984F7A7472@dggemi524-mbx.china.huawei.com>
 <CAFLxGvz__aw+BnfmGS3XXGqT6n6q-9miLPoVcL9KuvaZ2QbVUQ@mail.gmail.com> <0B80F9D4116B2F4484E7279D5A66984F7C0325@dggemi524-mbx.china.huawei.com>
In-Reply-To: <0B80F9D4116B2F4484E7279D5A66984F7C0325@dggemi524-mbx.china.huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 16 Sep 2019 00:00:10 +0200
Message-ID: <CAFLxGvwpYHKi_nf0-uVWWpzG5Yv-hXgOD=9zHmmHHn+Fv+PJDA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps
To:     chengzhihao <chengzhihao1@huawei.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:01 AM chengzhihao <chengzhihao1@huawei.com> wrote:
>
> >  ubifs_assert(c, p < c->gap_lebs + c->lst.idx_lebs);
>
> I've done 50 problem reproduces on different flash devices and made sure that the assertion was not triggered. See record.txt for details.

Thanks for letting me know. :)
I need to give this another thought, then we can apply it for -rc2.
