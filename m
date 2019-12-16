Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2BC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1320700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm3RMFhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLPGTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:19:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42030 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:18:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so3326779lfl.9;
        Sun, 15 Dec 2019 22:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lk0BXIIiWqEO9kfeGGGJrJLDU8Vj1PjkOxOAYcW+QLc=;
        b=nm3RMFhC0srV1g0QGrUSXww7JWUzdFhBP9sMb8Cx8bQkg/0X9t9KWdLtmTiQyWMFbN
         pVwjq+Oaws8GRuTysRty6CiMsZOYoYlnZJmsQaFfZufrR0I1gcyz9+ywGYGQE56q0eJL
         SknHfKC83O/XI6KLc/QbHlrzqgH77ko0UkzYsWSBh0nPOVGZ8lO95dJvVo0e1AoD9Dk5
         8tKU+O8BbvLcg738ZBOnosvOd64ktIDz9GxAhlhttUIjvEczkaq4opElVI1CR7AmQ5N5
         Iiu+bJZFrGbR+s5eszBAkdDAdlZr1tFin7jOxWjbAZGh4K0qpAPugrDmPagKxEpxzAGI
         JVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lk0BXIIiWqEO9kfeGGGJrJLDU8Vj1PjkOxOAYcW+QLc=;
        b=ndr+zSPXcyXOJtzsdOuHHEJD303Kup87v3gdICmjaCE7G00rpinFdzTrTc/gqCTdmj
         Kc54glgi23IaJVeXmTby8xvwiobgCqYnVwECPuCOOc2mmFa4qUaNJxnUCgXtNLeksdc6
         KUNOWOJHIqACE3riBi8t7GkAiSWDvn7CICN+l9LLz9qDqwpPXA4zJkSg1ZxzO2xyPaZ0
         6lgVac63uSgKmtIAsgS+D6gp2GD5k/fVEqpS+ohX/Ms3vNBSXx7C9VX4LiP2YG7QyUcf
         BrJkdeC1vpdkn5VvHY58PsGWLe8p6wEDos5ndeiQHp3mMVCt1u+yoqOQ3JWsUupoxL+H
         g81Q==
X-Gm-Message-State: APjAAAXeKnBKWuW0FZh284bcwnZhxVALV3M5BoIPO08GrvqAKvF4ByJ5
        GoUkiX6E53zfE9wzBtPHJtseuN+8MdOUCdmNHNHvbA==
X-Google-Smtp-Source: APXvYqzVlFw1aI21I6iZcTCXHbdyY0F1kGU9byOxk6ZA2qRNn21TUTU2wODR03Nic4UFqQ7HYHbGEnO5AciswL3pCbE=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr14968038lfp.162.1576477137015;
 Sun, 15 Dec 2019 22:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20191215233046.78212-1-jbi.octave@gmail.com> <dd0b6577-aaf6-a557-4cdd-ddc490995c38@fb.com>
 <9d195192-551f-377c-d440-8156dfe20b7b@fb.com>
In-Reply-To: <9d195192-551f-377c-d440-8156dfe20b7b@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 15 Dec 2019 22:18:45 -0800
Message-ID: <CAADnVQJYnt4WKMV8hDKAhf3w6Ju0Th3qVJCkbLFOnYPdnQe+pw@mail.gmail.com>
Subject: Re: [PATCH] kernel: bpf: add __release sparse annotation
To:     Yonghong Song <yhs@fb.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "bokun.feng@gmail.com" <bokun.feng@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 10:17 PM Yonghong Song <yhs@fb.com> wrote:
>
> Resend due to incorrect bpf vger email address in the original email.

This patch is not in patchworks. Cannot be reviewed/applied.
