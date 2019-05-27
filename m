Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF2C28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545FA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE0Euh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:50:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Euh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:50:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7ECF91481AD14;
        Sun, 26 May 2019 21:50:36 -0700 (PDT)
Date:   Sun, 26 May 2019 21:50:35 -0700 (PDT)
Message-Id: <20190526.215035.1766035827093417237.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: tulip: de4x5: Drop redundant MODULE_DEVICE_TABLE()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <201905241318.229430E@keescook>
References: <201905241318.229430E@keescook>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 26 May 2019 21:50:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri, 24 May 2019 13:20:19 -0700

> Building with Clang reports the redundant use of MODULE_DEVICE_TABLE():
> 
> drivers/net/ethernet/dec/tulip/de4x5.c:2110:1: error: redefinition of '__mod_eisa__de4x5_eisa_ids_device_table'
> MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
> ^
> ./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
> extern typeof(name) __mod_##type##__##name##_device_table               \
>                     ^
> <scratch space>:90:1: note: expanded from here
> __mod_eisa__de4x5_eisa_ids_device_table
> ^
> drivers/net/ethernet/dec/tulip/de4x5.c:2100:1: note: previous definition is here
> MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
> ^
> ./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
> extern typeof(name) __mod_##type##__##name##_device_table               \
>                     ^
> <scratch space>:85:1: note: expanded from here
> __mod_eisa__de4x5_eisa_ids_device_table
> ^
> 
> This drops the one further from the table definition to match the common
> use of MODULE_DEVICE_TABLE().
> 
> Fixes: 07563c711fbc ("EISA bus MODALIAS attributes support")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
