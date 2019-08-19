Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D1120989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="DBiJNvZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSHG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:06:26 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:35154 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfHSHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:06:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A510527E06B6;
        Mon, 19 Aug 2019 09:06:24 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tin4bzQYQocK; Mon, 19 Aug 2019 09:06:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 315B627E0C50;
        Mon, 19 Aug 2019 09:06:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 315B627E0C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1566198384;
        bh=dRbE1G1rLC8d0xbZihvvSPfRukHmXOgB5B+WDmoRRFg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DBiJNvZpojEcci5vbx4InadAxSgnp38scHxWHSetHfn6tOMnNszlXx+6KVL1aEFFq
         +SO0Zhl1RYIXAvaBX1JyEcOXYcqx+ty0IA6RonvgtAccVhvdGc1/OAvy3KcFEtoLzX
         cwuoiWsM0QLqUdA1BxbS+YzRaS5wDOeSzzAHy8eU=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OBDtmaUaefpI; Mon, 19 Aug 2019 09:06:24 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 1555C27E06B6;
        Mon, 19 Aug 2019 09:06:24 +0200 (CEST)
Date:   Mon, 19 Aug 2019 09:06:23 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Message-ID: <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20190816131606.GA26191@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu> <20190816131606.GA26191@lst.de>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: allow 64-bit results in passthru commands
Thread-Index: SvpBEuMWC+bTcJ9PbNdGJh/muWTsoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:

> Sorry for not replying to the earlier version, and thanks for doing
> this work.
> 
> I wonder if instead of using our own structure we'd just use
> a full nvme SQE for the input and CQE for that output.  Even if we
> reserve a few fields that means we are ready for any newly used
> field (at least until the SQE/CQE sizes are expanded..).

We could do that, nvme_command and nvme_completion are already UAPI.
On the other hand that would mean not filling out certain fields like
command_id. Can do an approach like this.
> 
> On Fri, Aug 16, 2019 at 11:47:21AM +0200, Marta Rybczynska wrote:
>> It is not possible to get 64-bit results from the passthru commands,
>> what prevents from getting for the Capabilities (CAP) property value.
>> 
>> As a result, it is not possible to implement IOL's NVMe Conformance
>> test 4.3 Case 1 for Fabrics targets [1] (page 123).
> 
> Not that I'm not sure passing through fabrics commands is an all that
> good idea.  But we have pending NVMe TPs that use 64-bit result
> values as well, so this seems like a good idea in general.

I'm not sure how those tests could be implemented otherwise today.
The goal is to send an arbitrary command to the target and the passthru
command is AFAIK the only solution. If we have something better
I'm sure they will be ready to use it.

Regards,
Marta
