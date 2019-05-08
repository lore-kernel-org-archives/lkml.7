Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA77C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95121530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2d16a1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfEHXlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:41:44 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:39264 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfEHXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:41:44 -0400
Received: by mail-vs1-f44.google.com with SMTP id g127so237247vsd.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:message-id;
        bh=+q9WHpodXg2jA9cvwwUZJGXSV/QFB7CTl6VSNlMBmg0=;
        b=j2d16a1TlDpUIp1TZfbBre066dZcnHk7Uxk/zYgayq2scAo/tDlCl/QBoEy/kcJNmN
         2tv2nuy7rSRB8iWCyFsym/zK368/yPB4tna1xp1G0kbgjrPrO846I/OUrhdI+j2zcosR
         kaGz5qphqevbtRk5VE79N/nHOx1ZUG81RPoZCowHbjCD/mRJVmsi42SkdelLtwB0VjVB
         gHlbVcy97f/99Pe0bFje8cURUcrja0RiO5Y64j6/cU9PfHSvqVIDC7ibX6Gxv4bdKb/o
         DeDDuo3e07r+BlRSJAebq/qbn89AHSJ/OrfqlDQ9o4IlDj9Un9iHD1DuJhKVasmnswWa
         wsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:message-id;
        bh=+q9WHpodXg2jA9cvwwUZJGXSV/QFB7CTl6VSNlMBmg0=;
        b=Vb0vOvmK6OXeqmzAywZ4PnLRh8uQWCdrNriPrcPX2TNIouceZpu06JDZB2izuuGrZk
         GAM3rioP0ulWXYuiRnlzNsM55sKlaXtCNyeL481dOL0NGMlZ7pQVOFOr8OB+RqK9BXaO
         86dTkhhkEf+vzKt5DXS8rRsoHp4oaBba8kE+Lz2RhdMzDYmMV5VMdiL8zjlHutr7Qh5Z
         LWBzYNTIVBr6g/Pa7uU2jUMAiIEzhCK/l3kBEK1I+lXpRi5PmBQjrmFdEU21IHPjDcvh
         /OagY0VboT5Jhes6V457P6FcYyOhXnadjsQ3Dw2u5P+2FDxlZ9hpv3U9WyU53TmtcxJ2
         JiKA==
X-Gm-Message-State: APjAAAW7udj0JoA/A9qoKqDUVOAG6Mm3uzZQo0G+FX4I/cq2mv8uI08+
        DzA4aPzNo1T+FIkdfoHmsrI=
X-Google-Smtp-Source: APXvYqwVm6V2EowNvVLx8nUNagnjipWb7PJSMnx0wTbyDyDGaLvwNXtq3gQg9HLpM0UqngtG/OSR4w==
X-Received: by 2002:a67:cb12:: with SMTP id b18mr628894vsl.191.1557358903406;
        Wed, 08 May 2019 16:41:43 -0700 (PDT)
Received: from [192.168.1.219] ([199.116.59.166])
        by smtp.gmail.com with ESMTPSA id e62sm366950vsc.24.2019.05.08.16.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 16:41:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Wed, 08 May 2019 19:41:26 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <2D67A146-0AE0-44A5-8659-55E7975EB67C@fb.com>
References: <20190508132010.14512-1-jolsa@kernel.org> <2D67A146-0AE0-44A5-8659-55E7975EB67C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>
CC:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Message-ID: <17468449-8A7B-4157-9CB1-178CBC4AD4F9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - patches are rebased on top of Arnaldo's perf/core with perf/urgent
>merged in
>>=20
>> It's also available in here:
>>  git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jolsa/perf=2Egit
>>  perf/fixes
>>=20
>> thanks,
>> jirka
>>=20
>
>For the series:=20
>
>Acked-by: Song Liu <songliubraving@fb=2Ecom>

Monday I'll test and apply, thanks!

- Arnaldo
