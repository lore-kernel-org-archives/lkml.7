Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00243CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6CE2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsjCf30h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfJUUmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:42:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39839 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:42:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so9148488pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dig8hdQP+17/31CFzOwaIuMHB4qUzCLfhXXtm0K40Bg=;
        b=FsjCf30hm46/hf+wWqqaCmrf7jxwA/VEqlr8sVdQAvAzwRe8UdIHTrqS5pjH3dgDHi
         sQRN7l7EnSibBhzLxAtTnelIKQiOiAO7EA9QA2/5o41iuvu+kuvzansSkZnPQ6TaR42l
         e0zeYipF1Hch72bXMPErx7Ebt2jMeshmRdBezYOcYh167TCfaNGPAujD6b7bzkSnDgKG
         YprcoxNMQSYcE2D6y6nMfUGgNxfs8qhXvozxfSdnlNiFk3Qx0XAn7sgXZcqT6TuHY92x
         WzQTJoFy1710df9IOATyEy/35iv9/NwJKKnq0KWTBMJW229EYCVAQc4xfmVMS+2qo8/6
         gHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dig8hdQP+17/31CFzOwaIuMHB4qUzCLfhXXtm0K40Bg=;
        b=Ru9V0T/BIDiZiA2mQge8heUJ5NmDNItxVOts9BTUr1nqL4D+q2eE360fC+/hbouYzJ
         rBFCfbQW5x9GKvTfsVWAvvVs9U6V/W0/OPj7uPY3G5U6fJyb/QiQICVrI6knRONGyhOQ
         WD2+GYb3sV4MwTyP/j7KQ4Hts7Z5SJ4VSaeo6zKtVt3ojqZBn8vq0fwLjlGKC9LJJxy3
         bISarJH8P5yT2sDH+tr5BJP2tMCng6fBWoTQ3IYy1Fk/An0QR+OUaInb7KvTLUkKEJYt
         njOWfU3zyfDC/vnmsiQSx5EUfNSEuZ8FdPFxY+imwnsfMSUZS5j2/GO96adYez3e1V4t
         mm8A==
X-Gm-Message-State: APjAAAXkurUogyngKAZp3qmlllyBvEs0/M1fS1JphAbaTw+2CtjCAc2J
        8waeKn3RBZKfsRqbu124/AryqqDwN9VNkWSsuWOq7g==
X-Google-Smtp-Source: APXvYqyTxGxTMYReALtQQX2SRQEQ0VWKxnlAX3pimCeKchW+U3If50SgaWjOTYOyFi48WxvzBlC84JH9lqSNiAZeAM8=
X-Received: by 2002:a62:28b:: with SMTP id 133mr24613316pfc.242.1571690523011;
 Mon, 21 Oct 2019 13:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com> <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
In-Reply-To: <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 21 Oct 2019 13:41:51 -0700
Message-ID: <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 2:13 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hi, Steven
>
> Any reviews for V3? I've addressed your concern about Kconfig.
>

Ping..
