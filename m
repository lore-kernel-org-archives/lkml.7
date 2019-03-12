Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1252083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxDwlbGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCLP1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:27:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35152 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:27:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so2103955pgd.2;
        Tue, 12 Mar 2019 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODldI1C3mxz+vy99PjB8RPMPSBYb65r6oyz5C0XKTeA=;
        b=RxDwlbGQAW3JTCLL1+jv+mN8bZwA8VfHgdf7CbkeBpwiVG+sFJjX191tO7dHFF3cii
         se8p3GqJJlfdIYNFS96VhSwCdrH7rLGLsN9CztXmdPA+VZzFBAciy0T8ABUveZNrMFj7
         TiJYe6C9HKwezW5zqIOUm3hXR+1xcZPiFHFDI+rhNjCzTie1DWpU42AlQJoypURfaOUi
         /LYuTrYK6AVa0rARWpg/13flpCP5rAl0qK/9Evo8CyYY+xXZiuiPj0miLxhudp0zmXPx
         K1TB3jvM/46cffLa3OuzwhPxBKVlk2ry2VmYv4flgUNKTawH1cV2FbFWnOJIjfEj+OKQ
         CxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODldI1C3mxz+vy99PjB8RPMPSBYb65r6oyz5C0XKTeA=;
        b=i94PJFEtU/MhRevtTzYykXM2nMtafy72Z2Q4rM8klAkfZ6RSGLRnksmNbIZD77wWY6
         eVB3AAN3KkB39djkmgpHKDSanZX385CkrkakCfZGH7V8vZ09WzhCRCigWqCq4rVwA7AR
         tRWTg3mAT61HXqlT9aglrgWFKaxsgzujL6jEsyFIbawPk+0nHudqgCGvBkLqouGuELTK
         cfQ5BXa6hdCx07kgQasJBzwWrm82wuNCyoxKeaunPJoXRwfv3ppippS3lXdRTkzEDDRQ
         puYny40/x9FQJ11y0xcdmBSFt5wWd6kJnohMUg2CTkDUAphCQHPStHORFqG/6Av58J8C
         q4Sg==
X-Gm-Message-State: APjAAAUzk+7C6VIBs7wEopxAvUldQpCR2VuKzD4IjDD+KnRtHhY+Y7m3
        AjCukkVcmLQ3tSNd2wZ4vOI=
X-Google-Smtp-Source: APXvYqzKQfGk4tT+alE8AqjgfLvuPvIqbP0236qh11bo5ZesXtpJ30nuYd6LjxKCNOC2tYA0xpXWDA==
X-Received: by 2002:a17:902:6804:: with SMTP id h4mr40331528plk.115.1552404429059;
        Tue, 12 Mar 2019 08:27:09 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::4168])
        by smtp.gmail.com with ESMTPSA id q78sm15818107pfa.138.2019.03.12.08.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 08:27:08 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:27:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Qais Yousef <Qais.Yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC][PATCH] Export supported trace features in debugfs
Message-ID: <20190312152703.dulqcnhkknklxihq@ast-mbp>
References: <20190312110437.5977-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312110437.5977-1-qais.yousef@arm.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:07:14AM +0000, Qais Yousef wrote:
> eBPF tools like bcc-tools have hard time figuring out when features like
> raw_tracepoint are supported in the kernel on which we are running. At
> the moment a fragile mechanism of matching bpf_find_raw_tracepoint()
> function in /proc/kallsyms is used to find out whether raw tracepoints
> can be used or not. But when this function was renamed recently to
> bpf_get_raw_tracepoint() the tool started to fail to use raw
> tracepoints.
> 
> To help in providing a more reliable way to detect features like
> RAW_TRACEPOINT, add a new file in trace debugfs to export the supported
> features.
> 
> $cat /sys/kernel/debug/tracing/supported_features
> RAW_TRACEPOINT
> EXAMPLE_FEATURE_1
> EXAMPLE_FEATURE_2
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

this type of attempts have been made in the past and we always rejected them.
Please use 'bpftool' instead that detects numerous bpf related features including raw_tp.
# bpftool feature probe|grep raw_tracepoint
eBPF program_type raw_tracepoint is available

