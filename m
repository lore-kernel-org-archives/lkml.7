Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF232C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B836520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU4aePDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439893AbfFLPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:02:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407156AbfFLPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:02:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so9842060pfc.1;
        Wed, 12 Jun 2019 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkAts0mKents718nZX+TF7/yIJP6YEEMSouzOt2gH1c=;
        b=dU4aePDAbdvzlu6ceSsWgf2GH8TpF805uOh0UU/45W1J9eg4hFCVJCIxn+W4/InrR6
         LM/RnDkz39iHGzvgT1RTddR6HfI7KTQCD28xXOaJTuHwiCMmU9xzVmppPpSPMTjsx2RO
         Nn/e6yMvmQcm1FuN1tRrgTuHR38DpDFDDipPCU9VUOWp7dVjnGmmQjgAsRd0RJrBHPuK
         4dTK0TJzF409tMcx7mwt4hcaKltOV4H2eJZMz64aN9/N74nR9s+EoUE36JC1PAP+D8T9
         bBAsoJ4gcZ+XKi0YU1lyrzLb2CYWJM9jPPwf1YRzACsbKQ8cx0MWvnqDjLWEyAAYTqKl
         TPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkAts0mKents718nZX+TF7/yIJP6YEEMSouzOt2gH1c=;
        b=ZLjUnl+GxefszHxAaL5UpQysqluSdDmw143YxkAhDD5AIymkLMcllnpoyd99ysVRLh
         XPQt3P1ITW4cJmBMF3bc+4D/PaIEqmr4ra8kZIVcpLe1deGTbk8mPPQAl/CTvR3GCeDV
         nQSOcXgi81jS+C37A5aj3VZiyC83H4ASc3P2gGd/ov2XYiHX5M3m1kRtjFOrIup1Ke4n
         HjjafCQQO3AvYVM9VBTMzgSnWtFUiMCPZx/F5S1++lAvPTsXxdAdJZ8TVEbALIeAY5Uh
         bRUNtsoBLLuv744LZFJHFRgn7BCCdp3oktNnY9sidrXn9dPiFKZo538zu8e4AebIWCOp
         aApg==
X-Gm-Message-State: APjAAAXMEZ965fN41d749vI+qKE6DM9+KW/TFxojsuPIbdYDNYrYTlU2
        BbsoGnXB3Fu+QlNEhqk0E20=
X-Google-Smtp-Source: APXvYqwh/XxRpRKOs6QNQBnIisN7zrwj1hD5OaZOwOUdujKJHqDi05WgjBvA6TP6+0PCpfzh65tJjg==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr81285227pfa.119.1560351761049;
        Wed, 12 Jun 2019 08:02:41 -0700 (PDT)
Received: from icarus ([2001:268:c1c1:781d:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id g2sm16800565pgi.92.2019.06.12.08.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 08:02:40 -0700 (PDT)
Date:   Thu, 13 Jun 2019 00:02:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH 1/1] MAINTAINERS: add counter/ftm-quaddec driver entry
Message-ID: <20190612150221.GA6631@icarus>
References: <20190612145223.8402-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612145223.8402-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:52:23PM +0200, Patrick Havelange wrote:
> Adding myself as maintainer for this driver
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..6671854098d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6218,6 +6218,14 @@ M:	Philip Kelleher <pjk1939@linux.ibm.com>
>  S:	Maintained
>  F:	drivers/block/rsxx/
>  
> +FLEXTIMER FTM-QUADDEC DRIVER
> +M:	Patrick Havelange <patrick.havelange@essensium.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
> +F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> +F:	drivers/counter/ftm-quaddec.c
> +
>  FLOPPY DRIVER
>  M:	Jiri Kosina <jikos@kernel.org>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/floppy.git
> -- 
> 2.19.1

Thank you, this should take care of those files.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
