Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55668C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A21F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j+np2dDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfH0Nnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:43:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39588 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0Nnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IR73i9W0EgWINjS9LPHNsm8ROGSdMjBWUOLcAHrBo3w=; b=j+np2dDDpbw0CoBR0jB5sUlni
        j9ktn94XD/d4xb2OmpNf+hF25/OV57icLJ0Orwx5/kPjLZu8Bi78psmXzgPb7AjD6gBUVK6wMICOs
        R4bjnE13q6k8dNtsSp878vxHDHvDZPCTa0AMhlpK1bEWr33iK6wVVy3ZuDSMYtrnm0ihM6b448OYy
        zAar44mmsQyiYgoFVUiWz09bswrfk22p0RkQtCsKkUEM1eB3lN9m3gzgwjJ0rPB1S0TdXCg3ZVJWc
        xYvzljn2z2dN+Gfg4KRPmkCs14Q/lZrST1WZr7GnBpk7vZdwNUCQt0m2kIghJgxEqLF0wRxLuWds4
        c/hHzmi6g==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55220)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2bl4-0004jw-9A; Tue, 27 Aug 2019 14:43:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2bl3-0005nO-KV; Tue, 27 Aug 2019 14:43:37 +0100
Date:   Tue, 27 Aug 2019 14:43:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Continuous SD IO causes hung task messages
Message-ID: <20190827134337.GK13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While dd'ing the contents of a SD card, I get hung task timeout
messages as per below.  However, the dd is making progress.  Any
ideas?

Presumably, mmc_rescan doesn't get a look-in while IO is progressing
for the card?

ARM64 host, Macchiatobin, uSD card.

Thanks.

root@arm-d06300000000:~# dd if=/dev/mmcblk1 | md5sum
INFO: task kworker/2:1:52 blocked for more than 120 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 120 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 241 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 362 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
