Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC120830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nbj5ObLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCDWLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:11:01 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:34777 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:11:00 -0500
Received: by mail-io1-f42.google.com with SMTP id e1so5307811iok.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vj49IZmp1GrMY1xTUuQD9hq4RsIb2liKzZRRfy2CemA=;
        b=Nbj5ObLWXYNVo6Hp3tJm7ii+yuZsP68jytnydqgfDdBl07K9iHRa7a4EX7EJne4Wfo
         Q1K7PV7cWgKFi3UCLJc3RZIK43tPJbZxpslt151hqYk2lykff15TjqP2loLu7H/FFxfw
         nGuuVGJuqNEjIUfV9CvwoO0ce5q/JvCm0IqJzmFIqi8ejFaY6Qt6M9uc8nBtMs81gd3b
         VH65fm0dYVolbqvJPgVu9/nWOSIZmRhfZbvSZxgUcdGCw3UqsVB8pd1IAbBhfVi0OwX2
         tletcFGKc0CQFKY755YyQVIKzH4ZQPFq/eokga0XGJoqUSp6rYo70BZlatNHtdad1WQZ
         Beng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj49IZmp1GrMY1xTUuQD9hq4RsIb2liKzZRRfy2CemA=;
        b=fCnkxVw+7hjzOKKXYc6UfYf7XRjlphnOA1g15QkbkYvKMZAwjCT4TlpSAoEzcFYLuA
         7jfq4OsyZBV1j8XBUZWQimVP8oCVVNawcPmHDGHBRx/g+XvuQs/3CL4U4V0JTm/wNcKW
         OcGI9QESLrXXKPGWEBVvCto1+gGWWl+FgEkW100XWIVtf6voq/BtePTvc9PX0dmcQ02V
         NM+wcmatr2XOSpbeWKGrHtUwoJrp1+VlXY3sdy32udHgGScAoj2PerbqaB6jEt6fFgJU
         NwxvncAYYlQFlY0fXtPgGXQY886xqsOHNyctpnNGvvN65zJR05LDd324848AMlIlN+uC
         OYlA==
X-Gm-Message-State: APjAAAU6MjdEKLkl31KaXJEZNCMiDsZmidfFILaI6oQkIstrNZRAb5KH
        tyNXnrdSWHUDzWSx4/WCHdPD3ViTfNnmrodHuLv2Dw==
X-Google-Smtp-Source: APXvYqwQrbFA5IlzK79qgPvlqYG+LyP4Ti+jgRCZ0sxsPgNpfnqXCIA2fvjkbvGSlTf7XawzfrnDhBbL038Gk9J0IaI=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr11205078iol.88.1551737459461;
 Mon, 04 Mar 2019 14:10:59 -0800 (PST)
MIME-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 4 Mar 2019 14:10:48 -0800
Message-ID: <CACdnJut3ix5nGOZ94KjxXPTdLWL1myi8rZcBv+0H3Gg2kAA5yg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Lock down patches
To:     jmorris@namei.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Based on feedback, I'm going to make a couple of small changes to this
patchset and then resend.
