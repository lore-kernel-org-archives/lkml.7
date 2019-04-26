Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DA2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfDZDHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:07:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfDZDHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:07:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54C66792D86FAE738FF5;
        Fri, 26 Apr 2019 11:07:18 +0800 (CST)
Received: from [127.0.0.1] (10.67.78.74) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Apr 2019
 11:07:10 +0800
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tangnianyao@huawei.com>
From:   "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Subject: [RFC] Question about reset order for xhci controller and pci
Message-ID: <4ae9963b-cfc1-7667-6082-a979725af0eb@huawei.com>
Date:   Fri, 26 Apr 2019 11:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.78.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

I've meet a problem about reset xhci and it may be caused by the
reset order of pci and xhci.
Using xhci-pci, when users send reset command in os(centos or red-hat os),
it would first reset PCI device by pci_reset_function. During this
process, it would disable BME(Bus Master Enable) and set BME=0, and
then enable it and set BME=1.
And then it comes to xhci reset process. First, it would send an
endpoint stop command in xhci_urb_dequeue. However, this stop ep command
fails to finish. The reason is that BME is set to 0 in former process and
xhci RUN/STOP changes to 0, and when BME is set to 1 again, RUN/STOP doesn't
recover to 1.
I've checked BME behavior in xhci spec, it shows that "If the BME bit is set to 0
when xHC is running, the xHC may treat this as a Host Controller Error, asserting
HCE(1) and immediately halt(R/S=0 and HCH=1). Recovery from this state will
require an HCRST." It seems that the stop ep command failure is reasonable.
Maybe I've missed something and please let me know.

linux version:5.0.0-rc3

Thanks,
Nianyao Tang

