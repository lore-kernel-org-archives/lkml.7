Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B62FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A96F2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js5vBpdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfFZMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:09:43 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36499 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:09:43 -0400
Received: by mail-ua1-f66.google.com with SMTP id v20so665570uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qWh/EgdzOh68E9KKq1aUl6lkQ8mAhAP0pUgHg6BRLk8=;
        b=Js5vBpdGtj62gCAgjVnR37jkKP43wJH5cuCK12dO4AQlbaD42ifjmYiwQXt3VMgoi/
         THKR4b4A2EG2W88fkLXjeMu9OCCeYiLjJeQN6yzilTe9IDRpAxVr2VYQlybBvEfxIELO
         Ghx9B7s8nWaoWCCayjKJ/fY4nCkoMkpRtJFYFgMYZm+IpwR4vZH99ChTZo+THeFku6Gr
         a6iayUwNn2bwIhJq5Rkxu5eB56EEYs7IT96f9DZMgbkOHVl7Xi3mBDjB2bolhhsEAGKf
         4wZA8iIkvp8FzRdWQ1kO/I2cf6NPjX7Fpz7lrZ4APZGN0Yss/WpWGiqZxqEOXrPQBPRh
         OOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qWh/EgdzOh68E9KKq1aUl6lkQ8mAhAP0pUgHg6BRLk8=;
        b=RL9ZMMGB10LE6eTJRLlxw23XKQSLKLXW8P4QYV+k5T291wn1U5iSzsCJ7g0j8evmCZ
         QhsJ44yioI3JC4ZZ44adF6vbSoM9I9MsKHCvenFnp787mH0ojAYDp91a26O6/gHK6KCC
         b4FWvRE1ZFfj1eOrpm6jRKe8EijEueYo4iP81ChFyg8VQ2UGJz7Faa1af2NXPGuCHIqP
         i/n3vAQ9MiaLlivv+DLPeh8/SpddcKPs1f0nAjlvCAFLWcm3h60JRsINfROD2Dl49MFK
         vbyxuCU/YmlSDBjb2Syt8Fpp7Xa9u5N7cjWWgjn4DVgZvGeDT/dXKT/Vt4fNrqXrYVMf
         vR9Q==
X-Gm-Message-State: APjAAAUMX6EIKHsD2Hq2mGTDPe2NvxTn8YUx/6yMHbgdYVhEkjc25xyN
        qk1PAWwfYlXj9kwF1Ousl9o2tpvhto9s2YqbpIqg3A==
X-Google-Smtp-Source: APXvYqyF9JV+5Av4f4w33Nsn8RsaVAM4p67vDttBBtYQL7YAuqszVBTyTurrDkYdKwu2KaTqb9CZeGQezRIH4iLyOnw=
X-Received: by 2002:ab0:30a3:: with SMTP id b3mr559322uam.3.1561550981921;
 Wed, 26 Jun 2019 05:09:41 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 26 Jun 2019 14:09:31 +0200
Message-ID: <CAG_fn=VyAYUYJuCqR1rL_KjGm5i1mBzffA=uuCnTa0QOBRsvaA@mail.gmail.com>
Subject: Re: WARNING in kvm_set_tsc_khz
To:     syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        pbonzini@redhat.com, haozhong.zhang@intel.com
Cc:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haozhong, Paolo,

KMSAN bot is hitting this warning every now and then.
Is it possible to replace it with a pr_warn()?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
