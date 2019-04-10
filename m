Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49811C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5FA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554912277;
	bh=4jYoZK+WAn/0HTad9YcD/I5hOYHYXCPL8X7Srb5aF14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PzE0Q+f4QGrtzX6JevS7TlRE3fP0BNO6gxlwrzbzBKh8kp3Zi068Bhq+kBuugycwA
	 hisgbz4TeXU/2zOnCv+tqijAru+dYP5HPZYSyQ2XYSgGXuDP+FbcE9W7S1DIc3KKWt
	 StPW+NxZ5DdVfAr96qkxDe9SwQE/KI1j7J8Cm194=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfDJQEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfDJQEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:04:35 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8852A206DF;
        Wed, 10 Apr 2019 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554912274;
        bh=4jYoZK+WAn/0HTad9YcD/I5hOYHYXCPL8X7Srb5aF14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0NTC1kYgbvQKdZipvVdhuA6Vb+44aGzxumpd3/QPRbY1wjJv63VeAu+Pwz2ZVE4M
         gE1NNf/aSFxag7kM93SDEbqGVnk96SC1GeSWD7EP93OBxnA7UUugslnls28lWhSJsV
         7sz5WE8Al2I4kLQ9KzJtd6TcCX9f4q+FacoMgLtM=
Date:   Wed, 10 Apr 2019 12:04:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190410160432.GB11568@sasha-vm>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190403181827.GB17006@linux.intel.com>
 <20190403182728.GA17451@linux.intel.com>
 <20190406153047.GF2935@sasha-vm>
 <20190410112927.GA6586@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410112927.GA6586@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:29:27PM +0300, Jarkko Sakkinen wrote:
>On Sat, Apr 06, 2019 at 11:30:47AM -0400, Sasha Levin wrote:
>> On Wed, Apr 03, 2019 at 09:27:28PM +0300, Jarkko Sakkinen wrote:
>> > On Wed, Apr 03, 2019 at 09:18:27PM +0300, Jarkko Sakkinen wrote:
>> > > On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:
>> > > > This patch adds support for a software-only implementation of a TPM
>> > > > running in TEE.
>> > > >
>> > > > There is extensive documentation of the design here:
>> > > > https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
>> > > >
>> > > > As well as reference code for the firmware available here:
>> > > > https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
>> > > >
>> > > > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > >
>> > > What is the context anyway? I mean tpm_crb already supports fTPM running
>> > > in TZ.
>> >
>> > Might take 2-3 weeks before I have time to go through ftpm1.pdf with
>> > full concentration. I did search through the PDF for CRB and found
>> > zero hits.
>>
>> The fTPM as described in that paper and implemented in practice does not
>> use the CRB interface, thus we can't use tpm_crb to interface with the
>> firmware TPM.
>
>Obviously not but what is the reason of not implementing CRB but instead
>making yet another interface? I mean CRB supports SMC call.
>
>For me this is taking steps back as to the early days when there was
>proprietary intefaces to TPM before TCG came along and stardized.
>
>I'm sure that the TPM implementation itself could be reworked to
>inteface using CRB. It would also be good for ARM as a platform as now
>this new made up interface causes unwanted divergence. I thought that
>throwing ad hoc intefaces everywhere is something that ARM Linux
>community tries to reduce, not increase.

I'm not sure what the original reasons were for not using the CRB
interface. Note that the paper is from a few years ago, and
implementations of this fTPM existed before the paper, so it's very
possible that it just predates CRB.

Either way, there is existing hardware that runs this TPM and I'm trying
to get it out of Microsoft's tree and get it upstream. There's not much
I could do about existing hardware at this point.


--
Thanks,
Sasha
