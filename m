Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46112C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12977206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfD2CdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:33:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfD2CdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:33:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7961D2ADFCC4B4BEFE0E;
        Mon, 29 Apr 2019 10:33:12 +0800 (CST)
Received: from [127.0.0.1] (10.67.78.74) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Apr 2019
 10:33:08 +0800
Subject: Re: [RFC] Question about reset order for xhci controller and pci
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <4ae9963b-cfc1-7667-6082-a979725af0eb@huawei.com>
From:   "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Message-ID: <160fa1ea-2e82-343b-d5d6-2b9adde70cf4@huawei.com>
Date:   Mon, 29 Apr 2019 10:33:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4ae9963b-cfc1-7667-6082-a979725af0eb@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.78.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using command "echo 1 > /sys/bus/pci/devices/0000:7a:02.0/reset"
on centos7.5 system to reset xhci.

On 2019/4/26 11:07, Tangnianyao (ICT) wrote:
> Hi,all
> 
> I've meet a problem about reset xhci and it may be caused by the
> reset order of pci and xhci.
> Using xhci-pci, when users send reset command in os(centos or red-hat os),
> it would first reset PCI device by pci_reset_function. During this
> process, it would disable BME(Bus Master Enable) and set BME=0, and
> then enable it and set BME=1.
> And then it comes to xhci reset process. First, it would send an
> endpoint stop command in xhci_urb_dequeue. However, this stop ep command
> fails to finish. The reason is that BME is set to 0 in former process and
> xhci RUN/STOP changes to 0, and when BME is set to 1 again, RUN/STOP doesn't
> recover to 1.
> I've checked BME behavior in xhci spec, it shows that "If the BME bit is set to 0
> when xHC is running, the xHC may treat this as a Host Controller Error, asserting
> HCE(1) and immediately halt(R/S=0 and HCH=1). Recovery from this state will
> require an HCRST." It seems that the stop ep command failure is reasonable.
> Maybe I've missed something and please let me know.
> 
> linux version:5.0.0-rc3
> 
> Thanks,
> Nianyao Tang
> 
> 
> .
> 

