Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE11C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E38A2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfFGPOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:14:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728486AbfFGPOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:14:09 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A5F40CEAEAC0267F1F0B;
        Fri,  7 Jun 2019 16:14:05 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 7 Jun
 2019 16:13:59 +0100
Subject: Re: [PATCH v3 2/2] ima: add enforce-evm and log-evm modes to strictly
 check EVM status
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <20190606112620.26488-3-roberto.sassu@huawei.com>
 <1559917462.4278.253.camel@linux.ibm.com>
 <93459fe8-f9b6-fe45-1ca7-2efb8854dc8b@huawei.com>
 <1559920112.4278.264.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <773c3301-7861-f28b-813a-1f2ff657bae8@huawei.com>
Date:   Fri, 7 Jun 2019 17:14:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559920112.4278.264.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2019 5:08 PM, Mimi Zohar wrote:
> On Fri, 2019-06-07 at 16:40 +0200, Roberto Sassu wrote:
>>> On Thu, 2019-06-06 at 13:26 +0200, Roberto Sassu wrote:
> 
>>>> Although this choice appears legitimate, it might not be suitable for
>>>> hardened systems, where the administrator expects that access is denied if
>>>> there is any error. An attacker could intentionally delete the EVM keys
>>>> from the system and set the file digest in security.ima to the actual file
>>>> digest so that the final appraisal status is INTEGRITY_PASS.
>>>
>>> Assuming that the EVM HMAC key is stored in the initramfs, not on some
>>> other file system, and the initramfs is signed, INTEGRITY_UNKNOWN
>>> would be limited to the rootfs filesystem.
>>
>> There is another issue. The HMAC key, like the public keys, should be
>> loaded when appraisal is disabled. This means that we have to create a
>> trusted key at early boot and defer the unsealing.
> 
> There is no need for IMA to appraise the public key file signature,
> since the certificate is signed by a key on the builtin/secondary
> trusted keyring.  With CONFIG_IMA_LOAD_X509 enabled, the public key
> can be loaded onto the IMA keyring with IMA-appraisal enabled, but
> without verifying the file signature.

Yes, but access to the files containing the master key and the EVM key
is denied if appraisal is enabled.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
