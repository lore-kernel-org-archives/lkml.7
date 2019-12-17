Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E01BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BFB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576571103;
	bh=bZFigZLvzDu1g+N6Jc7cJNMSgtBaJrpe7C/fnRca+dE=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=K0o+2NVbHCX9QIJBLO5geaGemKaoeH9mZJEBH/8fntbbEfBEdbWaxqBUHlyweUa+6
	 9iXPWlPdbG9DeSJiNqFx5Jn+MHDbrgAfuqMADN0RgAZnYkSmWJLnjlekGqDonQSH80
	 d5WO2T/0cqT9O8fxD0u21AGrdypzRleIX8EhFPQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLQIZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfLQIZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:25:02 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424892072D;
        Tue, 17 Dec 2019 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576571101;
        bh=bZFigZLvzDu1g+N6Jc7cJNMSgtBaJrpe7C/fnRca+dE=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=PDxbQ6NoBkf49Li2REiyNLweDfeWSx7ggVzm+kPmnIfRf8cfwcaImBm0FWY3ZiWKI
         VhdNZ8HfBv6A0FhPohejXie2oyGQ4cy6khQp1KUoEQJS1uzzJ95bfb7yH+KvnHc4GG
         zu7oBtys2Q9zjsgW8jftVDK75OrQW6X5KgktxYYc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191217044635.127912-1-olof@lixom.net>
References: <20191217044146.127200-1-olof@lixom.net> <20191217044635.127912-1-olof@lixom.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Olof Johansson <olof@lixom.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: declare clk_core_reparent_orphans() inline
User-Agent: alot/0.8.1
Date:   Tue, 17 Dec 2019 00:25:00 -0800
Message-Id: <20191217082501.424892072D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Olof Johansson (2019-12-16 20:46:35)
> A recent addition exposed a helper that is only used for
> CONFIG_OF. Instead of figuring out best place to have it in the order
> of various functions, just declare it as explicitly inline, and the
> compiler will happily handle it without warning.
>=20
> (Also fixup of a single stray empty line while I was looking at the code)
>=20
> Fixes: 66d9506440bb ("clk: walk orphan list on clock provider registratio=
n")
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>=20
> v3: ACTUALLY amend this time. Sigh. Time to go home.
>=20

Isn't it simple enough to just move the function down to CONFIG_OF in
drivers/clk/clk.c?

----8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae2795b30e06..6a11239ccde3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3277,13 +3277,6 @@ static void clk_core_reparent_orphans_nolock(void)
 	}
 }
=20
-static void clk_core_reparent_orphans(void)
-{
-	clk_prepare_lock();
-	clk_core_reparent_orphans_nolock();
-	clk_prepare_unlock();
-}
-
 /**
  * __clk_core_init - initialize the data structures in a struct clk_core
  * @core:	clk_core being initialized
@@ -4193,6 +4186,13 @@ int clk_notifier_unregister(struct clk *clk, struct =
notifier_block *nb)
 EXPORT_SYMBOL_GPL(clk_notifier_unregister);
=20
 #ifdef CONFIG_OF
+static void clk_core_reparent_orphans(void)
+{
+	clk_prepare_lock();
+	clk_core_reparent_orphans_nolock();
+	clk_prepare_unlock();
+}
+
 /**
  * struct of_clk_provider - Clock provider registration structure
  * @link: Entry in global list of clock providers
