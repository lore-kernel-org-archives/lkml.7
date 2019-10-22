Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED43E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hJDge/es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfJVTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:23:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40289 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJVTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:23:14 -0400
Received: by mail-io1-f66.google.com with SMTP id p6so13649190iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Z35gIg5VNnGoWRkAXQlW7xDcZ9tidybwVVKTt1ULIyc=;
        b=hJDge/esrdfFa6YNY6zLpWrNhnT1vMnK+6yKTySDF7X7A8kCqh7g9VGIGrCqmA3eDy
         +vJNbdHEIOyA+LAKuepLExmBXpYgtvAgSB46fxRVydVoEIY7Ud4+EggtysvenHkitn6J
         MxsUlNxJCjHVXO42qsHq7j0dQUXN+zylw/DteC9iJ9z4dY1vUnEQ74ZyGwWYhKEOlPpb
         0XHXco2eC7xKOUZWHVbrpMTtsWk9aDmDwJpu2r91G89jJLjmXRtEh36B6kyr5BMttz3s
         LigN5pbeqY5psQxX7XzLxSxWkHSJkziPmqXJgTSzGbHHCD9zQo26yq4n5eM6oKNyZfMD
         UrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Z35gIg5VNnGoWRkAXQlW7xDcZ9tidybwVVKTt1ULIyc=;
        b=diHzQu8r/DmhdLPymdAiwvRg+FJJbBT7MgPzGFD5GDBkHe9LNV0ylpE60XPSVvQSCW
         1YeFPls2Qhpfc9A4Tt3++RezmI6TbuxQp49FKHjLqC+NPA2WYNgI+6FzDS5jsqmCzCNN
         ILDF3tuS8jobbY9mS2a6708AIxz8k3kYkKwCAqj2BsXJw3Fvn7SsYRV8rvmqGParV3Ww
         OIlGz86QT7PqKSCKo4krgEvc676PwttsCrgc5flu4i6RysouQfJJBYCMgVh7JQnMGIs9
         XsEX9uUC3wNzYKJayOMZN+KDwwJ4kwNVx2rFIzJcoHCQko59/Vpa5sTsYbx1xDQtskvl
         eGOQ==
X-Gm-Message-State: APjAAAXVnlRHsJjqfvyMt89shComfvI1Hu5eZvlVD80RZPqN/7AvF1U7
        jlLzQItSmGni1wKglid2HbzVRw==
X-Google-Smtp-Source: APXvYqzuDxF1LOkvqGYX2uoK5tzbJ7xW8oeCnI+esDWQYsrpbral+spQ/BWD5pKzYIvIohhFWZtZ5A==
X-Received: by 2002:a02:3081:: with SMTP id q123mr5395163jaq.24.1571772193149;
        Tue, 22 Oct 2019 12:23:13 -0700 (PDT)
Received: from localhost (67-0-11-246.albq.qwest.net. [67.0.11.246])
        by smtp.gmail.com with ESMTPSA id d6sm5642705iop.34.2019.10.22.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:23:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:23:11 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
References: <20190925063706.56175-3-anup.patel@wdc.com> <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4> <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019, Anup Patel wrote:

> > -----Original Message-----
> > From: Palmer Dabbelt <palmer@sifive.com>
> > Sent: Saturday, October 12, 2019 11:09 PM
> > To: Anup Patel <Anup.Patel@wdc.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu;
> > Greg KH <gregkh@linuxfoundation.org>; rkir@google.com; Atish Patra
> > <Atish.Patra@wdc.com>; Alistair Francis <Alistair.Francis@wdc.com>;
> > Christoph Hellwig <hch@infradead.org>; anup@brainfault.org; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Anup Patel
> > <Anup.Patel@wdc.com>
> > Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
> > 
> > On Tue, 24 Sep 2019 23:38:08 PDT (-0700), Anup Patel wrote:
> > > We have Goldfish RTC device available on QEMU RISC-V virt machine
> > > hence enable required driver in RV32 and RV64 defconfigs.

My understanding is that the Goldfish support is still under 
discussion on the QEMU side and isn't merged yet - is that accurate?

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04904.html

> > 
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> > 
> > IIRC there was supposed to be a follow-up to your QEMU patch set to rebase
> > it on top of a refactoring of their RTC code, but I don't see it in my inbox.  LMK
> > if I missed it, as QEMU's soft freeze is in a few weeks and I'd like to make
> > sure I get everything in.
> 
> I was hoping for QEMU RTC refactoring to be merged soon but it has not
> happened so far. I will wait couple of more days then send v3 of QEMU
> patches.

The patch looks fine to me, but let's wait until the underlying support 
actually appears on the QEMU "hardware".  Could you resend once that's 
happened?

thanks,

- Paul
