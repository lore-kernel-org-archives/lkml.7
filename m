Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F321925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ucb399"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfIRUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:22:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34749 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfIRUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:22:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id h2so1288292ljk.1;
        Wed, 18 Sep 2019 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meIVwwcdmP/nxLwROeZNJKv2MKcCbPHX7tUkS9zAbzM=;
        b=Z7ucb399RGF9U9tQvgEYnaf/GVv/5O8JGgljOfEFbS59akeP8ua3MG96LGv6gp1/Bl
         FRSBFhV8554T6+PhvCNurUGqIj+l/5zx463jRffXiOBWGdWnibHtbhPZbIWJJYIFVLR8
         R7+Km/dNqvXLb24XWRPhA558QSW5AN4Q8vSFrSOQiNb7le2PSpSVDNHDQX+faujSuxDc
         galQGlc3OMS7mOrIOzPA+T9hOCj+UuiuYbICOnw1hnawKxFIpi8pmgiuDg65GPGc0HcY
         18rouYHLHbwxRZT4rY/1Zm6raqoxWfvkET9CUioERjOMJcE0WeLu/6fI89cdL29DmaZB
         M3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meIVwwcdmP/nxLwROeZNJKv2MKcCbPHX7tUkS9zAbzM=;
        b=Jd/XCGOieUU2vYzsiFhRa79qeBtDcdBZuvg0+E+Z2aw+y8JZ6X8kn8ezpjKfB+0KZ+
         4ldC7BX0WtR6HdaGSkoHCnKn7s+3zybkMesFVyUzxPZJInK6RbYKlLKCc+GUd5paZyd1
         cVXtJaKUfGGsTSiMwzZ9tVkrcIev8HpMgY6OMMVS2+V3bKtEma5INZoP75IRfeBnOy5U
         +REOi7CudX/ZbQ7ga9Aq2s7vEBKbCV6PKPIWgUzShqZ8i/vn1T4XfhP/elj8Q1R1bokI
         +3bBuXQqvPUMrNsctt+fNqWMzXuWBgShpl83xCpuZ/GTLpWnB+1mBhHf58V0Df0aPR2E
         SjyA==
X-Gm-Message-State: APjAAAUqnn9jmQBfhbCuc6BpABEJ/7Vcbe9CfH+Iv4zf+v7xZNIJ4XHU
        QbHnGvRIp/EkgoU/yMogFOnc5WrDs83SuIATT+A=
X-Google-Smtp-Source: APXvYqx/sOK9cpvYG89Tl6YDcE/lNs3l9ylwlvv9ugwHiO3AAV8UBwZYkdXxapXBp8WaXs7eqKDhElFzdrGjXl6++tg=
X-Received: by 2002:a2e:6a13:: with SMTP id f19mr3209725ljc.17.1568838150069;
 Wed, 18 Sep 2019 13:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190918052406.21385-1-jinshan.xiong@gmail.com>
 <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com> <20190918143235.kpclo45eo7qye7fs@ast-mbp.dhcp.thefacebook.com>
 <CA+-8EHRk6aAuDQ=S9O7h6T2fhyz2z+zQduN2yiDNWMOWt2-t_A@mail.gmail.com>
In-Reply-To: <CA+-8EHRk6aAuDQ=S9O7h6T2fhyz2z+zQduN2yiDNWMOWt2-t_A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 18 Sep 2019 13:22:18 -0700
Message-ID: <CAADnVQLsnFaFS+ZhRoL0QfDVcGiR2OSrqSqRsd5dci=rQ+Pb9A@mail.gmail.com>
Subject: Re: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
To:     Jinshan Xiong <jinshan.xiong@uber.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "jinshan.xiong@gmail.com" <jinshan.xiong@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:13 AM Jinshan Xiong <jinshan.xiong@uber.com> wrote:
>
> The problem with the current approach is that it would be difficult to filter cgroup, especially the cgroup in question has descendents, and also it would spawn new descendents after BPF program is installed. it's hard to filter it inside a BPF program.

Why is that?
bpf_current_task_under_cgroup() fits exactly that purpose.
