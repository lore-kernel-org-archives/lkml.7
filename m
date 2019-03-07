Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E2120835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCGJct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:32:49 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:32:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mdva2-1gU8nl1vuQ-00b3n2; Thu, 07 Mar 2019 10:32:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: isdnloop: fix pointer dereference bug
Date:   Thu,  7 Mar 2019 10:32:07 +0100
Message-Id: <20190307093241.3380715-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SgTeDUmCb4KFlphK0yPBLuw2NW6S032Tn10HjVm7TU0Czb6EpYa
 eRYVPB0/X6ZkfbzCWEXtFHhAGF4ttjsX54MPpkY0asX0xZBt1PLHacdMoVns5haU0tnQMe/
 qjQCVtT/gaJ6u5ZSh7eEa8hPpZ3jcvF+24HzToq9iSx0Vd4sv9FQ4U2fJ+oeDkBiYPr9bWl
 ATQ8CRZIe0gfrue85Dl/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xHhHN6Ai/kw=:xI/ns8pM133uhDonbRMncj
 Hk7sn8MB6WzkS5LlNHX72iouVZxeXHpQBCKlI5mqe+Yh5Eru/2hkGY7TZw+e1jMQ6GMp3zCuT
 TonvZdVPfYJ0dw9tLbeVqmUosaqY7J8znfww5hxsQ3L6iQqKzYJ8m6T25JylcUe158OlT29Dg
 1NNN9I6o3HQGQdYoq4v0iMtzo80EjkoJsnvDISpRyRQpXmS6GgCbITmx6xXTSMbK+/MdQkYra
 9LxwV/1W/36T/UEzPmGuvHGEspMl9P/lFwO/E7RqSDG+bOj2CHj/M791OfcdZ8whXsXYzEtFu
 EftV3QrasQO1fPsmqt3dav6CJ3SqlltXRQUuYJAH658KH6+8UROWLCR7RFUIqsHuGIoBjjyLe
 2dIS5Gr059KPQQsTaDZGcCHU2uEg1+w6kgjk/JeuUDpCS6OH9UVXw0/St6h6m0vMASvj9BCC+
 pCDjJ0sEF+z8sOW4B0T6EoCdUAy8cryXA0dtt0gH6ItNe03+UPvC4zqbRcifRqQg0UgWvvuue
 BeyqAMobRpWw7J8A9sus3U9PtJSCcEouI0aIE0vqvz68kxYNU65cu5h+a+oed32OJBOWgIiM4
 0YYdS2Ad9UGWcOEkmptvMlvlAtAWmnV/NDQRCZN13hdnutyQ3Qh/rwGOX8zOVDn4RG8lJO7MK
 wvWD4DpspeKTHgiOIYOz50mKP1hPBE7YWgWJ81vb9sYpW1bdaGpIE18ZyOTKKH6M5JrfHjNPo
 80PQXI8qU41f92QjwMrM74Xv5LkQGP2RSICypw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang has spotted an ancient code bug and warns about it with:

drivers/isdn/isdnloop/isdnloop.c:573:12: error: address of array 'card->rcard' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]

This is an array of pointers, so we should check if a specific
pointer exists in the array before using it, not whether the
array itself exists.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/isdn/isdnloop/isdnloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/isdnloop/isdnloop.c b/drivers/isdn/isdnloop/isdnloop.c
index f4253d468ae1..755c6bbc9553 100644
--- a/drivers/isdn/isdnloop/isdnloop.c
+++ b/drivers/isdn/isdnloop/isdnloop.c
@@ -570,7 +570,7 @@ isdnloop_atimeout(isdnloop_card *card, int ch)
 	char buf[60];
 
 	spin_lock_irqsave(&card->isdnloop_lock, flags);
-	if (card->rcard) {
+	if (card->rcard[ch]) {
 		isdnloop_fake(card->rcard[ch], "DDIS_I", card->rch[ch] + 1);
 		card->rcard[ch]->rcard[card->rch[ch]] = NULL;
 		card->rcard[ch] = NULL;
-- 
2.20.0

