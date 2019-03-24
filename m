Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF42C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08B2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2WqZSPCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfCXQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:19:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCXQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aRspIVlEuYCMJaE2WdYVOtNE7eAruzV48OpTDyN/xt4=; b=2WqZSPCQEiKWYFu8OQojkMKM5s
        uOzVYTPAxCZHDU749S2ox4Yx2BW/qf2W86Byc+T+hFeXaTPrUCDGWodDEOlXnVIKYP+afZNbtXZCO
        lPcvNd9faT6+onh4/yEBRpBE+/fm9Asf+e6htdhHf1SVQu25bu+oxzUZIALV7RusABIp5MwUCXO8k
        30J8BqQ7mQ0NQ+FJyrZ/3HzG70l7IA5CX2M52KWTdu+MZu6av8sn/pldR9ZrQpSSxjm/v2jQG9aAj
        ZRDUvL/bKwOGUySE24YSvVg/UcnknN8yFTddBXHccmWhC+groEtx1EbbbN/sbWxmxTNRhMKpoG9Z2
        aDhUSKPw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h85pw-0003EP-2K; Sun, 24 Mar 2019 16:19:04 +0000
Subject: Re: Debug scsi message in linux 4.19.31
To:     Hussam Al-Tayeb <ht990332@gmx.com>, linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <624bbdbb24ad7db69be29956cbf14689fd003cdb.camel@gmx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25d0ddcb-b603-6e0d-d512-b188813837bf@infradead.org>
Date:   Sun, 24 Mar 2019 09:18:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <624bbdbb24ad7db69be29956cbf14689fd003cdb.camel@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-scsi and mkp]

On 3/24/19 6:07 AM, Hussam Al-Tayeb wrote:
> Hi. I'm seeing a debug message in linux stable kernel 4.19.31 with this
> patch
> scsi-sd-optimal-i-o-size-should-be-a-multiple-of-physical-block-
> size.patch
> 
> I am getting:
> Mar 23 17:40:10 hades kernel: sd 0:0:0:0: [sda] Optimal transfer size 0
> bytes < PAGE_SIZE (4096 bytes)
> Mar 23 17:40:10 hades kernel: sd 2:0:0:0: [sdb] Optimal transfer size 0
> bytes < PAGE_SIZE (4096 bytes)
> Mar 23 17:46:43 hades kernel: sd 4:0:0:0: [sdc] Optimal transfer size 0
> bytes < PAGE_SIZE (4096 bytes)
> 
> sda and sdb are physically attached SATA mechanical disks (Western
> Digital and Seagate, respectively).
> sdc is a kingston usb flash drive. All three disks use ext4 luks
> encrypted partitions.
> Is the fact that it is reporting 0 as optimal transfer size something I
> should worry about? Note that the the three storage devices are from
> three different manufacturers.
> This particular machine is a Lenovo Intel(R) Core(TM) i5-6400 CPU @
> 2.70GHz with 16GB Kingston DDR4 ram.
> 
> I tried moving the root disk to another machine (a DELL Core I7 7700
> with slightly faster ram from Samsung) and I saw the same message.
> 
> This seems like a patch that fits better in a hardware vendor or
> operating system distributor tree than the upstream kernel. Shouldn't
> stable tree kernels only contain direct fixes and regression fixes?
> Does it really belong in an LTS kernel?
> 
> Please CC me in your reply as I am not subscribed to the list.
> Thank you.
> 


-- 
~Randy
