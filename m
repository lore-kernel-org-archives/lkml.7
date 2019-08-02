Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D54C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711732073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+cIwG1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbfHBFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:42:08 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45971 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbfHBFmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:42:07 -0400
Received: by mail-vs1-f53.google.com with SMTP id h28so50529478vsl.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJkMNylLamCwkuT6sROv1XDM0/n/3kNR/eOF3+/bQsY=;
        b=U+cIwG1CTsIRcb3q5QxRmfJyxK/tKtqsNZa9/kvmfw0prsc2+yTix3jrewhrmsxJUj
         orggiHfsAMhYs6nQncsBsFlu7lIWll4x3yFqrI4HCxQsB7HVuz/n3m1IS0WgnfGsWtkh
         UMtFqYWtEzUKaf7dWkKJmNKu9djlHekyNEPgYv/8FJQlcsOow1nvotkmCVOGP5eCEQVm
         n2Y7SCI9dNTSt8gJZsM8LbrAi7xtANu8IRIkEMxmqIqD4stKvfHxeBRUpAFgNoPe+BEO
         Uhh2sqRypMgUqU7HcpvuBlIrW/ozrzgw7HOivTJ5ISyGw6aqVMObyKT5qlspPlsPfBvR
         5b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJkMNylLamCwkuT6sROv1XDM0/n/3kNR/eOF3+/bQsY=;
        b=hEcff4Hpt8GuqcnyM+2DCx3Ft3pyc5VG7JHaq94z3MZc7HPG5z6mbomouBO4KikZyl
         d9+0okS0JaQvEZpJS8CulfsfOIA6cdV3hbp0adD5uXGtaXwDGNMz8lewpH/qfC26YzA3
         +etg8FGYnhmK4QhOzfQ+WCvbrjk93AmJZ/dslR1HVm8XmmjkaejDnMwUGfExNEK4Biwh
         ZOheQkHbs33JbJI0EdEXadJ4fdMUJ0oSYlj1qagfRBiWrayy9GWtGqCdJcn9oP5nOm4Z
         UQMAQXZ/V42izD+QueEma802GEOyA6QNf6q9nJtLFM/0eYBbPB5X4Vj5xG1KHxH5GUgi
         OksA==
X-Gm-Message-State: APjAAAVcFX1T2iYOWtaxnM58BqHa/no3qIcJjrXPvYL8f6OQzwq1R/Nm
        3XxcCYc3dvBlNiIdRzqMoi7f/EeuQ8GgtROZY4gOibPA
X-Google-Smtp-Source: APXvYqy5VBzBYR781n7LumQX3+g8YPMHJH0zfc6OdicCCwEv7AunmOG80U0iAe0NLu18nnDROszkQZnzh7bc/93TbZ4=
X-Received: by 2002:a67:bc15:: with SMTP id t21mr74454723vsn.99.1564724526292;
 Thu, 01 Aug 2019 22:42:06 -0700 (PDT)
MIME-Version: 1.0
From:   Fang Zhou <timchou.hit@gmail.com>
Date:   Fri, 2 Aug 2019 01:41:55 -0400
Message-ID: <CAJrp0nBcm-++zejsjuM-q4=0eKzXOOUMUNjnTzfmt6FgDiiy1Q@mail.gmail.com>
Subject: Overhead of ring buffer in Ftrace
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I=E2=80=99m currently using Ftrace with tracepoints to trace several events=
 in
kernel. But I found the tracing overhead is a little high.

I found the major overhead comes from
=E2=80=9Clocal_dec(&cpu_buffer->committing);=E2=80=9D in rb_end_commit() fu=
nction.
local_dec() will invoke atomic_long_dec(), which finally performs
LOCK_PREFIX plus "DECQ" on this variable.

I'm a little confused. cpu_buffer is a per-cpu buffer. Therefore, I
cannot come up with a scenario that two core runs INC or DEC on the
same per-cpu value at the same time.
So, why do we use such heavy-overhead operation here? Can we just
simply use "DECQ" without LOCK_PREFIX?

Thanks,
Tim
