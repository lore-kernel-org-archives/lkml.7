Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9283C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58DA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8gPgtAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLJNro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:47:44 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:35671 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:47:44 -0500
Received: by mail-qk1-f178.google.com with SMTP id v23so16478016qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ypBmAsfUoUInQlseX4GRC4daQUk6vx9GabpQwlhGCEA=;
        b=a8gPgtAjO9OdwKYPlhfjZhi8UVq5c2SGXad3PVQyNEIEUASD0XsKwN5u9NDhmxtNo6
         VwYqTTz1SbRwFVVDQWGusH7HhaeFAZ4GXsEcs6lQ/Qr86CDdzEx1v3JrHo31F8zx/ik3
         R9dwKrC7CdXY+rQ0uFFfFQZ0dWve59hZeaBMFbj8eer+Ru9UKsfj2VoKfcQ8HGZfnJ+M
         esYyriEoQ2JVmPtfCU32DFuW33wO73NE9SWIzMcZvT9Y34psn6oHusAD4uRYCmixdfUK
         JVLvxuUP2tqqZd4uW3idqaJL6t+rUyG9c+M4m+M5X68m5EU5sueozZaJLqEkRTBFcGqL
         e97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ypBmAsfUoUInQlseX4GRC4daQUk6vx9GabpQwlhGCEA=;
        b=dQMbW+kg822m1nsp+LCfSdZghW1AUszYOoXtAD14jI0LLHSY2uVooDuKVlXyK0rm6b
         qNRcNCD/6GrZWbKRrAo9ZM6KIM1BTdYJ5HIYp5pf26Js0VbUxt1w+fKc5GVcca7m6mCi
         Nu1Pks3TdhmzRr8ILGiJC2ol0uyuFqLMjIusbNy4xDoDK96HWeEsVBNrj1QuSguRF5eo
         az5OqoTNDGCSicp9UoQtJCLmlQSKm8Z1/gCsD3fxnDNggrby7wAfLe5l3lzFe9TFlvl6
         J4IgP0X1UtzsgcORKmeVAYKDM20elj6KlKJoB2rqDrw+2dL0WXG/the8W0akPV+4QFR/
         D0QQ==
X-Gm-Message-State: APjAAAVKd1241tmK7f6y6Ot7knd34cd2uuu9axA60BAtuv5e4cot77x5
        1+IEoKzVhJ2jgUEtjRreVm+N31ksRN/LRn82dFP+gg==
X-Google-Smtp-Source: APXvYqw9Yf52alvxvgAPKFrcHHUhUAXaa3Bpk9aTjYBUZPp5Q03DHGOR2QzXKtRBhAYbkYZTVlvPh3c+RKH3v5TQniE=
X-Received: by 2002:a37:e312:: with SMTP id y18mr26848551qki.250.1575985662613;
 Tue, 10 Dec 2019 05:47:42 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Dec 2019 14:47:29 +0100
Message-ID: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
Subject: get_maintainer.pl produces non-deterministic results
To:     Joe Perches <joe@perches.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

scripts/get_maintainer.pl fs/proc/task_mmu.c
non-deterministically gives me from 13 to 16 results, different number
every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
this with v5.28.2.
Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
non-determinism. But I guess it's not the right solution, there should
be some logical problem.
My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.

Thanks
