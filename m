Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED4C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485F420815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FB3bYM5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfJHMAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:00:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42666 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbfJHMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:00:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so24779257qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hMT2QOE/OAMarN+nxsAfhwGq8004d2eHigWLvE3NWsY=;
        b=FB3bYM5H6/0Vu2sXyCUS3ZXh6QnbHGNFksz2EMZQEQv1hYOCRU5i24RNJeiaYvvqDa
         j5mMRmFbRHTLXXcQ8oqs0e/akRMyHw3ZKTQkzQJ6L4GbfwasRzDMC7xA79pZ0Bis9fnW
         yOflSlbJwdY6Nr3iBQ+AvydqTfY5CzUTRm5D2MGUAUjCGtzgrXz+Dc0vJaJbqP2xq56I
         fTGqKFxvtOhGZV+4k+RzL12Xg6fRet2FxCe4Jm8Q+UAe4UinOEz0axC0DW9XXaO5+wtt
         eDs9bhFHEtuabXlmBH5vl+rP/h2++WUxQTrMpgwBWazTVr/nw6Xg5chm1q0q1cZO/vrT
         wzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hMT2QOE/OAMarN+nxsAfhwGq8004d2eHigWLvE3NWsY=;
        b=g9oFC+DQ8nL4F1ayIRxZbE2RUlHEMgeqwh2eLSAQgZJ25z0RvO63QZpVhGJjA5JpTN
         ZnO5oNiV5lKqcL9XDG0djX5YO7LPZ3qekGL7iDK06VYctv32TRlgybF+KNyjIwJdueNT
         qOIeHk24HUCi702ra0w4mwwwC6iZiVFr+KDQ+xvlsQ+M8RIE7uiHdw+qccH9h2Vec73b
         PUy5Gi/g8r9XYEMjJoU2ne5Y1NxhMv7kAZBTQZdBpEeGWWgZf2kxDyjpPO9+pJOX4r85
         8w7a2IObEeguO4HZdBdqsL4CQqzD7XfYOc5fLQnBaneCBQyBD3DtGTB/94ww1V21VooT
         B+fw==
X-Gm-Message-State: APjAAAVqvRYOLfh4wDxudqdIFbX88CthRM0xIkIs1dLhM5Z3EGRxBA4a
        u1M5iJrlR3MaZ0in54+v/abDYQ==
X-Google-Smtp-Source: APXvYqwi6mpb3TUaZFLEjiraqYM9798ysDR+1/i/r66aOzL4Y0x9nk3+sxOjsGTBD5LGyNEJt0PS6A==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr34903151qtd.63.1570536044299;
        Tue, 08 Oct 2019 05:00:44 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i25sm6765898qkk.30.2019.10.08.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:00:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Date:   Tue, 8 Oct 2019 08:00:43 -0400
Message-Id: <3836DE34-9DD2-4815-9E1E-CB87D881B9AD@lca.pw>
References: <20191008103907.GE6681@dhcp22.suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191008103907.GE6681@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2019, at 6:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Have you actually triggered any real deadlock? With a zone->lock in
> place it would be pretty clear with hard lockups detected.

Yes, I did trigger here and there, and those lockdep splats are especially u=
seful to figure out why.=
