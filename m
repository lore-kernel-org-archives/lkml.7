Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4485C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB17E20989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfGFKvD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:51:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49002 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:03 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 526A4CEFAE;
        Sat,  6 Jul 2019 12:59:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH][next] 6lowpan: fix off-by-one comparison of index id with
 LOWPAN_IPHC_CTX_TABLE_SIZE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190624144757.1285-1-colin.king@canonical.com>
Date:   Sat, 6 Jul 2019 12:51:00 +0200
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B6A1CB42-C239-42CA-B14E-483A02B930EB@holtmann.org>
References: <20190624144757.1285-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

> The WARN_ON_ONCE check on id is off-by-one, it should be greater or equal
> to LOWPAN_IPHC_CTX_TABLE_SIZE and not greater than. Fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> net/6lowpan/debugfs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
> index 1c140af06d52..a510bed8165b 100644
> --- a/net/6lowpan/debugfs.c
> +++ b/net/6lowpan/debugfs.c
> @@ -170,7 +170,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
> 	struct dentry *root;
> 	char buf[32];
> 
> -	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
> +	WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE);

this patch no longer applied cleanly to bluetooth-next. Can you send me an updated version.

Regards

Marcel

