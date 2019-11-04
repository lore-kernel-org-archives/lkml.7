Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE23CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B094A21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="NO/Bwf7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfKDO47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:56:59 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:43646 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:56:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 8424D27E03F9;
        Mon,  4 Nov 2019 15:56:57 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FBasB0e2P1LE; Mon,  4 Nov 2019 15:56:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 439EB27E064D;
        Mon,  4 Nov 2019 15:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 439EB27E064D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572879417;
        bh=zTdMY1D+/EaaQogl6Eug21gFV2VVh60wfcDGJ5Yqj6I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NO/Bwf7WEpyIAZilQE02nBufJrADGZiT/7YdlYFMmu3EHF6L6sJ0bULUkOBew1RcW
         VvDG0HOgOlJuX9609IV+kdtwM7JVOnp06GmNCYEcrmGJzbtjOg610l3p6QrcPlTJMy
         cE0rqYZJ2BMS0Bzz/JI0UgPfArZVTqpdBk16k5o4=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O9ucltNPY_jE; Mon,  4 Nov 2019 15:56:57 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 2B9B227E03F9;
        Mon,  4 Nov 2019 15:56:57 +0100 (CET)
Date:   Mon, 4 Nov 2019 15:56:57 +0100 (CET)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
In-Reply-To: <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de> <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu> <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: change nvme_passthru_cmd64's result field.
Thread-Index: NUQ6qFaX8J30rCk1l2+etdD7aEChkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 4 Nov, 2019, at 15:51, Charles Machalow csm10495@gmail.com wrote:

> For this one yes, UAPI size changes. Though I believe this IOCTL
> hasn't been in a released Kernel yet (just RC). Technically it may be
> changeable as a fix until the next Kernel is released. I do think its
> a useful enough
> change to warrant a late fix.

The old one is in UAPI for years. The new one is not yet, right. I'm OK
to change the new structure. To have compatibility you would have to use
the new structure (at least its size) in the user space code. This is
what you'd liek to do?

Marta
