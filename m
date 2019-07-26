Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E422C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D427D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155525;
	bh=vpI377tMKt8Npf0oXb9cYqBG4QChhMr9APg4179q2Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIlcjemL76mHBhmnYQtjhe574qHts74Ni3EaaXy3cgnyMgt1ORMrYQ+RsSn5hILdp
	 pK79N1GOIy51sxGC3N+tnLiuWLy50zd0czUMSVzbaWMwVqwrLiopyYqMPyoA3X5O9e
	 uQ45p8sO68wMxkkgrdywSqFEze5Ok0EAreRRDdnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbfGZPio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfGZP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:27:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D717205F4;
        Fri, 26 Jul 2019 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154856;
        bh=vpI377tMKt8Npf0oXb9cYqBG4QChhMr9APg4179q2Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIVHDFBeLwOVIb8UpaRTtTVnZcGOAh/gvPPHqUosi7lTTU+n7l5IjSbcJu+U3yhCr
         qe3DzEjn6NbGkuHUAhdXHs6zPC48WYp6fi/EpO2stL+WoH8WamAPMTmqFih4185Uce
         AlCJ0sDZ3Mo64PdlQynbsUQMZNJXZHD4mwLGrTW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5.2 50/66] gpiolib: of: fix a memory leak in of_gpio_flags_quirks()
Date:   Fri, 26 Jul 2019 17:24:49 +0200
Message-Id: <20190726152307.347871773@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

commit 89fea04c85e85f21ef4937611055abce82330d48 upstream.

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a break from the middle of the loop, there is no put, thus
causing a memory leak. Hence add an of_node_put before the break.
Issue found with Coccinelle.

Cc: <stable@vger.kernel.org>
Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
[Bartosz: tweaked the commit message]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib-of.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -154,6 +154,7 @@ static void of_gpio_flags_quirks(struct
 							of_node_full_name(child));
 					*flags |= OF_GPIO_ACTIVE_LOW;
 				}
+				of_node_put(child);
 				break;
 			}
 		}


