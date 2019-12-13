Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12AC80D41
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD624811
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269657;
	bh=Bn/A8pPjx5b3gjcXE0xjFh46MqimhSJTtlxlrQfDMiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=swFV62CrSirWnYYNPey4DjXdcd9ydOiAI1ENqVmUx0b+NxTOn3Y3Dw9RSrfq+9WQh
	 WMNivenl/2bGOFyZLybmNL1ELisn65kMn7nxVn7Q7h0zttHBwaR7MWfGHrOkcYLxMG
	 Nits5IBQRcvYkHd6z+FBkvkZ6qJHZ+upz5E4AIdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfLMTKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:10:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43206 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:10:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so292304oth.10;
        Fri, 13 Dec 2019 11:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHsUIESi47GUujK3ymDIbUW6G62I8FASealFyFb2qxM=;
        b=AcjW8tUdCv9JovElKmJf/3USBllUi8LdD3OGKxsR7zfxZtN4daJW5oW8GXsCBAiScR
         pfuQ/1djnhlMR5Jjwl+hdUZ4N8/Fh7g5jEGZqKy8G1/FDDtLYsypqunIMPoOMLg0k04I
         dVg2R5cSApJR5MhutHIiyIN47axT6o43HhU8fetu7K9CZPKeyRod4W2on6PLXBB8SAX0
         ir7rMlF8/lM0NtIC7y/VW3xZPASoqxkRkuUs7qRbDrMG3tK/UMBdT2V4DQavMFr+gIIs
         UMOVrgKMfihylRY7CE+bojRu15bQSb/+mPRmR8gQEAHaqUPBon274D60lSXDL8LINCLg
         7q5Q==
X-Gm-Message-State: APjAAAVyabQn1b3fGlXIChVt+1Bifp7eKZxI/d3IgP6XeC9FfK/gX7C+
        G+EZhSe3+0gTWJEViXCYdA==
X-Google-Smtp-Source: APXvYqzHxWniZ5J9xfopYjECrU07WUzV4L9U6fU6FRGgt1nEiyBXlgj3TRlcGj+V/4Fj0x84/KDZiQ==
X-Received: by 2002:a9d:53cb:: with SMTP id i11mr16760478oth.158.1576264244638;
        Fri, 13 Dec 2019 11:10:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm3550697oie.25.2019.12.13.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:10:44 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:10:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ming-Fan Chen <ming-fan.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add binding for MT6779 SMI
Message-ID: <20191213191043.GB28558@bogus>
References: <1575872371-671-1-git-send-email-ming-fan.chen@mediatek.com>
 <1575872371-671-3-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575872371-671-3-git-send-email-ming-fan.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 14:19:30 +0800, Ming-Fan Chen wrote:
> This patch add description for MT6779 SMI.
> 
> Signed-off-by: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |    5 +++--
>  .../memory-controllers/mediatek,smi-larb.txt       |    3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
