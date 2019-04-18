Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343E720643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnGy8nV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbfDRTtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:49:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389866AbfDRTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:49:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so1552149pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nv1osdKMnyQhFpXAYzfTc/y8P4eQhfnwJ3z9VJHumRs=;
        b=XnGy8nV+vrlbZLrGOz/2ITivLC4FD5nuOPNiQP39Nwi2Gff+bcupMcExivueyD+z4q
         Go4gLOQzKLBdAhlU1UFvA6mJ/k2mQAsY0MiA6Fj/0c2Uks1VRkL5eMVDgdeSFuqqHknh
         gFqVhfzZEtWCIJZzGTm9argq1WxEObOFJLsFmk181hFJUQ/4Rwa9wmOHbhQWBXSzvrLX
         ZDf/iLZrVTMrUuPGKKCkPG3jc3FJVXRUsRCwB7fIUkgz9zul3803EgfjxsaVzR27tsqi
         yia0T6ibseVHWa1l1bBeAXTCpcCG1vnuUKn6pY00thLmzsPgbupuGk6nwMDrLlgyL8nS
         PbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nv1osdKMnyQhFpXAYzfTc/y8P4eQhfnwJ3z9VJHumRs=;
        b=Wvxis3A3XZxNpWBYmReG5HIGLiRO3E3L/qPmxzn3t2PSZhfofwzx4ASP5RrATotiTL
         d3M2qrSQo+ElqeAcpUCiP0d+BbdUQMvkx5Zzg4LyU4VQYCz7oPt1CGRjQrRpghbyyBaW
         Dt2Qb8bt8OQOjERuOa8f+SSHYrkNFKe0mAHaLRS+B6bZII12siPrLfDFiDlZHCjasX/8
         L8YwIC4IauqGG0mr9y/ZWhTP59GwEwbgv4YkqTEfcVP8Oil09YUWbmyUadnIsyAzUnfR
         9O1WJwHAeeXXi3UiDkErTcury7PXARZZdYZKI049xbzWqEpoaesvi1Cb66KpsqaW21e2
         OZZA==
X-Gm-Message-State: APjAAAX+qHbdyH0G4myoApLFWIHNX5YzRj4avLDVTQcnGFeFSDhLeYbG
        UbApCaqi/NSTyPX1XME4504=
X-Google-Smtp-Source: APXvYqws8l3BHlRoJ8O3n8PyNUaV9SDlmTRmQ2aAZP27lA4t4fOhIUvpl8zDughhtClhkxUHkgXcWw==
X-Received: by 2002:a65:4bce:: with SMTP id p14mr92784659pgr.376.1555616941584;
        Thu, 18 Apr 2019 12:49:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id m23sm3924311pfa.117.2019.04.18.12.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 12:49:01 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:48:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418194857.GB14885@Asurada-Nvidia.nvidia.com>
References: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:34:15AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

The change looks fine, yet I'd prefer to have a good justification
in the commit message. It could be simply some benefit of doing so
like what you have discussed with Mark.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Please add it in next version upon commit message update:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
