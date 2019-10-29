Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D3320856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="reO02uSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfJ2NNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:13:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17799 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbfJ2NNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:13:22 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x9TDD9H7008016
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 22:13:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x9TDD9H7008016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572354790;
        bh=DFJCAzizH4g10ADI9Rn27rAUxoPMKfPEwBoru1VHVxA=;
        h=From:Date:Subject:To:Cc:From;
        b=reO02uSbAHEiFpcpuoY5UJNhpn0kLh5Dj2QO71BSTK3k3pwXlQDuuAtgPWtz3zNIH
         NfPDCNagWGZDJY7oPXPs/Ps/0Pe/9cNig5HWLYrnpFiCtrm8o3GvrAT0ia1hlY9INT
         MvuDMWB4G82zqXlOGIX8Ism57sfinIjk5fYGTDVh7Fh5gosTU+HyPx4Au2c+g6lSal
         MNL6df8Hg+gKRg/3lAoTGrRZVUjMTMHQBuYEurTE2BvV4T95XenPDXPxgUliKdu//2
         XuCoraRjAn5byjZm3heDx9pTKoAEr5L+HIIaGnjJO8SuCAE+4mGgkxEE5OBbOS+Wua
         hMacoe4lqPsIQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id g14so2846820vkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:13:09 -0700 (PDT)
X-Gm-Message-State: APjAAAVJN7WFDAZlcBail+dSFwJmgpVXv510dG+rYUnJ9ZyBjz/Ijj8Z
        ZKbfIp6RoULmSDLi0y6YDOowzegJhzpJH+jO22U=
X-Google-Smtp-Source: APXvYqwSk5zozYtnYOUFkJt9J/Q7e7F+pJLQ82qQ4jKDaoYaSEYkYBruilGg08QiiaIIzCBMAtQodOEwwSp+lok8Esw=
X-Received: by 2002:a1f:4b05:: with SMTP id y5mr11132787vka.12.1572354788616;
 Tue, 29 Oct 2019 06:13:08 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 22:12:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Message-ID: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Subject: Warning message from 'make nsdeps' when namespace is lower cases
To:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I was playing with 'make nsdeps',
I saw a new warning.

If I rename USB_STORAGE to usb_storage,
I see 'warning: line 15: should usb_storage be a metavariable?'
Why? I think it comes from spatch.
It should be technically OK to use either upper or lower cases
for the namespace name.


Just apply the following, and try 'make nsdeps'.


diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index 46635fa4a340..6f817d65c26b 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -8,7 +8,7 @@

 ccflags-y := -I $(srctree)/drivers/scsi

-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage

 obj-$(CONFIG_USB_UAS)          += uas.o
 obj-$(CONFIG_USB_STORAGE)      += usb-storage.o










-- 
Best Regards
Masahiro Yamada
