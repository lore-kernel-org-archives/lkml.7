Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336FEC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 01:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074FF206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 01:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx9/DkZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLZBYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 20:24:47 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:42106 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLZBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 20:24:46 -0500
Received: by mail-il1-f176.google.com with SMTP id t2so3835470ilq.9;
        Wed, 25 Dec 2019 17:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3yExkyYf6AESriKTXJcACWF6QhUwoYQa3Qvzxjf6dE=;
        b=mx9/DkZH/xrpgTDi5fDyajlPr3ZqGZ1YCq8++8GarrixDwcOmKMarBlLP7okJYj/9A
         EcmlL9Mkeo1sex07iFkM0ElQTxF191tH2WsJOo0iQ0liO3d7G3xDbAeH6E8dvNCaiA/1
         TMTj3j8vvB5Jpk4psMrEI8YgIppujPTIwbyiqvo5Q0ppvTBCvoGgD+9s2QiHsoYPGZEd
         5kTUJ8H+Nk/TEev4bAEqvpTu0jAaSD0Ops0ArSo1d2N+HKDhvSx42WQbnkIZocGRlRnx
         reyebFPk383hIuS1IeQtITWPEoT3Fa6R+oVC4BLrFcABtgHrt6CbjVnOYFHuhvFxNpN/
         JTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3yExkyYf6AESriKTXJcACWF6QhUwoYQa3Qvzxjf6dE=;
        b=VnIXBTxthh1kmRcKPylj6FotzRlCnfO5BH85/OQXPn0krP8ihMfzqRInK4970+AY4u
         LK6Db6wFwSEW+7O3f5ANlww51gubdUN6fxDW/wB3MS3891uxk0N18HbcQ1UJvaeVaXRn
         ZX7fGL6ITCrNriNUTCVCPJvgUZ5GTdmg0l5sgdz/7xFew1+gP0/o0u/81Scn1srNxNIj
         v95S2rThICbkSvbMY0xDbi1PhZkcTbqcBGwdOgFNCMC/KDooYsy24alNPCvgCB2JBgcI
         sa8itoBPKufXSh4hGmMcQuHuqZy+mWvpy1L+QzMcuZcZvyhF7Ds72+kAjNOGgpD9esqr
         06wA==
X-Gm-Message-State: APjAAAVASeZ/e6HS+oRFgNLm1iixugMMp3G0dQIJmwRnKVlXAtT7Eow8
        cHArhRdPHWoY2MwnDQwgS5VYuXlE3CQSqSVlsXw=
X-Google-Smtp-Source: APXvYqx98UNNAob773r6Ac+yM8P9GornmaYZmT5aug84ibVLD7iMI0T1aiL3GQDclD9nllF4eprKp6MU+H4kEex6exo=
X-Received: by 2002:a92:601:: with SMTP id x1mr34241177ilg.35.1577323486078;
 Wed, 25 Dec 2019 17:24:46 -0800 (PST)
MIME-Version: 1.0
References: <1573478985-3535-1-git-send-email-yangtiezhu@loongson.cn> <a45b4f64-6685-c0d8-da81-5536246be2c4@loongson.cn>
In-Reply-To: <a45b4f64-6685-c0d8-da81-5536246be2c4@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 26 Dec 2019 09:29:35 +0800
Message-ID: <CAAhV-H4EYpMAB1twRXWQaQuUPkys7K1jTs1vzAK5nYL+uiE4PQ@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Scan the DMI system information
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jean Delvare <jdelvare@suse.com>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>, yangyinglu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhc@lemote.com>

Huacai

On Tue, Dec 17, 2019 at 12:11 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Ping,
>
> Any problem in this patch?
>
> Thanks,
>
> Tiezhu Yang
>
