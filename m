Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B32AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A9217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sTxpZnPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfH0IXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:23:51 -0400
Received: from mout.web.de ([212.227.17.11]:41107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfH0IXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566894216;
        bh=EOdG8Jg0bjYCtLktuVJDbrUxViSF+xEWa2XtDYURb5A=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=sTxpZnPTX8/7gHKAGQe4WOKJo1P27D3gYAqv3viSy768z/e6Ii5sAnCFg/gdQszQQ
         tzkMzgBSmVkcK76z2OBG0QDWuf+6dWGmy5dL0ccmUxJ5upnDZPKuR1d4yGytpPYd12
         I3OUIZuC2e/INzYm/XiQZMcHm0niuVvVAY1DkiU0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.232]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPaA-1i34zd3bAQ-000fCi; Tue, 27
 Aug 2019 10:23:36 +0200
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <lkml@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] powerpc/82xx: Adjustments for pq2ads_pci_init_irq()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Date:   Tue, 27 Aug 2019 10:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FWPP7FnuP0R0YkBDMtPwXcV+dkmywBeiHniH8l8wNxIKIYzA2VH
 mGaZbaqheDKQWXTxTf0APXFrL/TOvCW8LtjeGIkoGh7Zd3rMCSaxC4N51eBKxDAjml7aRMw
 4M+YOa3AISg6vixPub+WGvxOxAKc40HgJsa3aiqOgMRuaYHaKZzDnJlYk+CwWrEonowb5Ga
 StBBa1O9YSLzYjPfZ9laQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nLDhNZ+302c=:7EAJy3DTm+DleBPFApAPXV
 s/zlqX/7KAH3yAJOprL80VhwqT3TihIdTmCwNeOM/dI5Y1ItvUUgCgj5y+i4IeKUaalvq6wfJ
 iU0tz5MhFWCYGgcb14+IiFQmYU6LBNgkY0UEAvzrgsAAFS9icfcK530MJKOae0OYiPxjixzSb
 FCHgpMr7A3XSTiG0rY0YgKOAjmkSFESUCMhbXd0Zy3UeaVLh1NC04bjFYCiDSrwi1jK4KbBEP
 rB0RZyq0cIH654dxulraTl3IXMj/5K0X3UnyDtxd53CEXQng7xTI16EnXwxgFZlvfoVFqmSDx
 Q2AEOkIBNLXwsjOU2lZ0tzuf+vgEI8tH+/qU0CvvdSSPLW0PoOgRy0bSJRm9HckC3UY43paDA
 72Sl/373wXhYf39SRBgd7cxY9X6/vx5lYTqfJUogze7pLRobfunqKkGnsMt/ygn2VtAZVuMqk
 cpD5yJvMO+cSQ0Gga409tJXeIdP0yAcEULV//EQ/W6BOx6UA/0b408PPCjav8t2zXNIEobH5F
 6heHIU0NmvCiIQeK27GjSoAtfJCRDlWwwk8BBGLPFinHMB/8us2i857RU/cLAcdzALbUxMUkX
 tV8huOq0QeR5isMfYVtcAb4l40DIq51n6SiotVmn0O9Bqn3kWlVCFV+VkDWFFUKVerz6AQYAf
 Dr5W1MLoH5DVYQSrjgb+T6bfKBjOXpVqkM+yUTa8oZ7w4x9hGUd66EvHiciNaOh1wxmx7SSFN
 iz/P/VdU3n46GY4TpzytPEWu02AUlRudwhuZulggzGlYTZ9FFBgmZC7cZuUa2w/0oOs1pHvaU
 s4lty4yYFmb5KUVelpJpOBuJaeU1+087wH0yQ8QlguSPPjGw3h5/CE67s1YEcn0nfNTczrP/j
 gynFLRMGBNPDjEiAZaD89g4u547EC8WgEotlf8J3hPOIIuwU95B3QptHmDpXdfCdu4Dd0GOiE
 l1gMjfvyMkPs+PVaMG9gcIFH+WIfrFyW9KsWU498s5J91R6Phf2hRN6JDBx7hAi+MM2q0YMv2
 jMhkg7WAJPbGM5xh32sW3iOJxokD44etrkRpJTBnGdJZxXG8wavtRaShk42hyBgjDicoXdRjs
 F8NrTlX2MlDwmFvrClKJgppIYB6bP7v2WPJ4MRV8Dl11ZRHI7iLpNO2XP2wxf50pd/zSxjDjY
 qkEiV6vi4AwtkPSqwW3ukwRnf+nvovIHS5Shm6lPHbMHM6wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Aug 2019 10:16:32 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an unnecessary of_node_put() call
  Use common error handling code

 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

=2D-
2.23.0

