Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17754CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13E621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AtREbgkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409559AbfJXO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:56:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34653 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407327AbfJXO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:56:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18so23076079qkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8h+hfVNVeTtMQwnm7B4X9bv+ecm7MivS0VqJ4GNo1Ks=;
        b=AtREbgkPP6G1Yhy6IZorgNmCi83u/pdkFqzAX1O7XV2cO/+Efpga2Fu+zhw5Y213WE
         MsUQZDi6F/JqPeBZxYYDltaY8IUPV+De1/aerznlRU0rj9f8eJqZUAGZYOGil4PM8p9j
         uKuQJVzJyOg2e4wCfU9TXjfIdTLnSviugw0QUXyqtZLxuU6pUGxhJiOSHlHXrKtS+q17
         3qf8worxHin7EOB4vLqtnIPlq4+dw0xFro6DLL3saraaGNKAmMdD8TLHLRPB88Lk/dCr
         8GDM8ft/zya4q3uPEqgCsTiSI/HaRJICfOoQSDP0gLKvvfftV+yfHcar3cHuVpkunD2L
         IAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8h+hfVNVeTtMQwnm7B4X9bv+ecm7MivS0VqJ4GNo1Ks=;
        b=Cx4lZRuXmGKWFsQrs69NmI7k2vfHt6fY1Wd5h7+rXx9vzOKN2kaB3AivcmWUct/7B4
         +KOYw8MPzSdDf6tchAYnwFZa1sOaOQNp8l+gJyOU1QXmKEMRG+OAj6J9b3TP/vgbFLs+
         EnrG3kZkPgrQd1ANCHnkbkDRjyeN8SFtvTOoPEApBCYoY4vNVXe6sQNhlnd3nKHEiX2U
         aJMkrGRLLXOsQCR2mHeq4DpVzoKY0Vk40Nt6cedPs764V9TDlKGimOsZua6xhVSJnfHy
         4nyyajyWMEdJcFFr3R7qgaXKxGZxUTCk/MVPwRGUy8R0eI/bx5lTjRyCpIZlLhACEgKj
         yKSA==
X-Gm-Message-State: APjAAAVoU7fQMMC3vvWNcxap0knb/mamh1Y/Xca/vu75+MGTfbkN0J6d
        g71KJXOJTqnmIRZ6XeytJiiqoA==
X-Google-Smtp-Source: APXvYqzHiFvQSRNaYv9jwUxhMp2feMBT+U53DXnUsv0IPvQC15/0Sq5EuGHMa5TCkwRaAwDfo+P2UQ==
X-Received: by 2002:a05:620a:1213:: with SMTP id u19mr1934748qkj.134.1571928961022;
        Thu, 24 Oct 2019 07:56:01 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t4sm879950qtq.49.2019.10.24.07.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 07:56:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Thu, 24 Oct 2019 10:55:59 -0400
Message-Id: <884AF12F-2CC5-4DCE-9F94-BEADECA98888@lca.pw>
References: <20191024133859.GX17610@dhcp22.suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
In-Reply-To: <20191024133859.GX17610@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2019, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Because the migrate type is the information that helps to understand
> fragmentation related issues. I am pretty sure Vlastimil would tell you
> much more.

Then, I don=E2=80=99t see any point of having two files (pagetypeinfo and bu=
ddyinfo) exporting the similar type of information which is probably more im=
portant to figure out than fixing the 10-year old DoS.=
