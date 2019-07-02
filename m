Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D6C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3024720659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGBIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:37:33 -0400
Received: from ns.iliad.fr ([212.27.33.1]:56440 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfGBIhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:37:32 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id EC3B720BC5;
        Tue,  2 Jul 2019 10:37:28 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 74BF22079D;
        Tue,  2 Jul 2019 10:37:28 +0200 (CEST)
Subject: Re: [PATCH v1] media: si2168: Refactor command setup code
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brad Love <brad@nextdimension.cc>
References: <6a8f9a5b-2e88-8c26-440b-76af0d91eda6@free.fr>
Message-ID: <5cdfcd0d-067b-16f0-1860-36997c1f04ee@free.fr>
Date:   Tue, 2 Jul 2019 10:37:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6a8f9a5b-2e88-8c26-440b-76af0d91eda6@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jul  2 10:37:28 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 13:44, Marc Gonzalez wrote:

> By refactoring the command setup code, we can let the compiler
> determine the size of each command.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  drivers/media/dvb-frontends/si2168.c | 142 ++++++++-------------------
>  1 file changed, 41 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
> index 168c503e9154..19398f041c79 100644
> --- a/drivers/media/dvb-frontends/si2168.c
> +++ b/drivers/media/dvb-frontends/si2168.c
> @@ -11,6 +11,12 @@
>  
>  static const struct dvb_frontend_ops si2168_ops;
>  
> +#define CMD_SETUP(cmd, __args, __rlen) do {	\
> +	int wlen = sizeof(__args) - 1;		\
> +	memcpy(cmd.args, __args, wlen);		\
> +	cmd.wlen = wlen; cmd.rlen = __rlen;	\
> +} while (0)
> +

I'm planning on sending a v2 where drivers/media/tuners/si2157.c
is refactored the same way. Not sure where to store the macro.
Maybe include/media/dvb_frontend.h ?

Regards.
