Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7C7C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C32073C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkFMC3mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfLAQww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:52:52 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:41250 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLAQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:52:52 -0500
Received: by mail-ua1-f54.google.com with SMTP id f7so5281368uaa.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YZolA5TOydgjZXG0zKvKtYGWqcUHrYRyJA0cZJuzTsU=;
        b=nkFMC3mOSVeM1tJqapo8Ii2kmRG69RCwNwySwu1zzl7Ny/OUkm5a0CncRZpXvKHdFl
         3HQ2Tr9/oMVC8AkzNQ2AUXF+hfEpWmHX9tszRRKwI8oPf04E0/5a4rEmo9djcP8MNY7A
         U5UhlOlFp6Uo2tGFDGwOa7BHLFXN3rrlXqDrZ92n4a9zbT7r5BmUt0U7pJ8LpfkrVc5g
         E+Ok3pV7RNE6V4EsEySbz3bDAcQiLpONHqknekLBZRZFY4WSNugwsb1Lb6fze8BkZ0s8
         MeQfxAnvmO4Ycbp/5bgvV8CSz8nTEGAWMmTlDTZbdZxsNDJkaGPZxVJmBXpN6nrkSUVE
         ngbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YZolA5TOydgjZXG0zKvKtYGWqcUHrYRyJA0cZJuzTsU=;
        b=Ha6p3mbZDMVfz3J7kDICI+WyeWsvAH2ERWYQ3+HURvPhr5xEN7plu9OSmWMKas8f2I
         ZapZc7ss3Vbi9Ntsx1IRuc/bOaHPWLgPYKRNs2xXyE2B7S8FCzbigWah01cHOsHkbtlh
         nKOKv3c22qFzox6B7jYhR7Ao2SOeXNE8RM0r2a+iUsq3ZLyHVMc8k1woMqDAEtaWu0kz
         fL+6aI0ZmWRvQH30vDuZir9Amjzv5nlpZuWEeN09DpmnjdwUDWwuLTNXk9ZhLy+JNCjB
         LszRsWabJ996jYQIgBKgj6BLBm7HjsSLMiIdks7I+pabsg5I1SImqtcCn4vINUG/a84a
         KXew==
X-Gm-Message-State: APjAAAXjMRW7tzbdRM137pWAeGV2Hx50zlzinQpQ0R89vVO4aZgplww/
        quI9yZuTMBs6mYr297HLK7qnGS3LiTFDc6/NQRD0ow==
X-Google-Smtp-Source: APXvYqyVBpl/uLmcT61jwn06Tx0D0a8PZZmFu/CGJyZcTWNxbqhpovEQ8v1m8VL3Ieru4qtAN7HnHAQA+BHAywtFYAE=
X-Received: by 2002:a9f:3ecc:: with SMTP id n12mr15598319uaj.45.1575219170438;
 Sun, 01 Dec 2019 08:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20191201161542.69535-1-dwlsalmeida@gmail.com> <20191201161542.69535-5-dwlsalmeida@gmail.com>
 <CAFzckaFfmVYV_baqV9bHrnguXfOKs42DJ2VgA4C1y2Ey-+99xQ@mail.gmail.com>
In-Reply-To: <CAFzckaFfmVYV_baqV9bHrnguXfOKs42DJ2VgA4C1y2Ey-+99xQ@mail.gmail.com>
From:   Amit Choudhary <amitchoudhary2305@gmail.com>
Date:   Sun, 1 Dec 2019 22:22:14 +0530
Message-ID: <CAFzckaGYZUac5JkwXtcdbZHtUgQyv_7oiHivi32ggYLR=9oT_w@mail.gmail.com>
Subject: Fwd: [PATCH 4/6] media: dvb_dummy_fe: Fix long lines
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
>
> +                                            u16 *strength)


In my opinion, the arguments on new line should be just below the
start of arguments on top line. Like this:
+static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
+
u16 *strength)



> +               .caps = FE_CAN_FEC_1_2 |
> +                       FE_CAN_FEC_2_3 |


Similarly, here too and other places too:
+               .caps = FE_CAN_FEC_1_2 |
+                           FE_CAN_FEC_2_3 |

Regards,
Amit
