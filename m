Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19576C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUDORxpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfEQIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:12:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEQIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:12:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so6141208wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8O+9BQEfJYc0g0qK+OD9OThVTAdpC5JdjbcFfzDR2ZA=;
        b=oUDORxpc5eA58F9PCGt7zt9qul2JIcPUhYvzn7WXi+pb3gin/izl1PNFoKbAnr3UYE
         nrQoODTAY1iC52tLWWXGejfZX1dJhvOat1Os8EsQxvcxL6y4J8dvKncqU7jHgvb5erG3
         ++WwlKTymT86TxTsfnUyFaWd6l57W78vHcZrpkNQceYPR56Eyoaaa5+espX5QGjITDUi
         kxhwRQ3MdqxQyV2Pqn24hzxppSILQqP78JYxf5DV8WfQ3gjVgcbSPBB8SPEzG+oW1I98
         KGQuEHX3qN9YIkQXmYKylMrs+0L3EAQ6VWCTn/JMgCn6DDHUCyRmilaZva/MiDmBONSw
         T9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8O+9BQEfJYc0g0qK+OD9OThVTAdpC5JdjbcFfzDR2ZA=;
        b=fVNYjf5gQ+ibQxWUhrBWLI4Q2GDucwRs8IjCe8FDe0feY87TrE2ROfjpXDqlakX4Kr
         SzETP8w6yJn2gZoeyz25fcE/pGpc/lK9zlC5s+8EG3WfoXItWb4HZvONivN1Sp8QBdzP
         0RGxujpBLk0ou2oCMj7zwpuNkUMm0LId41I6rH6wyuM8VhNc8pOfAzRyYQNC9lvuXG6F
         ZbHkPeu+uRTc1AjaMVRtWFbB6KCLlyxc8BaOwwQhhVEXTdE6DTjO8U+oqGyd9B2hYWHx
         KJP4F1t2fJHBefdmhIZSHKf5J3gW2Nk2uumdTHMIgKSnYcxm10BeK9kSHOkTKW4pIEGi
         lvSw==
X-Gm-Message-State: APjAAAUsemszhp5iL2a7yIstvboa0Ow1CuU9vNCR58kV6dgjCnTKGEkL
        lqtnuxPWp7/pGs28Dy4unTFr8VEHKKB2s//VznM=
X-Google-Smtp-Source: APXvYqxlNXvGX9Z5g/e9+tcRIXbot97JHSo4sVwFlLpLdTHuG73ENSQzTxHi7DK+95dl36jYqkWr1B/Q5HoSVlPk6Rc=
X-Received: by 2002:adf:db81:: with SMTP id u1mr6031003wri.296.1558080752113;
 Fri, 17 May 2019 01:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com> <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 May 2019 10:12:21 +0200
Message-ID: <CAFLxGvyZCpKthJevFHjjBQXo=j5f-FUip0MAsLy0HaoJzLZ2rA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: nand: raw: brcmnand: When oops in progress
 use pio and interrupt polling
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 6:42 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> If mtd_oops is in progress, switch to polling during NAND command
> completion instead of relying on DMA/interrupts so that the mtd_oops
> buffer can be completely written in the assigned NAND partition.

With the new flag the semantics change, as soon a panic write happened,
the flag will stay and *all* future operates will take the polling/pio path.

IMHO this is fine since the kernel cannot recover from an oops.
But just to make sure we all get this. :-)
An alternative would be to block all further non-panic writes.

-- 
Thanks,
//richard
