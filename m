Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8503C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C4B2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfGSSKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:10:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38397 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfGSSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:10:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so23898402qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I5yxDLBjD9O283UM+JdJ4IKPKIJoZcBeFuKThne91Js=;
        b=LaBMFD+fecDN+7J0jLnH2tMwasfrKmgviDlDCO2vWk+IkIjOhqCXawKEaopjGCLB55
         LF6bjvlivJJzRmroWg6xmKfP+LR29PVs+VglONY80kLSHuut3HDyTkBvoy0f0ihEReEE
         0A+Oa71ARtJsbH5z7tZ9OU+zoj82D/HzsFe56sKoU78ZKNlMY/ZZBb5CTkn6iUfJEbq9
         8lbBPBPi+BF4z+guTxM4q6QWyNQ4HKwk51StRJMkfJuvVTghafsMZfoeWdWhHp4hvLHo
         giCDhDEM/EeV1yTbceYNxWx61xZQDKvkiqnF43w6fUZ35V0YK4FeXciKKX+4Zm1DFDe9
         pNcg==
X-Gm-Message-State: APjAAAU7dnA6nBzJJHYNQ0lky7uV+XSbbsztFrdfxzT3pye/pymWCKnT
        futLgdvhnqW/qzUwL4oCtqXqBLTpR5AiCT75BKQ=
X-Google-Smtp-Source: APXvYqxdIqx8fHtrdKG48CKoyfiF259XnpXakKMTj3aM7ZskknXslVmiGlmFu/sjoFV7IojH8W4FsiJX2OBDg0dkXlw=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr2187297qki.352.1563559804402;
 Fri, 19 Jul 2019 11:10:04 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 20:09:47 +0200
Message-ID: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
Subject: warning: objtool: fn1 uses BP as a scratch register
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of objtool fixes showed up in linux-next, so I looked at some
remaining ones.
This one comes a lot up in some configurations

https://godbolt.org/z/ZZLVD-

struct ov7670_win_size {
  int width;
  int height;
};
struct ov7670_devtype {
  struct ov7670_win_size *win_sizes;
  unsigned n_win_sizes;
};
struct ov7670_info {
  int min_width;
  int min_height;
  struct ov7670_devtype devtype;
} a;
int b;
int fn1() {
  struct ov7670_info c = a;
  int i = 0;
  for (; i < c.devtype.n_win_sizes; i++) {
    struct ov7670_win_size d = c.devtype.win_sizes[i];
    if (c.min_width && d.width < d.height < c.min_height)
      if (b)
        return 0;
  }
  return 2;
}

$ clang-8 -O2 -fno-omit-frame-pointer -fno-strict-overflow -c ov7670.i
$ objtool check  --no-unreachable --uaccess ov7670.o
ov7670.o: warning: objtool: fn1 uses BP as a scratch register

     Arnd
