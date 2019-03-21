Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8905C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BE9218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfCUO0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:26:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUO0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:26:38 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 446A7630D7746368FDA5;
        Thu, 21 Mar 2019 14:26:36 +0000 (GMT)
Received: from [10.204.65.148] (10.204.65.148) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 21 Mar
 2019 14:26:34 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware
 TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        <keyrings@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
Date:   Thu, 21 Mar 2019 15:26:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190321135451.GD4603@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/2019 2:54 PM, Jarkko Sakkinen wrote:
> On Mon, Mar 18, 2019 at 04:45:13PM -0700, Dan Williams wrote:
>> Rather than fail initialization of the trusted.ko module, arrange for
>> the module to load, but rely on trusted_instantiate() to fail
>> trusted-key operations.
>>
>> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
>> Cc: Roberto Sassu <roberto.sassu@huawei.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: James Bottomley <jejb@linux.ibm.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> It should check for chip in each function that uses TPM now that
> the code does not rely on default chip. Otherwise, the semantics
> are kind of inconsistent.

If no other TPM function can be used before a successful key
instantiate, checking for a chip only in trusted_instantiate() seems
sufficient. Then, the same chip will be used by all TPM functions until
module unloading, since we incremented the reference count.

I would suggest to move the tpm_default_chip() and init_digests() calls
to trusted_instantiate() to restore the old behavior of init_trusted().

trusted_instantiate() should look like:
---
if (!chip) {
	chip = tpm_default_chip();
	if (!chip)
		return -ENODEV;
}

if (!digests) {
	ret = init_digests();
	if (ret < 0)
		return ret;
}
---

Roberto


> /Jarkko
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
