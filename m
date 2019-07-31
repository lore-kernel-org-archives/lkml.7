Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40742C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E57820693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGaLqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:46:39 -0400
Received: from ozlabs.org ([203.11.71.1]:54333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfGaLqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:46:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zBTm01V7z9s00;
        Wed, 31 Jul 2019 21:46:35 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
In-Reply-To: <201907301005.0661E63CF@keescook>
References: <20190730143704.060a2606@canb.auug.org.au> <878ssfzjdk.fsf@concordia.ellerman.id.au> <201907301005.0661E63CF@keescook>
Date:   Wed, 31 Jul 2019 21:46:34 +1000
Message-ID: <87ef26qvdx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Wed, Jul 31, 2019 at 12:28:55AM +1000, Michael Ellerman wrote:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>> > Mark switch cases where we are expecting to fall through.
>> >
>> > This patch fixes the following warning (Building: powerpc):
>> >
>> > drivers/macintosh/smu.c: In function 'smu_queue_i2c':
>> > drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> >    cmd->info.devaddr &= 0xfe;
>> >    ~~~~~~~~~~~~~~~~~~^~~~~~~
>> > drivers/macintosh/smu.c:855:2: note: here
>> >   case SMU_I2C_TRANSFER_STDSUB:
>> >   ^~~~
>> >
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> > ---
>> >  drivers/macintosh/smu.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
>> > index 276065c888bc..23f1f41c8602 100644
>> > --- a/drivers/macintosh/smu.c
>> > +++ b/drivers/macintosh/smu.c
>> > @@ -852,6 +852,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
>> >  		break;
>> >  	case SMU_I2C_TRANSFER_COMBINED:
>> >  		cmd->info.devaddr &= 0xfe;
>> > +		/* fall through */
>> >  	case SMU_I2C_TRANSFER_STDSUB:
>> >  		if (cmd->info.sublen > 3)
>> >  			return -EINVAL;
>> 
>> Why do we think it's an expected fall through? I can't really convince
>> myself from the surrounding code that it's definitely intentional.
>
> Yeah, good question. Just now when I went looking for who
> used SMU_I2C_TRANSFER_COMBINED, I found the only caller in
> arch/powerpc/platforms/powermac/low_i2c.c and it is clearly using a
> fall-through for building the command for "stdsub" and "combined",
> so I think that's justification enough:
>
>         switch(bus->mode) {
>         case pmac_i2c_mode_std:
>                 if (subsize != 0)
>                         return -EINVAL;
>                 cmd->info.type = SMU_I2C_TRANSFER_SIMPLE;
>                 break;
>         case pmac_i2c_mode_stdsub:
>         case pmac_i2c_mode_combined:
>                 if (subsize > 3 || subsize < 1)
>                         return -EINVAL;
>                 cmd->info.sublen = subsize;
>                 /* that's big-endian only but heh ! */
>                 memcpy(&cmd->info.subaddr, ((char *)&subaddr) + (4 - subsize),
>                        subsize);
>                 if (bus->mode == pmac_i2c_mode_stdsub)
>                         cmd->info.type = SMU_I2C_TRANSFER_STDSUB;
>                 else
>                         cmd->info.type = SMU_I2C_TRANSFER_COMBINED;
>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks.

cheers
