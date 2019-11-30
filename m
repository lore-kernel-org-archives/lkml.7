Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA4C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CA52075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="vryAB6gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfK3VUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:20:21 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46843 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3VUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:20:20 -0500
Received: by mail-qk1-f169.google.com with SMTP id f5so10473270qkm.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YS0My93qs4wfTeVuLS4eG6rOWxdhL0NApXflYAKBZis=;
        b=vryAB6gNcSJu81yvp6LI1tsPIlGq6zhpdTjjm0LSNTWQgaLLxCY6ujogIuJ1lVqILy
         HsIuI3gxNnsGZXL6SkH2s02Rqk5tOUhseDJumrg8Y4Goned5eSnwXiOJ02FVwkLUpmq1
         fy2dkQ4kGcJlW5IgkT8EkbzTjzSlppz3fGgGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YS0My93qs4wfTeVuLS4eG6rOWxdhL0NApXflYAKBZis=;
        b=SkqdNZCpWQueAcVPTTTQF80ZJcbn6SUV4rXSfUyl9JugfGaRjXoeRHTwAt4HN/3lwx
         8ReyV058spZYmKcKnZt2hAptnzrWP2ovJAIc6Oc80MOTEwgvlaYEVzmJMGG2abOIVJ9b
         N/+EDTTaznao/NP7JKvsr4nzzZ35Dq71Gmv1lI43Tw8vSsK3UTVESLcwE5Nyr5MlTUny
         GrQC9IhcjrIxkSrfaoE/3yX1s/mm+15Y9SGY2yzzxk8SCIMEZGZkCPNZHzYirmbZpw6a
         tCSNQ/pIVqtzIPbaD7sRn5nWMCrX2vSJi97DQzLEtmGekBWJuJfUFGohRnpErAdgIrpX
         I/4Q==
X-Gm-Message-State: APjAAAXadevfWdzYlQBM+lqMaDcg6mbussuwgzqYJr1co7V2gS1EVQrk
        Ay7aQE7dlCLhATxqoRHt7dzGzoPUu1N/Hsvt5w5xGeC4sgVmqw==
X-Google-Smtp-Source: APXvYqyOli57ideDJnYA8Xot+9aJ3TPxPwSiAasZ7J/43lAH9KfvXVRK8W7FmYYXiP1p9TDBrbzrFpzcxz2UAKjaCfY=
X-Received: by 2002:a37:bd06:: with SMTP id n6mr24400401qkf.286.1575148819181;
 Sat, 30 Nov 2019 13:20:19 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Sat, 30 Nov 2019 13:20:08 -0800
Message-ID: <CABWYdi32BXz4W0VyYR2hV5A58rcegCaF4Jk__QmyiTJsr7=b3A@mail.gmail.com>
Subject: Misaligned output of perf stat --topdown
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm observing misaligned output of perf stat --topdown:

$ sudo perf stat --topdown --cpu 1 -a find /state > /dev/null

 Performance counter stats for 'system wide':

                                    retiring      bad speculation
 frontend bound        backend bound
S0-D0-C1           1                30.4%                        13.4%
                       38.0%                18.2%

$ sudo perf stat --topdown --cpu 1 -a find /state > /dev/null

 Performance counter stats for 'system wide':

                                    retiring      bad speculation
 frontend bound        backend bound
S0-D0-C1           1                27.5%                 6.5%
               24.1%                        41.9%

$ sudo perf stat --topdown --cpu 1 -a find /state > /dev/null

 Performance counter stats for 'system wide':

                                    retiring      bad speculation
 frontend bound        backend bound
S0-D0-C1           1                29.6%                        12.3%
                       23.7%                        34.4%

It may be hard to notice in narrow plaintext email, so here's a gist:

* https://gist.github.com/bobrik/ea5ddd8eb1629c350c898093f39ac7ee

I think there are two issues:

* Sometimes output is misaligned, which may or may not depend on the
length of the printed value (<10.0% is misaligned, >=10.0% is ok)
* Values are never really aligned to headers (except for maybe the first column)

This is on 5.4.0.
