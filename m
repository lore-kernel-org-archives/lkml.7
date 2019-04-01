Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DCCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0CA20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOkqZmQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDANtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:49:20 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38673 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfDANtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:49:19 -0400
Received: by mail-pg1-f174.google.com with SMTP id j26so4809071pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ohFcaPeYqgg4dDV5fMqVmXEevnaJpVm7hAbwso7XpvQ=;
        b=YOkqZmQoaRmpE6pusRal1EaulW247xJaYHMzfpt2UaW0kFYp/0K4AU73ASfilPtxyi
         tV9yTiottCynw+Hj3kA67JbrJpDp4QV9nV9YdQRpN7ht+eF4A3/HwgDlhDGNK16TAp93
         +7aOh2VUF5mD+X4ZUpVR3rMR12qh1FoS1nfwkCaH+qX2l9mA/18jTXHv0Hryh57sTCM7
         WxLHudj0KH0Vv5ejeHTa8evnf+dnXJ+Mtxte/U1XwQYkwbhzvVItRqiknTA3v9UhqCJd
         sM5c8pNY8zRLj9ulaodnfo2dvCqxhudBrtJeRodfQVGkfy8VtPRmNsdlX/d8pX+hjGr/
         DiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ohFcaPeYqgg4dDV5fMqVmXEevnaJpVm7hAbwso7XpvQ=;
        b=mB5lQ4OP/Hvew0iQE6vyWL9f7QXEnVmfHoKR0BeC6JQwp8qRLA74ap4+RLPeZciONJ
         hbG+tBj2sJpqyiPgt6Fq9WeLl2DaDjCUoI4w1I5espCPrP1Yl5EH0GSakyy3ro7liiXB
         iq8uXamVQjQLmD5kzOAs7JMOBadREDhxZ6KYUfq5FmyyJBjypwjujLxDfSBJJDp5FNX1
         hcoyDdRs/lk7QWCOjsP61hXNJo3KXpq70Gu2pwRIrM5fkGtKgEk31rN2UiUG+WjbC+OF
         so8Cd5qGDqRgMw2/oWoeDd8uWxE53bWeTok2pogTFdY3S+xmQ7DXm40SMAxX7wSeXcwK
         rQgA==
X-Gm-Message-State: APjAAAX9KGje5xAV1mH5hvLYScUnpKmYt4wZd6RcZuokdyQTboQhifWw
        TDjSjGJotQpRF6S0p/fz5BLg//PJjYqhpU2nWi1Yfg==
X-Google-Smtp-Source: APXvYqx1hWV4YV5UObT3VfLQVd99p9/gsz/utjMu9GDeYxvY1cntED+e0aw62BFMDJamJ+J4R1denWwHQaI5Oj/HSFE=
X-Received: by 2002:a63:84c7:: with SMTP id k190mr60827960pgd.255.1554126558645;
 Mon, 01 Apr 2019 06:49:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Behmer <jbehmer@google.com>
Date:   Mon, 1 Apr 2019 06:49:07 -0700
Message-ID: <CAMmhGq+VCHWp4s-Xh3ZUtxEudgqK-C1LYhttFpc4MUOrzRD3Ag@mail.gmail.com>
Subject: Correct commit mask for page data size
To:     rostedt@goodmis.org
Cc:     Craig Barabas <craigbarabas@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
We're wondering what the correct number of bits to take from the
commit field is when determining the size of the page data.  The
format file shows the bottom 56 bits not overlapping with anything:

        field: local_t commit;  offset:8;       size:8; signed:1;
        field: int overwrite;   offset:8;       size:1; signed:1;

We first naively interpreted this as the size, but eventually ran into
cases where this gave back a nonsense result.  But then in our
investigation of what the correct thing to do is, we found conflicting
answers.

In the kernel we see that commit is often updated to write, which is
masked against RB_WRITE_MASK.  So it seems taking the bottom 20 bits
is correct.  However, in trace-cmd, a fairly authoritative parser, we
see that COMMIT_MASK is set to take the bottom 27 bits and set that to
the page data size.

Could you provide some guidance?

Thanks,
Jason
