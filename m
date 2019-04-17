Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfDQIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:41:25 -0400
Received: from ozlabs.org ([203.11.71.1]:40889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfDQIlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:41:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kbLV67Gvz9s4Y;
        Wed, 17 Apr 2019 18:41:22 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Diana Madalina Craciun <diana.craciun@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "stable\@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 20/76] powerpc/64: Disable the speculation barrier from the command line
In-Reply-To: <VI1PR0401MB2463835B1223FDAE2EFFCD43FF240@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190415183707.712011689@linuxfoundation.org> <20190415183712.869759410@linuxfoundation.org> <VI1PR0401MB2463835B1223FDAE2EFFCD43FF240@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Date:   Wed, 17 Apr 2019 18:41:20 +1000
Message-ID: <87ef61uiq7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diana Madalina Craciun <diana.craciun@nxp.com> writes:
> Hi,
>
> I have tested the patches on NXP platforms and they worked as expected.

Thanks Diana.

cheers

> On 4/15/2019 9:45 PM, Greg Kroah-Hartman wrote:
>> commit cf175dc315f90185128fb061dc05b6fbb211aa2f upstream.
>>
>> The speculation barrier can be disabled from the command line
>> with the parameter: "nospectre_v1".
>>
>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/powerpc/kernel/security.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
>> index bf298d0c475f..813e38ff81ce 100644
>> --- a/arch/powerpc/kernel/security.c
>> +++ b/arch/powerpc/kernel/security.c
>> @@ -17,6 +17,7 @@
>>  unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
>>
>>  bool barrier_nospec_enabled;
>> +static bool no_nospec;
>>
>>  static void enable_barrier_nospec(bool enable)
>>  {
>> @@ -43,9 +44,18 @@ void setup_barrier_nospec(void)
>>         enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
>>                  security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
>>
>> -       enable_barrier_nospec(enable);
>> +       if (!no_nospec)
>> +               enable_barrier_nospec(enable);
>>  }
>>
>> +static int __init handle_nospectre_v1(char *p)
>> +{
>> +       no_nospec = true;
>> +
>> +       return 0;
>> +}
>> +early_param("nospectre_v1", handle_nospectre_v1);
>> +
>>  #ifdef CONFIG_DEBUG_FS
>>  static int barrier_nospec_set(void *data, u64 val)
>>  {
>> --
>> 2.19.1
>>
>>
>>
>>
