Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05294C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57C02173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfFLTXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:23:16 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41530 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfFLTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:23:16 -0400
Received: by mail-qt1-f176.google.com with SMTP id 33so11603694qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jTgyXnqAA1RWkM9GuN0X0PVMrNnVGRWkQvCz1tb289s=;
        b=lBn+D/uQ1jpmz7pbLk1Rt4AVs/DB7RQqei79CZ7U21rMewZECXK98yhrlSk1hLxGUf
         x9BQGjjXGjj6EiVhq2kAY1qmygFuJl8hDRv2TY6SHGyuTNywqUJpPB+RRQfiJZgmbJgT
         poo7KX5MuTxW05EyCH+Ul22gdy+Xw8LVZmpvqRATkxLHuejSqRt5rh4EbKtVrAW0/v58
         nNpK3KgblnhPCvb7UMdAGxddlHajfCM629Tzd/O19oVSYr7V6ksxfRgPJdaFwO/jDXcR
         nLYB/KPENp4HbUkN5crfZI4ejjZBwTpSxnK6n9AOnC9qfBgw/StIytaai8fhpOq9lar5
         Ib+g==
X-Gm-Message-State: APjAAAWUHtlahI5SKGq5bwA3g24WMpIw8bXGZ+sFFlHDaRctFLYXPvhH
        FkDab1hx3pDTxCUburUqJr118Zt5SGM=
X-Google-Smtp-Source: APXvYqxVBIzDgHYsuro2G3S0PSUvtErDwfCVKs8QllR8Gq0rOvWEEtD9UsxSAKB1Ac6RLWtQ5Bslhw==
X-Received: by 2002:ac8:7652:: with SMTP id i18mr62832443qtr.10.1560367394552;
        Wed, 12 Jun 2019 12:23:14 -0700 (PDT)
Received: from ?IPv6:2601:543:8101:1d87::fd60? ([2601:543:8101:1d87::fd60])
        by smtp.gmail.com with ESMTPSA id j37sm323900qtb.76.2019.06.12.12.23.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 12:23:13 -0700 (PDT)
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: perf build failure with newer glibc headers
Message-ID: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
Date:   Wed, 12 Jun 2019 15:23:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While doing some build experiments, I found a compile failure with perf and jvmti:

BUILDSTDERR:   gcc -Wp,-MD,./.xsk.o.d -Wp,-MT,xsk.o -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-jvmti/jvmti_agent.c:48:21: error: static declaration of 'gettid' follows non-static declaration
BUILDSTDERR:    48 | static inline pid_t gettid(void)
BUILDSTDERR:       |                     ^~~~~~
BUILDSTDERR: In file included from /usr/include/unistd.h:1170,
BUILDSTDERR:                  from jvmti/jvmti_agent.c:33:
BUILDSTDERR: /usr/include/bits/unistd_ext.h:40:16: note: previous declaration of 'gettid' was here
BUILDSTDERR:    40 | extern __pid_t gettid (void) __THROW;
BUILDSTDERR:       |                ^~~~~~


This is with the newer glibc headers that came into Fedora earlier this week
(glibc-2.29.9000-27.fc31)  It looks like the newer headers now define gettid
so the in file gettid no longer works. Note this was a custom build with
jvmti enabled as regular Fedora doesn't have it enabled which is why this
wasn't reported elsewhere.

I don't know enough about either the glibc headers or perf to make a suggestion
on how to fix this but I'm happy to test.

Thanks,
Laura
