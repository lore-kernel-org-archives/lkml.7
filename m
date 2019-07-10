Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617EC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CADA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGpHipit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGJXyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:54:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44726 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:54:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so2000219plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFYw+HMYMcy9WDWAf7lBOqFHKuuJ9aebWvblsMHgVuM=;
        b=XGpHipitrwxuJAmZlyG7V9JPyfM7owm246snIlqAPmAbAGT+TpB3cvC9uq4gTBgrkV
         54fTAwAckeuotsLh92QIwHqxvTZNNTPCZ0lmxln7WYBOTrxmrmQ3abMb5TH3hluGcp+S
         ZW0JmODXSrqZ2HPxVd2O3lOzgv/nYxYOxDG8oHV5FFvgn+Emb1SOCD9hhTKZa6xsSbJp
         thfo7s046j0jn5t7c+8rn3VyYLqq2Ly5TJcrpLWS11PBcE6Cj/jAXFb5YI5BsUiRu1HR
         H1JTxEpV93MAyHHghvXcZhh/I78XBRv0j5w7+vGTnMg8Deoz7yvSMnUhIgzRMRrT13mN
         fu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFYw+HMYMcy9WDWAf7lBOqFHKuuJ9aebWvblsMHgVuM=;
        b=uN4R4UHptfwINvXyyjN8OsTw+ie65oZSXszodOIH2LFAKxA5m/X8OCeU2dut7qGTeQ
         zm7PSPS1t6VxYWE7LsO2phAFDdQke/6eNADs2WOnMoeku5MtUdfoFSNilM9nEdVLcpo+
         FhA3958oFNtV99opks7Bovtnywc5GC9JOjDdW5pNxux+ZhPNgEjaW+ztZdIrglte7e5Q
         OTMOKdPl/9BqC5ipuysLNjdlN1S4AuP1fhj3/uWkhfF+u3ZbGbGrA8ExQK9bowkoQDAd
         kaqbxbvl0JvE60HU3TRRqDHVgaMVrSavN/M2RHkZuJZtLAzygitbyqjXKGFqU79LMPeh
         rXmA==
X-Gm-Message-State: APjAAAW5Sjyqnx53GdPXBcwE3PgxR0BNGPoRUOIwThh/54LzKP078d7v
        5znXU9X/bqEKI+egvaivq0106K7lOU5Q7yDlEICDJA==
X-Google-Smtp-Source: APXvYqzp1hs90Rwc0aIZR4yrq/LXA6p5+K72VfDeYJ0yPeISfrkbaXGgGHoaXuTZjUxbjZu9JiVnGVXwU9LrMXwKpk8=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr990493pld.119.1562802841570;
 Wed, 10 Jul 2019 16:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190710174800.34451-1-natechancellor@gmail.com> <20190710182624.GG4051@ziepe.ca>
In-Reply-To: <20190710182624.GG4051@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Jul 2019 16:53:50 -0700
Message-ID: <CAKwvOd=yJQgzjQBKW7=en_YnF6OCAg0MXy5c6c9tBLSjGgorPA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 10, 2019 at 10:48:00AM -0700, Nathan Chancellor wrote:
> > clang warns several times:
> >
> > drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
> > from enumeration type 'enum siw_wc_status' to different enumeration type
> > 'enum siw_opcode' [-Wenum-conversion]
> Weird that gcc doesn't warn on this by default..

Based on the sheer number of -Wenum-conversion that Nathan has fixed,
I don't think gcc has -Wenum-conversion (or it's somehow disabled just
for gcc).
-- 
Thanks,
~Nick Desaulniers
