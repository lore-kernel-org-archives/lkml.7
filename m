Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A166ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29320663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJOTjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:39:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfJOTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:39:01 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKSep-00038e-V2; Tue, 15 Oct 2019 19:38:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191015165531.27469-1-ckellner@redhat.com>
Date:   Tue, 15 Oct 2019 21:38:59 +0200
Cc:     "Christian Kellner" <christian@kellner.me>,
        "Christian Brauner" <christian@brauner.io>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] pidfd: avoid linux/wait.h and sys/wait.h name
 clashes
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
To:     "Christian Kellner" <ckellner@redhat.com>,
        <linux-kernel@vger.kernel.org>
Message-Id: <BXQCOYS7J0NU.363NAWEEPN3GH@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 15, 2019 at 6:55 PM Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
>=20
> Both linux/wait.h and sys/wait.h contain values for the first argument
> of 'waitid' (P_ALL, P_PID, ...).  While the former uses defines the
> latter uses an enum. When linux/wait.h is included before sys/wait.h
> this will lead to an error, because P_ALL, P_PID, ... will already
> have been substituted to 0, 1, ... respectively and this the resulting
> code will be 'typedef enum {0, 1, ...'.
> Remove 'linux/wait.h' and rename P_PIDFD to avoid a future clash, in
> case P_PIDFD gets added to the idtype_t enum in sys/wait.h.
>=20
> Signed-off-by: Christian Kellner <christian@kellner.me>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
