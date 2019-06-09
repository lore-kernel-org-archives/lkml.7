Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C3C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064B6214C6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFICuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:50:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:7114 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfFICuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:50:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 19:50:46 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2019 19:50:43 -0700
Cc:     baolu.lu@linux.intel.com, James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
 megaraid_sas
To:     Qian Cai <cai@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
Date:   Sun, 9 Jun 2019 10:43:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559941717.6132.63.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

I just posted some fix patches. I cc'ed them in your email inbox as
well. Can you please check whether they happen to fix your issue?
If not, do you mind posting more debug messages?

Best regards,
Baolu


On 6/8/19 5:08 AM, Qian Cai wrote:
> The linux-next series "iommu/vt-d: Delegate DMA domain to generic iommu" [1]
> causes a system with the rootfs on megaraid_sas card unable to boot.
> 
> Reverted the whole series on the top of linux-next (next-20190607) fixed the
> issue.
> 
> The information regards this storage card is,
> 
> [  116.466810][  T324] megaraid_sas 0000:06:00.0: FW provided supportMaxExtLDs:
> 0	max_lds: 32
> [  116.476052][  T324] megaraid_sas 0000:06:00.0: controller type	:
> iMR(0MB)
> [  116.483646][  T324] megaraid_sas 0000:06:00.0: Online Controller Reset(OCR)	
> : Enabled
> [  116.492403][  T324] megaraid_sas 0000:06:00.0: Secure JBOD support	:
> Yes
> [  116.499887][  T324] megaraid_sas 0000:06:00.0: NVMe passthru support	:
> No
> [  116.507480][  T324] megaraid_sas 0000:06:00.0: FW provided
> [  116.612523][  T324] megaraid_sas 0000:06:00.0: NVME page size	: (0)
> [  116.629991][  T324] megaraid_sas 0000:06:00.0: INIT adapter done
> [  116.714789][  T324] megaraid_sas 0000:06:00.0: pci id		:
> (0x1000)/(0x0017)/(0x1d49)/(0x0500)
> [  116.724228][  T324] megaraid_sas 0000:06:00.0: unevenspan support	: no
> [  116.731518][  T324] megaraid_sas 0000:06:00.0: firmware crash dump	:
> no
> [  116.738981][  T324] megaraid_sas 0000:06:00.0: jbod sync map		:
> yes
> [  116.787433][  T324] scsi host0: Avago SAS based MegaRAID driver
> [  117.081088][  T324] scsi 0:0:0:0: Direct-
> Access     LENOVO   ST900MM0168      L587 PQ: 0 ANSI: 6
> 
> [1] https://lore.kernel.org/patchwork/cover/1078960/
> 
