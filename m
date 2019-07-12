Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F17C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917442080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="AkbziRsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfGLNIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:08:19 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:36436 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGLNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:08:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 101892960D3C;
        Fri, 12 Jul 2019 15:08:17 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HTSI3eohb4Bk; Fri, 12 Jul 2019 15:08:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D54442960D6D;
        Fri, 12 Jul 2019 15:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D54442960D6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1562936895;
        bh=yyCslXZGpu39EYnls+rZ8yM854MaPIDJPEXwDlJvY2w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AkbziRsr+Z4AWrLAiKk4QzbBivKncLt6+slmERVtKJipGa18QIKSj5JoinD0gC4g6
         Dfl+TNRWxEvNhBcq63HAwAdLToYTMKO47XzzSNhdnPBmyB9qI8kveFyQysMBy6P7Nt
         ZAS+6lT5/8lrcp9QQO2KdPwNqzSUlNlORllunxlQ=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FhP-mWq7ry6s; Fri, 12 Jul 2019 15:08:15 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B9E302960D32;
        Fri, 12 Jul 2019 15:08:15 +0200 (CEST)
Date:   Fri, 12 Jul 2019 15:08:15 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Max Gurtovoy <maxg@mellanox.com>, kbusch <kbusch@kernel.org>,
        axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Message-ID: <1603354553.31165718.1562936895742.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20190710163853.GB25486@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu> <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com> <20190709212904.GB9636@lst.de> <516302383.30860772.1562736406606.JavaMail.zimbra@kalray.eu> <20190710163853.GB25486@lst.de>
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: fix multipath crash when ANA desactivated
Thread-Index: fwKn1PX6YED9F5qDEy8Az7LxHoTF6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 10 Jul, 2019, at 18:38, Christoph Hellwig hch@lst.de wrote:

> On Wed, Jul 10, 2019 at 07:26:46AM +0200, Marta Rybczynska wrote:
>> Christoph, why would you like to put the use_ana function in the header?
>> It isn't used anywhere else outside of that file.
> 
> nvme_ctrl_use_ana has a single caller in core.c as well.

Thanks Christoph, I'm testing a version similar to yours.

Marta
