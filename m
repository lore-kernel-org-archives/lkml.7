Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A5AC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DB121019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554564650;
	bh=69SVdAMKOi54l2cejvIAxS8Ti1tgoy349qwCGdEADyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWBmECV59b/j62rLW+2W+1HLAOB2Oc48M9iQX6xpcknhkoH5eSe0rlNXxYdZ+LMEU
	 DvhiCmyY4Prl7eJih23ITa2MB1MIbVA09SzffZNHqIheERWiHNkg3yhf1tQUz2/OXv
	 2SO8bNzaQqBGAMBDUaKGNApnzX6CUkSIr3b1vsT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDFPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfDFPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 11:30:49 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923482083E;
        Sat,  6 Apr 2019 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554564648;
        bh=69SVdAMKOi54l2cejvIAxS8Ti1tgoy349qwCGdEADyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeFzRYXS6rbDeKWUWSPeNobw7CX8oIQmanT91oatL2x/a9tZIbqDjEJSzRG3b8WSy
         p+ub6QgapqBNXZFM0qisU91TZsTW4eG1s4vbwZede2BsIGrSW0fNFqUtPTOuabXLpg
         fEsI42/MKSuqh+gg3WDbrkDOASOtStlRutrfY1AI=
Date:   Sat, 6 Apr 2019 11:30:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190406153047.GF2935@sasha-vm>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190403181827.GB17006@linux.intel.com>
 <20190403182728.GA17451@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190403182728.GA17451@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:27:28PM +0300, Jarkko Sakkinen wrote:
>On Wed, Apr 03, 2019 at 09:18:27PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:
>> > This patch adds support for a software-only implementation of a TPM
>> > running in TEE.
>> >
>> > There is extensive documentation of the design here:
>> > https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
>> >
>> > As well as reference code for the firmware available here:
>> > https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
>> >
>> > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> What is the context anyway? I mean tpm_crb already supports fTPM running
>> in TZ.
>
>Might take 2-3 weeks before I have time to go through ftpm1.pdf with
>full concentration. I did search through the PDF for CRB and found
>zero hits.

The fTPM as described in that paper and implemented in practice does not
use the CRB interface, thus we can't use tpm_crb to interface with the
firmware TPM.

>The commit message should absolutely better explain what is going on
>and preferably there should be some more broad documentation in
>Documentation/security/tpm.

The code itself is just a small shim between the firmware TPM and the
kernel's TPM interface. There's really not much else to expand on in the
commit log.

I'll add some background to Documentation/security/tpm.

>Now this is just a random code dump and nothing else.

It pretty much is, but that's because this is just a "stupid" shim,
there heavy lifting is done outside of the kernel.

>Also, I have zero idea how to test this. Any recommendations on ARM
>board that can be easily used to test custom TZ applications would be
>nice.

We are testing this on a Broadcom's Stingray SST100 board, and if you
have one we can help out with setting up a test environment. Otherwise,
we haven't really tried it on other boards.

--
Thanks,
Sasha
