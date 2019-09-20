Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B387C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ADB208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbfITPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:44:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37981 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbfITPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:44:36 -0400
Received: from gandi.net (lmontsouris-657-1-214-187.w90-63.abo.wanadoo.fr [90.63.246.187])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 51A0A240008;
        Fri, 20 Sep 2019 15:44:34 +0000 (UTC)
Date:   Fri, 20 Sep 2019 17:44:34 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
Message-ID: <20190920154434.GA923@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
trying to "cryptsetup open" a volume. I found out that it was only
happening when I disabled CONFIG_CRYPTO_AUTHENC.

drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?

-- 
Thibaut Sautereau
CLIP OS developer
