Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F2AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3642070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cXYZ/yJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfJHJrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:47:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38023 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:47:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id u186so16047505qkc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qLgfnJa8TF+fqJn6Csm2aNbaRpOd4zDzxzOPf12HbGU=;
        b=cXYZ/yJKZHxhLdFc+J/7aqzW3aWMwrEzbFfkVK6b2STx6QHscvIWH7imnBEe4+5hu8
         /u0EZHWjyQPT1nvtbEF/Q0Kg9i/YqCDMse7zLQQlF9qvnZzDAYO5lv25xZR6t9BXHcuq
         ah+dWBDMRgaikW+rvVfyvyISzE+jZZi8EytVeEJcb33yP6AZXWRPX4ij4dNNh6n//HA4
         ZeX5K7IRgHSrqr/EWrbf7Id2OL3sA+Y9zt+wp0c875bq5Eka/sHOIgqCnKbwSuEhZiRH
         Ywn2sJjbAl32mBITdW2nABbm8slhsaxFggyDU0O6KlXeMgbBlIYIBTgAtq0NFFUY9INh
         Kx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qLgfnJa8TF+fqJn6Csm2aNbaRpOd4zDzxzOPf12HbGU=;
        b=tQSz0dNOI5q/EczKBJDk0T5Yzrg7UGYKZI0v9lkAjuAY6qTAZQZLmrYD7ThSEK07bY
         2ADQfFRVa/Xkt6ZrYbOIGE5fSU5vIEH0kakxgP2Q3yd+coI8YSt8pE4BRDh5W9lTpRfh
         tPXWY/lyPYoiH9G3Bx79G0cVtaQ0YBkAyIZS+IAtGNzhkVGY8rBCSKVvp75ZW4KNhtPJ
         ngnMmoYbwiOC55FZg9dxTrn+K9Zo7aZtfTZKFU/9TjVPMi9NNXkudiEYKlM/40djUodC
         Y5xXJgPppXeCgm0UHjypPBzqlL3aDs4gKxl3m2pCLmbJk7e4c3WLDAskywAHDnjLvKik
         N4Cg==
X-Gm-Message-State: APjAAAXglB3c09VIEQLN8lr41/+nDc/OVZX21eRLxtF4jwZQuJBMgUv4
        AM2dQ/P3zG4UyCfk7cyKgyymGQ==
X-Google-Smtp-Source: APXvYqxfD11gEiq1MLqW9BfGOXUQNepLHs6yxjwdSPwZov/5cEt3QgQYUXTBcN37CEYZ7nm6dUXSjQ==
X-Received: by 2002:a37:4d4a:: with SMTP id a71mr28591867qkb.327.1570528051524;
        Tue, 08 Oct 2019 02:47:31 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h68sm8988573qkd.35.2019.10.08.02.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 02:47:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy with CONFIG_KASAN_GENERIC=y
Date:   Tue, 8 Oct 2019 05:47:30 -0400
Message-Id: <B53A3CC0-CEA6-4E1C-BC38-19315D949F38@lca.pw>
References: <1570515358.4686.97.camel@mtksdccf07>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
In-Reply-To: <1570515358.4686.97.camel@mtksdccf07>
To:     Walter Wu <walter-zh.wu@mediatek.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2019, at 2:16 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>=20
> It is an undefined behavior to pass a negative numbers to
>    memset()/memcpy()/memmove(), so need to be detected by KASAN.

Why can=E2=80=99t this be detected by UBSAN?=
