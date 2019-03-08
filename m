Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D9F20652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhDhRrmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCHA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:57:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40018 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHA5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:57:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so15061102eds.7;
        Thu, 07 Mar 2019 16:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Gaf+kx7RIOF/U4PqMr0dagqHc8dm/ObO0XEF+OQjw1Y=;
        b=FhDhRrmZDkUh3xhSfPBgQh3euUdl2NVxje9qvDp/GpJjYTQ1tMmuajBF0cGRvJ4xSL
         dELlfxjxOe3mSU22A1gkzTAeI0yJxDNY0HDwxD6TgtnXdjgRRSfvioszUFsZrspDm2Ci
         1gM5Bvywl1ALKMZ6jMrfAV5R9dZqvMxSjGEzBpqESNRQNqqQ5eTNqfBoA62bCKhyQa7x
         qO5HrbPPbgS0bBwhYF/k3RrFr4GYt8pLDqa8FUeEYvETdylUdj+f7w6QCo34E1zA9Bmi
         B34UawNItflE3wX0wfE7aV+4G2aBaNzacuM/oNy3VuiTK1hPTHD9V7bHgKyl60xfVyZh
         kKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Gaf+kx7RIOF/U4PqMr0dagqHc8dm/ObO0XEF+OQjw1Y=;
        b=OT3bCnuLr3EB9dwvd2CEQFhdpgqAXQshQLe0z09fMHQQnzaXByi++gvG4RrUk3KXTG
         YX16CKGmKF4Qc3LQLiLYaedJ90gIU0WnlpPK/0Z+uHcCtcGQ6ZQ00Jfrz1RgoPTsRiKc
         4688HxaIAi7tcN40e55e3frcixJ4+b2Vxweu9P/t8K86anMjmAyNTWD5plxIrTjaHsiI
         dEXtfVx9MG8K6C81ac1Tse/ECVYY4uqVNr4Rj0Omeodxb3bmUEwEUkEfVOy06SW/ON/X
         FML4BxA7JJHS04wSHgGus5UneGahTeaHrgP3URjNHxREYSG+8P7BwQYJxEQpEBOehyl8
         jHwQ==
X-Gm-Message-State: APjAAAVD4V/IHXz4ima8qq1d9HSzHjPC4IAeFe96Gm4+hun2T3T3nDIK
        7jjnJLxCN+88ikGfD2AHN3U=
X-Google-Smtp-Source: APXvYqzRhQhmAkvl7yRdyeYtmHHskEpltUtHHs6QU/gWv3XTqiJpI0gP6JJuEpK4jtBiig5E2zfY/A==
X-Received: by 2002:a17:906:5784:: with SMTP id k4mr9738078ejq.107.1552006658134;
        Thu, 07 Mar 2019 16:57:38 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b10sm1727862edy.80.2019.03.07.16.57.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 16:57:37 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:57:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: -Wsometimes-uninitialized Clang warning in
 drivers/net/ethernet/broadcom/bnxt/bnxt.c
Message-ID: <20190308005735.GA4122@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are trying to get Clang's -Wsometimes-uninitialized turned on for the
kernel as it can catch some bugs that GCC can't. This warning came up:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
        cpr->rx_bytes += len;
                         ^~~
drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
        if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
        unsigned int len;
                        ^
                         = 0
1 warning generated.

It seems like the logical change to make is this; however, I am not sure
if this has any other unintended consequences since this is a rather
dense function. I would much appreciate your input, especially if there
is a better way to fix it.

Cheers,
Nathan

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0bb9d7b3a2b6..7d3d206c2e86 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1615,7 +1615,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
                        bnxt_reuse_rx_agg_bufs(cpr, cp_cons, agg_bufs);
 
                rc = -EIO;
-               goto next_rx;
+               goto next_rx_no_prod_no_len;
        }
 
        len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
