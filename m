Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767822075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFDSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:07:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41997 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:07:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so14843369qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 11:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VqQq4cQNP39z5kvp6mgBtOtgAsl+vbQi/V8jvuLhzoY=;
        b=tPTjuQkmBMx9fkLKcb+vt859YFQ9I9z4dn/G504QN8WZ4b7qHkS5jURnWDNjCl9L8H
         d6+ffqeFtUpjpldObJsV9qoydKv5xxROZGM2MIJ/1X+wASmvtvoJ66C58wQ3U1kw/orC
         7eRuAqY8XtPJ97z8oV7Mrar4MBzrzrWnAKyMkbiihpXw+/qg9/5TeOeXHSHM8KN8zvbY
         VeElBmrCO9dL41pKN5jHeytUPEuOp9X22TPobxzmHiVWkcCBpy/9OPNzCI0JqAZXE6M5
         PAspE0Gk1PVa48IZq1MG/3/FvXd+jhBmm7lnPU9iM/5RG8a6cTZ4wD8n8tn35xObehfp
         DrjQ==
X-Gm-Message-State: APjAAAVudounZm77UL/B29afs/G/ksnmxRqRNOdm3EQjxumy4QVBcoo6
        ViGjTr6qnk5lNakmCQ9quqUK9g==
X-Google-Smtp-Source: APXvYqy+vc04jO68N2skYgAkUCBemyhBzD4nK6XLrxpDnp+XzXuRkXQj7D06MZEKj1rgjNFGd/ZNTQ==
X-Received: by 2002:aed:3a87:: with SMTP id o7mr29174051qte.310.1559671627398;
        Tue, 04 Jun 2019 11:07:07 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id y8sm11947465qth.22.2019.06.04.11.07.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 11:07:06 -0700 (PDT)
Message-ID: <ad520b3710906bfcf51d2f823db5cc99fb12ee90.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau/bios/init: Improve pre-PMU devinit
 opcode coverage
From:   Lyude Paul <lyude@redhat.com>
To:     Rhys Kidd <rhyskidd@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 04 Jun 2019 14:07:05 -0400
In-Reply-To: <20190602141315.6197-1-rhyskidd@gmail.com>
References: <20190602141315.6197-1-rhyskidd@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Tested on a GK104 and GK110 (same ones as my vbios traces in our vbios repo)

On Mon, 2019-06-03 at 00:13 +1000, Rhys Kidd wrote:
> NVIDIA GPUs include a common scripting language (devinit) that can be
> interpreted by a number of "engines", e.g. within a kernel-mode software
> driver, the VGA BIOS or an on-board small microcontroller which provides
> certain security assertions (the 'PMU').
> 
> This system allows a GPU programming sequence to be shared by multiple
> entities that would not otherwise be able to execute common code.
> 
> This series adds support to nouveau for two opcodes seen on VBIOSes prior
> to the locked-down PMU taking over responsibility for executing devinit
> scripts.
> 
> Documentation for these two opcodes can be found at:
> 
>   https://github.com/envytools/envytools/pull/189
> 
> Rhys Kidd (2):
>   drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
>   drm/nouveau/bios/init: handle INIT_RESET_END devinit opcode
> 
>  .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
-- 
Cheers,
	Lyude Paul

