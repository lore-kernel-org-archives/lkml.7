Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E1B21925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138524;
	bh=5OcE3JTx9uBHk7WR/W0LyqH4pdz4aTHZg5YrrGJ7DYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jdt5MEUJJDPIz8lhDx2aU1Aspw03iARQpNvnKWwgoC8hbRJWHmR6WOHn7VfzaqsIP
	 yH6qem+hZzjQlwDQxQeSbtKEUrIXXOtBf0YR/J1jp5NSZiTxvxK1Ec1K0IX5+e7wpr
	 wqTvD+zJgGgHhPtf7/vwZ9O3RWJKQhxlobtUSnuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfDARIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbfDARIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F352192B;
        Mon,  1 Apr 2019 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138521;
        bh=5OcE3JTx9uBHk7WR/W0LyqH4pdz4aTHZg5YrrGJ7DYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pslp11ii6qsYog/JyLSBjXEZuaKNgWc2D/RzNkCOmMeCqfBwitsIzwuSys1TxokRn
         4m4CNC7os0385si1yxvszcImOwRQ87IH9ootMG5+yvxMh+BykEKDOmKJQxdcD5Olzg
         1SKIWMHS46IHXeGClRGbAQC8w0sbPp3fT6B82Bhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.0 083/146] staging: olpc_dcon_xo_1: add missing const qualifier
Date:   Mon,  1 Apr 2019 19:01:35 +0200
Message-Id: <20190401170055.875738511@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ae0a6d2017f733781dcc938a471ccc2d05f9bee6 upstream.

gcc noticed a mismatch between the type qualifiers after a recent
cleanup:

drivers/staging/olpc_dcon/olpc_dcon_xo_1.c: In function 'dcon_init_xo_1':
drivers/staging/olpc_dcon/olpc_dcon_xo_1.c:48:26: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

Add the 'const' keyword that should have been there all along.

Fixes: 2159fb372929 ("staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio descriptor interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -45,7 +45,7 @@ static int dcon_init_xo_1(struct dcon_pr
 {
 	unsigned char lob;
 	int ret, i;
-	struct dcon_gpio *pin = &gpios_asis[0];
+	const struct dcon_gpio *pin = &gpios_asis[0];
 
 	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
 		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,


