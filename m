Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FD921871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCNR2O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:28:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:53354 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCNR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:28:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 4FA5B1802DF7B;
        Thu, 14 Mar 2019 18:16:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com
Subject: [RFC] fscrypt_key_required mount option
Date:   Thu, 14 Mar 2019 18:15:55 +0100
Message-Id: <20190314171559.27584-1-richard@nod.at>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an RFC, it outlines how an filesystem, in this case UBIFS,
could implement a mount option to disable filesystem operations on encrypted
files where no key is present.
The desired byproduct is that in this case ->d_revalidate() is not needed
anymore and VFS folks are in less fear about the dcache implications.

Thanks,
//richard

[PATCH 1/4] fscrypt: Implement FS_CFLG_OWN_D_OPS
[PATCH 2/4] fscrypt: Export fscrypt_d_ops
[PATCH 3/4] ubifs: Simplify fscrypt_get_encryption_info() error
[PATCH 4/4] ubifs: Implement new mount option, fscrypt_key_required

