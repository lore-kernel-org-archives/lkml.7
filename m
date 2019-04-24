Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4128C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A913520685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="KaEB7XxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfDXSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:14:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39477 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfDXRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:11:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so9633018pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MN5yriTLCqLM4B/l2zakQLWVdZUNj3azdHHd9ghurIU=;
        b=KaEB7XxZUxTXZ7CfIiMYwPOQmzDFDwj9ICa0iBL99FFuwaawBwOQsMt2eFZZkpxcJM
         ilaRZByDmr7kgU8sh6akKcSAp1Kaq7j6N1pMMVsS0LJP5ih9W8MUX0VMQPN+9Eicqy14
         OuU6InC70DT+Z7Hn+JaCtToSEEIRW0MligxpERgxr3Gf3Ju+RnZpFWUK2iR2my1peIKs
         9NyWGm2ScEGfOejKq8W+LZU1EEtA/YRGsSq9JQV+SCCvsIIjowWQs8Ebi2POQa29TT9x
         2GAw5KNmCYcG7d0sG6SZM6jwDsEv82YV12bfFRbYoD1epvsYlWSeZ7jeRXpl1/3a4rKY
         RUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MN5yriTLCqLM4B/l2zakQLWVdZUNj3azdHHd9ghurIU=;
        b=J7n6scMLoCQPDpXv+m14egIysHfoK9TqXsqUXefEtdBNnydE0lnwWjx2JvKMQsjQpA
         J+MpXyKL2wZ7nUxzomfI0GAYanXZRLFtjtZEm4WHvrwG1YdETYhNn6kFaszSvkMrbtDW
         tJdzg1hksQxoPBiRaBw528zbwl3oHoQJLD7fgNd20T1/VAFKSCeoTMaKMhtBdniRnNls
         22DeI9fCBD09ShXddLOM41JEvmKLU7jupF0+Q6VUIUF00AFOQAVwgBDGyIvet0d9kgIc
         i2xr6x3sa4YtwvyJB7IthEJRAosbXmKUL9twt5HrC+4nulhcDrq1v+rvF+3t9FY/Wt1G
         kpNg==
X-Gm-Message-State: APjAAAXauy34fH5XpEsQpWEEbo0iSFluEshMqbY+nPSqlJFz1YqbJAGN
        mGN/t/vTNnv8jjCAzxDtpHiRlQ==
X-Google-Smtp-Source: APXvYqzyA2NJYpAEaaT+USTkjcSH91+Ksktq84P+rydR/ZcJqbbZbZEK1QdwWQxWSyxp17zorxbIoQ==
X-Received: by 2002:a63:2015:: with SMTP id g21mr31179600pgg.226.1556125888875;
        Wed, 24 Apr 2019 10:11:28 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
        by smtp.gmail.com with ESMTPSA id o7sm13153777pgv.63.2019.04.24.10.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:11:28 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:11:26 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/seccomp: Prepare for exclusive seccomp
 flags
Message-ID: <20190424171126.GM3758@cisco>
References: <20190424163756.40001-1-keescook@chromium.org>
 <20190424163756.40001-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424163756.40001-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:37:55AM -0700, Kees Cook wrote:
> Some seccomp flags will become exclusive, so the selftest needs to
> be adjusted to mask those out and test them individually for the "all
> flags" tests.
> 
> Cc: stable@vger.kernel.org # v5.0+
> Signed-off-by: Kees Cook <keescook@chromium.org>

Whoops, thanks for this too.

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
