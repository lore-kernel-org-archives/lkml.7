Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869EC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7746D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2W69+bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAFHeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:34:37 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48591 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAFHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:34:37 -0500
Received: by mail-qk1-f202.google.com with SMTP id d1so6806160qkk.15
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQuut/X/n4tj8+mFTwoLLA+4SmHaEnPrhwV00PJc3JE=;
        b=G2W69+bt7ri9aBBIUO5TrD0dCvZaGADY6sf5X0OO2PtW2ov2MwhsLM8r0NaXWQ2UB+
         kDHIn101OYCbCytSGJhlVuuace7KdkLwG/CSlktcMZrKtIgu/AthjuXKsAuXbQIjS9VU
         F1J0PWyZsAbO793m6K9TF+eTO47fjkoVhBZPKorywrxgZncdzgz5R8mJnqusA/J1Q53X
         tA5cRfw9OAaYSaBXRqH1S7bjnM0Xsk8SZNJ8orjSDpqxKjVzMsdOwmUYvW9eSXYwJcwx
         WseBEa9Bx1+BFWzO6iS5HLBpyTKRi1rUkkllfk9yt90f7SlSbxSpYJt1GyWw2Wf96vTR
         O7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQuut/X/n4tj8+mFTwoLLA+4SmHaEnPrhwV00PJc3JE=;
        b=dW4lBXt59kGsrNwFK5P9q7ShKQS2MIgBTKA0ktdNK0xEKl3+J03w4AVE+BmXKiaLD0
         T0Za20W+kDj/O7SD+KkpVxpQIZj0+bbjyJl+97NdCAGcF9QA6fLlN7InfbYaKG2QncQx
         dpZmWD8hd4P/CDdFFMsB+os2rLcQLxn2lOjxk7F+NlBT7LOPMp4Ma31iX56gYi0ofihX
         DHWxGbADbEEGWvRgrXy97Ro9exp3TdLFNS1FR/lmc9BlwPsknLDtRekeLNdzd1Iy0/kS
         3QI/SYEi9Ly1v4u+o2VogXS0U0+MLZw7mgUxMtmQfBan+rT1EPHGvCpDJdLoJmi3JXBn
         8E/w==
X-Gm-Message-State: APjAAAUzaelhPBz64LM+9eOb/90NNZIDw/2JECjkP9flelBlUlQaLoiW
        MGKw50wsA3XzA4xKzVeFbgp+Ir1oya5L
X-Google-Smtp-Source: APXvYqwZk96azg+wSnBjPpdVcomn4j/TgWjL9PPZ6ewHrda792uhgGbb4+PaOi2lhAuZEybajJl1bYRSiXrG
X-Received: by 2002:ac8:440b:: with SMTP id j11mr75206754qtn.283.1578296075872;
 Sun, 05 Jan 2020 23:34:35 -0800 (PST)
Date:   Sun, 05 Jan 2020 23:34:33 -0800
In-Reply-To: <20200104150238.19834-4-masahiroy@kernel.org>
Message-Id: <xr93imlp6nsm.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-4-masahiroy@kernel.org>
Subject: Re: [PATCH v2 03/13] gen_initramfs_list.sh: fix the tool name in the comment
From:   Greg Thelen <gthelen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> There is no tool named "gen_initramfs". The correct name is
> "gen_init_cpio".
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Greg Thelen <gthelen@google.com>
