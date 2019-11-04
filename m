Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA9520659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="DwOKDmRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKDPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:16:17 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:54496 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:16:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C20EA27E03F9;
        Mon,  4 Nov 2019 16:16:15 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KfDxJ_klKXSE; Mon,  4 Nov 2019 16:16:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6640227E064D;
        Mon,  4 Nov 2019 16:16:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6640227E064D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572880575;
        bh=AjnnDpDaF7bW9PCgTtGxUhgirQ2AQU543GX7VWx8kp4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DwOKDmRs+wSBhUmzJSSKP2Mcz7b8xxO65LNQITeTMQdJmPkueWiQFGa/TxprqgUZu
         NEASZwXjQNq7+ck51KhFPhy+FNT6wyFmMYIqXG0tn7ZGMD+rdgs4zTzVDE483Z3kix
         6RSlf2eqpAuQMStLbOa2RFZtnPzDELA9v2aAvWsA=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IAkr1OWFfAie; Mon,  4 Nov 2019 16:16:15 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4DF6927E03F9;
        Mon,  4 Nov 2019 16:16:15 +0100 (CET)
Date:   Mon, 4 Nov 2019 16:16:15 +0100 (CET)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <266047531.90300507.1572880575232.JavaMail.zimbra@kalray.eu>
In-Reply-To: <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com>
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de> <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu> <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com> <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu> <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: change nvme_passthru_cmd64's result field.
Thread-Index: lwHoMaVJp4iAGDQQRMXUf/hZljBQaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 4 Nov, 2019, at 16:01, Charles Machalow csm10495@gmail.com wrote:

> Yes. The idea is just to change the 64 IOCTL structure so it lines up
> with the old ones so that the same struct can be used from userspace.
> Right now the first 32 of 64's result doesn't line up with the old
> result field.
> 
> - Charlie Scott Machalow

OK, then this will work on all architectures I know:

struct nvme_passthru_cmd64 {
        __u8	opcode;
	__u8	flags;
	__u16	rsvd1;
	__u32	nsid;
	__u32	cdw2;
	__u32	cdw3;
	__u64	metadata;
	__u64	addr;
	__u32	metadata_len;
	__u32	data_len;
	__u32	cdw10;
	__u32	cdw11;
	__u32	cdw12;
	__u32	cdw13;
	__u32	cdw14;
	__u32	cdw15;
	__u32	timeout_ms;
        __u32   rsvd2;
	__u64	result;
};

Marta
